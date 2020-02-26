package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IDBSourceDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DBSource;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IDBSourceService;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("dbSourceService")
public class DBSourceService extends AbstractService<DBSource> implements IDBSourceService {
	private IDBSourceDao dbSourceDao;

	@Override
	protected IOperations<DBSource> getDao() {
		return dbSourceDao;
	}
}
