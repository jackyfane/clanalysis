package com.enmotech.clanalysis.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class Item implements Serializable {
	@Id
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@GeneratedValue(generator = "uuid2")
	@Column(length = 64)
	protected String id;

	@Column(name = "name", length = 32)
	protected String name;

	@Column(name = "title", length = 50)
	protected String title;

	@Column(name = "description", length = 200)
	protected String description;

	@ManyToMany(targetEntity = User.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "item_visible_user", joinColumns = @JoinColumn(name = "item_id") , inverseJoinColumns = @JoinColumn(name = "user_id") )
	protected Set<User> visibleUser;

	@Column(name = "only_edit_by_creator")
	protected Boolean editByCreator;

	protected Date createdTime;

	@ManyToOne
	@JoinColumn(name = "user_id", referencedColumnName = "user_id")
	protected User user;

	@ManyToOne
	@JoinColumn(name = "category_id")
	protected Category category;

	/**
	 * 状态,1:正常; 0:关闭; -1：删除
	 */
	@Column(name = "status", columnDefinition = "int(1) null default 1")
	private Integer status;

	public Item() {
	}

	public Item(String id) {
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getEditByCreator() {
		return editByCreator;
	}

	public void setEditByCreator(Boolean editByCreator) {
		this.editByCreator = editByCreator;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	@Column(name = "created_time", columnDefinition = "TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	@OrderBy("desc")
	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Set<User> getVisibleUser() {
		return visibleUser;
	}

	public void setVisibleUser(Set<User> visibleUser) {
		this.visibleUser = visibleUser;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}
