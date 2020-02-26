package com.enmotech.clanalysis.service;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Menu;

import java.util.List;

/**
 * Created by Administrator on 2015/6/10.
 */
public interface IResourceService extends IOperations<Menu> {

	/**
	 * @param sidx
	 * @param sord
	 * @param menu
	 * @return
	 */
	public List<Menu> queryTreeGrid(String sidx, String sord, Menu menu);
}
