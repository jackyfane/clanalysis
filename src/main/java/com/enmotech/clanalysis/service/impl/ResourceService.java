package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.dao.IResourceDao;
import com.enmotech.clanalysis.entity.Menu;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IResourceService;
import com.enmotech.clanalysis.util.EntityUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.List;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("resourceService")
public class ResourceService extends AbstractService<Menu> implements IResourceService {
	@Autowired
	private IResourceDao resourceDao;

	@Override
	protected IOperations<Menu> getDao() {
		return resourceDao;
	}

	@Override
	public List<Menu> queryTreeGrid(String sidx, String sord, Menu menu) {
		String hql = "from Menu m where 1=1 and m.parent.id is null";
		List<Object> params = new LinkedList<Object>();
		String where = EntityUtil.createHQLParams(menu, params, false);
		if (StringUtils.isNotEmpty(where))
			hql += where;
		if (StringUtils.isNotEmpty(sidx))
			hql += " order by " + sidx + " " + sord;

		return resourceDao.findTreeGrid(hql, params);
	}
}
