package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.Column;
import javax.persistence.Entity;

@Entity
@DynamicInsert(true)
public class Association extends Item {

	//
	// public byte[] getFileData()
	// {
	// return fileData;
	// }
	//
	// public void setFileData(byte[] fileData)
	// {
	// this.fileData = fileData;
	// }
	//
	// public String getUploadFile()
	// {
	// return uploadFile;
	// }
	//
	// public void setUploadFile(String uploadFile)
	// {
	// this.uploadFile = uploadFile;
	// }
	@Column(name = "file_path")
	private String filePath;

	@Column(name = "config", length = 1000)
	private String config;

	// @Column(name = "upload_file_name",length = 50)
	// private String uploadFile;
	//
	// @Lob
	// @Column(name="upload_file_data")
	// private byte[] fileData;
	//
	public Association() {

	}

	public Association(String id) {
		this.id = id;
	}

	public String getConfig() {
		return config;
	}

	public void setConfig(String config) {
		this.config = config;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

}
