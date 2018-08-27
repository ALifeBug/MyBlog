package com.ssh;

import com.ssh.util.RedisUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring-mvc.xml"})
@WebAppConfiguration("src/main/resources")
public class TestRedis {

    @Resource
    private RedisTemplate redisTemplate;

    @Autowired
    private RedisUtil redisUtil;

    @Test
    public void testRedis() {
        redisTemplate.boundValueOps("zhangsan").set("李四");

        String str = (String) redisTemplate.boundValueOps("zhangsan").get();
        System.out.println(str);
    }

    @Test
    public void testRedisUtil(){
        redisUtil.set("name", "王赛超");
        redisUtil.set("age", 24);
        redisUtil.set("address", "河北邯郸");

        //System.out.println(redisUtil.set("address", "河北邯郸", 50));

        System.out.println(redisUtil.get("age"));

        //redisUtil.del("name","age","address");

        //Map<String,Object> user = new HashMap<>();
        //user.put("name","hqs");
        //user.put("age",21);
        //user.put("address","海淀");

        //redisUtil.hmset("user",user);
        //redisUtil.hdel("user","address");

        //System.out.println(redisUtil.hmget("user"));
        //System.out.println(redisUtil.hget("user","name"));

        //redisUtil.set("online",12);
        //System.out.println(redisUtil.get("online"));
        //redisUtil.incr("online",1);
        //System.out.println(redisUtil.get("online"));

        //Set<String> set = new HashSet<>();
        //set.add("hqs1");
        //set.add("hqs2");
        //redisUtil.set("set",set);
        //System.out.println(redisUtil.sSet("set","hh","bb"));
        //System.out.println(redisUtil.sGet("set"));
        //System.out.println(redisUtil.sHasKey("set","hh"));

        //List<Integer> list = new ArrayList<Integer>();
        //list.add(1);
        //list.add(2);
        //redisUtil.lSet("list",list);
        //redisUtil.lSet("list",3);
        //System.out.println(redisUtil.lGet("list",0,-1));
        //System.out.println(redisUtil.lGetListSize("list"));
        //System.out.println(redisUtil.lGetIndex("list",1));

        //redisUtil.lUpdateIndex("list",0,1);
        //List mylist = (List)redisUtil.lGetIndex("list",1);
        //System.out.println(mylist);
        //redisUtil.lRemove("list",1,mylist);
        //redisUtil.lSet("list",list);
        //System.out.println(redisUtil.lGet("list",0,-1));

    }
}
