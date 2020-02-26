package com.enmotech.clanalysis.entity;

import com.enmotech.clanalysis.util.DateUtils;
import com.fasterxml.jackson.annotation.JsonIgnore;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "resource")
@DynamicInsert(true)
public class Menu extends TreeGrid {

	private String name;

	private String linkURL;

	private String identify;

	private String icon;

	private Integer position;

	private Boolean enable;

	private Boolean visible;

	private String description;

	private Menu parent;

	private List<Menu> children;

	public Menu() {
	}

	public Menu(String id) {
		this.id = id;
	}

	@Column(name = "menu_name", length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "link_url", length = 100)
	public String getLinkURL() {
		return linkURL;
	}

	public void setLinkURL(String linkURL) {
		this.linkURL = linkURL;
	}

	@Column(name = "identify", length = 32, unique = true)
	public String getIdentify() {
		return identify;
	}

	public void setIdentify(String identify) {
		this.identify = identify;
	}

	@Column(name = "icon", length = 30)
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@Column(length = 3)
	@OrderBy("asc")
	public Integer getPosition() {
		return position;
	}

	public void setPosition(Integer position) {
		this.position = position;
	}

	@Column(name = "is_visual", columnDefinition = "bit(1) default 1 comment false,不显示;true,显示;")
	public Boolean getVisible() {
		return visible;
	}

	public void setVisible(Boolean visible) {
		this.visible = visible;
	}

	@Column(name = "description")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "is_enable")
	public Boolean getEnable() {
		return enable;
	}

	public void setEnable(Boolean enable) {
		this.enable = enable;
	}

	@ManyToOne(cascade = { CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "parent_id", nullable = true)
	public Menu getParent() {
		if (parent != null && StringUtils.isEmpty(parent.getId()))
			return null;
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}

	@OneToMany(cascade = { CascadeType.MERGE }, fetch = FetchType.EAGER, mappedBy = "parent")
	@JsonIgnore
	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

	@Override
	public String toString() {
		JSONObject jo = new JSONObject();
		jo.put("id", id);
		jo.put("name", name);
		jo.put("linkURL", linkURL);
		jo.put("identify", identify);
		jo.put("icon", icon);
		jo.put("description", description == null ? "" : description);
		jo.put("parent", parent == null ? "" : parent.getId());
		jo.put("parentName", parent == null ? "" : parent.getName());
		jo.put("createdTime", createdTime == null ? "" : DateUtils.getTimestamp(createdTime, "yyyy-MM-dd HH:mm:ss"));
		jo.put("enable", enable);
		jo.put("visible", visible);
		jo.put("position", position);
		jo.put("level", level);
		jo.put("isLeaf", leaf);
		jo.put("expanded", expanded);
		jo.put("loaded", loaded);
		jo.put("status", status);
		jo.put("children", new JSONObject());

		return jo.toString();

	}
}
