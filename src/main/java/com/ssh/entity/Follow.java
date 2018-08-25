package com.ssh.entity;

import javax.persistence.*;

/**
 * Created by sccy on 2018/4/9/0009.
 */
@Entity
@Table(name = "FOLLOW")
public class Follow {

    @Id
    @GeneratedValue
    @Column(name = "ID",updatable = false)
    private Integer id;

    @Column(name = "FOLLOWER",nullable = false)
    private String follower;//关注者

    @Column(name = "FOLLOWER_ID",nullable = false)
    private Integer followerId;//关注者ID

    @Column(name = "FOLLOWED",nullable = false)
    private String followed;//被关注者

    @Column(name = "FOLLOWED_ID",nullable = false)
    private Integer followedId;//被关注者ID

    @Column(name = "UP")
    private Integer update;//被关注者博客更新数量

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFollower() {
        return follower;
    }

    public void setFollower(String follower) {
        this.follower = follower;
    }

    public String getFollowed() {
        return followed;
    }

    public void setFollowed(String followed) {
        this.followed = followed;
    }

    public Integer getUpdate() {
        return update;
    }

    public void setUpdate(Integer update) {
        this.update = update;
    }

    public Integer getFollowerId() {
        return followerId;
    }

    public void setFollowerId(Integer followerId) {
        this.followerId = followerId;
    }

    public Integer getFollowedId() {
        return followedId;
    }

    public void setFollowedId(Integer followedId) {
        this.followedId = followedId;
    }
}
