<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.restman.dao.MemberDAO" %>
<%@ page import="com.restman.model.Member" %>
<%@ page import="com.restman.model.Customer" %>
<%@ page import="com.restman.model.Manager" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đăng nhập"/>
<%
    request.setCharacterEncoding("UTF-8");

    String errorMessage = null;
    String username = "";

    if (request.getMethod() != null && "POST".equalsIgnoreCase(request.getMethod())) {
        username = request.getParameter("username");
        String password = request.getParameter("password");
        if (username == null) {
            username = "";
        }

        Member member = null;
        try (MemberDAO dao = new MemberDAO()) {
            member = dao.login(username.trim(), password == null ? "" : password);
        } catch (RuntimeException ex) {
            member = null;
        }

        if (member != null) {
            // Tao session moi truoc khi luu thong tin dang nhap.
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("member", member);

            if (member instanceof Customer) {
                response.sendRedirect(request.getContextPath() + "/view/Customer/CustomerHome.jsp");
                return;
            } else if (member instanceof Manager) {
                response.sendRedirect(request.getContextPath() + "/view/Manager/ManagerHome.jsp");
                return;
            }
        }
        errorMessage = "Tên đăng nhập hoặc mật khẩu không đúng, hoặc tài khoản chưa được hỗ trợ ở phiên bản này.";
    }

    request.setAttribute("errorMessage", errorMessage);
    request.setAttribute("username", username);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>RestMan &mdash; Đăng nhập</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/restman.css'/>"/>
    <link rel="icon" type="image/svg+xml" href="<c:url value='/assets/img/placeholder-dish.svg'/>"/>
</head>
<body class="page-auth">
<main class="auth-card">
    <div class="auth-card__brand">
        <span class="brand__mark" aria-hidden="true">R</span>
        <h1>RestMan</h1>
        <p>Quản lý nhà hàng</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error" role="alert">
            <span class="alert__icon" aria-hidden="true">!</span>
            <span><c:out value="${errorMessage}"/></span>
        </div>
    </c:if>

    <form method="post" action="<c:url value='/view/Login.jsp'/>" class="form form-auth">
        <div class="field">
            <label for="txtUsername">Tên đăng nhập</label>
            <input type="text" id="txtUsername" name="username" value="<c:out value='${username}'/>"
                   autocomplete="username" required autofocus/>
        </div>
        <div class="field">
            <label for="txtPassword">Mật khẩu</label>
            <input type="password" id="txtPassword" name="password" autocomplete="current-password" required/>
        </div>
        <button type="submit" id="btnLogin" class="btn btn-primary btn-block">Đăng nhập</button>
    </form>

    <p class="auth-card__hint">
        Tài khoản mẫu: <code>customer1</code> (khách hàng) &middot; <code>manager1</code> (quản lý) &middot;
        mật khẩu <code>123456</code>
    </p>
</main>
</body>
</html>
