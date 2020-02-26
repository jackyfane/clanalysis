package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IResourceDao;
import com.enmotech.clanalysis.entity.Menu;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("resourceDao")
public class ResourceDao extends AbstractOperations<Menu> implements IResourceDao {
	public ResourceDao() {
		super();
		setClazz(Menu.class);
	}

	@Override
	public List<Menu> findTreeGrid(final String hql, final List<?> params) {
		return hibernateTemplate.execute(new HibernateCallback<List<Menu>>() {
			@Override
			public List<Menu> doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);
				for (int i = 0; i < params.size(); i++) {
					query.setParameter(i + 1, params.get(i));
				}
				return query.list();
			}
		});
	}
}
