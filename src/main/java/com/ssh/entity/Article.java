package com.ssh.entity;

import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Size;
import java.util.Date;

/**
 * Created by sccy on 2018/3/15/0015.
 */
@Entity
@Table(name = "ARTICLE")
public class Article {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="ID",updatable = false)
    private Integer id;

    @Column(name = "TITLE",nullable = false)
    private String title;//标题

    @Column(name = "CONTENT",length = 500)
    private String content;//内容

    @Column(name = "TIME")
    private Date time;//发布时间

    @Column(name = "BROWSER_COUNT",nullable = false)
    private Integer browserCount;//浏览次数

    @Column(name = "COMMENT_COUNT",nullable = false)
    private Integer commentCount;//评论次数

    @Column(name = "EDITOR")
    private String editor;//作者

    @Column(name = "EDITOR_ID")
    private Integer editorId;

    @Column(name = "IMAGE")
    private Integer imageId;


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

    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
    }

    public Integer getEditorId() {
        return editorId;
    }

    public void setEditorId(Integer editorId) {
        this.editorId = editorId;
    }

    @Override
    public String toString() {
        return "Article{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", time=" + time +
                ", browserCount=" + browserCount +
                ", commentCount=" + commentCount +
                ", editor='" + editor + '\'' +
                ", editorId=" + editorId +
                ", imageId=" + imageId +
                '}';
    }

    public Article(Integer id,String title, Date time, Integer browserCount, Integer commentCount, String editor) {
        this.id = id;
        this.title = title;
        this.time = time;
        this.browserCount = browserCount;
        this.commentCount = commentCount;
        this.editor = editor;
    }
}
