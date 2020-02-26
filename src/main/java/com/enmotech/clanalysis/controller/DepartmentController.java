package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Department;
import com.enmotech.clanalysis.service.IDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/department")
public class DepartmentController extends AbstractController<Department> {
	@Autowired
	private IDeptService deptService;

	@Override
	protected IOperations<Department> getService() {
		return deptService;
	}
}
