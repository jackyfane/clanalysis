package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Element;
import com.enmotech.clanalysis.service.IElementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping(value = "/element")
public class ElementController extends AbstractController<Element> {
	@Autowired
	private IElementService elementService;

	@Override
	protected IOperations<Element> getService() {
		return elementService;
	}
}
