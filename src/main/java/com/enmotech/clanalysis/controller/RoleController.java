package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Role;
import com.enmotech.clanalysis.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/role")
public class RoleController extends AbstractController<Role> {
	@Autowired
	private IRoleService roleService;

	@Override
	protected IOperations<Role> getService() {
		return roleService;
	}
}
