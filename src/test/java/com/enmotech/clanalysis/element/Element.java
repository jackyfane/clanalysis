package com.enmotech.clanalysis.element;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by Administrator on 2015/9/8.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:xml/applicationContext.xml")
public class Element
{
    final String url = "http://localhost:8080/clanalysis/association/get-all";

    @Test
    public void testFindAll()
    {

    }
}
