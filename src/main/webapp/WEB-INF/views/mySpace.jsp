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
                        <c:if test="${!empty sessionScope.user.imageId}">
                            <img src="${path}/image/getUserImage" class="img-thumbnail" width="100%" height="100%">
                        </c:if>
                        <c:if test="${empty sessionScope.user.imageId}">
                            <img src="${path}/img/img2.png" class="img-thumbnail" style="height: 210px;width: 210px">
                        </c:if>
                    </div>
                    <div class="userInfo">
                        <div class="top">
                            <span>${user.name}</span>
                            <a href="${path}/user/editForm" class="btn btn-default" role="button">修改个人信息</a>
                        </div>
                        <hr style="width: 450px;margin: 0"/>
                        <div class="bottom">
                            <table  cellspacing="4" cellpadding="10">
                                <tr>
                                    <td align="right">已有博客:&nbsp;</td>
                                    <td>${user.articles.size()}篇</td>
                                </tr>
                                <tr>
                                    <td align="right">我的邮箱:&nbsp;</td>
                                    <td>${user.email}</td>
                                </tr>
                                <tr>
                                    <td align="right">我的兴趣:&nbsp;</td>
                                    <td>${user.interest}</td>
                                </tr>
                                <tr>
                                    <td align="right">个人描述:&nbsp;</td>
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
                                <a href="${path}/user/space?id=${follow.followedId}">${follow.followed}</a>
                                <span>(更新博客${follow.update}篇)</span>
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
