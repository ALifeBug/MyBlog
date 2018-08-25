<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/16/0016
  Time: 下午 19:19
  To change this template use File | Settings | File Templates.
--%>

<%@page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" scope="session"><%=request.getContextPath()%></c:set>
<link rel="stylesheet" href="${path}/css/base.css"/>
<link rel="stylesheet" href="${path}/css/bootstrap.min.css"/>
<link rel="stylesheet" href="${path}/css/aside.css"/>
<link rel="stylesheet" href="${path}/css/index.css"/>
<script src="${path}/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<script src="${path}/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${path}/js/slider.js" type="text/javascript"></script>
