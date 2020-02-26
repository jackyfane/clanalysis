package com.enmotech.clanalysis.project;

import com.enmotech.clanalysis.controller.ProjectController;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by Administrator on 2015/9/1.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:xml/applicationContext.xml")
public class ProjectTest
{
    ProjectController controller = new ProjectController();

    @Test
    public void testIndex()
    {

        //controller.getGeneralIndex();
    }
}
