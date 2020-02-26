package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IDataSourceDao;
import com.enmotech.clanalysis.entity.DataSource;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("dataSourceDao")
public class DataSourceDao extends AbstractOperations<DataSource> implements IDataSourceDao {
	public DataSourceDao() {
		super();
		setClazz(DataSource.class);
	}
}
