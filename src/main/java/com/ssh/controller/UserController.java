package com.ssh.controller;

import com.ssh.entity.Article;
import com.ssh.entity.Follow;
import com.ssh.entity.Star;
import com.ssh.entity.User;
import com.ssh.service.ArticleService;
import com.ssh.service.FollowService;
import com.ssh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by sccy on 2018/3/15/0015.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private FollowService followService;

    @Autowired
    private ArticleService articleService;

    //获取session中的用户
    private User getSessionUser(HttpSession session){
        return (User)session.getAttribute("user");
    }

    @RequestMapping("/mySpace")
    public String mySpace(HttpSession session,Model model){
        //绑定登录的用户
        User user = getSessionUser(session);
        model.addAttribute("user",user);

        //获取当前用户的关注与粉丝
        List<Follow> followed = followService.queryByFollowed(user.getName());//获取我的粉丝
        List<Follow> follower = followService.queryByFollower(user.getName());//获取我的关注
        model.addAttribute("followed",followed);
        model.addAttribute("follower",follower);

        return "mySpace";
    }

    @RequestMapping("/space")
    public String space(@RequestParam("id")Integer id, Model model, HttpSession session){
        User user;
        user = userService.getUserById(id);
        model.addAttribute("user",user);
        //查询登陆的用户是否关注了该空间的用户
        if(getSessionUser(session)!=null) {
            Follow follow = followService.queryForOne(user.getName(), getSessionUser(session).getName());
            boolean isFollowed = false;
            if (follow != null) {
                followService.toZero(user.getName(), getSessionUser(session).getName());
                isFollowed = true;
            }
            model.addAttribute("isFollowed", isFollowed);
        }
        return "space";
    }

    @RequestMapping("/follow")
    public String follow(@RequestParam("followedId")Integer followedId,HttpSession session){
        //保存关注信息
        Follow follow = new Follow();

        //关注者是当前用户
        String follower = getSessionUser(session).getName();
        follow.setFollower(follower);
        follow.setFollowerId(getSessionUser(session).getId());

        //被关注者为入参
        follow.setFollowedId(followedId);
        User user = userService.getUserById(followedId);
        follow.setFollowed(user.getName());

        //被关注者博客更新量初始为0
        follow.setUpdate(0);
        followService.Save(follow);

        //重定向被关注者的空间
        return "redirect:/user/space?id="+followedId;
    }

    @RequestMapping("/unfollow")
    public String unfollow(@RequestParam("followedId")Integer followedId,HttpSession session){
        //调用取消关注方法
        followService.unfollow(followedId,getSessionUser(session).getId());

        //重定向徽被关注者的空间
        return "redirect:/user/space?id="+followedId;
    }


    @RequestMapping("/editForm")
    public String editForm(){
        return "editInfo";
    }

    @RequestMapping("/edit")
    public String edit( @RequestParam("interest")String interest, @RequestParam("description")String description,
                       HttpSession session){
        //获取当前登陆用户
        User user = (User)session.getAttribute("user");
        String portrait = (String)session.getAttribute("image");
        //调用用户编辑信息方法，再重定向回我的空间
        userService.edit(user,portrait,interest,description);
        return "redirect:/user/mySpace";
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

    @RequestMapping("/favorite")
    public String favorite(HttpSession session,Model model){
        User user = (User)session.getAttribute("user");
        List<Star> stars = articleService.favorite(user.getId());
        Map<Star,Article> map = new HashMap<Star, Article>();
        for(Star star:stars){
            map.put(star,articleService.queryById(star.getBlogId()));
        }
        model.addAttribute("favorite",map);
        return "favorite";
    }

    @RequestMapping("/unstar")
    public String unstar(@RequestParam Integer blogId, HttpSession session){
        User user = (User)session.getAttribute("user");
        if(articleService.unstar(blogId,user.getId())){
            return "redirect:/user/favorite";
        }else
            return "error";

    }


    // 上传图片
    @RequestMapping("/uploadFile")
    @ResponseBody
    public Map<String, Object> uploadFile(MultipartFile myfile, HttpSession session)
            throws IllegalStateException, IOException {
        // 原始名称
        String oldFileName = myfile.getOriginalFilename(); // 获取上传文件的原名
        // 存储图片的虚拟本地路径（这里需要配置tomcat的web模块路径，双击猫进行配置）
        String saveFilePath = "/home/hqs/image";
        // 上传图片
        if (oldFileName != null && oldFileName.length() > 0) {
            // 新的图片名称
            String newFileName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
            // 新图片
            File newFile = new File(saveFilePath + "/" + newFileName);
            // 将内存中的数据写入磁盘
            myfile.transferTo(newFile);
            session.setAttribute("image",newFileName);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("success", "成功啦");
            map.put("url", newFileName);
            return map;
        } else {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("error", "图片不合法");
            return map;
        }
    }

}
