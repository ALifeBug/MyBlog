<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/17/0017
  Time: 下午 22:17
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@include file="header.jsp"%>
<html>
<head>
    <title>我的博客</title>
    <link href="${path}/css/blog.css" rel="stylesheet">
    <jsp:useBean id="article" class="com.ssh.entity.Article" scope="request"/>
</head>
<body>
    <div class="iBody">
        <%@include file="nav.jsp"%>
        <article>
            <div class="blog">
                <h2>
                    <p>
                        <span>写博客</span>
                    </p>
                </h2>
            </div>
            <div class="writeArea">
            <form role="form" action="${path}/blog/save?pageNo=${page.pageNo}" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" class="form-control title" placeholder="给个标题吧" name="title" id="title" required value="${title}"/>
                </div>
                <div class="form-group">
                    <textarea class="form-control content" rows="10" placeholder="写点什么吧...(最多500个字)" name="content" id="content" required maxlength="500">${content}</textarea>
                </div>
                <div class="form-group">
                    <label for="img">贴个图(1M以内)</label>
                    <input type="file" id="img" name="img"/>
                    <span style="color: #ac2925">${error}</span>
                </div>
                <div>
                    <input type="submit" value="保&nbsp;&nbsp;&nbsp;&nbsp;存" class="btn btn-info btn-lg btn-block"/>
                </div>
            </form>
            </div>
            <div class="blog">
                <h2>
                    <p>
                        <span>我的博客</span>
                    </p>
                </h2>
                <c:if test="${empty sessionScope.user.articles}">
                    <div>
                        <div style="margin: 20px 0 10px 50px;font-size: 20px;text-align: center;font-family: 华文彩云">
                            您还没有博客哦,赶快写一篇吧。
                        </div>
                    </div>
                </c:if>
                <c:forEach items="${page.list}" var="blog">
                    <div class="blogList">
                        <h3><a href="${path}/blog/details?blogId=${blog.id}&pageNo=${page.pageNo}">${blog.title}</a></h3>
                        <div class="blogContent">
                                ${blog.content}
                        </div>
                        <div style="clear: both;">
                            <span class="blogRef"><a href="${path}/blog/details?blogId=${blog.id}&pageNo=${page.pageNo}">阅读全文</a></span>
                            <span class="blogInfo">
                                <fmt:formatDate value="${blog.time}"  pattern="yyyy-MM-dd HH:mm"/>&nbsp;&nbsp;
                                浏览:(${blog.browserCount})&nbsp;&nbsp;
                                评论:(${blog.commentCount})
                            </span>
                        </div>
                    </div>
                    <hr class="hr" />
                </c:forEach>
            </div>
            <div>
                    <c:if test="${page.totalPages != 0}">
                        <center>
                    <ul class="pagination pagination-sm">
                        <!--当前页数为1-->
                        <c:if test="${page.pageNo==1}">
                            <li class="disabled page-item"><a class="page-link" style="margin: 0 10px;border-radius: 50px;font-family: Consolas" href="#">&lt;</a></li>
                        </c:if>
                        <!--当前页数不为1-->
                        <c:if test="${page.pageNo > 1}">
                            <li class="page-item"><a class="page-link" href="${path}/blog/myBlog?pageNo=${page.previousPageNo}" style="margin: 0 10px;border-radius: 50px;font-family: Consolas">&lt;</a></li>
                        </c:if>
                        <c:forEach begin="1" end="${page.totalPages}" var="x">
                            <c:if test="${page.pageNo==x}">
                                <li class="page-item active"><a class="page-link" href="${path}/blog/myBlog?pageNo=${x}" style="margin: 0 10px;border-radius: 50px;font-family: Consolas">${x}</a></li>
                            </c:if>
                            <c:if test="${page.pageNo!=x}">
                                <li class="page-item" ><a class="page-link" href="${path}/blog/myBlog?pageNo=${x}" style="margin: 0 10px;border-radius: 50px">${x}</a></li>
                            </c:if>
                        </c:forEach>
                        <c:if test="${page.totalPages==page.pageNo}">
                            <li class="page-item disabled"><a class="page-link" href="#" style="margin: 0 10px;border-radius: 50px">&gt;</a></li>
                        </c:if>
                        <c:if test="${page.totalPages>page.pageNo}">
                            <li class="page-item"><a class="page-link" href="${path}/blog/myBlog?pageNo=${page.nextPageNo}" style="margin: 0 10px;border-radius: 50px">&gt;</a></li>
                        </c:if>
                    </ul>
                        </center>
                    </c:if>
            </div>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear:both"></div>
    </div>
</body>
</html>
