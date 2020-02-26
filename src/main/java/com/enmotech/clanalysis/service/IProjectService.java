package com.enmotech.clanalysis.service;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Project;

/**
 * Created by Administrator on 2015/6/5.
 */
public interface IProjectService extends IOperations<Project> {
	/**
	 * 获取指标
	 *
	 * @param params
	 *            json格式
	 */
	public String getGeneralIndex(String params);

}
