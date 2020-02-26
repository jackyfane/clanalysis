package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IDBConfigDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.DBConfig;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IDBConfigService;
import com.enmotech.clanalysis.util.DBHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("dbConfigService")
public class DBConfigService extends AbstractService<DBConfig> implements IDBConfigService {
	@Autowired
	private IDBConfigDao dbConfigDao;

	@Override
	protected IOperations<DBConfig> getDao() {
		return dbConfigDao;
	}

	/**
	 * 查询所有的表
	 *
	 * @param id
	 * @return
	 */
	@Override
	public List<Map<String, String>> findTables(String id) {
		Map<String, Object> map = getDBHelper(id);
		DBHelper dbHelper = (DBHelper) map.get("dbHelper");
		List<String> dataset = dbHelper.getTables(map.get("query").toString());

		return this.generateMapList(dataset);
	}

	/**
	 * 查询指定表的所以字段
	 *
	 * @return
	 */
	public List<Map<String, String>> findFields(String id, String table) {
		Map<String, Object> map = getDBHelper(id);
		DBHelper dbHelper = (DBHelper) map.get("dbHelper");
		List<String> dataset = dbHelper.getColumns("select * from " + table + " where 1=2");

		return this.generateMapList(dataset);
	}

	/**
	 * @param dataset
	 * @return
	 */
	public List<Map<String, String>> generateMapList(List<String> dataset) {
		List<Map<String, String>> mapList = new LinkedList<Map<String, String>>();
		for (String data : dataset) {
			Map<String, String> tableMap = new HashMap<String, String>();
			tableMap.put("id", data);
			tableMap.put("name", data);
			mapList.add(tableMap);
		}
		return mapList;
	}

	/**
	 * @param confId
	 * @return
	 */
	public Map<String, Object> getDBHelper(String confId) {
		DBConfig config = findById(confId);
		Map<String, Object> map = this.getDBUrl(config);

		DBHelper dbHelper = new DBHelper(config.getDriverClass());
		dbHelper.setUrl(map.get("url").toString());
		dbHelper.setUsername(config.getUsername());
		dbHelper.setPassword(config.getPassword());

		map.put("dbHelper", dbHelper);

		return map;
	}

	/**
	 * 获取数据库URL
	 *
	 * @param config
	 * @return
	 */
	private Map<String, Object> getDBUrl(DBConfig config) {
		Map<String, Object> map = new HashMap<String, Object>();

		String url = "";
		String queryTablesSQL = "";
		switch (config.getDriverClass()) {
		case "org.gjt.mm.mysql.Driver":// MYSQL
		case "com.mysql.jdbc.Driver":
			url = "jdbc:mysql://" + config.getHost() + ":" + config.getPort() + "/" + config.getInstance()
					+ "?useUnicode=true&characterEncoding=UTF-8";
			queryTablesSQL = "show tables";
			break;
		case "oracle.jdbc.driver.OracleDriver":// Oracle
			url = "jdbc:oracle:thin:@" + config.getHost() + ":" + config.getPort() + ":" + config.getInstance();
			queryTablesSQL = "select table_name from user_tables";
			break;
		case "com.microsoft.jdbc.sqlserver.SQLServerDriver":// SQLServer
															// 7.0/2000
			url = "jdbc:microsoft:sqlserver://" + config.getHost() + ":" + config.getPort() + ";DatabaseName="
					+ config.getInstance();
			queryTablesSQL = "select [name] as name from [sysobjects] where [type] = 'u'";
			break;
		case "com.microsoft.sqlserver.jdbc.SQLServerDriver":// SQLServer 2005
			url = "jdbc:sqlserver://" + config.getHost() + ":" + config.getPort() + ";DatabaseName="
					+ config.getInstance();
			queryTablesSQL = "select [name] as name from [sysobjects] where [type] = 'u'";
			break;
		case "org.postgresql.Driver":// postgresql
			url = "jdbc:postgresql://" + config.getHost() + ":" + config.getPort() + "/" + config.getInstance();
			queryTablesSQL = "select tablename from pg_tables where schemaname='public'";
			break;
		case "com.sybase.jdbc2.jdbc.SybDriver":// sybase
			url = "jdbc:sybase:Tds:" + config.getHost() + ":" + config.getPort() + "/" + config.getInstance();
			queryTablesSQL = "select name from sysobjects where xtype='U'";
			break;
		case "com.ibm.db2.jdbc.net.DB2Driver":// db2
			url = "jdbc:db2://" + config.getHost() + ":" + config.getPort() + "/" + config.getInstance();
			queryTablesSQL = "select tabname from syscat.tables where tabschema = current schema";
			break;
		case "com.informix.jdbc.IfxDriver":// informix
			url = "jdbc:informix-sqli://" + config.getHost() + ":" + config.getPort() + "/" + config.getInstance()
					+ ":INFORMIXSERVER=myserver";
			break;
		}

		map.put("url", url);
		map.put("query", queryTablesSQL);

		return map;
	}
}
