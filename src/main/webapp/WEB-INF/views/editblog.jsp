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
    <link href="${path}/css/style.css" rel="stylesheet">
</head>
<body>
<div class="iBody">
    <%@include file="nav.jsp"%>
    <article>
        <center><h3 style="margin-top: 20px;">修改我的博客</h3></center>
        <c:if test="${!empty image}">
            <div class="image">
                <img src="${path}/index/getImage?imgName=${image}"/>
            </div>
        </c:if>
        <div class="area">
            <form method="post" action="${path}/blog/edit?pageNo=${page.pageNo}&id=${id}" role="form" enctype="multipart/form-data">
                <div class="form-group" style="margin-left: -16px">
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
                    <textarea id="description"  class="form-control" rows="30" style="width: 80%" name="content" maxlength="500" required>${content}</textarea>
                </div>
                <div class="form-group">
                    <div class="switch switch-blue" style="float: left;margin-right: 20px">
                        <input type="radio" class="switch-input" name="notice" value="1" id="notice">
                        <label for="notice" class="switch-label switch-label-off">推荐</label>
                        <input type="radio" class="switch-input" name="notice" value="0" id="keep">
                        <label for="keep" class="switch-label switch-label-on">保留</label>
                        <span class="switch-selection"></span>
                    </div>
                    <div class="switch switch-yellow" style="float: left">
                        <input type="radio" class="switch-input" name="secret" value="1" id="secret">
                        <label for="secret" class="switch-label switch-label-off">私密</label>
                        <input type="radio" class="switch-input" name="secret" value="0" id="public">
                        <label for="public" class="switch-label switch-label-on">公开</label>
                        <span class="switch-selection"></span>
                    </div>
                </div>
                <div style="clear: both;height: 20px;"></div>
                <input type="submit" value="保存" class="btn btn-default">
            </form>
        </div>
    </article>
    <%@include file="aside.jsp"%>
    <%@include file="upload.jsp"%>
    <div style="clear: both"></div>
</div>
<script>
    $(function () {
        if(${notice eq 1})
            $("#notice").attr("checked",true);
        else
            $("#keep").attr("checked",true);
        if(${secret eq 1})
            $("#secret").attr("checked",true);
        else
            $("#public").attr("checked",true);
    })
</script>
</body>
</html>
