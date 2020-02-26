package com.enmotech.clanalysis.entity;

import org.hibernate.annotations.DynamicInsert;

import javax.persistence.Column;
import javax.persistence.Entity;

@Entity
@DynamicInsert(true)
public class Filter extends Item {
	/**
	 * 指标的过滤条件，使用JSON格式，[{"id":"指标ID","name":"指标名称","mode":"text","value":"=99"}
	 * ]
	 */
	private String[] ruleConf;

	/**
	 * 匹配规则（1、全部匹配，2、任一条匹配） matchMode为true全部匹配，false为任一条匹配
	 */
	@Column(name = "match_mode")
	private Boolean matchMode;

	public Boolean getMatchMode() {
		return matchMode;
	}

	public void setMatchMode(Boolean matchMode) {
		this.matchMode = matchMode;
	}

	public String[] getRuleConf() {
		return ruleConf;
	}

	public void setRuleConf(String[] ruleConf) {
		this.ruleConf = ruleConf;
	}
}
