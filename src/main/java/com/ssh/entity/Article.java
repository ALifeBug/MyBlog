package com.ssh.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by sccy on 2018/3/15/0015.
 */
@Entity
@Table(name = "ARTICLE")
public class Article implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="ID",updatable = false)
    private Integer id;

    @Column(name = "TITLE",nullable = false)
    private String title;//标题

    @Column(name = "CONTENT",length = 10000)
    private String content;//内容

    @Column(name = "TIME")
    private Date time;//发布时间

    @Column(name = "BROWSER_COUNT",nullable = false)
    private Integer browserCount;//浏览次数

    @Column(name = "COMMENT_COUNT",nullable = false)
    private Integer commentCount;//评论次数

    @Column(name = "LIKE_COUNT")
    private Integer likeCount;//点赞次数

    @Column(name = "STAR_COUNT")
    private Integer starCount;//收藏次数

    @Column(name = "EDITOR")
    private String editor;//作者

    @Column(name = "EDITOR_ID")
    private Integer editorId;

    @Column(name = "IMAGE")
    private String image;//配图

    @Column(name = "NOTICE")
    private Integer notice;//推荐

    @Column(name = "SECRET")
    private Integer secret;//私密

    public Article(){}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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

    public Integer getBrowserCount() {
        return browserCount;
    }

    public void setBrowserCount(Integer browserCount) {
        this.browserCount = browserCount;
    }

    public Integer getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(Integer commentCount) {
        this.commentCount = commentCount;
    }

    public String getEditor() {
        return editor;
    }

    public void setEditor(String editor) {
        this.editor = editor;
    }

    public Integer getEditorId() {
        return editorId;
    }

    public void setEditorId(Integer editorId) {
        this.editorId = editorId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Integer getNotice() {
        return notice;
    }

    public void setNotice(Integer notice) {
        this.notice = notice;
    }

    public Integer getSecret() {
        return secret;
    }

    public void setSecret(Integer secret) {
        this.secret = secret;
    }

    public Integer getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Integer likeCount) {
        this.likeCount = likeCount;
    }

    public Integer getStarCount() {
        return starCount;
    }

    public void setStarCount(Integer starCount) {
        this.starCount = starCount;
    }

    public Article(Integer id, String title, Date time, Integer browserCount, Integer commentCount, String editor) {
        this.id = id;
        this.title = title;
        this.time = time;
        this.browserCount = browserCount;
        this.commentCount = commentCount;
        this.editor = editor;
    }

    public Article(Integer id,String title, String editor) {
        this.id = id;
        this.title = title;
        this.editor = editor;
    }
}
