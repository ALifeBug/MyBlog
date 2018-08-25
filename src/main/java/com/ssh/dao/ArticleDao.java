package com.ssh.dao;

import com.ssh.entity.Article;
import com.ssh.entity.Page;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by sccy on 2018/3/17/0017.
 */
@Repository
public class ArticleDao extends BaseDao<Article> {


    /**
     * @param page 用于查询的page
     * @param name 用户名
     * @return  返回查询记录集合，按时间降序排列
     */
    public List<Article> queryForList(final Page<Article> page,final String name){
            return   getHibernateTemplate().execute(new HibernateCallback<List<Article>>() {
                public List<Article> doInHibernate(Session session) throws HibernateException {
                    String hql = "from Article a where a.editor = ? order by a.time desc ";
                    Query query = session.createQuery(hql);
                    query.setString(0,name);
                    query.setFirstResult(page.getOffset());
                    query.setMaxResults(page.getPageSize());
                    return query.list();
                }
            });
    }

    /**
     *
     * @param page 用于查询的page
     * @return 按照时间顺序返回所有的博客记录
     */
    public List<Article> queryForAll(final Page<Article> page, final String order){
        return getHibernateTemplate().execute(new HibernateCallback<List<Article>>() {
            public List<Article> doInHibernate(Session session) throws HibernateException {
                String hql1 = "select new Article(id,title,time,browserCount,commentCount,editor) from Article a order by a.browserCount desc";
                String hql2 = "select new Article(id,title,time,browserCount,commentCount,editor) from Article a order by a.commentCount desc";
                String hql3 = "select new Article(id,title,time,browserCount,commentCount,editor) from Article a order by a.time desc";
                String hql;
                if(order.equals("browser")) hql=hql1;
                else if(order.equals("comment")) hql=hql2;
                else hql=hql3;
                Query query = session.createQuery(hql);
                query.setFirstResult(page.getOffset());
                query.setMaxResults(page.getPageSize());
                return query.list();
            }
        });
    }


    /**
     *
     * @param name 编辑者名字
     * @return 指定作者下一共有多少条记录
     */
    public int queryForCount(String name){
         Long value = (Long)find("select count(id) from Article a where a.editor = ?",name).iterator().next();
         return value.intValue();
    }

    /**
     *
     * @return 一共有多少博客
     */
    public int queryForAllCount(){
        Long value = (Long)find("select count(id) from Article").iterator().next();
        return value.intValue();
    }

    /**
     *
     * @param name 作者名字
     * @return 返回该作者的所有文章的概要
     */
    public  List<Article> queryForOutlineByName(String name){
        return find("select new Article(id,title,time,browserCount,commentCount,editor)  from Article a where a.editor=?",name);
    }




}
