package com.ssh.service;

import com.ssh.dao.ImageDao;
import com.ssh.entity.Image;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by sccy on 2018/4/4/0004.
 */
@Service
@Transactional
public class ImageService {

    @Autowired
    private ImageDao imageDao;

    public Integer save(final MultipartFile file){
        return imageDao.save(file);
    }

    public Image get(Integer id){
        return imageDao.getById(id);
    }
}
