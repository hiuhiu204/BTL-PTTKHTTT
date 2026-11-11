<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Trang chủ quản lý"/>
<%@ include file="../../WEB-INF/jspf/auth-manager.jspf" %>
<%@ include file="../../WEB-INF/jspf/header.jspf" %>

<section class="card">
    <h1 class="card__title">Trang chủ quản lý</h1>
    <p class="card__lead">
        Xin chào, <strong><c:out value="${manager.fullName}"/></strong> — chọn loại báo cáo cần xem.
    </p>
    <p class="badge-line">
        Mã nhân viên <strong><c:out value="${manager.employeeID}"/></strong>
        &middot; chức vụ <strong><c:out value="${manager.position}"/></strong>
    </p>

    <div class="action-grid">
        <a class="action-card" id="viewReportLink" href="<c:url value='/view/Manager/ReportMenu.jsp'/>">
            <span class="action-card__icon" aria-hidden="true">▤</span>
            <span class="action-card__body">
                <span class="action-card__title">Xem báo cáo</span>
                <span class="action-card__desc">Thống kê nhà cung cấp theo tổng lượng nhập.</span>
            </span>
        </a>
    </div>
</section>

<%@ include file="../../WEB-INF/jspf/footer.jspf" %>
