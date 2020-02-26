package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DBSystem;
import com.enmotech.clanalysis.service.IDBSystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping(value = "/dbSystem")
public class DBSystemController extends AbstractController<DBSystem> {
	@Autowired
	private IDBSystemService dbSystemService;

	@Override
	protected IOperations<DBSystem> getService() {
		return dbSystemService;
	}
}
