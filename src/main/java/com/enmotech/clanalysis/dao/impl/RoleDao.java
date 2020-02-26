package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IRoleDao;
import com.enmotech.clanalysis.entity.Role;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("roleDao")
public class RoleDao extends AbstractOperations<Role> implements IRoleDao {
	public RoleDao() {
		super();
		setClazz(Role.class);
	}
}
