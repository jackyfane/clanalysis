package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 数据库源
 */
@Entity
@Table(name = "db_source")
public class DBSource implements Serializable {

	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(name = "dbs_id", length = 64)
	private String id;

	@Column(name = "flag", length = 8)
	private String flag;

	@Column(name = "exec_sql")
	private String sql;

	@ManyToOne
	@JoinColumn(name = "db_config_id")
	private DBConfig dbConfig;

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		if ("table".equals(flag)) {
			System.out.println(sql);
		}
		this.sql = sql;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public DBConfig getDbConfig() {
		return dbConfig;
	}

	public void setDbConfig(DBConfig dbConfig) {
		this.dbConfig = dbConfig;
	}
}
