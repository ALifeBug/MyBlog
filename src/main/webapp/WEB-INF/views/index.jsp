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
                        <div>
                            <a href="${path}/index/details/${blog.id}" style="font-size: 20px;color: #dc3545">${blog.title}</a>
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
                    </div>
                    <hr/>
                </c:forEach>
            </div>
            <div style="margin-left: 37px">
                <c:if test="${!(page.totalPages eq 0)}">
                    <c:if test="${page.totalPages gt 7}">
                        <ul class="pagination pagination-sm">
                            <!--当前页数为1-->
                            <c:if test="${page.pageNo==1}">
                                <li class="disabled page-item"><a class="page-link" href="#">«</a></li>
                            </c:if>
                            <!--当前页数不为1-->
                            <c:if test="${page.pageNo > 1}">
                                <li class="page-item"><a class="page-link" href="${path}/index/${order}/${page.previousPageNo}" >«</a></li>
                            </c:if>

                            <c:if test="${page.pageNo le 4}">
                                <c:forEach begin="1" end="5" var="x">
                                    <c:if test="${page.pageNo==x}">
                                        <li class="page-item active"><a class="page-link " href="${path}/index/${order}/${x}">${x}</a></li>
                                    </c:if>
                                    <c:if test="${page.pageNo!=x}">
                                        <li class="page-item" ><a class="page-link " href="${path}/index/${order}/${x}">${x}</a></li>
                                    </c:if>
                                </c:forEach>
                                <li class="page-item"><a class="page-link" href="#">...</a></li>
                            </c:if>

                            <c:if test="${page.totalPages-page.pageNo le 3}">
                                <li class="page-item "><a class="page-link" href="#">...</a></li>
                                <c:forEach begin="${page.totalPages-4}" end="${page.totalPages}" var="x">
                                    <c:if test="${page.pageNo==x}">
                                        <li class="page-item active"><a class="page-link "  href="${path}/index/${order}/${x}">${x}</a></li>
                                    </c:if>
                                    <c:if test="${page.pageNo!=x}">
                                        <li class="page-item" ><a class="page-link " href="${path}/index/${order}/${x}">${x}</a></li>
                                    </c:if>
                                </c:forEach>
                            </c:if>

                            <c:if test="${page.pageNo gt 4 && page.totalPages-page.pageNo gt 3}">
                                <li class="page-item"><a class="page-link" href="#">...</a></li>
                                <li class="page-item active"><a class="page-link " href="${path}/index/${order}/${page.pageNo}">${page.pageNo}</a></li>
                                <li class="page-item" ><a class="page-link " href="${path}/index/${order}/${page.pageNo+1}">${page.pageNo+1}</a></li>
                                <li class="page-item" ><a class="page-link " href="${path}/index/${order}/${page.pageNo+2}">${page.pageNo+2}</a></li>
                                <li class="page-item"><a class="page-link" href="#">...</a></li>
                            </c:if>

                            <c:if test="${page.totalPages==page.pageNo}">
                                <li class="page-item disabled"><a class="page-link " href="${path}/index/${order}/${page.nextPageNo}">»</a></li>
                            </c:if>
                            <c:if test="${page.totalPages>page.pageNo}">
                                <li class="page-item"><a class="page-link " href="${path}/index/${order}/${page.nextPageNo}">»</a></li>
                            </c:if>
                        </ul>
                    </c:if>

                    <c:if test="${page.totalPages le 7}">
                        <ul class="pagination pagination-sm">
                            <!--当前页数为1-->
                            <c:if test="${page.pageNo==1}">
                                <li class="disabled page-item"><a class="page-link" href="#">«</a></li>
                            </c:if>
                            <!--当前页数不为1-->
                            <c:if test="${page.pageNo > 1}">
                                <li class="page-item"><a class="page-link " href="${path}/index/${order}/${page.previousPageNo}" >«</a></li>
                            </c:if>
                            <c:forEach begin="1" end="${page.totalPages}" var="x">
                                <c:if test="${page.pageNo==x}">
                                    <li class="page-item active"><a class="page-link " href="${path}/index/${order}/${x}">${x}</a></li>
                                </c:if>
                                <c:if test="${page.pageNo!=x}">
                                    <li class="page-item" ><a class="page-link " href="${path}/index/${order}/${x}">${x}</a></li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${page.totalPages==page.pageNo}">
                                <li class="page-item disabled"><a class="page-link " href="${path}/index/${order}/${page.nextPageNo}">»</a></li>
                            </c:if>
                            <c:if test="${page.totalPages>page.pageNo}">
                                <li class="page-item"><a class="page-link " href="${path}/index/${order}/${page.nextPageNo}">»</a></li>
                            </c:if>
                        </ul>
                    </c:if>
                </c:if>
            </div>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear: both"></div>
    </div>
</body>
</html>
