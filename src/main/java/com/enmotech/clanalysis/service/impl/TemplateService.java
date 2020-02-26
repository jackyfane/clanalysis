package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.dao.ITemplateDao;
import com.enmotech.clanalysis.entity.Template;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.ITemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("templateService")
public class TemplateService extends AbstractService<Template> implements ITemplateService {
	@Autowired
	private ITemplateDao templateDao;

	@Override
	protected IOperations<Template> getDao() {
		return templateDao;
	}

}
