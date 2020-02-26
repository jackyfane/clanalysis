package com.enmotech.clanalysis.service.impl;

import com.enmotech.caa.itf.utils.InterfaceUtils;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.dao.IProjectDao;
import com.enmotech.clanalysis.entity.Project;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/6/3.
 */
@Service("projectService")
public class ProjectService extends AbstractService<Project> implements IProjectService {

	@Autowired
	private IProjectDao projectDao;

	@Override
	protected IOperations<Project> getDao() {
		return projectDao;
	}

	@Override
	public String getGeneralIndex(String params) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("timeout", "5000");
		map.put("idxs", params);
		return InterfaceUtils.call("getGeneralIndexResult", map);
	}
}
