<%--
  Created by IntelliJ IDEA.
  User: hqs
  Date: 18-8-27
  Time: 下午9:00
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" %>
<%@page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>收藏夹</title>
    <%@include file="header.jsp"%>
    <style>
        .favorite{color: #16181b}
        a.favorite:hover{text-decoration: none}
    </style>
</head>
<body>
    <div class="iBody">
        <%@include file="nav.jsp"%>
        <article style="padding-top: 40px;padding-left: 40px">
            <h5 style="width:auto;margin: 20px auto 10px;">
                我的收藏
            </h5>
            <p style="font-size: 14px;width: 90%;border-bottom: 1px solid;height: 20px;margin-bottom: 10px">共${fn:length(favorite)}篇文章</p>
            <c:forEach items="${favorite}" var="favorite">
                <a href="${path}/index/details/${favorite.key.blogId}" class="favorite">
                <div class="card bg-light" style="width: 90%;margin-top: 10px;margin-bottom: 10px;color: #f7f7f7">
                    <div class="card-body">
                        <div>
                            <span style="font-size: 20px;">${favorite.value.title}</span>
                        </div>
                        <div>
                            <div style="float: left">
                                    ${favorite.value.editor}&nbsp;&nbsp;
                                浏览:${favorite.value.browserCount}&nbsp;|&nbsp;评论:${favorite.value.commentCount}
                            </div>
                            <div style="color: #6c757d;font-size: 12px;float: right">
                                收藏时间:<fmt:formatDate value="${favorite.key.time}"  pattern="yyyy-MM-dd HH:mm"/>&nbsp;
                                <a href="${path}/user/unstar?blogId=${favorite.key.blogId}" onclick="if(confirm('确定移出吗?')==false)return false;">移出</a>
                            </div>
                            <div style="clear: both"></div>
                        </div>
                    </div>
                </div>
                </a>
            </c:forEach>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear: both"></div>
    </div>
</body>
</html>
