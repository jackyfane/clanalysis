package com.enmotech.clanalysis.logsouce;

import com.enmotech.clanalysis.service.IDataSourceService;
import com.enmotech.clanalysis.service.impl.DataSourceService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/16.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:xml/applicationContext.xml")
public class LogSourceServer
{
    private static IDataSourceService service = new DataSourceService();

    @Test
    public void testVids()
    {
        String sid = "W001";
        String result = service.getVids(sid);
        System.out.println(result);
    }

    @Test
    public void testLSFields()
    {
        String sid = "W001";
        List<Map<String, String>> list = service.getLSFields(sid);
        System.out.println(list);
    }
}
