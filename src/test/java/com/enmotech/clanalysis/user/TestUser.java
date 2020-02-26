package com.enmotech.clanalysis.user;

import com.enmotech.clanalysis.entity.User;
import com.enmotech.clanalysis.service.IUserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

/**
 * Created by Administrator on 2015/6/5.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:xml/applicationContext.xml")
public class TestUser
{

    @Autowired
    private IUserService userService;

    @Test
    public void testSave()
    {
        User user = new User();
        user.setCreatedTime(new Date());
        user.setName("admin");
        user.setPassword("1");

        userService.saveOrUpdate(user);
    }
}
