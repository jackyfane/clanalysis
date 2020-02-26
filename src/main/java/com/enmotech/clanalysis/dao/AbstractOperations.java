package com.enmotech.clanalysis.dao;

import com.enmotech.clanalysis.entity.Category;
import com.enmotech.clanalysis.entity.Item;
import com.enmotech.clanalysis.entity.User;
import com.enmotech.clanalysis.util.EntityUtil;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.util.StringUtils;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.util.LinkedList;
import java.util.List;

/**
 * 数据层抽象类，实现了公用的CRUD，所有数据层具体实现类都继承此类
 */
public abstract class AbstractOperations<T extends Serializable> implements IOperations<T> {

	@Autowired
	protected HibernateTemplate hibernateTemplate;

	private Class<T> clazz;

	@Override
	public T findById(Serializable id) {
		return hibernateTemplate.get(clazz, id);
	}

	@Override
	public List<T> findAll(final T entity) {

		if (EntityUtil.isExistsProperty(clazz, "status")) {
			return hibernateTemplate.execute(new HibernateCallback<List<T>>() {
				List<Object> params = new LinkedList<Object>();

				String queryWhere = EntityUtil.createHQLParams(entity, params, false);

				String queryStr = "from " + clazz.getSimpleName() + " where 1=1 " + queryWhere;

				@Override
				public List<T> doInHibernate(Session session) throws HibernateException {
					Query query = session.createQuery(queryStr);
					for (int i = 0; i < params.size(); i++) {
						query.setParameter(i, params.get(i));
					}
					return query.list();
				}
			});
		} else {
			return hibernateTemplate.loadAll(clazz);
		}
	}

	@Override
	public List<T> findByPage(final T entity, final int firstResult, final int maxResults) {
		// return hibernateTemplate.findByExample(entity, firstResult,
		// maxResults);

		return hibernateTemplate.execute(new HibernateCallback<List<T>>() {
			@Override
			public List<T> doInHibernate(Session session) throws HibernateException {
				Query query = query(entity, session);
				query.setMaxResults(maxResults);
				query.setFirstResult(firstResult);
				return query.list();
			}
		});

	}

	@Override
	public int findCount(final T entity) {
		// List<T> list = hibernateTemplate.findByExample(entity);
		// if (list == null)
		// return 0;
		// else
		// return list.size();
		return hibernateTemplate.execute(new HibernateCallback<Integer>() {
			@Override
			public Integer doInHibernate(Session session) throws HibernateException {
				int total = query(entity, session).list().size();
				return total;
			}
		});
	}

	@Override
	public void save(T entity) {
		hibernateTemplate.save(entity);
	}

	@Override
	public void update(final T entity) {
		hibernateTemplate.update(entity);
	}

	@Override
	public void saveOrUpdate(T entity) {
		hibernateTemplate.saveOrUpdate(entity);
	}

	@Override
	public void delete(T entity) {
		hibernateTemplate.delete(entity);
	}

	@Override
	public void delete(List<T> entities) {
		String className = entities.get(0).getClass().getName();
		StringBuffer idBuffer = new StringBuffer();
		// 判断是否有status属性，如果有就进行状态更新，只做逻辑删除，不做物理删除
		// 如果没有status属性，则进行物理删除
		int i = 0;
		boolean noStatus = false;
		for (T entity : entities) {
			String id = getIdIfExistsStatus(entity, entity.getClass());
			if (StringUtils.isEmpty(id) && !noStatus) {
				noStatus = true;
			}
			if (i >= entities.size() - 1)
				idBuffer.append("'").append(id).append("'");
			else
				idBuffer.append("'").append(id).append("'").append(",");
			i++;
		}

		if (noStatus) {
			// 物理删除
			hibernateTemplate.deleteAll(entities);
		} else {
			// 逻辑删除
			final String idString = idBuffer.toString();
			final String table = className.substring(className.lastIndexOf(".") + 1);
			hibernateTemplate.execute(new HibernateCallback<Boolean>() {
				@Override
				public Boolean doInHibernate(Session session) throws HibernateException {
					String hql = "update " + table + " set status=-1 where id in(" + idString + ")";
					Query query = session.createQuery(hql);
					int count = query.executeUpdate();
					if (count > 0) {
						return true;
					}
					return false;
				}
			});
		}

	}

	@Override
	public void deleteById(final Serializable id) {
		final T entity = findById(id);
		final String className = entity.getClass().getName();
		String status = getIdIfExistsStatus(entity, entity.getClass());
		if (StringUtils.isEmpty(status)) {
			// 物理删除
			delete(entity);
		} else {
			// 逻辑删除
			hibernateTemplate.execute(new HibernateCallback<Boolean>() {
				@Override
				public Boolean doInHibernate(Session session) throws HibernateException {
					String table = className.substring(className.lastIndexOf(".") + 1);
					String hql = "update " + table + " set status = -1 where id = ?";
					Query query = session.createQuery(hql);
					query.setParameter(0, id);
					int count = query.executeUpdate();
					if (count > 0)
						return true;
					return false;
				}
			});
		}
	}

	@Override
	public void refresh(T entity) {
		hibernateTemplate.refresh(entity);
	}

	@Override
	public void flush() {
		hibernateTemplate.flush();
	}

	public Class<T> getClazz() {
		return clazz;
	}

	public void setClazz(Class<T> clazz) {
		this.clazz = clazz;
	}

	/**
	 * @param entity
	 * @param cls
	 * @return
	 */
	private String getIdIfExistsStatus(T entity, Class<?> cls) {
		if (EntityUtil.isExistsProperty(cls, "status")) {
			try {
				Method method = cls.getMethod("getId");
				return (String) method.invoke(entity);
			} catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException
					| InvocationTargetException e) {
				e.printStackTrace();
			}
		}

		return "";
	}

	/**
	 * 创建HQL并返回Query对象
	 *
	 * @param entity
	 * @param session
	 * @return
	 */
	// public abstract Query query(T entity, Session session);
	public Query query(T entity, Session session) {
		List<Object> params = new LinkedList<Object>();

		Class cls = entity.getClass();
		Type t = cls.getGenericSuperclass();
		String hql = "from " + cls.getSimpleName() + " where 1=1";
		if (t == Item.class) {
			Class superCls = cls.getSuperclass();
			Field[] fields = superCls.getDeclaredFields();
			for (Field field : fields) {
				String property = field.getName();
				String getMethod = "get" + property.substring(0, 1).toUpperCase() + property.substring(1);
				try {
					Method method = superCls.getMethod(getMethod);
					if (field.getGenericType() == Category.class) {
						Category category = (Category) method.invoke(entity);
						if (category != null) {
							hql += EntityUtil.createHQLParams(category, params, true);
						}
					} else if (field.getGenericType() == User.class) {
						User user = (User) method.invoke(entity);
						if (user != null) {
							hql += EntityUtil.createHQLParams(user, params, true);
						}
					} else {
						Object val = method.invoke(entity);
						if (StringUtils.isEmpty(val) && "status".equals(property)) {
							hql += " and status != -1";
						} else if (!StringUtils.isEmpty(val)) {
							if ("status".equals(property) || "id".equals(property)) {
								hql += " and " + property + " =?";
								params.add(val);
							} else {
								hql += " and " + property + " like ?";
								params.add("%" + val + "%");
							}
						}
					}
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				}
			}
		} else {
			hql += EntityUtil.createHQLParams(entity, params, false);
		}

		Query query = session.createQuery(hql);
		if (params != null && params.size() > 0) {
			for (int i = 0; i < params.size(); i++) {
				query.setParameter(i, params.get(i));
			}
		}

		return query;
	}
}
