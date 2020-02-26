package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

/**
 * 用户组
 *
 * @author Administrator
 */
@Entity
@Table(name = "user_group")
public class Group implements Serializable {
	private String id;

	private String name;

	private String description;

	private Set<User> users;

	private Set<Role> roles;

	private Set<Privilege> privileges;

	private Group parent;

	public Group() {
	}

	public Group(String id) {
		this.id = id;
	}

	@Id
	@GeneratedValue(generator = "uuid2")
	@GenericGenerator(name = "uuid2", strategy = "uuid2")
	@Column(name = "group_id", length = 64)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "group_name", length = 32)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "description")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@ManyToMany(targetEntity = User.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "group_user", joinColumns = {
			@JoinColumn(name = "group_id", referencedColumnName = "group_id") }, inverseJoinColumns = {
					@JoinColumn(name = "user_id", referencedColumnName = "user_id") })
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@ManyToMany(targetEntity = Role.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "group_role", joinColumns = {
			@JoinColumn(name = "group_id", referencedColumnName = "group_id") }, inverseJoinColumns = {
					@JoinColumn(name = "role_id", referencedColumnName = "role_id") })
	public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	@ManyToMany(targetEntity = Privilege.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "group_privilege", joinColumns = {
			@JoinColumn(name = "group_id", referencedColumnName = "group_id") }, inverseJoinColumns = {
					@JoinColumn(name = "privilege_id", referencedColumnName = "privilege_id") })
	public Set<Privilege> getPrivileges() {
		return privileges;
	}

	public void setPrivileges(Set<Privilege> privileges) {
		this.privileges = privileges;
	}

	@ManyToOne
	@JoinColumn(name = "parent_id")
	public Group getParent() {
		return parent;
	}

	public void setParent(Group parent) {
		this.parent = parent;
	}

}
