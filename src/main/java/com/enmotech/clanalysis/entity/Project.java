package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.util.Set;

@Entity
@DynamicInsert(true)
public class Project extends Item {
	@Column(name = "zone_time", length = 6)
	private String zoneTime; // 时区

	@Column(name = "language", length = 6)
	private String language; // 语言

	private String website; // 网站

	@Column(name = "datasource_config")
	@Lob
	private String dataSourceConfig; // 数据源配置，JSON数据

	/**
	 * 模板配置
	 */
	@OneToMany(targetEntity = Template.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "project_template", joinColumns = @JoinColumn(name = "project_id") , inverseJoinColumns = @JoinColumn(name = "template_id") )
	private Set<Template> templates;

	public String getZoneTime() {
		return zoneTime;
	}

	public void setZoneTime(String zoneTime) {
		this.zoneTime = zoneTime;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getDataSourceConfig() {
		return dataSourceConfig;
	}

	public void setDataSourceConfig(String dataSourceConfig) {
		this.dataSourceConfig = dataSourceConfig;
	}

	public Set<Template> getTemplates() {
		return templates;
	}

	public void setTemplates(Set<Template> templates) {
		this.templates = templates;
	}
}
