package com.ssh.controller;

import com.ssh.entity.Article;
import com.ssh.entity.Comment;
import com.ssh.entity.Page;
import com.ssh.entity.User;
import com.ssh.service.ArticleService;
import com.ssh.service.CommentService;
import com.ssh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sccy on 2018/3/28/0028.
 */
@Controller
@RequestMapping("/index")
public class IndexController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    @ModelAttribute
    public Page<Article> page(){
        //返回page类对象加入model模型中
        return articleService.queryForAllBlog(1,4,"time");
    }

    @RequestMapping(value = {"/home","/"})
    public String Home(Model model){
        //默认按浏览量排序
        model.addAttribute("order","browser");
        return "index";
    }

    /**
     *
     * @param model
     * @param order 排序方式
     * @param pageNo 页码
     * @return 返回指定一页博客
     */
    @RequestMapping("/{order}/{pageNo}")
    public String blog(Model model, @PathVariable("order") String order, @PathVariable("pageNo") int pageNo){
        Page<Article> page = articleService.queryForAllBlog(pageNo,4,order);
        model.addAttribute("page",page);
        model.addAttribute("order",order);
        return "index";
    }

    /**
     *
     * @param blogId 博客id
     * @param model
     * @return 该博客详细信息
     */
    @RequestMapping("/details/{id}")
    public String detail(@PathVariable("id") Integer blogId,Model model){
        Article article = articleService.queryById(blogId);
        //浏览量加一
        articleService.BrowserCountIncrement(blogId);
        List<Comment> comments = commentService.getByBlogId(blogId);
        model.addAttribute("article",article).addAttribute("comments",comments).addAttribute("comment",new Comment());

        return "blog_detail";
    }

    @RequestMapping(value = {"/registerForm"})
    public String registerForm(Model model){
        //返回注册表单
        model.addAttribute("user",new User());
        model.addAttribute("register",true);

        return "index";
    }

    @RequestMapping("/register")
    public String register(@Valid User user, BindingResult result, HttpServletRequest request, Model model){
        //检查确认密码是否正确
        boolean confirm = request.getParameter("confirmPwd").equals(user.getPassword());

        //检查昵称是否被占用
        boolean nameUsed = userService.UserExist(user);

        //错误处理
        if(result.hasErrors() || !confirm || nameUsed){
            if(!confirm)
                model.addAttribute("confirmResult","两次输入密码不一致");
            if(nameUsed)
                model.addAttribute("used","该昵称已被占用");
            model.addAttribute("register",true);
            return "index";
        }else {
            //保存用户，返回主页
            userService.saveUser(user);
            request.getSession().setAttribute("user",user);
            return "redirect:/index/";
        }
    }


    @RequestMapping("/loginForm")
    public String loginForm(){
        return "index";
    }

    @RequestMapping("/login")
    public String Login(HttpServletRequest request, Model model){
        //获取参数昵称和密码
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        //错误处理
        if(!userService.UserExist(name)){
            model.addAttribute("error","用户不存在");
        }else if(!userService.validatePwd(name,password)){
            model.addAttribute("error","密码错误");
        }else{
            request.getSession().setAttribute("user",userService.getUserByName(name));
        }
        return "index";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        //移除session中的user
        session.removeAttribute("user");
        return "index";
    }

    /**
     *
     * @param name 用户姓名
     * @param model
     * @return 指定用户搜索
     */
    @RequestMapping("/search")
    public String search(@RequestParam("name")String name, Model model){
        List<User> users;
        if(name.trim().equals("")){
            //参数为空返回空集合
            model.addAttribute("users",new ArrayList<User>());
        }else{
            //模糊查询符合条件的user
            users = userService.getUserLike(name);
            model.addAttribute("users",users);
        }
        return "index";
    }
}
