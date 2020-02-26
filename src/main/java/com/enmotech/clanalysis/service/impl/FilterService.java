package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IFilterDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Filter;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IFilterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("filterService")
public class FilterService extends AbstractService<Filter> implements IFilterService {

	@Autowired
	private IFilterDao filterDao;

	@Override
	protected IOperations<Filter> getDao() {
		return filterDao;
	}
}
