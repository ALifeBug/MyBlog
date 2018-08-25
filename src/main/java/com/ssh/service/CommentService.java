package com.ssh.service;

import com.ssh.dao.CommentDao;
import com.ssh.entity.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by sccy on 2018/3/21/0021.
 */
@Service
@Transactional
public class CommentService {

    @Autowired
    private CommentDao commentDao;

    public List<Comment> getByBlogId(Integer blogId){
        return commentDao.getByBlogId(blogId);
    }

    public void save(Comment comment){
        commentDao.save(comment);
    }
}
