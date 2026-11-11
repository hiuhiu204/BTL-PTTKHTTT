<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Lịch sử nhập hàng"/>
<%@ include file="../../WEB-INF/jspf/auth-manager.jspf" %>
<%@ include file="../../WEB-INF/jspf/header.jspf" %>
<%@ page import="com.restman.dao.ImportInvoiceDAO" %>
<%@ page import="com.restman.model.ImportInvoice" %>
<%@ page import="com.restman.model.Supplier" %>
<%
    request.setCharacterEncoding("UTF-8");

    String supplierIdParam = request.getParameter("supplierId");
    String startDateParam = request.getParameter("startDate");
    String endDateParam = request.getParameter("endDate");

    String statUrl = request.getContextPath() + "/view/Manager/SupplierStat.jsp";
    if (startDateParam != null && !startDateParam.trim().isEmpty()
            && endDateParam != null && !endDateParam.trim().isEmpty()) {
        statUrl += "?startDate=" + java.net.URLEncoder.encode(startDateParam.trim(), "UTF-8")
                + "&endDate=" + java.net.URLEncoder.encode(endDateParam.trim(), "UTF-8");
    }

    Supplier supplier = null;

    // Tim nha cung cap da chon trong session "listStat" theo khoa chinh id.
    if (supplierIdParam != null && !supplierIdParam.trim().isEmpty()) {
        int supplierId;
        try {
            supplierId = Integer.parseInt(supplierIdParam.trim());
        } catch (NumberFormatException ex) {
            response.sendRedirect(statUrl);
            return;
        }

        Object listStatObject = session.getAttribute("listStat");
        if (listStatObject instanceof Supplier[]) {
            for (Supplier item : (Supplier[]) listStatObject) {
                if (item.getId() == supplierId) {
                    supplier = item;
                    break;
                }
            }
        }
    }

    // Thieu tham so hoac mat du lieu session -> quay lai trang thong ke.
    if (supplier == null || startDateParam == null || endDateParam == null
            || startDateParam.trim().isEmpty() || endDateParam.trim().isEmpty()) {
        response.sendRedirect(statUrl);
        return;
    }

    String startDateStr = startDateParam.trim();
    String endDateStr = endDateParam.trim();

    java.sql.Date startDate = null;
    java.sql.Date endDate = null;
    try {
        startDate = java.sql.Date.valueOf(startDateStr);
        endDate = java.sql.Date.valueOf(endDateStr);
    } catch (IllegalArgumentException ex) {
        response.sendRedirect(statUrl);
        return;
    }

    ImportInvoice[] listInvoice = null;
    String errorMessage = null;
    boolean loaded = false;
    try (ImportInvoiceDAO dao = new ImportInvoiceDAO()) {
        listInvoice = dao.getInvoicesBySupplier(supplier, startDate, endDate);
        // Luu lich su nhap hang vao session de trang hoa don dung lai.
        session.setAttribute("listInvoice", listInvoice);
        loaded = true;
    } catch (RuntimeException ex) {
        errorMessage = "Không truy vấn được lịch sử nhập hàng. Vui lòng thử lại sau.";
        listInvoice = null;
    }

    request.setAttribute("supplier", supplier);
    request.setAttribute("listInvoice", listInvoice);
    request.setAttribute("loaded", loaded);
    request.setAttribute("errorMessage", errorMessage);
    request.setAttribute("startDateStr", startDateStr);
    request.setAttribute("endDateStr", endDateStr);
%>

<nav class="breadcrumb" aria-label="Đường dẫn">
    <a href="<c:url value='/view/Manager/ManagerHome.jsp'/>">Trang chủ quản lý</a>
    <span class="breadcrumb__sep" aria-hidden="true">/</span>
    <a href="<c:url value='/view/Manager/ReportMenu.jsp'/>">Báo cáo</a>
    <span class="breadcrumb__sep" aria-hidden="true">/</span>
    <a href="<c:url value='/view/Manager/SupplierStat.jsp'>
            <c:param name="startDate" value="${startDateStr}"/>
            <c:param name="endDate" value="${endDateStr}"/>
        </c:url>">Thống kê nhà cung cấp</a>
    <span class="breadcrumb__sep" aria-hidden="true">/</span>
    <span aria-current="page">Lịch sử nhập hàng</span>
</nav>

<section class="card">
    <div class="card__head">
        <h1 class="card__title">Lịch sử nhập hàng</h1>
        <a class="btn btn-outline btn-sm" id="btnBack"
           href="<c:url value='/view/Manager/SupplierStat.jsp'>
                   <c:param name="startDate" value="${startDateStr}"/>
                   <c:param name="endDate" value="${endDateStr}"/>
               </c:url>">Quay lại</a>
    </div>

    <div class="summary">
        <div class="summary__item">
            <span class="summary__label">ID</span>
            <span class="summary__value"><c:out value="${supplier.supplierID}"/></span>
        </div>
        <div class="summary__item">
            <span class="summary__label">Nhà cung cấp</span>
            <span class="summary__value"><c:out value="${supplier.supplierName}"/></span>
        </div>
        <div class="summary__item">
            <span class="summary__label">Khoảng thời gian</span>
            <span class="summary__value">
                <fmt:parseDate value="${startDateStr}" pattern="yyyy-MM-dd" var="startDateDisplay"/>
                <fmt:parseDate value="${endDateStr}" pattern="yyyy-MM-dd" var="endDateDisplay"/>
                <fmt:formatDate value="${startDateDisplay}" pattern="dd/MM/yyyy"/> -
                <fmt:formatDate value="${endDateDisplay}" pattern="dd/MM/yyyy"/>
            </span>
        </div>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error" role="alert">
            <span class="alert__icon" aria-hidden="true">!</span>
            <span><c:out value="${errorMessage}"/></span>
        </div>
    </c:if>

    <c:if test="${loaded}">
        <c:choose>
            <c:when test="${fn:length(listInvoice) == 0}">
                <div class="alert alert-info" role="alert">
                    <span class="alert__icon" aria-hidden="true">i</span>
                    <span>Nhà cung cấp chưa có lịch sử nhập hàng nào.</span>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table class="table" id="tblInvoice">
                        <caption class="sr-only">Lịch sử nhập hàng của nhà cung cấp</caption>
                        <thead>
                        <tr>
                            <th scope="col" class="col-id">Mã HĐ</th>
                            <th scope="col">Ngày nhập</th>
                            <th scope="col" class="col-num">Tổng tiền (VNĐ)</th>
                            <th scope="col" class="col-action">Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="invoice" items="${listInvoice}">
                            <tr>
                                <td class="col-id"><c:out value="${invoice.invoiceID}"/></td>
                                <td><fmt:formatDate value="${invoice.createdDate}" pattern="dd/MM/yyyy"/></td>
                                <td class="col-num"><fmt:formatNumber value="${invoice.totalAmount}" type="number"/></td>
                                <td class="col-action">
                                    <a class="btn btn-primary btn-sm chooseInvoice"
                                       href="<c:url value='/view/Manager/ViewImportInvoice.jsp'>
                                               <c:param name="invoiceId" value="${invoice.id}"/>
                                               <c:param name="supplierId" value="${supplier.id}"/>
                                               <c:param name="startDate" value="${startDateStr}"/>
                                               <c:param name="endDate" value="${endDateStr}"/>
                                           </c:url>">Chọn</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>
</section>

<%@ include file="../../WEB-INF/jspf/footer.jspf" %>
