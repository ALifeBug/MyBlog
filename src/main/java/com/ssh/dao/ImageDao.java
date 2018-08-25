package com.ssh.dao;

import com.ssh.entity.Image;
import org.hibernate.HibernateException;
import org.hibernate.LobHelper;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;

/**
 * Created by sccy on 2018/4/4/0004.
 */
@Repository
public class ImageDao extends BaseDao<Image>{

    /**
     *
     * @param file
     * @return 图片的id
     */
    public Integer save(final MultipartFile file){
        return getHibernateTemplate().execute(new HibernateCallback<Integer>() {
            public Integer doInHibernate(Session session) throws HibernateException {
                //设置图片的名字和大小
                Image image = new Image();
                image.setName(file.getOriginalFilename());
                image.setSize(file.getSize());
                LobHelper lobHelper = session.getLobHelper();
                try {
                    //保存图片返回id
                    InputStream in = file.getInputStream();
                    image.setPicData(lobHelper.createBlob(in,in.available()));
                    session.save(image);
                    return image.getId();
                } catch (IOException e) {
                    e.printStackTrace();
                    return 0;
                }
            }
        });
    }
}
