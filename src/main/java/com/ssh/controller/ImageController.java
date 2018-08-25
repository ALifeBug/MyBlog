package com.ssh.controller;

import com.ssh.entity.Image;
import com.ssh.entity.User;
import com.ssh.service.ImageService;
import com.ssh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.SQLException;

/**
 * Created by sccy on 2018/4/8/0008.
 */
@Controller
@RequestMapping("/image")
public class ImageController {

    @Autowired
    private ImageService imageService;

    @Autowired
    private UserService userService;

    @RequestMapping("/getBlogImage")
    public void getImage(HttpServletResponse response, @RequestParam("imageId")Integer imageId) throws SQLException, IOException {
        Image image;
        BufferedInputStream in=null;
        if(imageId!= null){
            image = imageService.get(imageId);
            in = new BufferedInputStream(image.getPicData().getBinaryStream());
        }
        response.setContentType("image/*");// 设置返回内容格式
        OutputStream os = response.getOutputStream();  //创建输出流
        byte[] b = new byte[1024];
        while( in.read(b)!= -1){
            os.write(b);
        }
        in.close();
        os.flush();
        os.close();
    }

    @RequestMapping("/getUserImage")
    public void getImage(HttpSession session, HttpServletResponse response, @RequestParam(value = "userId",required = false)Integer userId) throws SQLException, IOException {
        User user;
        if(userId!=null)
            user = userService.getUserById(userId);
        else
            user = (User) session.getAttribute("user");
        if(user.getImageId() != null) {
            BufferedInputStream in = null;
            Image image = imageService.get(user.getImageId());
            in = new BufferedInputStream(image.getPicData().getBinaryStream());
            response.setContentType("image/*");// 设置返回内容格式
            OutputStream os = response.getOutputStream();  //创建输出流
            byte[] b = new byte[1024];
            while (in.read(b) != -1) {
                os.write(b);
            }
            in.close();
            os.flush();
            os.close();
        }
    }


}
