package com.ssh.controller;

import com.ssh.entity.*;
import com.ssh.service.ArticleService;
import com.ssh.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sccy on 2018/3/17/0017.
 */
@Controller
@RequestMapping("/blog")
public class ArticleController implements HandlerExceptionResolver{

    @Autowired
    private ArticleService articleService;
    @Autowired
    private CommentService commentService;

    /**
     *
     * @param pageNo 指定页码
     * @param session
     * @return 登陆用户的博客分页
     */
    @ModelAttribute
    public Page<Article> getPage(@RequestParam int pageNo,HttpSession session){
        User user = (User)session.getAttribute("user");
        String name = user.getName();
        Page<Article> page =articleService.queryForPage(pageNo,2,name);
        return page;
    }

    //我的博客
    @RequestMapping("/myBlog")
    public String myBlog(Model model){
        return "blog";
    }

    //保存博客
    @RequestMapping("/save")
    public String saveArticle(@RequestParam("title") String title,@RequestParam("content")String content, HttpSession session,
                              @RequestParam("pageNo")Integer pageNo){
        //设置博客标题和内容
        Article article = new Article();
        article.setContent(content);
        article.setTitle(title);
        String image = (String)session.getAttribute("image");
        if(image!=null)
            article.setImage(image);
        //获取博客作者
        User user = (User)session.getAttribute("user");

        //为用户添加博客
        articleService.saveArticle(article,user);

        return "redirect:/blog/myBlog?pageNo="+pageNo;
    }

    //返回编辑指定博客的页面
    @RequestMapping("/editform")
    public String editform(@RequestParam("blogId")Integer blogId,Model model){
        Article article = articleService.queryById(blogId);

        model.addAttribute("id",blogId);
        model.addAttribute("image",article.getImage());
        model.addAttribute("title",article.getTitle());
        model.addAttribute("content",article.getContent().replaceAll("<br>","\n").replaceAll("&nbsp;"," "));

        return "editblog";
    }

    //编辑博客
    @RequestMapping("/edit")
    public String edit(@RequestParam("title")String title,HttpSession session,
                       @RequestParam("content")String content,@RequestParam("id")Integer id,@RequestParam("pageNo")Integer pageNo){
        Article article = articleService.queryById(id);
        String image = (String)session.getAttribute("image");
        articleService.edit(article,image,title,content);
        return "redirect:/blog/details?blogId="+id+"&pageNo="+pageNo;
    }

    //删除博客
    @RequestMapping("/delete")
    public String delete(@RequestParam("blogId")Integer id,@RequestParam("pageNo")Integer pageNo){
        articleService.delete(id);
        return "redirect:/blog/myBlog?pageNo="+pageNo;
    }

    //返回博客详情页
    @RequestMapping("/details")
    public String detail(@RequestParam("blogId") Integer blogId,Model model){
        Article article = articleService.queryById(blogId);

        //浏览量加一
        articleService.BrowserCountIncrement(blogId);

        //获取该博客下的所有评论
        List<Comment> comments = commentService.getByBlogId(blogId);

        model.addAttribute("article",article).addAttribute("comments",comments).addAttribute("comment",new Comment());
        return "blog_detail";
    }

    //处理文件上传超过最大体积的异常
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        Map<String,Object> map = new HashMap<String,Object>();
        if (ex instanceof MaxUploadSizeExceededException) {
            long maxSize = ((MaxUploadSizeExceededException) ex)
                    .getMaxUploadSize();
            map.put("error", "上传文件太大，不能超过" + maxSize / 1024 + "k");

            User user = (User) request.getSession().getAttribute("user");
            String name = user.getName();
            Page<Article> page = articleService.queryForPage(Integer.parseInt(request.getParameter("pageNo")), 4, name);
            map.put("page", page);

            //判断是编辑博客时还是写博客时的异常
            if (request.getRequestURL().indexOf("edit") >= 0) {
                return new ModelAndView("editblog", map);
            } else {
                return new ModelAndView("blog", map);
            }
        }
        else {
            //其他异常，打印后返回错误页面
            ex.printStackTrace();
            return new ModelAndView("error",map);
        }
    }



}
