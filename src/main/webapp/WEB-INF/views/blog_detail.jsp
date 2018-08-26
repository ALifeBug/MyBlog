<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/21/0021
  Time: 下午 12:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ include file="header.jsp"%>
<html>
<head>
    <title>${article.title}</title>
    <link href="${path}/css/detail.css" rel="stylesheet">
</head>
<body>
    <div class="iBody">
        <%@include file="nav.jsp"%>
        <article>
            <div class="blog">
                <center>
                    <h2>${article.title}</h2>
                <div>
                    发布时间:<fmt:formatDate value="${article.time}"  pattern="yyyy年MM月dd日 HH:mm"/>
                    作者:<c:if test="${empty sessionScope.user}"><a id="editor" href="${path}/user/space?id=${article.editorId}">${article.editor}</a></c:if>
                    <c:if test="${!empty sessionScope.user}">
                        <c:if test="${!(sessionScope.user.id eq article.editorId)}"><a id="editor" href="${path}/user/space?id=${article.editorId}">${article.editor}</a></c:if>
                        <c:if test="${(sessionScope.user.id eq article.editorId)}"><a id="editor" href="${path}/user/mySpace">${article.editor}</a></c:if>
                    </c:if>
                    浏览量(${article.browserCount})&nbsp;
                    <c:if test="${!empty sessionScope.user}">
                        <c:if test="${sessionScope.user.name eq article.editor}">
                            <a href="${path}/blog/editform?blogId=${article.id}&pageNo=${page.pageNo}">
                                编辑
                            </a>
                            |
                            <a href="${path}/blog/delete?blogId=${article.id}&pageNo=${page.pageNo}" onclick="if(confirm('确定删除吗?')==false)return false;" style="color: #dc3545">
                                删除
                            </a>
                        </c:if>
                    </c:if>
                </div>
                </center>
                <div style="width: 700px;margin: 10px 35px;font-family: 'Microsoft Yahei', Arial, Helvetica, sans-serif;font-size: 17px;">
                    <c:if test="${!empty article.image}">
                        <img src="${path}/index/getImage?imgName=${article.image}" class="image"/>
                    </c:if>
                    ${article.content}
                </div>
            </div>
            <div style="clear: both"></div>
            <div class="commBanner"><span style="font-size: 20px" class="glyphicon glyphicon-comment">评论</span><span style="font-size: medium">(已有${article.commentCount}条评论)</span></div>
            <c:if test="${!empty sessionScope.user}">
            <div class="commArea">
                <form:form role="form" commandName="comment" action="${path}/comment/save?pageNo=${page.pageNo}" method="post" >
                    <form:hidden path="blogId" value="${article.id}"/>
                    <form:hidden path="userName" value="${sessionScope.user.name}"/>
                    <form:hidden path="userId" value="${sessionScope.user.id}"/>
                    <form:hidden path="image" value="${sessionScope.user.portrait}"/>
                    <div class="input-group mb-3 " style="width: 100%;height: 40px;margin: 30px auto;font-size: 15px">
                        <input type="text" class="form-control" placeholder="发表评论" id="name" name="content" required maxlength="100">
                        <div class="input-group-append">
                            <button class="btn btn-info"  id="search"><span class="glyphicon glyphicon-pencil"></span></button>
                        </div>
                    </div>
                </form:form>
            </div>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <div class="loginFail">
                    <h2><a href="${path}/index/loginForm" style="text-decoration: none;">登录后加入评论</a></h2>
                </div>
            </c:if>
            <div class="commBanner">
                <span style="font-size: medium">最新评论</span>
            </div>
            <div class="comments">
                <c:forEach var="comment" items="${comments}">
                    <div class="commInfo">
                        <div style="width: 50px">
                            <c:if test="${!empty comment.image}">
                                <img src="${path}/index/getImage?imgName=${comment.image}" style="border-radius: 50%;width: 45px;height: 45px;">
                            </c:if>
                            <c:if test="${empty comment.image}">
                                <img src="${path}/img/img2.png" style="border-radius: 50%;width: 45px;height: 45px">
                            </c:if>
                        </div>
                        <div style="width: 560px;height: auto;margin-bottom: 10px">
                            <div class="commContent" style="font-size: 15px;color: #0f0f0f">
                                <c:if test="${empty sessionScope.user}"><a href="${path}/user/space?id=${comment.userId}">${comment.userName}:</a></c:if>
                                <c:if test="${!empty sessionScope.user}">
                                    <c:if test="${!(sessionScope.user.id eq article.editorId)}"><a href="${path}/user/space?id=${comment.userId}">${comment.userName}:</a></c:if>
                                    <c:if test="${(sessionScope.user.id eq article.editorId)}"><a href="${path}/user/mySpace">${article.editor}</a></c:if>
                                </c:if>
                                ${comment.content}
                            </div>
                            <div class="commContent" style="font-size: 10px;color: #6c757d"><fmt:formatDate value="${comment.time}"  pattern="yyyy年MM月dd日 HH:mm"/></div>
                        </div>
                    </div>
                    <div style="clear: both"></div>
                    <hr style="height:3px;border:none;border-top:1px groove skyblue;margin:10px 0;width: 610px;"/>
                </c:forEach>
            </div>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear: both"></div>
    </div>
</body>
</html>
