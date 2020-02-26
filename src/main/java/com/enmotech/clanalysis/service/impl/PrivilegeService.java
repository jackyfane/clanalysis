package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.dao.IPrivilegeDao;
import com.enmotech.clanalysis.entity.Privilege;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IPrivilegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("privilegeService")
public class PrivilegeService extends AbstractService<Privilege> implements IPrivilegeService {
	@Autowired
	private IPrivilegeDao privilegeDao;

	@Override
	protected IOperations<Privilege> getDao() {
		return privilegeDao;
	}
}
