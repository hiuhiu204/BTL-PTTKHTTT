<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Chọn loại báo cáo"/>
<%@ include file="../../WEB-INF/jspf/auth-manager.jspf" %>
<%@ include file="../../WEB-INF/jspf/header.jspf" %>

<nav class="breadcrumb" aria-label="Đường dẫn">
    <a href="<c:url value='/view/Manager/ManagerHome.jsp'/>">Trang chủ quản lý</a>
    <span class="breadcrumb__sep" aria-hidden="true">/</span>
    <span aria-current="page">Chọn báo cáo</span>
</nav>

<section class="card">
    <div class="card__head">
        <h1 class="card__title">Chọn loại báo cáo</h1>
        <a class="btn btn-outline btn-sm" id="btnBack" href="<c:url value='/view/Manager/ManagerHome.jsp'/>">Quay lại</a>
    </div>

    <ul class="report-list">
        <li class="report-item">
            <a class="report-link is-disabled" id="dishStatLink" href="#" aria-disabled="true"
               onclick="return false;">
                <span class="report-link__title">Thống kê món ăn</span>
                <span class="report-link__state">Sắp có</span>
            </a>
        </li>
        <li class="report-item">
            <a class="report-link is-disabled" id="ingredientStatLink" href="#" aria-disabled="true"
               onclick="return false;">
                <span class="report-link__title">Thống kê nguyên liệu</span>
                <span class="report-link__state">Sắp có</span>
            </a>
        </li>
        <li class="report-item">
            <a class="report-link is-disabled" id="customerStatLink" href="#" aria-disabled="true"
               onclick="return false;">
                <span class="report-link__title">Thống kê khách hàng</span>
                <span class="report-link__state">Sắp có</span>
            </a>
        </li>
        <li class="report-item">
            <a class="report-link" id="supplierStatLink"
               href="<c:url value='/view/Manager/SupplierStat.jsp'/>">
                <span class="report-link__title">Thống kê nhà cung cấp theo lượng nhập</span>
                <span class="report-link__state">Xem báo cáo</span>
            </a>
        </li>
    </ul>
</section>

<%@ include file="../../WEB-INF/jspf/footer.jspf" %>
