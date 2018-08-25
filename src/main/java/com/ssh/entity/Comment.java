package com.ssh.entity;

import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by sccy on 2018/3/21/0021.
 */
@Entity
@Table(name = "COMMENT")
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="ID",updatable = false)
    private Integer id;

    @Column(name = "CONTENT")
    private String content;//评论的内容

    @Column(name = "TIME")
    private Date time;//评论时间

    @Column(name = "BLOG_ID")
    private Integer blogId;//评论的博客ID

    @Column(name = "USER_NAME")
    private String userName;//评论者姓名

    @Column(name = "USER_ID")
    private Integer userId;//评论者ID

    @Column(name = "IMAGE_ID")
    private String image;//评论者头像

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Integer getBlogId() {
        return blogId;
    }

    public void setBlogId(Integer blogId) {
        this.blogId = blogId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
