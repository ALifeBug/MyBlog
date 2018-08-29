package com.ssh.service;

import com.ssh.entity.Article;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by sccy on 2018/3/19/0019.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring-mvc.xml"})
@WebAppConfiguration("src/main/resources")
public class ArticleServiceTest {

    @Autowired
    private ArticleService articleService;

    @Test
    public void queryForPage() throws Exception {
        System.out.println(articleService.queryForAllBlog(2,2,"browser"));
    }

    @Test
    public void findHot() {
        List<Article> articles = articleService.findHot();
        for(Article article : articles){
            System.out.println(article);
        }
    }
}