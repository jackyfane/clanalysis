package com.enmotech.clanalysis.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "category")
@DynamicInsert(true)
public class Category implements Serializable {
	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(name = "category_id", length = 64)
	private String id;

	@Column(length = 30, unique = true)
	private String name;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@Column(name = "status", columnDefinition = "int(1) null default 1")
	private Integer status;

	@Column(name = "created_time", columnDefinition = "TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP")
	@OrderBy("desc")
	private Date createdTime;

	public Category() {
	}

	public Category(String id) {
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
}
