package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.ILocalFileDao;
import com.enmotech.clanalysis.entity.LocalFile;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("localFileDao")
public class LocalFileDao extends AbstractOperations<LocalFile> implements ILocalFileDao {
	public LocalFileDao() {
		super();
		setClazz(LocalFile.class);
	}

	@Override
	public Query query(final LocalFile entity, Session session) {
		List<String> params = new LinkedList<String>();

		String hql = "from Association a where 1=1";

		Query query = session.createQuery(hql);
		if (params != null && params.size() > 0) {
			for (int i = 0; i < params.size(); i++) {
				query.setParameter(i, params.get(i));
			}
		}
		return query;
	}
}
