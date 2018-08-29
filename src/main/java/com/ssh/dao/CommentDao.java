package com.ssh.dao;

import com.ssh.entity.Comment;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sccy on 2018/3/21/0021.
 */
@Repository
public class CommentDao extends BaseDao<Comment> {
    /**
     *
     * @param blogId
     * @return 指定博客下的所有评论
     */
    public List<Comment> getByBlogId(Integer blogId){
        return find("from Comment c where c.blogId = ? order by c.time desc",blogId);
    }

    public void deleteByBlogId(Integer blogId){
        List<Comment> comments = getByBlogId(blogId);
        for(Comment comment:comments){
            getHibernateTemplate().delete(comment);
        }
    }
}
