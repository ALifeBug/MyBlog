<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>${user.name}的空间</title>
    <%@include file="header.jsp"%>
    <link rel="stylesheet" href="${path}/css/space.css">
</head>
<body>
<div class="iBody">
    <%@include file="nav.jsp"%>
    <article>
        <div style="width: 100%;height: 300px">
            <div class="portrait">
                <c:if test="${!empty user.portrait}">
                    <img src="${path}/index/getImage?imgName=${user.portrait}" class="img-thumbnail" width="100%" height="100%">
                </c:if>
                <c:if test="${empty user.portrait}">
                    <img src="${path}/img/img2.png" class="img-thumbnail" style="height: 210px;width: 210px">
                </c:if>
            </div>
            <div class="userInfo">
                <div class="anyTop">
                    <span>${user.name}</span>
                    <c:if test="${!(sessionScope.user.id eq user.id)}">
                        <c:if test="${!isFollowed}">
                            <a href="${path}/user/follow?followedId=${user.id}">
                                <button class="btn btn-success followButton">关注</button></a>
                        </c:if>
                        <c:if test="${isFollowed}">
                            <a href="${path}/user/unfollow?followedId=${user.id}">
                                <button class="btn btn-danger followButton">取消关注</button></a>
                        </c:if>
                    </c:if>
                </div>
                <hr style="width: 450px;margin: 0"/>
                <div class="bottom">
                    <table  cellspacing="4" cellpadding="15">
                        <tr>
                            <td align="right">已有博客:&nbsp;</td>
                            <td>${user.articles.size()}篇</td>
                        </tr>
                        <tr>
                            <td align="right">他的邮箱:&nbsp;</td>
                            <td>${user.email}</td>
                        </tr>
                        <tr>
                            <td align="right">他的兴趣:&nbsp;</td>
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
                    <span>他的博客</span>
                </p>
            </h2>
            <c:if test="${!empty user.articles}">
                <c:set var="startIndex" value="${fn:length(user.articles)-1}"/>
                <div style="margin:20px 0">
                    <c:forEach items="${user.articles}" var="article" varStatus="status">
                        <div class="anyArticle">
                            <a href="${path}/blog/details?blogId=${user.articles[startIndex - status.index].id}&pageNo=1">${user.articles[startIndex - status.index].title}</a>
                            <span><fmt:formatDate value="${user.articles[startIndex - status.index].time}"  pattern="yyyy-MM-dd HH:mm"/>&nbsp;&nbsp;</span>
                        </div>
                        <hr/>
                    </c:forEach>
                </div>
            </c:if>
            <c:if test="${empty user.articles}">
                <div>
                    <div class="hint">
                        他还没有博客哦
                    </div>
                </div>
            </c:if>
        </div>
    </article>
    <%@include file="aside.jsp"%>
    <div style="clear: both"></div>
</div>
</body>
</html>
