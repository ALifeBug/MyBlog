package com.ssh.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "STAR")
public class Star {

    @Id
    @GeneratedValue
    @Column(name = "ID",updatable = false)
    private Integer id;

    @Column(name = "USR_ID")
    private Integer usrId;//收藏者id

    @Column(name = "BLOG_ID")
    private Integer blogId;//收藏的博客id

    @Column(name = "STATS")
    private Integer stats;//收藏状态,可能取消收藏

    @Column(name = "TIME")
    private Date time;//收藏时间

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUsrId() {
        return usrId;
    }

    public void setUsrId(Integer usrId) {
        this.usrId = usrId;
    }

    public Integer getBlogId() {
        return blogId;
    }

    public void setBlogId(Integer blogId) {
        this.blogId = blogId;
    }

    public Integer getStats() {
        return stats;
    }

    public void setStats(Integer stats) {
        this.stats = stats;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Star(Integer usrId, Integer blogId, Integer stats, Date time) {
        this.usrId = usrId;
        this.blogId = blogId;
        this.stats = stats;
        this.time = time;
    }

    public Star(){}
}
