package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IElementDao;
import com.enmotech.clanalysis.entity.Element;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("elementDao")
public class ElementDao extends AbstractOperations<Element> implements IElementDao {
	public ElementDao() {
		super();
		setClazz(Element.class);
	}

	// @Override
	// public Query query(final Element entity, Session session)
	// {
	// List<String> params = new LinkedList<String>();
	// String hql = "from Element a where 1=1";
	// if (!StringUtils.isEmpty(entity.getName()))
	// {
	// hql += " and a.name = ?";
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
