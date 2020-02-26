package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Template;
import com.enmotech.clanalysis.service.ITemplateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/template")
public class TemplateController extends AbstractController<Template> {

	@Autowired
	private ITemplateService templateService;

	@Override
	protected IOperations<Template> getService() {
		return templateService;
	}
}
