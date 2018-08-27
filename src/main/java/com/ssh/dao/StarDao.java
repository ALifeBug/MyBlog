package com.ssh.dao;

import com.ssh.entity.Star;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class StarDao extends BaseDao<Star> {
    public Star queryForOne(final Integer blogId, final Integer usrId){
        return getHibernateTemplate().execute(new HibernateCallback<Star>() {
            public Star doInHibernate(Session session) throws HibernateException {
                String hql = "from Star s where s.blogId = ? and s.usrId = ?";
                Query query = session.createQuery(hql);
                query.setParameter(0,blogId).setParameter(1,usrId);
                return (Star) query.uniqueResult();
            }
        });
    }

    //根据博客id查询收藏
    public List<Star> queryForList(final Integer blogId){
        return   getHibernateTemplate().execute(new HibernateCallback<List<Star>>() {
            public List<Star> doInHibernate(Session session) throws HibernateException {
                String hql = "from Star s where s.blogId = ?";
                Query query = session.createQuery(hql);
                query.setParameter(0,blogId);
                return query.list();
            }
        });
    }

    //根据用户id查询收藏
    public List<Star> queryForFavorite(final Integer usrId){
        return   getHibernateTemplate().execute(new HibernateCallback<List<Star>>() {
            public List<Star> doInHibernate(Session session) throws HibernateException {
                String hql = "from Star s where s.usrId = ? and s.stats = 1";
                Query query = session.createQuery(hql);
                query.setParameter(0,usrId);
                return query.list();
            }
        });
    }
}
