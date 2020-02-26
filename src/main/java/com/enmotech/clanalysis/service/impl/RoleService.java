package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.dao.IRoleDao;
import com.enmotech.clanalysis.entity.Role;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("roleService")
public class RoleService extends AbstractService<Role> implements IRoleService {
	@Autowired
	private IRoleDao roleDao;

	@Override
	protected IOperations<Role> getDao() {
		return roleDao;
	}
}
