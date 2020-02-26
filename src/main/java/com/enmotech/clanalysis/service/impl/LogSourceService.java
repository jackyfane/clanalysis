package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.ILogSourceDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.LogSource;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.ILogSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("logSourceService")
public class LogSourceService extends AbstractService<LogSource> implements ILogSourceService {
	@Autowired
	private ILogSourceDao logSourceDao;

	@Override
	protected IOperations<LogSource> getDao() {
		return logSourceDao;
	}
}
