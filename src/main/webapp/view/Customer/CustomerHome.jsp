<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Trang chủ khách hàng"/>
<%@ include file="../../WEB-INF/jspf/auth-customer.jspf" %>
<%@ include file="../../WEB-INF/jspf/header.jspf" %>

<section class="card">
    <h1 class="card__title">Trang chủ khách hàng</h1>
    <p class="card__lead">
        Xin chào, <strong><c:out value="${customer.fullName}"/></strong> — bạn có thể tra cứu thông tin các món ăn
        trong thực đơn của RestMan.
    </p>

    <c:if test="${not empty customer.membershipCard}">
        <p class="badge-line">
            Thẻ thành viên <strong><c:out value="${customer.membershipCard.cardID}"/></strong>
            &middot; hạng <strong><c:out value="${customer.membershipCard.tier}"/></strong>
            &middot; điểm <strong><c:out value="${customer.membershipCard.points}"/></strong>
        </p>
    </c:if>

    <div class="action-grid">
        <a class="action-card" id="searchDishLink" href="<c:url value='/view/Customer/SearchDish.jsp'/>">
            <span class="action-card__icon" aria-hidden="true">&#128269;</span>
            <span class="action-card__body">
                <span class="action-card__title">Tìm thông tin món ăn</span>
                <span class="action-card__desc">Tìm món theo tên, xem giá, loại và mô tả chi tiết.</span>
            </span>
        </a>
    </div>
</section>

<%@ include file="../../WEB-INF/jspf/footer.jspf" %>
