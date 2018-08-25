<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/17/0017
  Time: 下午 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<aside>
    <div style="margin-top: 30px">
        <center>
        <c:if test="${!empty register}">
                <form:form commandName="user" method="post" action="${path}/index/register" cssClass="form">
                    <div class="error">${used}</div>
                    <form:input path="name" placeholder="昵称/至少5个字符" cssClass="form-control"/>
                    <form:errors cssClass="error" path="name"/>
                    <form:password path="password" placeholder="密码/5-10个字符" cssClass="form-control" />
                    <form:errors cssClass="error" path="password"/>
                    <input type="password" placeholder="确认密码" class="form-control" name="confirmPwd"/>
                    <div class="error">${confirmResult}</div>
                    <form:input path="email" placeholder="邮箱" cssClass="form-control"/>
                    <form:errors cssClass="error" path="email"/>
                    <form:input path="interest" placeholder="兴趣" cssClass="form-control" />
                    <form:textarea path="description" placeholder="自我描述..." cssClass="form-control"/>
                    <input type="submit" value="注册" class="btn btn-primary">
                </form:form>
                <p><a href="${path}/index/loginForm">返回登录</a></p>
        </c:if>
        <c:if test="${empty sessionScope.user && empty register}">
                <form action="${path}/index/login" method="post" class="form">
                    <div class="error">${error}</div>
                    <input  name="name" placeholder="昵称" class="form-control" required />
                    <input type="password"   id="password" class="form-control" name="password"  placeholder="密码" required/>
                    <input type="submit" class="btn btn-info" value="登&nbsp;&nbsp;录" />
                </form>
                <p>
                    <a href="${path}/index/registerForm">没有账号?去注册</a>
                </p>
        </c:if>
        </center>
        <c:if test="${!empty sessionScope.user}">
            <div style="width: 150px;height: 150px;margin: 0 auto">
                <c:if test="${!empty sessionScope.user.portrait}">
                    <img src="${path}/index/getImage?imgName=${sessionScope.user.portrait}" height="100%" width="100%" style="border-radius: 50%;">
                </c:if>
                <c:if test="${empty sessionScope.user.portrait}">
                    <img src="${path}/img/img2.png" height="100%" width="100%" style="border-radius: 50%;">
                </c:if>
            </div>
            <div class="personalInfo">
                <div><span class="glyphicon glyphicon-user"></span>昵称:${sessionScope.user.name}</div>
                <div><span class="glyphicon glyphicon-envelope"></span>邮箱:${sessionScope.user.email}</div>
                <div><span class="glyphicon glyphicon-heart"></span>兴趣:${sessionScope.user.interest}</div>
                <div><span class="glyphicon glyphicon-tag"></span>个人描述:${sessionScope.user.description}</div>
            </div>
            <form method="post" action="${path}/index/search">
            <div class="input-group mb-3 " style="width: 80%;height: 35px;margin: 30px auto;font-size: 15px">
                    <input type="text" class="form-control" placeholder="输入用户名搜索用户" id="name" name="name">
                    <div class="input-group-append">
                        <button class="btn btn-primary"  id="search"><span class="glyphicon glyphicon-search"></span></button>
                    </div>
            </div>
            </form>
            <c:if test="${!empty users}">
                <div style="margin-left: 37px;">
                    <div style="float: left;margin-right: 10px;font-family: 微软雅黑">结果</div>
                    <div style="float:left;">
                        <c:forEach items="${users}" var="user">
                            <div>
                                <c:if test="${!empty user.portrait}">
                                    <img src="${path}/index/getImage?imgName=${user.portrait}" class="usrPortrait">
                                </c:if>
                                <c:if test="${empty user.portrait}">
                                    <img src="${path}/img/img2.png"  class="usrPortrait">
                                </c:if>
                                <a href="${path}/user/space?id=${user.id}" class="usrText">${user.name}</a>
                            </div>
                        </c:forEach>
                    </div>
                 </div>
            </c:if>
        </c:if>
    </div>
</aside>
