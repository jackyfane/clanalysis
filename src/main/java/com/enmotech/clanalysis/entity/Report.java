package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "report")
@DynamicInsert(true)
public class Report extends Item {
	// 报表维度
	@ManyToMany(targetEntity = Element.class, fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
	@JoinTable(name = "report_dimension_index", joinColumns = @JoinColumn(name = "report_id") , inverseJoinColumns = @JoinColumn(name = "element_id") )
	private Set<Element> dimension;

	// 运算模式（1、统计模式；2、计算模式）
	@Column(name = "model", columnDefinition = "char(1)")
	private String model;

	// 统计指标
	// @ManyToMany(targetEntity = Element.class, fetch = FetchType.EAGER,
	// cascade = CascadeType.REMOVE)
	// @JoinTable(name = "report_statistical_index", joinColumns =
	// @JoinColumn(name = "report_id"), inverseJoinColumns = @JoinColumn(name =
	// "element_id"))
	// private Set<Element> statistical;
	@Column(name = "statistical_index")
	private String[] statistical;

	// 运算表达式
	@Column(name = "expression_value")
	private String expression;

	@Column(name = "log_source", length = 11)
	private String logSource;

	@Column(name = "v_id", length = 30)
	private String vid;

	// ------------------图标配置参数------------------------
	// //使用JSON格式存储
	// @Column(name = "chart_conf")
	// private String chartConf;

	@Column(name = "page_rows", columnDefinition = "int(3)")
	private Integer pageRows; // 表格单页行数

	@Column(name = "total_rows", columnDefinition = "int(3)")
	private Integer totalRows; // 表格总行数

	@Column(name = "line_chart")
	private Boolean line = true;

	@Column(name = "column_chart")
	private Boolean column;

	@Column(name = "pie_chart")
	private Boolean pie;

	@Column(name = "bar_chart")
	private Boolean bar;

	@Column(name = "sky_chart")
	private Boolean sky;

	@Column(name = "boxplot_chart")
	private Boolean boxplot;

	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}

	public Integer getPageRows() {
		return pageRows;
	}

	public void setPageRows(Integer pageRows) {
		this.pageRows = pageRows;
	}

	public Integer getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(Integer totalRows) {
		this.totalRows = totalRows;
	}

	public Boolean getLine() {
		return line;
	}

	public void setLine(Boolean line) {
		this.line = line;
	}

	public Boolean getColumn() {
		return column;
	}

	public void setColumn(Boolean column) {
		this.column = column;
	}

	public Boolean getPie() {
		return pie;
	}

	public void setPie(Boolean pie) {
		this.pie = pie;
	}

	public Boolean getBar() {
		return bar;
	}

	public void setBar(Boolean bar) {
		this.bar = bar;
	}

	public Boolean getSky() {
		return sky;
	}

	public void setSky(Boolean sky) {
		this.sky = sky;
	}

	public Boolean getBoxplot() {
		return boxplot;
	}

	public void setBoxplot(Boolean boxplot) {
		this.boxplot = boxplot;
	}

	public Set<Element> getDimension() {
		return dimension;
	}

	public void setDimension(Set<Element> dimension) {
		this.dimension = dimension;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String[] getStatistical() {
		return statistical;
	}

	public void setStatistical(String[] statistical) {
		this.statistical = statistical;
	}

	public String getLogSource() {
		return logSource;
	}

	public void setLogSource(String logSource) {
		this.logSource = logSource;
	}

	public String getVid() {
		return vid;
	}

	public void setVid(String vid) {
		this.vid = vid;
	}
}
