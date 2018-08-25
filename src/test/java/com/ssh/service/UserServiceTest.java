package com.ssh.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import static org.junit.Assert.*;

/**
 * Created by sccy on 2018/4/10/0010.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring-mvc.xml"})
@WebAppConfiguration("src/main/resources")
public class UserServiceTest {

    @Autowired
    private UserService userService;

    @Test
    public void getUserLike() throws Exception {
        System.out.println(userService.getUserLike(""));
    }

}