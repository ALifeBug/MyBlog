package com.ssh.service;

import com.ssh.dao.FollowDao;
import com.ssh.entity.Follow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sccy on 2018/4/9/0009.
 */
@Service
@Transactional
public class FollowService {

    @Autowired
    private FollowDao followDao;

    //关注
    public void Save(Follow follow){
        followDao.save(follow);
    }

    //获取我的关注
    public List<Follow> queryByFollower(String follower){
        return followDao.getByFollower(follower);
    }

    //获取我的粉丝
    public List<Follow> queryByFollowed(String followed){
        return followDao.getByFollowed(followed);
    }

    //指定被关注者所有关注记录的博客更新加一
    public void add(String followed){
        List<Follow> follows = followDao.getByFollowed(followed);
        Integer update;
        for(Follow follow:follows){
            update=follow.getUpdate();
            update++;
            follow.setUpdate(update);
        }
    }

    //获取某一条关注
    public Follow  queryForOne(String followed,String follower){
        return followDao.getByFollowerAndFollowed(follower,followed);
    }

    //被关注者博客更新清零
    public void toZero(String followed,String follower){
        Follow follow = followDao.getByFollowerAndFollowed(follower,followed);
        follow.setUpdate(0);
    }

    //取消关注
    public void unfollow(Integer followedId,Integer followerId){
        Follow follow = followDao.getByFollowerAndFollowed(followedId,followerId);
        followDao.remove(follow);
    }
}
