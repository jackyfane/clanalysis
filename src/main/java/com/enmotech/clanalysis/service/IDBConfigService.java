package com.enmotech.clanalysis.service;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DBConfig;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/6/10.
 */
public interface IDBConfigService extends IOperations<DBConfig> {
	/**
	 * 查询配置数据库的所有用户表
	 *
	 * @param id
	 * @return
	 */
	public List<Map<String, String>> findTables(String id);

	/**
	 * 获取配置数据库指定表的所有字段
	 *
	 * @param id
	 * @param table
	 * @return
	 */
	public List<Map<String, String>> findFields(String id, String table);

	/**
	 * @param confId
	 * @return
	 */
	public Map<String, Object> getDBHelper(String confId);

	/**
	 * @param dataset
	 * @return
	 */
	public List<Map<String, String>> generateMapList(List<String> dataset);
}
