package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Filter;
import com.enmotech.clanalysis.service.IFilterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/filter")
public class FilterController extends AbstractController<Filter> {
	@Autowired
	private IFilterService filterService;

	@Override
	protected IOperations<Filter> getService() {
		return filterService;
	}
}
