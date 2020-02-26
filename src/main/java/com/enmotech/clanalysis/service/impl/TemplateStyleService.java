package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.dao.ITemplateStyleDao;
import com.enmotech.clanalysis.entity.TemplateStyle;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.ITemplateStyleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("templateStyleService")
public class TemplateStyleService extends AbstractService<TemplateStyle> implements ITemplateStyleService {

	@Autowired
	private ITemplateStyleDao templateStyleDao;

	@Override
	protected IOperations<TemplateStyle> getDao() {
		return templateStyleDao;
	}
}
