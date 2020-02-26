package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.util.StringUtils;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "department")
public class Department implements Serializable {
	private String id;

	private String name;

	private Set<User> users;

	private Set<Role> roles;

	private Integer status;

	private Date createdTime;

	private Department parent;

	private String description;

	public Department() {
	}

	public Department(String id) {
		this.id = id;
	}

	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(name = "dept_id", length = 64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "dept_name", length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToMany(targetEntity = User.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "department_user", joinColumns = {
			@JoinColumn(name = "dept_id", referencedColumnName = "dept_id") }, inverseJoinColumns = {
					@JoinColumn(name = "user_id", referencedColumnName = "user_id") })
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@ManyToMany(targetEntity = Role.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "department_role", joinColumns = {
			@JoinColumn(name = "dept_id", referencedColumnName = "dept_id") }, inverseJoinColumns = {
					@JoinColumn(name = "role_id", referencedColumnName = "role_id") })
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	@Column(columnDefinition = "int(1) null default 1 comment '-1,删除;1,正常;'")
	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Column(name = "created_time", columnDefinition = "TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	@ManyToOne
	@JoinColumn(name = "parent_id", referencedColumnName = "dept_id")
	public Department getParent() {
		if (parent != null && StringUtils.isEmpty(parent.getId()))
			return null;
		return parent;
	}

	public void setParent(Department parent) {
		this.parent = parent;
	}

	@Column(name = "description")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
