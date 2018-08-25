package com.ssh.entity;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sccy on 2018/3/15/0015.
 */
@Entity
@Table(name = "USER")
public class User {

    @Id
    @GeneratedValue
    @Column(name="ID",updatable = false)
    private Integer id;

    @Column(name = "NAME",nullable = false,unique = true)
    @Size(min = 5,message = "昵称长度不合法")
    private String name;//昵称

    @Column(name = "PASSWORD",nullable = false)
    @Size(min = 5,max = 10,message = "密码长度不合法")
    private String password;

    @Column(name = "EMAIL")
    @NotEmpty(message = "邮箱不能为空")
    @Email(message = "邮箱格式不合法")
    private String email;//邮箱

    @Column(name = "INTEREST")
    private String interest;//兴趣

    @Column(name = "DESCRIPTION")
    private String description;//描述

    @Column(name = "PORTRAIT")
    private String portrait;

    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "USER_ID")
    private List<Article> articles = new ArrayList<Article>();



    public List<Article> getArticles() {
        return articles;
    }

    public void setArticles(List<Article> articles) {
        this.articles = articles;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getInterest() {
        return interest;
    }

    public void setInterest(String interest) {
        this.interest = interest;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPortrait() {
        return portrait;
    }

    public void setPortrait(String portrait) {
        this.portrait = portrait;
    }
}
