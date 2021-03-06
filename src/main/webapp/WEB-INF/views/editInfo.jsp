<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/4/4/0004
  Time: 下午 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page pageEncoding="UTF-8" %>
<html>
<head>
    <title>${sessionScope.user.name}-修改</title>
    <%@ include file="header.jsp"%>
    <link rel="stylesheet" href="${path}/css/fileinput.min.css">
    <script src="${path}/js/fileinput.min.js"></script>
    <script src="${path}/js/zh.js"></script>
</head>
<body>
<div class="iBody">
    <%@include file="nav.jsp"%>
    <article>
        <center><h3 style="margin-top: 20px">修改个人资料</h3></center>
        <div style="margin: 30px 0 0 50px">
        <form method="post" action="${path}/user/edit" role="form" enctype="multipart/form-data">
                <c:if test="${!empty sessionScope.user.portrait}">
                    <img src="${path}/index/getImage?imgName=${sessionScope.user.portrait}" class="img-thumbnail" style="height: auto;width: 210px">
                </c:if>
                <c:if test="${empty sessionScope.user.portrait}">
                    <img src="${path}/img/img2.png" class="img-thumbnail" style="height: 210px;width: 210px">
                </c:if>
            <div class="form-group" style="margin-left: -15px;">
                <label class="col-sm-10 control-label item">上传头像</label>
                <div class="col-sm-10">
                    <input type="file" name="myfile" data-ref="url2" class="col-sm-10 myfile" value=""/>
                    <input type="hidden" name="url2" value="">
                </div>
            </div>
            <div class="form-group">
                <label for="interest">个人兴趣</label>
                <input type="text" class="form-control" id="interest" style="width: 80%" name="interest" value="${sessionScope.user.interest}">
            </div>
            <div class="form-group">
                <label for="description">个人描述</label>
                <textarea id="description"  class="form-control" rows="5" style="width: 80%" name="description">${sessionScope.user.description}</textarea>
            </div>
            <input type="submit" value="保&nbsp;&nbsp;存" class="btn btn-default">
        </form>
        </div>
    </article>
    <%@include file="aside.jsp"%>
    <div style="clear: both"></div>
</div>
<%@include file="upload.jsp"%>
</body>
</html>
