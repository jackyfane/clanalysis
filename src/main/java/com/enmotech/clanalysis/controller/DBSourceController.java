package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DBSource;
import com.enmotech.clanalysis.service.IDBSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping(value = "/dbSource")
public class DBSourceController extends AbstractController<DBSource> {
	@Autowired
	private IDBSourceService dbSourceService;

	@Override
	protected IOperations<DBSource> getService() {
		return dbSourceService;
	}
}
