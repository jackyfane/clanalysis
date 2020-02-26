package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IDeptDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Department;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("deptService")
public class DeptService extends AbstractService<Department> implements IDeptService {
	@Autowired
	private IDeptDao deptDao;

	@Override
	protected IOperations<Department> getDao() {
		return deptDao;
	}
}
