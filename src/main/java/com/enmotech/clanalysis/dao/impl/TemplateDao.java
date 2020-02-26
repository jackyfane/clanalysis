package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.ITemplateDao;
import com.enmotech.clanalysis.entity.Template;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/10.
 */
@Repository("templateDao")
public class TemplateDao extends AbstractOperations<Template> implements ITemplateDao {
	public TemplateDao() {
		super();
		setClazz(Template.class);
	}
}
