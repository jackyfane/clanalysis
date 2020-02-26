package com.enmotech.clanalysis.entity;

public class ReportElement {
	private String type;

	private float x;

	private float y;

	private float width;

	private float height;

	private String svg;

	public ReportElement(String type, float x, float y, float width, float height, String svg) {
		super();
		this.type = type;
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.svg = svg;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSvg() {
		return svg;
	}

	public void setSvg(String svg) {
		this.svg = svg;
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

	public void setHeight(int height) {
		this.height = height;
	}

	public float getX() {
		return x;
	}

	public void setX(float x) {
		this.x = x;
	}

	public float getY() {
		return y;
	}

	public void setY(float y) {
		this.y = y;
	}

}
