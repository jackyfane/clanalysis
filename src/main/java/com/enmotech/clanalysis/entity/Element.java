package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

@Entity
@Table(name = "element")
@DynamicInsert(true)
public class Element extends Item {
	// //基础字段
	// @Column(name = "base_field", length = 30)
	// private String baseField;
	//
	// //查询标识
	// @Column(name = "query_field", length = 50)
	// private String queryField;
	// @Column(name = "idxs", length = 200)
	// private String idxs;

	// 计算模式(1.所有值，2.含有固定值，3.正则表达式)
	@Column(name = "exp_type", length = 5)
	private String expType;

	@Column(name = "fixed_portion", length = 50)
	private String fixedPortion;

	// 表达式
	@Column(name = "express_regular", length = 100)
	private String expressRegular;

	// 统计方法（1.分类，维度标识；2.求和，指标标识）
	@Column(name = "element_type", length = 6)
	private String elementType;

	// 货币单位
	@Column(name = "currency_unit")
	private String currencyUnit;

	// 字符转换标识
	@Column(name = "is_convert")
	private Boolean convert;

	// @ManyToOne
	// @JoinColumn(name = "log_source_id")
	// private LogSource logSource;

	@Column(name = "log_source", length = 11)
	private String logSource;

	@Column(name = "family", length = 12)
	private String family;

	@Column(name = "search_column", length = 12)
	private String searchCol;

	// 字符名称转换
	// 使用外部关联文件的值
	@ManyToOne(targetEntity = Association.class, fetch = FetchType.EAGER)
	@JoinColumn(name = "association_id")
	private Association association;

	// 源字符位置
	@Column(name = "src_chr_index", length = 5)
	private Integer srcChrIndex;

	// 转换字符位置
	@Column(name = "convert_chr_index")
	private Integer convertChrIndex;

	// 复合指标标识
	@Column(name = "composite")
	private Boolean composite;

	// 复合指标计算表达式
	@Column(name = "complex_expression")
	private String complexExp;

	public Element() {

	}

	public Element(String id) {
		this.id = id;
	}

	// public String getIdxs()
	// {
	// return idxs;
	// }
	//
	// public void setIdxs(String idxs)
	// {
	// this.idxs = idxs;
	// }

	public String getExpType() {
		return expType;
	}

	public void setExpType(String expType) {
		this.expType = expType;
	}

	public String getFixedPortion() {
		return fixedPortion;
	}

	public void setFixedPortion(String fixedPortion) {
		this.fixedPortion = fixedPortion;
	}

	public String getExpressRegular() {
		return expressRegular;
	}

	public void setExpressRegular(String expressRegular) {
		this.expressRegular = expressRegular;
	}

	public String getElementType() {
		return elementType;
	}

	public void setElementType(String elementType) {
		this.elementType = elementType;
	}

	public String getCurrencyUnit() {
		return currencyUnit;
	}

	public void setCurrencyUnit(String currencyUnit) {
		this.currencyUnit = currencyUnit;
	}

	public Boolean getConvert() {
		return convert;
	}

	public void setConvert(Boolean convert) {
		this.convert = convert;
	}

	public Association getAssociation() {
		return association;
	}

	public void setAssociation(Association association) {
		this.association = association;
	}

	public Integer getSrcChrIndex() {
		return srcChrIndex;
	}

	public void setSrcChrIndex(Integer srcChrIndex) {
		this.srcChrIndex = srcChrIndex;
	}

	public Integer getConvertChrIndex() {
		return convertChrIndex;
	}

	public void setConvertChrIndex(Integer convertChrIndex) {
		this.convertChrIndex = convertChrIndex;
	}

	public Boolean getComposite() {
		return composite;
	}

	public void setComposite(Boolean composite) {
		this.composite = composite;
	}

	public String getComplexExp() {
		return complexExp;
	}

	public void setComplexExp(String complexExp) {
		this.complexExp = complexExp;
	}

	public String getLogSource() {
		return logSource;
	}

	public void setLogSource(String logSource) {
		this.logSource = logSource;
	}

	public String getFamily() {
		return family;
	}

	public void setFamily(String family) {
		this.family = family;
	}

	public String getSearchCol() {
		return searchCol;
	}

	public void setSearchCol(String searchCol) {
		this.searchCol = searchCol;
	}
}
