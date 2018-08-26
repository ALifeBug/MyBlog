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
                    <c:if test="${!empty sessionScope.user}">
                        <c:if test="${!isFollowed}">
                            <a href="${path}/user/follow?followedId=${user.id}">
                                <button class="btn btn-success followButton btn-sm">+关注</button></a>
                        </c:if>
                        <c:if test="${isFollowed}">
                            <a href="${path}/user/unfollow?followedId=${user.id}">
                                <button class="btn btn-danger followButton btn-sm">取消关注</button></a>
                        </c:if>
                    </c:if>
                </div>
                <hr style="width: 450px;margin: 0"/>
                <div class="bottom">
                    <table  cellspacing="2" cellpadding="2">
                        <tr>
                            <td align="right" style="font-weight: bold"><span class="glyphicon glyphicon-book"></span>已有博客:&nbsp;</td>
                            <td>${user.articles.size()}篇</td>
                        </tr>
                        <tr>
                            <td align="right" style="font-weight: bold"><span class="glyphicon glyphicon-envelope"></span>他的邮箱:&nbsp;</td>
                            <td>${user.email}</td>
                        </tr>
                        <tr>
                            <td align="right" style="font-weight: bold"><span class="glyphicon glyphicon-heart"></span>他的兴趣:&nbsp;</td>
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
                    <span>他的博客</span>
                </p>
            </h2>
            <div class="articleList">
                <c:set var="startIndex" value="${fn:length(user.articles)-1}"/>
                    <div style="margin:20px 0">
                    <c:forEach items="${user.articles}" var="blog" varStatus="status">
                        <div>
                            <a href="${path}/index/details/${blog.id}" style="font-size: 20px;color: #dc3545;">${blog.title}</a>
                        </div>
                        <div class="articleInfo">
                            <div style="float: left">
                                ${blog.editor}&nbsp;&nbsp;
                                浏览:${blog.browserCount}&nbsp;|&nbsp;评论:${blog.commentCount}
                            </div>
                            <div style="color: #6c757d;font-size: 12px;float: right">
                                <fmt:formatDate value="${blog.time}"  pattern="yyyy-MM-dd HH:mm"/>
                            </div>
                            <div style="clear: both"></div>
                        </div>
                        <hr/>
                        </c:forEach>
                    </div>
            </div>

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
