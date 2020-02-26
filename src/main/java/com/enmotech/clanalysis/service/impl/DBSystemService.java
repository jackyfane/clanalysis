package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IDBSystemDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DBSystem;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IDBSystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("dbSystemService")
public class DBSystemService extends AbstractService<DBSystem> implements IDBSystemService {
	@Autowired
	private IDBSystemDao dbSystemDao;

	@Override
	protected IOperations<DBSystem> getDao() {
		return dbSystemDao;
	}
}
