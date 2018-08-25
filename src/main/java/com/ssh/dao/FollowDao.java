package com.ssh.dao;

import com.ssh.entity.Follow;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sccy on 2018/4/9/0009.
 */
@Repository
public class FollowDao extends BaseDao<Follow>{

    //获取我的关注
    public List<Follow> getByFollower(String follower){
        return find("from Follow f where f.follower=?",follower);
    }

    //获取我的粉丝
    public List<Follow> getByFollowed(String followed){
        return find("from Follow f where f.followed=?",followed);
    }

    //获取某一条关注记录
    public Follow getByFollowerAndFollowed(Integer followedId, Integer followerId){
        List<Follow> follows = find("from Follow f where f.followedId=? and f.followerId=?",followedId,followerId);
        if(follows.isEmpty())
            return  null;
        return follows.get(0);
    }

    public Follow getByFollowerAndFollowed(String follower, String followed){
        List<Follow> follows = find("from Follow f where f.follower=? and f.followed=?",follower,followed);
        if(follows.isEmpty())
            return  null;
        return follows.get(0);
    }
}
