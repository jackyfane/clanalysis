package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IDBConfigDao;
import com.enmotech.clanalysis.entity.DBConfig;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("dbConfigDao")
public class DBConfigDao extends AbstractOperations<DBConfig> implements IDBConfigDao {
	public DBConfigDao() {
		super();
		setClazz(DBConfig.class);
	}
}
