package com.enmotech.clanalysis.util;

import java.sql.*;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/8/18.
 */
public class DBHelper {
	private String url;

	private String username;

	private String password;

	private String driverClass;

	public DBHelper(String driverClass) {
		try {
			this.driverClass = driverClass;
			Class.forName(this.driverClass).newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public DBHelper(String url, String username, String password, String driverClass) {
		this(driverClass);
		this.url = url;
		this.username = username;
		this.password = password;
	}

	/**
	 * 获取数据库连接
	 *
	 * @return
	 */
	public Connection getConn() throws SQLException {
		return DriverManager.getConnection(this.url, this.username, this.password);
	}

	/**
	 * 获取数据库连接
	 *
	 * @param url
	 * @param username
	 * @param password
	 * @return
	 */
	public Connection getConn(String url, String username, String password) throws SQLException {
		return DriverManager.getConnection(url, username, password);
	}

	/**
	 * 根据SQL查询数据 返回的数据库为List集合，list的map对象，map是字段和字段对应的值
	 *
	 * @param queryString
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> query(String queryString, Object... params) {
		List<Map<String, Object>> dataset = new LinkedList<Map<String, Object>>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			ps = conn.prepareStatement(queryString);
			if (params != null && params.length > 0) {
				for (int i = 1; i <= params.length; i++)
					ps.setObject(i, params[i]);
			}
			rs = ps.executeQuery();
			ResultSetMetaData metaData = rs.getMetaData();
			int count = metaData.getColumnCount();
			while (rs.next()) {
				Map<String, Object> map = new LinkedHashMap<String, Object>();
				for (int i = 1; i < count; i++) {
					String column = metaData.getColumnName(i);
					map.put(column, rs.getObject(column));
				}
				dataset.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return dataset;
	}

	/**
	 * 获取
	 *
	 * @param queryString
	 * @return
	 */
	public List<String> getTables(String queryString) {
		List<String> tables = new LinkedList<String>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = getConn();
			ps = conn.prepareStatement(queryString);
			rs = ps.executeQuery();
			while (rs.next()) {
				tables.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return tables;
	}

	/**
	 * @param queryString
	 * @return
	 */
	public List<String> getColumns(String queryString) {

		List<String> fields = new LinkedList<String>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = getConn();
			ps = conn.prepareStatement(queryString);
			rs = ps.executeQuery();
			ResultSetMetaData metaData = rs.getMetaData();
			int count = metaData.getColumnCount();
			for (int i = 1; i <= count; i++) {
				String field = metaData.getColumnName(i);
				fields.add(field);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return fields;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
