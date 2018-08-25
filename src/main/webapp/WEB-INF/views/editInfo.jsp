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

<script>
    $(".myfile").fileinput({
        //上传的地址
        uploadUrl:"${path}/user/uploadFile",
        uploadAsync : true, //默认异步上传
        showUpload : false, //是否显示上传按钮,跟随文本框的那个
        showRemove : false, //显示移除按钮,跟随文本框的那个
        showCaption : true,//是否显示标题,就是那个文本框
        showPreview : true, //是否显示预览,不写默认为true
        dropZoneEnabled : false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
        //minImageWidth: 50, //图片的最小宽度
        //minImageHeight: 50,//图片的最小高度
        //maxImageWidth: 1000,//图片的最大宽度
        //maxImageHeight: 1000,//图片的最大高度
        maxFileSize:3072,//单位为kb，如果为0表示不限制文件大小
        //minFileCount: 0,
        maxFileCount : 4, //表示允许同时上传的最大文件个
        enctype : 'multipart/form-data',
        validateInitialCount : true,
        previewFileIcon : "<i class='glyphicon glyphicon-king'></i>",
        msgFilesTooMany : "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        allowedFileTypes : [ 'image' ],//配置允许文件上传的类型
        allowedPreviewTypes : [ 'image' ],//配置所有的被预览文件类型
        allowedPreviewMimeTypes : [ 'jpg', 'png', 'gif' ],//控制被预览的所有mime类型
        language : 'zh'
    });
    //异步上传返回结果处理
    $('.myfile').on('fileerror', function(event, data, msg) {
        console.log("fileerror");
        console.log(data);
    });
    //异步上传返回结果处理
    $(".myfile").on("fileuploaded", function(event, data, previewId, index) {
        console.log("fileuploaded");
        var ref = $(this).attr("data-ref");
        $("input[name='" + ref + "']").val(data.response.url);

    });

    //同步上传错误处理
    $('.myfile').on('filebatchuploaderror', function(event, data, msg) {
        console.log("filebatchuploaderror");
        console.log(data);
    });

    //同步上传返回结果处理
    $(".myfile").on("filebatchuploadsuccess",
        function(event, data, previewId, index) {
            console.log("filebatchuploadsuccess");
            console.log(data);
        });

    //上传前
    $('.myfile').on('filepreupload', function(event, data, previewId, index) {
        console.log("filepreupload");
    });
</script>
</body>
</html>
