package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Report;
import com.enmotech.clanalysis.service.IReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/report")
public class ReportController extends AbstractController<Report> {
	@Autowired
	private IReportService reportService;

	@Override
	protected IOperations<Report> getService() {
		return reportService;
	}
}
