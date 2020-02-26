package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.LogSource;
import com.enmotech.clanalysis.service.ILogSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/logSource")
public class LogSourceController extends AbstractController<LogSource> {
	@Autowired
	private ILogSourceService logSourceService;

	@Override
	protected IOperations<LogSource> getService() {
		return logSourceService;
	}
}