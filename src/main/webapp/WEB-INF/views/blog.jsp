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
    <script src="${path}/js/fileinput.min.js"></script>
    <script src="${path}/js/zh.js"></script>
    <link href="${path}/css/blog.css" rel="stylesheet">
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
                    <textarea class="form-control content" rows="30" placeholder="开始创作" name="content" id="content" required maxlength="500"></textarea>
                </div>
                <div class="form-group">
                    <div class="col-sm-10" style="margin-left: -16px">
                        <input type="file" name="myfile" data-ref="url2" class="col-sm-10 myfile" value=""/>
                        <input type="hidden" name="url2" value="">
                    </div>
                </div>
                <div>
                    <input type="submit" value="保存" class="btn btn-success" style="margin-left: 65px"/>
                </div>
            </form>
            <div class="blog">
                <h5 style="margin-left: 40px;margin-top: 40px;padding-bottom: 5px;width: 800px;border-bottom: 1px solid">历史博客</h5>
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
                    <hr/>
                </c:forEach>
            </div>
            <div style="margin: 50px 35px">
                <c:if test="${page.totalPages != 0}">
                <ul class="pagination pagination-sm">
                    <!--当前页数为1-->
                    <c:if test="${page.pageNo==1}">
                        <li class="disabled page-item"><a class="page-link"  href="#">«</a></li>
                    </c:if>
                    <!--当前页数不为1-->
                    <c:if test="${page.pageNo > 1}">
                        <li class="page-item"><a class="page-link" href="${path}/blog/myBlog?pageNo=${page.previousPageNo}" >«</a></li>
                    </c:if>
                    <c:forEach begin="1" end="${page.totalPages}" var="x">
                        <c:if test="${page.pageNo==x}">
                            <li class="page-item active"><a class="page-link" href="${path}/blog/myBlog?pageNo=${x}" >${x}</a></li>
                        </c:if>
                        <c:if test="${page.pageNo!=x}">
                            <li class="page-item" ><a class="page-link" href="${path}/blog/myBlog?pageNo=${x}" >${x}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${page.totalPages==page.pageNo}">
                        <li class="page-item disabled"><a class="page-link" href="#" >»</a></li>
                    </c:if>
                    <c:if test="${page.totalPages>page.pageNo}">
                        <li class="page-item"><a class="page-link" href="${path}/blog/myBlog?pageNo=${page.nextPageNo}">»</a></li>
                    </c:if>
                </ul>
                </c:if>
            </div>

        </article>
        <%@include file="aside.jsp"%>
        <div style="clear:both"></div>
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
