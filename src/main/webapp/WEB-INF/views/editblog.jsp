<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/4/8/0008
  Time: 下午 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<%@ include file="header.jsp"%>
<link rel="stylesheet" href="${path}/css/fileinput.min.css">
<script src="${path}/js/fileinput.min.js"></script>
<script src="${path}/js/zh.js"></script>
<html>
<head>
    <title>${title}-修改</title>
    <link href="${path}/css/editblog.css" rel="stylesheet" />
</head>
<body>
<div class="iBody">
    <%@include file="nav.jsp"%>
    <article>
        <center><h3>修改我的博客</h3></center>
        <c:if test="${!empty image}">
            <div class="image">
                <img src="${path}/index/getImage?imgName=${image}"/>
            </div>
        </c:if>
        <div class="area">
            <form method="post" action="${path}/blog/edit?pageNo=${page.pageNo}&id=${id}" role="form" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="col-sm-10 control-label item">替换配图</label>
                    <div class="col-sm-10">
                        <input type="file" name="myfile" data-ref="url2" class="col-sm-10 myfile" value=""/>
                        <input type="hidden" name="url2" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="title">标题</label>
                    <input type="text" class="form-control" id="title" style="width: 80%" name="title" value="${title}" required>
                </div>
                <div class="form-group">
                    <label for="description">内容</label>
                    <textarea id="description"  class="form-control" rows="15" style="width: 80%" name="content" maxlength="500" required>${content}</textarea>
                </div>
                <input type="submit" value="保&nbsp;&nbsp;存" class="btn btn-default">
            </form>
        </div>
    </article>
    <%@include file="aside.jsp"%>
    <div style="clear: both"></div>
</div>
</body>
</html>
