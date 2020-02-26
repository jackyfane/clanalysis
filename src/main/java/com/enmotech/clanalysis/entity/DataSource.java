package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

@Entity
@Table(name = "data_source")
@DynamicInsert(true)
public class DataSource extends Item {
	// 数据源类型：数据库、日志、本地文件
	@Column(name = "src_type", length = 6)
	private String srcType;

	// ------------标准日志-------------
	// 日志类型
	@Column(name = "log_type", length = 6)
	private String logType;

	// ------------数据库---------------
	@Column(name = "flag", length = 8)
	private String flag;

	@Column(name = "exec_sql", length = 500)
	private String sql;

	@ManyToOne
	@JoinColumn(name = "db_config_id", nullable = true)
	private DBConfig dbConfig;

	// -----------本地上传---------------
	// 文件类型
	@Column(name = "doc_type", length = 6)
	private String docType;

	// @Column(name="file")
	// private File file;

	@Column(name = "sheet_flag", length = 8)
	private String sheetFlag;

	@Column(name = "sheet_mode", length = 8)
	private String sheetMode;

	@Column(name = "region", length = 8)
	private String region;

	@Column(name = "idx_start", columnDefinition = "int(2)")
	private Integer start;

	@Column(name = "idx_end", columnDefinition = "int(2)")
	private Integer end;

	@Column(name = "file_path")
	private String filePath;

	public DataSource() {
	}

	// @Column(name = "first_row_for_cols")
	// private boolean firstRow4Cols;
	//
	// @Column(name = "upload_file_name",length = 50)
	// private String uploadFile;
	//
	// @Lob
	// @Column(name="upload_file_data")
	// private byte[] fileData;

	public DataSource(String id) {
		this.id = id;
	}

	public String getSrcType() {
		return srcType;
	}

	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}

	public String getLogType() {
		return logType;
	}

	public void setLogType(String logType) {
		this.logType = logType;
	}

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
		this.sql = sql;
	}

	public DBConfig getDbConfig() {
		return dbConfig;
	}

	public void setDbConfig(DBConfig dbConfig) {
		this.dbConfig = dbConfig;
	}

	public String getSheetFlag() {
		return sheetFlag;
	}

	public void setSheetFlag(String sheetFlag) {
		this.sheetFlag = sheetFlag;
	}

	public String getSheetMode() {
		return sheetMode;
	}

	public void setSheetMode(String sheetMode) {
		this.sheetMode = sheetMode;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public Integer getEnd() {
		return end;
	}

	public void setEnd(Integer end) {
		this.end = end;
	}

	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

}
