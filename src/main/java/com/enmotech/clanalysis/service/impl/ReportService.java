package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.dao.IReportDao;
import com.enmotech.clanalysis.entity.Report;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("reportService")
public class ReportService extends AbstractService<Report> implements IReportService {
	@Autowired
	private IReportDao reportDao;

	@Override
	protected IOperations<Report> getDao() {
		return reportDao;
	}
}
