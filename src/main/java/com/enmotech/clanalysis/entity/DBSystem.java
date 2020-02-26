package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 数据库系统：主流的有Oracle，MySQL，DB2, SQLServer
 */
@Entity
@Table(name = "db_system")
public class DBSystem implements Serializable {
	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(name = "dbs_id", length = 64)
	private String id;

	@Column(name = "name", length = 32, unique = true)
	private String name;

	@Column(length = 6)
	private String port;

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

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}
}
