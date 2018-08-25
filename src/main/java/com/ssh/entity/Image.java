package com.ssh.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Blob;

/**
 * Created by sccy on 2018/4/3/0003.
 */
@Entity
@Table(name = "IMAGE")
public class Image implements Serializable{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "ID",updatable = false)
    private Integer id;

    @Column(name = "NAME",nullable = false)
    private String name;//图片名

    @Column(name = "PIC_DATA",nullable = false)
    private Blob picData;//图片数据

    @Column(name = "SIZE")
    private long size;//图片大小

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

    public Blob getPicData() {
        return picData;
    }

    public void setPicData(Blob picData) {
        this.picData = picData;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }
}
