package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.File;
import java.io.Serializable;

@Entity
@Table(name = "local_file")
public class LocalFile implements Serializable {

	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(length = 64)
	private String id;

	@Column(name = "file")
	private File file;

	@Column(name = "sheet_flag", length = 4)
	private String sheetFlag;

	@Column(name = "sheet_mode", length = 8)
	private String sheetMode;

	@Column(name = "region", length = 4)
	private String region;

	@Column(name = "start", columnDefinition = "int(2)")
	private Integer start;

	@Column(name = "end", columnDefinition = "int(2)")
	private Integer end;

	@Column(name = "first_row_for_cols")
	private boolean firstRow4Cols;

	@Column(name = "field")
	private String[] fields;

	public LocalFile() {
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
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

	public boolean isFirstRow4Cols() {
		return firstRow4Cols;
	}

	public void setFirstRow4Cols(boolean firstRow4Cols) {
		this.firstRow4Cols = firstRow4Cols;
	}

	public String[] getFields() {
		return fields;
	}

	public void setFields(String[] fields) {
		this.fields = fields;
	}
}
