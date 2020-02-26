package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IPrivilegeDao;
import com.enmotech.clanalysis.entity.Privilege;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("permissionDao")
public class PrivilegeDao extends AbstractOperations<Privilege> implements IPrivilegeDao {
	public PrivilegeDao() {
		super();
		setClazz(Privilege.class);
	}
}
