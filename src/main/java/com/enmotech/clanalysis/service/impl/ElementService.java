package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IElementDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Element;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IElementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("elementService")
public class ElementService extends AbstractService<Element> implements IElementService {
	@Autowired
	private IElementDao elementDao;

	@Override
	protected IOperations<Element> getDao() {
		return elementDao;
	}
}
