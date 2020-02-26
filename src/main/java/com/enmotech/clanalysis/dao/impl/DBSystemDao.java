package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IDBSystemDao;
import com.enmotech.clanalysis.entity.DBSystem;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("dbSystemDao")
public class DBSystemDao extends AbstractOperations<DBSystem> implements IDBSystemDao {
	public DBSystemDao() {
		super();
		setClazz(DBSystem.class);
	}
}
