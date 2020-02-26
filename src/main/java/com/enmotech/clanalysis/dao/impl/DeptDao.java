package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IDeptDao;
import com.enmotech.clanalysis.entity.Department;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("deptDao")
public class DeptDao extends AbstractOperations<Department> implements IDeptDao {
	public DeptDao() {
		super();
		setClazz(Department.class);
	}
}
