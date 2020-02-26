package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.ITemplateStyleDao;
import com.enmotech.clanalysis.entity.TemplateStyle;
import org.springframework.stereotype.Repository;

@Repository("templateStyleDao")
public class TemplateStyleDao extends AbstractOperations<TemplateStyle> implements ITemplateStyleDao {

	public TemplateStyleDao() {
		super();
		setClazz(TemplateStyle.class);
	}
}
