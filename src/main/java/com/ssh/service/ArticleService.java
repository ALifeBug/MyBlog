package com.ssh.service;

import com.ssh.dao.ArticleDao;
import com.ssh.dao.FollowDao;
import com.ssh.dao.UserDao;
import com.ssh.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

/**
 * Created by sccy on 2018/3/17/0017.
 */
@Service
@Transactional
public class ArticleService {

    @Autowired
    private ArticleDao articleDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private FollowDao followDao;

    /**
     *
     * @param id
     * @return 根据id查询blog
     */
    public Article queryById(Integer id){
        return articleDao.getById(id);
    }

    public void saveArticle(Article article, User user){
        //设置默认属性
        article.setTime(new Date());
        article.setEditor(user.getName());
        article.setEditorId(user.getId());
        article.setCommentCount(0);
        article.setBrowserCount(0);
        //替换空格与换行,再次显示保留原格式
        String content = article.getContent();
        article.setContent(content.replaceAll("\n","<br>").replaceAll(" ","&nbsp;"));
        //保存用户的文章
        articleDao.save(article);
        user.getArticles().add(article);
        userDao.update(user);

        //更新关注信息，更新量加一
        List<Follow> follows = followDao.getByFollowed(user.getName());
        Integer update;
        for(Follow follow : follows){
            update = follow.getUpdate();
            follow.setUpdate(update+1);
        }
    }

    /**
     *
     * @param pageNo 页数
     * @param pageSize 页的大小
     * @param name 编辑者
     * @return 一页记录
     */
    public Page<Article> queryForPage(final int pageNo,final int pageSize,final String name){
        Page<Article> page = new Page<Article>();
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        page.setList(articleDao.queryForList(page,name));
        page.setTotalRecords(articleDao.queryForCount(name));
        return page;
    }


    /**
     *
     * @param pageNo
     * @param pageSize
     * @param order 判断按照什么字段排序,browser为浏览量,comment为评论量,time为时间
     * @return
     */
    public Page<Article> queryForAllBlog(final int pageNo,final int pageSize,final String order){
        Page<Article> page = new Page<Article>();
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        page.setList(articleDao.queryForAll(page,order));
        page.setTotalRecords(articleDao.queryForAllCount());
        return page;
    }

    //更新博客的浏览量
    public void BrowserCountIncrement(Integer blogId){
        Article article = articleDao.getById(blogId);
        article.setBrowserCount(article.getBrowserCount()+1);
    }

    //更新博客的评论数
    public void CommentCountIncrement(Integer blogId){
        Article article = articleDao.getById(blogId);
        article.setCommentCount(article.getCommentCount()+1);
    }

    //返回指定用户的所有博客的概要
    public List<Article> queryForOutline(String name){
        return articleDao.queryForOutlineByName(name);
    }

    //修改博客
    public void edit(Article article, String image,String title,String content){

        if(image!=null) {
            article.setImage(image);
        }
        article.setTitle(title);
        article.setContent(content.replaceAll("\n","<br>").replaceAll(" ","&nbsp;"));

        //更新博客
        articleDao.update(article);
    }

    //删除博客
    public void delete(Integer id){
        Article article = articleDao.getById(id);
        if(article!=null){
            //删除博客
            articleDao.remove(article);

            //更新关注信息，更新量减一
            List<Follow> follows = followDao.getByFollowed(article.getEditor());
            Integer update;
            for(Follow follow : follows){
                update = follow.getUpdate();
                if(update > 0) {
                    follow.setUpdate(update - 1);
                }
            }
        }
    }

}
