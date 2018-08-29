package com.ssh.util;

import com.ssh.entity.User;
import com.ssh.service.ArticleService;
import com.ssh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;

/**
 * Created by sccy on 2018/4/3/0003.
 */
public class LoginInterceptor implements HandlerInterceptor{

    @Autowired
    private UserService userService;

    @Autowired
    private ArticleService articleService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object sessionuser = request.getSession().getAttribute("user");
        if(sessionuser == null){
            String loginCookieUserName = "";
            String loginCookiePassword = "";

            Cookie[] cookies = request.getCookies();
            if(null!=cookies){
                for(Cookie cookie : cookies){
                    if("userName".equals(cookie.getName())){
                        loginCookieUserName = URLDecoder.decode(cookie.getValue(),"utf-8");
                    }else if("password".equals(cookie.getName())){
                        loginCookiePassword = cookie.getValue();
                    }
                }
                if(!"".equals(loginCookieUserName) && !"".equals(loginCookiePassword)){
                    String pwd = userService.getPwdByName(loginCookieUserName);
                    if(loginCookiePassword.equals(pwd)){
                        request.getSession().setAttribute("user", userService.getUserByName(loginCookieUserName));
                    }
                }
            }
        }
        if(request.getSession().getAttribute("hotBlog")==null) {
            request.getSession().setAttribute("hotBlog", articleService.findHot());
        }
        return true;
    }



    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {}
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {}
}
