package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IFilterDao;
import com.enmotech.clanalysis.entity.Filter;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("filterDao")
public class FilterDao extends AbstractOperations<Filter> implements IFilterDao {
	public FilterDao() {
		super();
		setClazz(Filter.class);
	}
}
