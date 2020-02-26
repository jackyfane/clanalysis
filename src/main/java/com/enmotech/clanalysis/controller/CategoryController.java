package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Category;
import com.enmotech.clanalysis.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/3.
 */
@Controller
@RequestMapping(value = "/category")
public class CategoryController extends AbstractController<Category> {

	@Autowired
	private ICategoryService categoryService;

	@Override
	protected IOperations getService() {
		return categoryService;
	}
}
