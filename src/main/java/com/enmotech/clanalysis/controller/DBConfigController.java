package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DBConfig;
import com.enmotech.clanalysis.service.IDBConfigService;
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
@RequestMapping(value = "/dbConfig")
public class DBConfigController extends AbstractController<DBConfig> {
	@Autowired
	private IDBConfigService dbConfigService;

	@Override
	protected IOperations<DBConfig> getService() {
		return dbConfigService;
	}

	/**
	 * 获取数据库表
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/tables")
	@ResponseBody
	protected List<Map<String, String>> getTables(String id) {
		return dbConfigService.findTables(id);
	}

	/**
	 * 获取表的所有字段
	 *
	 * @param id
	 * @param table
	 * @return
	 */
	@RequestMapping(value = "/fields")
	@ResponseBody
	protected List<Map<String, String>> getFields(String id, String table) {
		return dbConfigService.findFields(id, table);
	}
}
