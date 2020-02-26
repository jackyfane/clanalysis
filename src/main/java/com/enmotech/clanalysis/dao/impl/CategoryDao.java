package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.ICategoryDao;
import com.enmotech.clanalysis.entity.Category;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/5.
 */
@Repository("categoryDao")
public class CategoryDao extends AbstractOperations<Category> implements ICategoryDao {
	public CategoryDao() {
		super();
		setClazz(Category.class);
	}

	// @Override
	// public Query query(Category entity, Session session)
	// {
	// List<String> params = new LinkedList<String>();
	//
	// String hql = "from Category c where c.status != -1";
	// if (!StringUtils.isEmpty(entity.getName()))
	// {
	// hql += " and c.name = ?";
	// params.add(entity.getName());
	// }
	//
	// Query query = session.createQuery(hql);
	// if (params != null && params.size() > 0)
	// {
	// for (int i = 0; i < params.size(); i++)
	// {
	// query.setParameter(i, params.get(i));
	// }
	// }
	// return query;
	// }
}
