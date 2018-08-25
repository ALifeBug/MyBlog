package com.ssh.dao;

import com.ssh.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sccy on 2018/3/15/0015.
 */
@Repository
public class UserDao extends BaseDao<User>{

    //根据昵称查询用户
    public List<User> getUserByName(String name){
        return find("from User u where u.name = ?",name);
    }
    //根据昵称获取密码
    public List<String> getPwdByName(String name){return find("select u.password from User u where u.name = ?",name);}
    //根据昵称模糊查询
    public List<User> getUserLike(String name){
        return find("from User u where u.name like ?",name);
    }
 }
