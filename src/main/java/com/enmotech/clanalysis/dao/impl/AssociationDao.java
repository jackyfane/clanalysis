package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IAssociationDao;
import com.enmotech.clanalysis.entity.Association;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("associationDao")
public class AssociationDao extends AbstractOperations<Association> implements IAssociationDao {
	public AssociationDao() {
		super();
		setClazz(Association.class);
	}

	// @Override
	// public Query query(final Association entity, Session session)
	// {
	// List<String> params = new LinkedList<String>();
	// String hql = "from Association a where a.status != -1 ";
	// if (!StringUtils.isEmpty(entity.getName()))
	// {
	// hql += " and a.name = ?";
	// params.add(entity.getName());
	// }
	// if (entity.getCategory() != null)
	// {
	// hql += " and a.category.id = ?";
	// params.add(entity.getCategory().getId());
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
