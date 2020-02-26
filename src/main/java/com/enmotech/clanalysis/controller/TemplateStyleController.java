package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.TemplateStyle;
import com.enmotech.clanalysis.service.ITemplateStyleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/templateStyle")
public class TemplateStyleController extends AbstractController<TemplateStyle> {

	@Autowired
	private ITemplateStyleService templateStyleService;

	@Override
	protected IOperations<TemplateStyle> getService() {
		return templateStyleService;
	}

}
