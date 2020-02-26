package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name = "template")
@DynamicInsert(true)
public class Template extends Item {
	// @OneToMany(targetEntity = Report.class,fetch = FetchType.EAGER, cascade =
	// CascadeType.ALL)
	// @JoinTable(name = "template_report", joinColumns = @JoinColumn(name =
	// "template_id"), inverseJoinColumns = @JoinColumn(name = "report_id"))
	// private Set<Report> reports = new HashSet<Report>();
	//
	// @ManyToMany(targetEntity = Project.class,mappedBy = "templates",fetch =
	// FetchType.EAGER, cascade = CascadeType.ALL)
	// private Set<Project> projects;
	//
	// public Set<Project> getProjects()
	// {
	// return projects;
	// }
	//
	// public void setProject(
	// Set<Project> projects)
	// {
	// this.projects = projects;
	// }
	//
	// public Set<Report> getReports()
	// {
	// return reports;
	// }
	//
	// public void setReports(Set<Report> reports)
	// {
	// this.reports = reports;
	// }

	@Column(name = "chart_config")
	@Lob
	private String chartConfig;

	public Template() {
	}

	public Template(String id) {
		this.id = id;
	}

	public String getChartConfig() {
		return chartConfig;
	}

	public void setChartConfig(String chartConfig) {
		this.chartConfig = chartConfig;
	}
}
