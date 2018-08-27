package com.ssh.entity;

import javax.persistence.*;

@Entity
@Table(name = "Praise")
public class Praise{

    @Id
    @GeneratedValue
    @Column(name = "ID",updatable = false)
    private Integer id;

    @Column(name = "USR_ID")
    private Integer usrId;//点赞者id

    @Column(name = "BLOG_ID")
    private Integer blogId;//点赞博客id

    @Column(name = "STATS")
    private Integer stats;//是否赞,可能取消赞

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

    public Praise(Integer usrId, Integer blogId, Integer stats) {
        this.usrId = usrId;
        this.blogId = blogId;
        this.stats = stats;
    }

    public Praise() {
    }
}
