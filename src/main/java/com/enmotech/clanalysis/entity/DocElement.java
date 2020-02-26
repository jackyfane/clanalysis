package com.enmotech.clanalysis.entity;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class DocElement {

	private String docType;

	private String docName;

	private String title;

	private String subTitle;

	private float width;

	private float height;

	private String html;

	private ReportElement[] elements;

	public DocElement() {
	}

	public DocElement(String docType, JSONObject json) {
		this.docType = docType;
		generateToObject(json);

	}

	/**
	 * @param json
	 */
	private void generateToObject(JSONObject json) {
		this.docName = json.getString("docName");
		this.title = json.getString("title");
		this.subTitle = json.getString("subTitle");
		this.width = json.getInt("width");
		this.height = json.getInt("height");
		this.html = json.getString("html");
		JSONArray array = json.getJSONArray("elements");
		elements = new ReportElement[array.size()];
		for (int i = 0; i < array.size(); i++) {
			JSONObject obj = array.getJSONObject(i);
			ReportElement reportEl = new ReportElement(obj.getString("type"), obj.getInt("left"), obj.getInt("top"),
					obj.getInt("width"), obj.getInt("height"), obj.getString("svg"));
			elements[i] = reportEl;
		}
	}

	public String getDocType() {
		return docType;
	}

	public void setDocType(String docType) {
		this.docType = docType;
	}

	public ReportElement[] getElements() {
		return elements;
	}

	public void setElements(ReportElement[] elements) {
		this.elements = elements;
	}

	public float getWidth() {
		return width;
	}

	public void setWidth(float width) {
		this.width = width;
	}

	public float getHeight() {
		return height;
	}

	public void setHeight(float height) {
		this.height = height;
	}

	public String getDocName() {
		return docName;
	}

	public void setDocName(String docName) {
		this.docName = docName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubTitle() {
		return subTitle;
	}

	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

}
