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
                <div class="info">
                    发布时间:<fmt:formatDate value="${article.time}"  pattern="yyyy年MM月dd日 HH:mm"/>
                    作者:<a id="editor" href="${path}/user/space?id=${article.editorId}">${article.editor}</a>
                    浏览量(${article.browserCount})
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
            <div class="commBanner"><span style="font-size: 20px" class="glyphicon glyphicon-pencil">评论</span><span style="font-size: medium">(已有${article.commentCount}条评论)</span></div>
            <c:if test="${!empty sessionScope.user}">
            <div class="commArea">
            <form:form role="form" commandName="comment" action="${path}/comment/save?pageNo=${page.pageNo}" method="post" >
                <div class="form-group">
                    <input type="text" class="form-control" name="content" placeholder="发表评论" required maxlength="100">
                </div>
                <form:hidden path="blogId" value="${article.id}"/>
                <form:hidden path="userName" value="${sessionScope.user.name}"/>
                <form:hidden path="userId" value="${sessionScope.user.id}"/>
                <form:hidden path="image" value="${sessionScope.user.portrait}"/>
                <div>
                    <input type="submit" value="保存" class="btn btn-info"/>
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
                            <div class="commContent" style="font-size: 15px;color: #0f0f0f"><a href="${path}/user/space?id=${comment.userId}" style="text-decoration: none">${comment.userName}:</a>${comment.content}</div>
                            <div class="commContent" style="font-size: 10px;color: #6c757d"><fmt:formatDate value="${comment.time}"  pattern="yyyy年MM月dd日 HH:mm"/></div>
                        </div>
                    </div>
                    <div style="clear: both"></div>
                </c:forEach>
            </div>
            <c:if test="${!empty sessionScope.user}">
                <c:if test="${sessionScope.user.name eq article.editor}">
                    <a href="${path}/blog/editform?blogId=${article.id}&pageNo=${page.pageNo}" class="edit">
                        <button class="btn btn-success">编辑</button>
                    </a>
                    <a href="${path}/blog/delete?blogId=${article.id}&pageNo=${page.pageNo}" class="delete">
                        <button class="btn btn-danger" onclick="if(confirm('确定删除吗?')==false)return false;">删除</button>
                    </a>
                    <a href="${path}/blog/myBlog?pageNo=${page.pageNo}" class="return">
                        <button class="btn btn-primary">返回</button>
                    </a>
                </c:if>
            </c:if>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear: both"></div>
    </div>
</body>
</html>
