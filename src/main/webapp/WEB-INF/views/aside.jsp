<%--
  Created by IntelliJ IDEA.
  User: sccy
  Date: 2018/3/17/0017
  Time: 下午 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" isELIgnored="false" %>
<aside>
    <div>
        <c:if test="${!empty register}">
            <div class="formBlock">
                <form:form commandName="user" method="post" action="${path}/index/register" cssClass="form">
                    <form:errors cssClass="error" path="name"/>
                    <div class="error">${used}</div>
                    <form:input path="name" placeholder="昵称/至少5个字符" cssClass="form-control"/>
                    <form:errors cssClass="error" path="password"/>
                    <form:password path="password" placeholder="密码/5-10个字符" cssClass="form-control" />
                    <div class="error">${confirmResult}</div>
                    <input type="password" placeholder="确认密码" class="form-control" name="confirmPwd"/>
                    <form:errors cssClass="error" path="email"/>
                    <form:input path="email" placeholder="邮箱" cssClass="form-control"/>
                    <form:input path="interest" placeholder="兴趣" cssClass="form-control" />
                    <form:textarea path="description" placeholder="自我描述..." cssClass="form-control"/>
                    <input type="submit" value="注册" class="btn btn-primary">
                </form:form>
                <p><a href="${path}/index/loginForm">返回登录</a></p>
            </div>
        </c:if>
        <c:if test="${empty sessionScope.user && empty register}">
            <div class="formBlock">
                <form action="${path}/index/login" method="post" class="form">
                    <div class="error">${error}</div>
                    <input  name="name" placeholder="昵称" class="form-control" required />
                    <input type="password"   id="password" class="form-control" name="password"  placeholder="密码" required/>
                    <input type="submit" class="btn btn-info" value="登&nbsp;&nbsp;录" />
                </form>
                <p>
                    <a href="${path}/index/registerForm">没有账号?去注册</a>
                </p>
            </div>
        </c:if>
        <c:if test="${!empty sessionScope.user}">
            <div style="width: 150px;height: 150px;margin: 0 auto">
                <c:if test="${!empty sessionScope.user.imageId}">
                    <img src="${path}/image/getUserImage" height="100%" width="100%" style="border-radius: 50%;">
                </c:if>
                <c:if test="${empty sessionScope.user.imageId}">
                    <img src="${path}/img/img2.png" height="100%" width="100%" style="border-radius: 50%;">
                </c:if>
            </div>
            <div class="personalInfo">
                <div>昵称:${sessionScope.user.name}</div>
                <div>邮箱:${sessionScope.user.email}</div>
                <div>兴趣:${sessionScope.user.interest}</div>
                <div>个人描述:${sessionScope.user.description}</div>
                <div style="font-size: 20px"><a href="${path}/index/logout" class="btn btn-primary" style="text-decoration: none">注销账号</a></div>
            </div>

            <div style="margin:20px 0 35px 10px;height: 35px;width:260px;padding: 5px">
                <form method="post" action="${path}/index/search">
                    <span><input type="text" placeholder="输入用户名搜索用户" class="searchText" name="name"></span>
                    <span style="position: relative;left:-5px;"><input type="submit" value="Go!" class="searchButton" ></span>
                </form>
            </div>
            <c:if test="${!empty users}">
                <div style="width: 100%;height: auto;padding: 15px">
                    <div style="float: left;margin-right: 10px;font-family: 微软雅黑">查询结果</div>
                    <div style="float:left;">
                        <c:forEach items="${users}" var="user">
                            <div>
                                <c:if test="${!empty user.imageId}">
                                    <img src="${path}/image/getUserImage?userId=${user.id}" class="usrPortrait">
                                </c:if>
                                <c:if test="${empty user.imageId}">
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
