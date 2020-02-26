package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IReportDao;
import com.enmotech.clanalysis.entity.Report;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("reportDao")
public class ReportDao extends AbstractOperations<Report> implements IReportDao {
	public ReportDao() {
		super();
		setClazz(Report.class);
	}
}
