package com.ssh.controller;

import com.ssh.entity.Article;
import com.ssh.entity.Comment;
import com.ssh.service.ArticleService;
import com.ssh.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Date;

/**
 * Created by sccy on 2018/3/21/0021.
 */
@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;
    @Autowired
    private ArticleService articleService;

    //保存评论
    @RequestMapping("/save")
    public String save(Comment comment, @RequestParam("pageNo")Integer pageNo, @RequestParam("content") String content){
            Integer id = comment.getBlogId();

            //增加指定文章的评论数
            articleService.CommentCountIncrement(comment.getBlogId());

            //设置评论的时间
            comment.setTime(new Date());

            //设置评论内容，替换空格与换行，保证正确显示
            comment.setContent(content.replaceAll(" ", "&nbsp;").replaceAll("\n", "<br>"));

            //保存评论
            commentService.save(comment);

            //重定向回博客详情页
            return "redirect:/blog/details?blogId="+id+"&pageNo="+pageNo;
        }

}
