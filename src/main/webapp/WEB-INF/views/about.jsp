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
        <article>
            <p style="margin: 80px 20px 20px 20px;">
                <center style="font-family: Consolas;font-size: 20px">
                    本项目是本人的练习项目<br>
                    项目结构:MAVEN Spring+SpringMVC+Hibernate c3p0数据源<br>
                    前台显示JSP，使用了少量的jquery。对javaScript还不是很精通<br>
                    Github:<a href="https://github.com/ALifeBug/SSHBlog">https://github.com/ALifeBug/SSHBlog</a>
                    感谢您的关注!
                </center>
            </p>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear: both"></div>
    </div>
</body>
</html>
