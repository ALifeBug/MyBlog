package com.ssh.service;

import com.ssh.dao.ArticleDao;
import com.ssh.dao.UserDao;
import com.ssh.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sccy on 2018/3/15/0015.
 */
@Service
@Transactional
public class UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private ArticleDao articleDao;


    //根据ID获取用户
    public User getUserById(Integer id){
        return userDao.getById(id);
    }

    //根据昵称获取用户
    public User getUserByName(String name){
        return userDao.getUserByName(name).get(0);
    }

    /*@Cacheable(value = "user",key = "#name")
    public String getPwdByName(String name){
        System.out.println("打印语句则没有走缓存");
        return userDao.getPwdByName(name).get(0);
    }*/

    //根据昵称模糊查询
    public List<User> getUserLike(String name){
        return userDao.getUserLike("%"+name+"%");
    }

    //检查用户是否存在
    public boolean UserExist(String name){
        if(userDao.getUserByName(name).isEmpty())
            return false;
        else
            return true;
    }

    //检查用户昵称是否被占用
    public boolean UserExist(User user){
        if(!userDao.getUserByName(user.getName()).isEmpty())
            return true;
        else
            return false;
    }

    //验证密码
    public boolean validatePwd(String name,String password){
        String pwd = userDao.getPwdByName(name).get(0);
        if(pwd.equals(password))
            return true;
        else
            return false;

    }

    //保存新用户
    public void saveUser(User user){
        userDao.save(user);
    }


    //更改用户信息
    public void edit(User user, String portrait,String interest,String description){
        //更新用户头像
        if(portrait!=null) {
            user.setPortrait(portrait);
        }

        //保存用户的兴趣和个人描述
        user.setInterest(interest);
        user.setDescription(description);

        //更新
        userDao.update(user);
    }


}
