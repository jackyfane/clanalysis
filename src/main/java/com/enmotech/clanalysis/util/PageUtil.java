package com.enmotech.clanalysis.util;

import org.hibernate.Query;
import org.hibernate.Session;

import java.util.List;

/**
 * Created by Administrator on 2015/5/22.
 */
public final class PageUtil {
	public static List<?> getListForHql(Session session, final String hql, final int offset, final int size) {
		Query query = session.createQuery(hql);
		return getList(query, offset, size);
	}

	;

	public static List<?> getListForSql(Session session, final String sql, final int offset, final int size) {
		Query query = session.createSQLQuery(sql);
		return getList(query, offset, size);
	}

	private static List<?> getList(Query query, final int offset, final int size) {
		query.setFirstResult(offset);
		query.setMaxResults(size);
		return query.list();
	}
}
