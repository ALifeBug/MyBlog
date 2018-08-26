<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/28/0028
  Time: 下午 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>${sessionScope.user.name}的空间</title>
    <%@include file="header.jsp"%>
    <link rel="stylesheet" href="${path}/css/space.css">
</head>
<body>
    <div class="iBody">
        <%@include file="nav.jsp"%>
        <article>
                <div style="width: 100%;height: 300px">
                    <div class="portrait">
                        <c:if test="${!empty sessionScope.user.portrait}">
                            <img src="${path}/index/getImage?imgName=${sessionScope.user.portrait}" class="img-thumbnail" width="100%" height="100%">
                        </c:if>
                        <c:if test="${empty sessionScope.user.portrait}">
                            <img src="${path}/img/img2.png" class="img-thumbnail" style="height: 240px;width: 240px">
                        </c:if>
                    </div>
                    <div class="userInfo">
                        <div class="top">
                            <span>${user.name}</span> 关注${fn:length(follower)} | 粉丝${fn:length(followed)}
                            <a href="${path}/index/logout" ><button class="btn btn-sm btn-danger">登出</button></a>
                            <a href="${path}/user/editForm" ><button class="btn btn-sm btn-primary">修改</button></a>
                        </div>
                        <hr style="margin: 0;width: 540px;"/>
                        <div class="bottom">
                            <table  cellspacing="2" cellpadding="2">
                                <tr>
                                    <td align="right" style="font-weight: bold"><span class="glyphicon glyphicon-book"></span>已有博客:&nbsp;</td>
                                    <td>${user.articles.size()}篇</td>
                                </tr>
                                <tr>
                                    <td align="right" style="font-weight: bold"><span class="glyphicon glyphicon-envelope"></span>我的邮箱:&nbsp;</td>
                                    <td>${user.email}</td>
                                </tr>
                                <tr>
                                    <td align="right" style="font-weight: bold"><span class="glyphicon glyphicon-heart"></span>我的兴趣:&nbsp;</td>
                                    <td>${user.interest}</td>
                                </tr>
                                <tr>
                                    <td align="right" style="font-weight: bold"><span class="glyphicon glyphicon-tag"></span>个人描述:&nbsp;</td>
                                    <td>${user.description}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="Info">
                    <h2>
                        <p>
                            <span>我的关注</span>
                        </p>
                    </h2>
                    <c:if test="${!empty follower}">
                        <c:forEach items="${follower}" var="follow">
                            <div class="follow">
                                <img src="${path}/index/getImage?usrId=${follow.followedId}" style="border-radius: 50%;width: 35px;height: 35px">
                                <a href="${path}/user/space?id=${follow.followedId}">${follow.followed}</a>
                                <span class="badge badge-primary" style="font-size: 12px">${follow.update}</span>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty follower}">
                        <div class="hint">
                            您还没有关注别人哦
                        </div>
                    </c:if>
                </div>
            <div class="Info">
                <h2>
                    <p>
                        <span>我的粉丝</span>
                    </p>
                </h2>
                <c:if test="${!empty followed}">
                    <c:forEach items="${followed}" var="follow">
                        <div class="follow">
                            <img src="${path}/index/getImage?usrId=${follow.followerId}" style="border-radius: 50%;width: 35px;height: 35px">
                            <a href="${path}/user/space?id=${follow.followerId}" style="color: rgba(61,204,17,0.82);">${follow.follower}</a>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty followed}">
                    <div class="hint">
                        您还没有粉丝哦
                    </div>
                </c:if>
            </div>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear: both"></div>
    </div>
</body>
</html>
