package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * 数据库配置
 */
@Entity
@Table(name = "db_config")
@DynamicInsert(true)
public class DBConfig implements Serializable {
	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(name = "config_id", length = 64)
	private String id;

	// 数据库名称
	@Column(name = "name", length = 30)
	private String name;

	// 数据库实例
	@Column(name = "instance", length = 20)
	private String instance;

	// 数据库用户
	@Column(name = "user_name", length = 30)
	private String username;

	// 登陆密码
	@Column(name = "password", length = 32)
	private String password;

	// 主机（ip）
	@Column(name = "host", length = 50)
	private String host;

	// 端口
	@Column(name = "port", length = 6)
	private String port;

	// 驱动
	@Column(name = "driver_class", length = 50)
	private String driverClass;

	// @ManyToOne
	// @JoinColumn(name = "dbsys_id")
	// private DBSystem dbSystem;

	@Column(columnDefinition = "int(1) null default 1")
	private Integer status;

	@Column(name = "created_time", columnDefinition = "TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	private Date createdTime;

	public DBConfig() {
	}

	public DBConfig(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInstance() {
		return instance;
	}

	public void setInstance(String instance) {
		this.instance = instance;
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

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	// public DBSystem getDbSystem()
	// {
	// return dbSystem;
	// }
	//
	// public void setDbSystem(DBSystem dbSystem)
	// {
	// this.dbSystem = dbSystem;
	// }

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getDriverClass() {
		return driverClass;
	}

	public void setDriverClass(String driverClass) {
		this.driverClass = driverClass;
	}

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
}
