package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.ICategoryDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Category;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/6/3.
 */
@Service("categoryService")
public class CategoryService extends AbstractService<Category> implements ICategoryService {

	@Autowired
	private ICategoryDao categoryDao;

	@Override
	protected IOperations<Category> getDao() {
		return this.categoryDao;
	}
}
