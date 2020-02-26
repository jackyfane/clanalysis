package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.ILogSourceDao;
import com.enmotech.clanalysis.entity.LogSource;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("logSourceDao")
public class LogSourceDao extends AbstractOperations<LogSource> implements ILogSourceDao {
	public LogSourceDao() {
		super();
		setClazz(LogSource.class);
	}
}
