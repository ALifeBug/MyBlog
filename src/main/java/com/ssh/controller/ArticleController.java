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
    public String saveArticle(@RequestParam(value = "title",required = false) String title,@RequestParam(value = "content",required = false)String content,
                              @RequestParam(value = "mdtitle",required = false) String mdtitle,@RequestParam(value = "mdcontent",required = false)String mdcontent,
                              HttpSession session,
                              @RequestParam("pageNo")Integer pageNo,@RequestParam("notice")Integer notice,@RequestParam("secret")Integer secret){
        //设置博客标题和内容
        if((content==null || content.equals("") || content.trim().equals("")) && (mdcontent==null || mdcontent.equals("") || mdcontent.trim().equals("")))
            return "redirect:/blog/myBlog?pageNo="+pageNo;
        Article article = new Article();
        if(content==null || content.equals("")){
            article.setContent(mdcontent);
            article.setIsMd(1);
        }
        else {
            article.setContent(content);
            article.setIsMd(0);
        }
        System.out.println("content:"+content);
        System.out.println("mdcontent:"+mdcontent);
        if(title==null || title.equals("")) article.setTitle(mdtitle);
        else article.setTitle(title);
        article.setNotice(notice);
        article.setSecret(secret);
        String image = (String)session.getAttribute("image");
        if(image!=null) {
            article.setImage(image);
            session.removeAttribute("image");
        }
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
        model.addAttribute("notice",article.getNotice());
        model.addAttribute("secret",article.getSecret());
        model.addAttribute("content",article.getContent().replaceAll("<br>","\n").replaceAll("&nbsp;"," "));

        return "editblog";
    }

    //编辑博客
    @RequestMapping("/edit")
    public String edit(@RequestParam("title")String title,HttpSession session,
                       @RequestParam("content")String content,@RequestParam("id")Integer id,@RequestParam("pageNo")Integer pageNo,
                       @RequestParam("notice")Integer notice,@RequestParam("secret")Integer secret){
        Article article = articleService.queryById(id);
        String image = (String)session.getAttribute("image");
        articleService.edit(article,image,title,content,notice,secret);
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
    public String detail(@RequestParam("blogId") Integer blogId,Model model,HttpSession session){
        Article article = articleService.queryById(blogId);

        //浏览量加一
        articleService.BrowserCountIncrement(blogId);

        //获取该博客下的所有评论
        List<Comment> comments = commentService.getByBlogId(blogId);

        //是否点过赞
        User user = (User)session.getAttribute("user");
        Integer isLike=0,isStar=0;
        if(articleService.isLike(blogId,user.getId())) isLike = 1;
        if(articleService.isStar(blogId,user.getId())) isStar = 1;

        model.addAttribute("article",article)
                .addAttribute("comments",comments)
                .addAttribute("comment",new Comment()).addAttribute("isLike",isLike).addAttribute("isStar",isStar);
        return "blog_detail";
    }

    //点赞
    @RequestMapping(value = "/like",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> like(@RequestParam("blogId") String blogId,@RequestParam("usrId") String usrId){
        Map<String,String> map = new HashMap<String, String>();
        if(articleService.like(Integer.parseInt(blogId),Integer.parseInt(usrId))){
            map.put("status","success");
        }else{
            map.put("status","failed");
        }
        return map;
    }

    //收藏
    @RequestMapping(value = "/star",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> star(@RequestParam("blogId") String blogId,@RequestParam("usrId") String usrId){
        Map<String,String> map = new HashMap<String, String>();
        if(articleService.star(Integer.parseInt(blogId),Integer.parseInt(usrId))){
            map.put("status","success");
        }else{
            map.put("status","failed");
        }
        return map;
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
