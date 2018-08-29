<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/17/0017
  Time: 上午 0:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" isELIgnored="false" %>
<header>
    <div style="width: 1200px;height: 15px;background-color: #080808"></div>
    <nav id="tonal">
        <a href="${path}/index/home" id="index"><span class="glyphicon glyphicon-home"></span>首页</a>
        <a href="${path}/blog/myBlog?pageNo=1" id="blog"><span class="glyphicon glyphicon-pencil"></span>博客</a>
        <a href="${path}/user/mySpace" id="user"><span class="glyphicon glyphicon-user"></span>空间</a>
        <a href="${path}/user/favorite" id="favorite"><span class="glyphicon glyphicon-star"></span>收藏</a>
        <a href="${path}/about/about" id="about">关于我</a>
    </nav>
</header>