package com.enmotech.clanalysis.category;

import com.enmotech.clanalysis.entity.Category;
import com.enmotech.clanalysis.service.ICategoryService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by Administrator on 2015/6/4.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:xml/applicationContext.xml")
public class TestCategory
{

    @Autowired
    private ICategoryService categoryService;

    @Test
    public void testSave()
    {
        Category category = new Category();
        category.setId("e35fc374-8a90-46f4-b9dd-437012814e20");
        category.setName("EM");
        categoryService.saveOrUpdate(category);
    }
}
