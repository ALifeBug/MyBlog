package com.ssh.controller;

import com.ssh.entity.Follow;
import com.ssh.entity.User;
import com.ssh.service.FollowService;
import com.ssh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

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
    public String space(@RequestParam("id")Integer id, Model model, HttpSession session) throws UnsupportedEncodingException {
        User user;
        user = userService.getUserById(id);
        model.addAttribute("user",user);
        //查询登陆的用户是否关注了该空间的用户
        Follow follow = followService.queryForOne(user.getName(),getSessionUser(session).getName());
        boolean isFollowed = false;
        if(follow!=null){
            followService.toZero(user.getName(),getSessionUser(session).getName());
            isFollowed = true;
        }
        model.addAttribute("isFollowed",isFollowed);

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
    public String edit(@RequestParam("portrait")MultipartFile file, @RequestParam("interest")String interest, @RequestParam("description")String description,
                       HttpSession session){
        //获取当前登陆用户
        User user = (User)session.getAttribute("user");

        //调用用户编辑信息方法，再重定向回我的空间
        userService.edit(user,file,interest,description);
        return "redirect:/user/mySpace";
    }




}
