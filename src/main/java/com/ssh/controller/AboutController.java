package com.ssh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by sccy on 2018/4/12/0012.
 */
@Controller
@RequestMapping("/about")
public class AboutController {

    @RequestMapping("about")
    public String about(){
        return "about";
    }
}
