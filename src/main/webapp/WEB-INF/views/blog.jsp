<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/17/0017
  Time: 下午 22:17
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>我的博客</title>
    <%@include file="header.jsp"%>
    <link rel="stylesheet" href="${path}/css/fileinput.min.css">
    <link href="${path}/css/blog.css" rel="stylesheet">
    <link rel="stylesheet" href="${path}/css/style.css">
    <script src="${path}/js/fileinput.min.js"></script>
    <script src="${path}/js/zh.js"></script>
    <jsp:useBean id="article" class="com.ssh.entity.Article" scope="request"/>
</head>
<body>
    <div class="iBody">
        <%@include file="nav.jsp"%>
        <article style="margin-top: 20px">
            <form action="${path}/blog/save?pageNo=${page.pageNo}" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" class="form-control title" placeholder="标题" name="title" id="title" required />
                </div>
                <div class="form-group">
                    <textarea class="form-control content" rows="30" placeholder="开始创作" name="content" id="content" required></textarea>
                </div>
                <div class="form-group" title="添加配图">
                    <div class="col-sm-10" style="margin-left: -16px">
                        <input type="file" name="myfile" data-ref="url2" class="col-sm-10 myfile" value=""/>
                        <input type="hidden" name="url2" value="">
                    </div>
                </div>
                <div class="form-group">
                    <div class="switch switch-blue" style="float: left;margin-right: 20px" title="推荐后显示在首页">
                        <input type="radio" class="switch-input" name="notice" value="1" id="notice">
                        <label for="notice" class="switch-label switch-label-off">推荐</label>
                        <input type="radio" class="switch-input" name="notice" value="0" id="keep" checked>
                        <label for="keep" class="switch-label switch-label-on">保留</label>
                        <span class="switch-selection"></span>
                    </div>
                    <div class="switch switch-yellow" style="float: left" title="设为私密加保留后仅自己可见">
                        <input type="radio" class="switch-input" name="secret" value="1" id="secret">
                        <label for="secret" class="switch-label switch-label-off">私密</label>
                        <input type="radio" class="switch-input" name="secret" value="0" id="public" checked>
                        <label for="public" class="switch-label switch-label-on">公开</label>
                        <span class="switch-selection"></span>
                    </div>
                </div>
                <div style="clear: both;height: 20px;"></div>
                <div>
                    <input type="submit" value="保存" class="btn btn-success" style="margin-left: 65px"/>
                </div>
            </form>
            <div class="blog">
                <h5 style="margin-left: 40px;margin-top: 40px;padding-bottom: 5px;width: 800px;border-bottom: 1px solid;">历史博客</h5>
                <c:if test="${empty sessionScope.user.articles}">
                    <div>
                        <div style="margin: 20px 0 10px 50px;font-size: 20px;text-align: center;">
                            您还没有博客哦,赶快写一篇吧。
                        </div>
                    </div>
                </c:if>
                <c:forEach items="${page.list}" var="blog">
                    <div class="blogList">
                        <h3><a href="${path}/blog/details?blogId=${blog.id}&pageNo=${page.pageNo}">${blog.title}</a></h3>
                        <div style="height: 25px;width: 100%">
                            <span class="blogRef"><a href="${path}/blog/details?blogId=${blog.id}&pageNo=${page.pageNo}">阅读全文</a></span>
                            <span class="blogInfo">
                                <fmt:formatDate value="${blog.time}"  pattern="yyyy-MM-dd HH:mm"/>&nbsp;&nbsp;
                                浏览:(${blog.browserCount})&nbsp;&nbsp;
                                评论:(${blog.commentCount})
                            </span>
                        </div>
                    </div>
                    <hr/>
                </c:forEach>
            </div>
            <div style="margin: 50px 35px">
                    <c:if test="${!(page.totalPages eq 0)}">
                    <c:if test="${page.totalPages gt 7}">
                        <ul class="pagination pagination-sm">
                            <!--当前页数为1-->
                            <c:if test="${page.pageNo==1}">
                                <li class="disabled page-item"><a class="page-link" href="#">«</a></li>
                            </c:if>
                            <!--当前页数不为1-->
                            <c:if test="${page.pageNo > 1}">
                                <li class="page-item"><a class="page-link" href="${path}/blog/myBlog?pageNo=${page.previousPageNo}" >«</a></li>
                            </c:if>

                            <c:if test="${page.pageNo le 4}">
                                <c:forEach begin="1" end="5" var="x">
                                    <c:if test="${page.pageNo==x}">
                                        <li class="page-item active"><a class="page-link " href="${path}/blog/myBlog?pageNo=${x}">${x}</a></li>
                                    </c:if>
                                    <c:if test="${page.pageNo!=x}">
                                        <li class="page-item" ><a class="page-link " href="${path}/blog/myBlog?pageNo=${x}">${x}</a></li>
                                    </c:if>
                                </c:forEach>
                                <li class="page-item"><a class="page-link" href="#">...</a></li>
                            </c:if>

                            <c:if test="${page.totalPages-page.pageNo le 3}">
                                <li class="page-item "><a class="page-link" href="#">...</a></li>
                                <c:forEach begin="${page.totalPages-4}" end="${page.totalPages}" var="x">
                                    <c:if test="${page.pageNo==x}">
                                        <li class="page-item active"><a class="page-link "  href="${path}/blog/myBlog?pageNo=${x}">${x}</a></li>
                                    </c:if>
                                    <c:if test="${page.pageNo!=x}">
                                        <li class="page-item" ><a class="page-link " href="${path}/blog/myBlog?pageNo=${x}">${x}</a></li>
                                    </c:if>
                                </c:forEach>
                            </c:if>

                            <c:if test="${page.pageNo gt 4 && page.totalPages-page.pageNo gt 3}">
                                <li class="page-item"><a class="page-link" href="#">...</a></li>
                                <li class="page-item active"><a class="page-link " href="${path}/blog/myBlog?pageNo=${page.pageNo}">${page.pageNo}</a></li>
                                <li class="page-item" ><a class="page-link " href="${path}/blog/myBlog?pageNo=${page.pageNo+1}">${page.pageNo+1}</a></li>
                                <li class="page-item" ><a class="page-link " href="${path}/blog/myBlog?pageNo=${page.pageNo+2}">${page.pageNo+2}</a></li>
                                <li class="page-item"><a class="page-link" href="#">...</a></li>
                            </c:if>

                            <c:if test="${page.totalPages==page.pageNo}">
                                <li class="page-item disabled"><a class="page-link " href="${path}/blog/myBlog?pageNo=${page.nextPageNo}">»</a></li>
                            </c:if>
                            <c:if test="${page.totalPages>page.pageNo}">
                                <li class="page-item"><a class="page-link " href="${path}/blog/myBlog?pageNo=${page.nextPageNo}">»</a></li>
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
                                <li class="page-item"><a class="page-link " href="${path}/blog/myBlog?pageNo=${page.previousPageNo}" >«</a></li>
                            </c:if>
                            <c:forEach begin="1" end="${page.totalPages}" var="x">
                                <c:if test="${page.pageNo==x}">
                                    <li class="page-item active"><a class="page-link " href="${path}/blog/myBlog?pageNo=${x}">${x}</a></li>
                                </c:if>
                                <c:if test="${page.pageNo!=x}">
                                    <li class="page-item" ><a class="page-link " href="${path}/blog/myBlog?pageNo=${x}">${x}</a></li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${page.totalPages==page.pageNo}">
                                <li class="page-item disabled"><a class="page-link " href="${path}/blog/myBlog?pageNo=${page.nextPageNo}">»</a></li>
                            </c:if>
                            <c:if test="${page.totalPages>page.pageNo}">
                                <li class="page-item"><a class="page-link " href="${path}/blog/myBlog?pageNo=${page.nextPageNo}">»</a></li>
                            </c:if>
                        </ul>
                    </c:if>
                    </c:if>
            </div>
        </article>
        <%@include file="aside.jsp"%>
        <div style="clear:both"></div>
    </div>
    <%@include file="upload.jsp"%>
</body>
</html>
