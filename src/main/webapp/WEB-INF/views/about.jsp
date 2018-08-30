<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/4/12/0012
  Time: 下午 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>关于</title>
    <%@include file="header.jsp"%>
</head>
<body>
    <div class="iBody">
        <%@include file="nav.jsp"%>
        <article style="padding: 5%">
            <h3 style="font-family: Consolas;color: #ffc107;">About me</h3>
            <p style="font-size: 14px;line-height: 30px;margin-bottom: 60px">
                <span style="font-family: 'Microsoft Yahei';">年轻的思想总会受到现实的围追堵截.</span><br>
                <span style="font-family: Arial">一生最理想的情况是只做一件事.</span><br>
                <span style="font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif">逃不过似水流年,只盼活在当下.</span><br>
                <span style="font-family: 楷体">最漫长的事情莫过于等待,比等待还漫长的事情莫过于踯躅独行.</span><br>
                <span style="font-family: 'Microsoft Yahei'">人比动物高级,是因为懂得思考.</span><br>
                <span style="font-family: 'Microsoft Yahei'">没有人能逃得过死亡,万物皆虚,万事皆允.</span><br>
                <span style="font-family: Arial">坐在凉凉月色旁,何尝不是一种清静.</span><br>
                <span style="font-family: 楷体">回忆是一池清泉,掬一捧总会从指尖消散.</span><br>
                <span style="font-family: 'Microsoft Yahei'">创造美是一种天赋,欣赏美是一种能力.</span><br>
                <span style="font-family: 黑体">与世争不如与己争,与己争不如不争.</span><br>
                <span style="font-family: 楷体">昨日,我新发现一首好歌,满心欢喜.</span><br>
                <span style="font-family: 'Microsoft Yahei'">道法自然,万事皆有因缘,随缘吧,一切都是最好的安排.</span><br>
                ..................
            </p>
            <h3 style="font-family: Consolas;color: #ffc107;">About MyBlog</h3>
            <p style="font-size: 14px;line-height: 30px;font-family: 'Microsoft Yahei';margin-bottom: 60px">
                <span style="font-weight: bold">作者:</span> 伤透一盏风<br>
                <span style="font-weight: bold">程序:</span> 原创程序,练习项目<br>
                <span style="font-weight: bold">服务器:</span> 阿里云 tomcat<br>
                <span style="font-weight: bold">Github:</span> <a href="https://github.com/ALifeBug/MyBlog">MyBlog</a><br>
                <span style="font-weight: bold">技术路线:</span> 框架:spring+springmvc+hibernate 数据库:mysql+redis+c3p0 前端:jsp+jquery+css+bootstrap
            </p>
            <h4 style="font-family: Consolas;color: #fd7e14">Thank you for coming!</h4>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear: both"></div>
    </div>
</body>
</html>
