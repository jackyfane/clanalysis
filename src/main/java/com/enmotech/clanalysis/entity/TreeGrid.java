package com.enmotech.clanalysis.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class TreeGrid implements Serializable {

	protected String id;

	protected Integer level;

	protected Boolean leaf;

	protected Boolean expanded;

	protected Boolean loaded;

	protected Integer status;

	protected Date createdTime;

	public TreeGrid() {
	}

	public TreeGrid(String id) {
		this.id = id;
	}

	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(name = "menu_id", length = 64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "level", columnDefinition = "int(2) default 0")
	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	@Column(name = "is_leaf", columnDefinition = "bit default 1")
	public Boolean getLeaf() {
		return leaf;
	}

	public void setLeaf(Boolean leaf) {
		this.leaf = leaf;
	}

	@Column(name = "is_expand", columnDefinition = "bit default 0")
	public Boolean getExpanded() {
		return expanded;
	}

	public void setExpanded(Boolean expanded) {
		this.expanded = expanded;
	}

	@Column(name = "status", columnDefinition = "int(1) default 1")
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	@Column(name = "created_time", columnDefinition = "TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	@Column(name = "is_loaded", columnDefinition = "bit default 1")
	public Boolean getLoaded() {
		return loaded;
	}

	public void setLoaded(Boolean loaded) {
		this.loaded = loaded;
	}
}
