package com.enmotech.clanalysis.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "user")
@DynamicInsert(true)
public class User implements Serializable {

	private String id;

	private String name;

	private String username;

	private String email;

	private String password;

	// private Set<Privilege> privileges;

	private Set<Role> roles;

	// private Department department;

	private Integer status;

	private Date createdTime;

	private User user;

	public User() {
	}

	public User(String id) {
		this.id = id;
	}

	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(name = "user_id", length = 64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "name", length = 30)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "user_name", unique = true, nullable = false, length = 32)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(unique = true, nullable = false, length = 50)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(columnDefinition = "char(32) null default '000000'")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(columnDefinition = "int(1) null default 1 comment '-1,删除;0,未激活;1,已激活;'")
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

	// @ManyToMany(mappedBy = "users",targetEntity = Department.class, fetch =
	// FetchType.EAGER, cascade = CascadeType.REMOVE)
	// public Set<Department> getDepartments()
	// {
	// return departments;
	// }
	//
	// public void setDepartments(Set<Department> departments)
	// {
	// this.departments = departments;
	// }

	// @JoinColumn(name = "dept_id")
	// public Department getDepartment()
	// {
	// return department;
	// }
	//
	// public void setDepartment(Department department)
	// {
	// this.department = department;
	// }

	// @ManyToMany(targetEntity = Privilege.class, fetch = FetchType.EAGER,
	// cascade = CascadeType.REMOVE)
	// @JoinTable(name = "user_privilege",
	// joinColumns = {@JoinColumn(name="user_id", referencedColumnName =
	// "user_id")},
	// inverseJoinColumns = {@JoinColumn(name="privilege_id",
	// referencedColumnName="privilege_id")})
	// public Set<Privilege> getPrivileges()
	// {
	// return privileges;
	// }
	//
	// public void setPrivileges(Set<Privilege> privileges)
	// {
	// this.privileges = privileges;
	// }

	@ManyToMany(targetEntity = Role.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "user_role", joinColumns = {
			@JoinColumn(name = "user_id", referencedColumnName = "user_id") }, inverseJoinColumns = {
					@JoinColumn(name = "role_id", referencedColumnName = "role_id") })
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	@ManyToOne
	@JsonIgnore
	@JoinColumn(name = "creator_id", referencedColumnName = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
