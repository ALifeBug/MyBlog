package com.ssh.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;


import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

/**
 * Created by sccy on 2018/3/15/0015.
 */
public class BaseDao<T> {
    private Class<T> entityClass;

    @Autowired
    private HibernateTemplate hibernateTemplate;

    public HibernateTemplate getHibernateTemplate() {
        return hibernateTemplate;
    }

    public BaseDao(){
        Type genType = getClass().getGenericSuperclass();
        Type[] params = ((ParameterizedType)genType).getActualTypeArguments();
        entityClass = (Class) params[0];
    }

    //查询
    public T getById(Serializable id){
        return hibernateTemplate.get(entityClass,id);
    }
    //保存
    public void save(T entity){
        hibernateTemplate.save(entity);
    }
    //删除
    public void remove(T entity){
        hibernateTemplate.delete(entity);
    }
    //更新
    public void update(T entity){
        hibernateTemplate.update(entity);
    }
    //hql查询
    public List find(String hql){
        return hibernateTemplate.find(hql);
    }
    //hql带参查询
    public List find(String hql,Object...params){
        return hibernateTemplate.find(hql, params);
    }

}
