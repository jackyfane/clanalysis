package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Privilege;
import com.enmotech.clanalysis.service.IPrivilegeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/privilege")
public class PrivilegeController extends AbstractController<Privilege> {
	@Autowired
	private IPrivilegeService privilegeService;

	@Override
	protected IOperations<Privilege> getService() {
		return privilegeService;
	}
}
