<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/16/0016
  Time: 下午 18:38
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" %>
<%@page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>MyBlog-主页</title>
    <%@include file="header.jsp"%>
    <meta charset="UTF-8">
    <link href="${path}/css/blog.css" rel="stylesheet">
    <script src="${path}/js/index.js" type="text/javascript"></script>
</head>
<body>
    <div class="iBody">
        <%@include file="nav.jsp"%>
        <article>
            <div class="bgImg">
                <h6>
                    <span style="font-family: 'Microsoft Yahei'">一个简单的博客,记录你的点点滴滴</span><br>
                    <span style="font-family: Consolas">Thank you for coming!</span>
                </h6>
            </div>
            <div class="article">
                <h2>
                    <p>
                        <span>推荐文章:</span>
                    </p>
                </h2>
                <div class="order" id="order">
                    <a href="${path}/index/time/1" id="time">按时间排序</a>&nbsp;
                    <a href="${path}/index/browser/1" id="browser">按浏览量排序</a>&nbsp;
                    <a href="${path}/index/comment/1" id="comment">按评论数排序</a>
                </div>
                <c:forEach items="${page.list}" var="blog">
                    <div class="articleList">
                        <h4><a href="${path}/index/details/${blog.id}">${blog.title}</a></h4>
                        <div class="articleInfo">
                            <span>
                                ${blog.editor}&nbsp;&nbsp;
                                <fmt:formatDate value="${blog.time}"  pattern="yyyy-MM-dd HH:mm"/>&nbsp;&nbsp;
                                浏览:(${blog.browserCount})&nbsp;&nbsp;
                                评论:(${blog.commentCount})
                            </span>
                        </div>
                    </div>
                    <hr/>
                </c:forEach>
            </div>
            <div style="margin-left: 37px">
                <c:if test="${page.totalPages != 0}">
                    <center>
                        <ul class="pagination pagination-sm">
                            <!--当前页数为1-->
                            <c:if test="${page.pageNo==1}">
                                <li class="disabled page-item"><a class="page-link" href="#">&lt;</a></li>
                            </c:if>
                            <!--当前页数不为1-->
                            <c:if test="${page.pageNo > 1}">
                                <li class="page-item"><a class="page-link" href="${path}/index/${order}/${page.previousPageNo}" >&lt;</a></li>
                            </c:if>
                            <c:forEach begin="1" end="${page.totalPages}" var="x">
                                <c:if test="${page.pageNo==x}">
                                    <li class="page-item active"><a class="page-link" href="${path}/index/${order}/${x}">${x}</a></li>
                                </c:if>
                                <c:if test="${page.pageNo!=x}">
                                    <li class="page-item" ><a class="page-link" href="${path}/index/${order}/${x}">${x}</a></li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${page.totalPages==page.pageNo}">
                                <li class="page-item disabled"><a class="page-link" href="#">&gt;</a></li>
                            </c:if>
                            <c:if test="${page.totalPages>page.pageNo}">
                                <li class="page-item"><a class="page-link" href="${path}/index/${order}/${page.nextPageNo}" >&gt;</a></li>
                            </c:if>
                        </ul>
                    </center>
                </c:if>
            </div>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear: both"></div>
    </div>
</body>
</html>
