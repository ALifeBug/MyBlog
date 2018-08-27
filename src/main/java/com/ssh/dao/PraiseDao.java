package com.ssh.dao;

import com.ssh.entity.Praise;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PraiseDao extends BaseDao<Praise>{

    public Praise queryForOne(final Integer blogId, final Integer usrId){
        return getHibernateTemplate().execute(new HibernateCallback<Praise>() {
            public Praise doInHibernate(Session session) throws HibernateException {
                String hql = "from Praise p where p.blogId = ? and p.usrId = ?";
                Query query = session.createQuery(hql);
                query.setParameter(0,blogId).setParameter(1,usrId);
                return (Praise) query.uniqueResult();
            }
        });
    }

    public List<Praise> queryForList(final Integer blogId){
        return   getHibernateTemplate().execute(new HibernateCallback<List<Praise>>() {
            public List<Praise> doInHibernate(Session session) throws HibernateException {
                String hql = "from Praise p where p.blogId = ?";
                Query query = session.createQuery(hql);
                query.setParameter(0,blogId);
                return query.list();
            }
        });
    }


}
