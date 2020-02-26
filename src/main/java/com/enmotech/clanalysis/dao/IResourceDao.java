package com.enmotech.clanalysis.dao;

import com.enmotech.clanalysis.entity.Menu;

import java.util.List;

/**
 * Created by Administrator on 2015/6/10.
 */
public interface IResourceDao extends IOperations<Menu> {

	/**
	 * @param hql
	 * @param params
	 * @return
	 */
	public List<Menu> findTreeGrid(String hql, List<?> params);
}
