package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IDBSourceDao;
import com.enmotech.clanalysis.entity.DBSource;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("dbSourceDao")
public class DBSourceDao extends AbstractOperations<DBSource> implements IDBSourceDao {
	public DBSourceDao() {
		super();
		setClazz(DBSource.class);
	}
}
