<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Thống kê nhà cung cấp"/>
<%@ include file="../../WEB-INF/jspf/auth-manager.jspf" %>
<%@ include file="../../WEB-INF/jspf/header.jspf" %>
<%@ page import="com.restman.dao.StatSupplierDAO" %>
<%@ page import="com.restman.model.StatSupplier" %>
<%
    request.setCharacterEncoding("UTF-8");

    String startDateParam = request.getParameter("startDate");
    String endDateParam = request.getParameter("endDate");
    String startDateStr = startDateParam == null ? "" : startDateParam.trim();
    String endDateStr = endDateParam == null ? "" : endDateParam.trim();

    String errorMessage = null;
    boolean searched = false;
    StatSupplier[] listStat = null;

    if (startDateParam != null || endDateParam != null) {
        if (startDateStr.isEmpty() || endDateStr.isEmpty()) {
            errorMessage = "Vui lòng chọn đầy đủ từ ngày và đến ngày.";
        } else {
            java.sql.Date startDate = null;
            java.sql.Date endDate = null;
            try {
                startDate = java.sql.Date.valueOf(startDateStr);
                endDate = java.sql.Date.valueOf(endDateStr);
            } catch (IllegalArgumentException ex) {
                errorMessage = "Khoảng thời gian không hợp lệ. Vui lòng nhập ngày theo định dạng yyyy-MM-dd.";
            }

            if (errorMessage == null) {
                if (startDate.after(endDate)) {
                    errorMessage = "Từ ngày không được sau đến ngày.";
                } else {
                    try (StatSupplierDAO dao = new StatSupplierDAO()) {
                        listStat = dao.getSupplierStat(startDate, endDate);
                        searched = true;
                    } catch (RuntimeException ex) {
                        errorMessage = "Không truy vấn được dữ liệu thống kê. Vui lòng thử lại sau.";
                        listStat = null;
                    }
                }
            }
        }
    }

    if (listStat != null) {
        // Luu danh sach thong ke vao session de cac trang sau dung lai.
        session.setAttribute("listStat", listStat);
    }

    request.setAttribute("listStat", listStat);
    request.setAttribute("searched", searched);
    request.setAttribute("errorMessage", errorMessage);
    request.setAttribute("startDateStr", startDateStr);
    request.setAttribute("endDateStr", endDateStr);
%>

<nav class="breadcrumb" aria-label="Đường dẫn">
    <a href="<c:url value='/view/Manager/ManagerHome.jsp'/>">Trang chủ quản lý</a>
    <span class="breadcrumb__sep" aria-hidden="true">/</span>
    <a href="<c:url value='/view/Manager/ReportMenu.jsp'/>">Báo cáo</a>
    <span class="breadcrumb__sep" aria-hidden="true">/</span>
    <span aria-current="page">Thống kê nhà cung cấp</span>
</nav>

<section class="card">
    <div class="card__head">
        <h1 class="card__title">Thống kê nhà cung cấp theo lượng nhập</h1>
        <a class="btn btn-outline btn-sm" id="btnBack" href="<c:url value='/view/Manager/ReportMenu.jsp'/>">Quay lại</a>
    </div>

    <form method="get" action="<c:url value='/view/Manager/SupplierStat.jsp'/>" class="form form-inline">
        <div class="field">
            <label for="txtStartDate">Từ ngày</label>
            <input type="date" id="txtStartDate" name="startDate" value="<c:out value='${startDateStr}'/>"
                   max="<c:out value='${endDateStr}'/>" required autofocus/>
        </div>
        <div class="field">
            <label for="txtEndDate">Đến ngày</label>
            <input type="date" id="txtEndDate" name="endDate" value="<c:out value='${endDateStr}'/>"
                   min="<c:out value='${startDateStr}'/>" required/>
        </div>
        <div class="field field-action">
            <button type="submit" id="btnStat" class="btn btn-primary">Thống kê</button>
        </div>
    </form>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error" role="alert">
            <span class="alert__icon" aria-hidden="true">!</span>
            <span><c:out value="${errorMessage}"/></span>
        </div>
    </c:if>

    <c:if test="${searched}">
        <div class="table-wrap">
            <table class="table" id="tblSupplier">
                <caption class="sr-only">Thống kê tổng lượng nhập theo nhà cung cấp</caption>
                <thead>
                <tr>
                    <th scope="col" class="col-id">ID</th>
                    <th scope="col">Tên nhà cung cấp</th>
                    <th scope="col" class="col-num">Tổng lượng nhập</th>
                    <th scope="col" class="col-action">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="stat" items="${listStat}">
                    <tr>
                        <td class="col-id"><c:out value="${stat.supplierID}"/></td>
                        <td class="col-strong"><c:out value="${stat.supplierName}"/></td>
                        <td class="col-num">
                            <fmt:formatNumber value="${stat.totalImportAmount}" type="number"/>
                        </td>
                        <td class="col-action">
                            <a class="btn btn-primary btn-sm chooseSupplier"
                               href="<c:url value='/view/Manager/ImportHistory.jsp'>
                                       <c:param name="supplierId" value="${stat.id}"/>
                                       <c:param name="startDate" value="${startDateStr}"/>
                                       <c:param name="endDate" value="${endDateStr}"/>
                                   </c:url>">Chọn</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${fn:length(listStat) == 0}">
                    <tr>
                        <td colspan="4" class="table-empty">Không có dữ liệu nhập hàng trong khoảng thời gian đã chọn.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <c:if test="${fn:length(listStat) > 0}">
            <p class="result-count">
                Thống kê cho
                <fmt:parseDate value="${startDateStr}" pattern="yyyy-MM-dd" var="startDateDisplay"/>
                <fmt:parseDate value="${endDateStr}" pattern="yyyy-MM-dd" var="endDateDisplay"/>
                <strong><fmt:formatDate value="${startDateDisplay}" pattern="dd/MM/yyyy"/></strong> -
                <strong><fmt:formatDate value="${endDateDisplay}" pattern="dd/MM/yyyy"/></strong>:
                <strong><c:out value="${fn:length(listStat)}"/></strong> nhà cung cấp có phát sinh nhập.
            </p>
        </c:if>
    </c:if>
</section>

<%@ include file="../../WEB-INF/jspf/footer.jspf" %>
