package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DataSource;
import com.enmotech.clanalysis.service.IDataSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping(value = "/dataSource")
public class DataSourceController extends AbstractController<DataSource> {
	@Autowired
	private IDataSourceService dataSourceService;

	@Override
	protected IOperations<DataSource> getService() {
		return dataSourceService;
	}

	@RequestMapping(value = "/logsource")
	@ResponseBody
	public String getLogSources() {
		String json = dataSourceService.getLogSources();
		return json;
	}

	/**
	 * @param sid
	 *            日志源ID
	 * @return
	 */
	@RequestMapping(value = "/vids")
	@ResponseBody
	public String getVids(String sid) {
		String vids = dataSourceService.getVids(sid);
		return vids;
	}

	/**
	 * @param sid
	 * @return
	 */
	@RequestMapping(value = "/fields")
	@ResponseBody
	protected List<Map<String, String>> getFields(String sid) {
		return dataSourceService.getFields(sid);
	}
}
