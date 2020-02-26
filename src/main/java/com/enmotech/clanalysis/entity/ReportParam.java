package com.enmotech.clanalysis.entity;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/23. 查看报表参数
 */
public class ReportParam {
	private long[][] timestamp;

	private String template;

	private String report;

	private String element;

	private String type;

	private String subType;

	private String xAxis;

	private List<Map<String, String>> yAxis;

	private int total;

	private int row;

	public long[][] getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(long[][] timestamp) {
		this.timestamp = timestamp;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public String getReport() {
		return report;
	}

	public void setReport(String report) {
		this.report = report;
	}

	public String getxAxis() {
		return xAxis;
	}

	public void setxAxis(String xAxis) {
		this.xAxis = xAxis;
	}

	public List<Map<String, String>> getyAxis() {
		return yAxis;
	}

	public void setyAxis(List<Map<String, String>> yAxis) {
		this.yAxis = yAxis;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public String getElement() {
		return element;
	}

	public void setElement(String element) {
		this.element = element;
	}

	// @Override
	// public String toString()
	// {
	// return "ReportParam{" +
	// "timestamp=" + Arrays.toString(timestamp) +
	// ", template='" + template + '\'' +
	// ", report='" + report + '\'' +
	// ", type='" + type + '\'' +
	// ", subType='" + subType + '\'' +
	// ", xAxis='" + xAxis + '\'' +
	// ", yAxis=" + Arrays.toString(yAxis) +
	// ", total=" + total +
	// ", row=" + row +
	// ", group=" + group +
	// '}';
	// }
}
