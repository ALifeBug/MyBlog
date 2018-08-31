package com.ssh.controller;

import com.ssh.entity.Article;
import com.ssh.entity.Comment;
import com.ssh.entity.Page;
import com.ssh.entity.User;
import com.ssh.service.ArticleService;
import com.ssh.service.CommentService;
import com.ssh.service.UserService;
import com.ssh.util.CookieUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        return articleService.queryForAllBlog(1,10,"time");
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
        Page<Article> page = articleService.queryForAllBlog(pageNo,10,order);
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
    @RequestMapping("/details")
    public String detail(@RequestParam Integer blogId,Model model,HttpSession session){
        Article article = articleService.queryById(blogId);
        //浏览量加一
        articleService.BrowserCountIncrement(blogId);
        List<Comment> comments = commentService.getByBlogId(blogId);

        //是否点过赞
        User user = (User)session.getAttribute("user");
        Integer isLike=0,isStar=0;
        if(user!=null) {
            if (articleService.isLike(blogId, user.getId())) isLike = 1;
            if (articleService.isStar(blogId,user.getId())) isStar = 1;
        }
        model.addAttribute("article",article).addAttribute("comments",comments).addAttribute("comment",new Comment()).addAttribute("isLike",isLike).addAttribute("isStar",isStar);

        return "blog_detail";
    }

    //点赞
    @RequestMapping(value = "/like",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,String> like(@RequestParam("blogId") String blogId, @RequestParam("usrId") String usrId){
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

    @RequestMapping(value = {"/registerForm"})
    public String registerForm(Model model){
        //返回注册表单
        model.addAttribute("user",new User());
        model.addAttribute("register",true);

        return "index";
    }

    @RequestMapping("/register")
    public String register(@Valid User user, BindingResult result, HttpServletRequest request, HttpServletResponse response,Model model) throws UnsupportedEncodingException {
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
            CookieUtils.cookie(30*24*60*60,response,user.getName(),user.getPassword());
            return "redirect:/index/";
        }
    }


    @RequestMapping("/loginForm")
    public String loginForm(){
        return "index";
    }

    @RequestMapping("/login")
    public String Login(HttpServletRequest request, HttpServletResponse response,Model model) throws UnsupportedEncodingException {
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
            CookieUtils.cookie(30*24*60*60,response,name,password);
        }
        return "index";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session,HttpServletResponse response) throws UnsupportedEncodingException {
        User user = (User) session.getAttribute("user");
        CookieUtils.cookie(0, response, user.getName(), user.getPassword());
        session.removeAttribute("user");
        return "redirect:/";
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

    //读写图片
    @RequestMapping("/getImage")
    public void getImage(@RequestParam(required = false) String imgName,@RequestParam(required = false)Integer usrId,HttpServletResponse response,HttpServletRequest request){
        String picUrl = "/home/hqs/image/";
        InputStream in;
        response.setContentType("application/octet-stream;charset=UTF-8");
        String img;
        if(usrId!=null)
            img = userService.getUserById(usrId).getPortrait();
        else
            img = imgName;
        try {
            if(img==null)
                in = request.getServletContext().getResourceAsStream("/img/img2.png");
            else
                in = new FileInputStream(picUrl+img);
            int i = in.available();
            byte[] data = new byte[i];
            in.read(data);
            in.close();

            OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
            outputStream.write(data);
            outputStream.flush();
            outputStream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
