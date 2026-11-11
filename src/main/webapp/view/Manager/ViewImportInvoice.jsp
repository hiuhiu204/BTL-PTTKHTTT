<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Chi tiết hóa đơn nhập hàng"/>
<%@ include file="../../WEB-INF/jspf/auth-manager.jspf" %>
<%@ include file="../../WEB-INF/jspf/header.jspf" %>
<%@ page import="com.restman.dao.ImportDetailDAO" %>
<%@ page import="com.restman.model.ImportDetail" %>
<%@ page import="com.restman.model.ImportInvoice" %>
<%@ page import="com.restman.model.Supplier" %>
<%
    request.setCharacterEncoding("UTF-8");

    String invoiceIdParam = request.getParameter("invoiceId");
    String supplierIdParam = request.getParameter("supplierId");
    String startDateParam = request.getParameter("startDate");
    String endDateParam = request.getParameter("endDate");

    String statUrl = request.getContextPath() + "/view/Manager/SupplierStat.jsp";
    if (startDateParam != null && !startDateParam.trim().isEmpty()
            && endDateParam != null && !endDateParam.trim().isEmpty()) {
        statUrl += "?startDate=" + java.net.URLEncoder.encode(startDateParam.trim(), "UTF-8")
                + "&endDate=" + java.net.URLEncoder.encode(endDateParam.trim(), "UTF-8");
    }

    ImportInvoice invoice = null;

    // Tim hoa don da chon trong session "listInvoice" theo khoa chinh id.
    if (invoiceIdParam != null && !invoiceIdParam.trim().isEmpty()) {
        int invoiceId;
        try {
            invoiceId = Integer.parseInt(invoiceIdParam.trim());
        } catch (NumberFormatException ex) {
            response.sendRedirect(statUrl);
            return;
        }

        Object listInvoiceObject = session.getAttribute("listInvoice");
        if (listInvoiceObject instanceof ImportInvoice[]) {
            for (ImportInvoice item : (ImportInvoice[]) listInvoiceObject) {
                if (item.getId() == invoiceId) {
                    invoice = item;
                    break;
                }
            }
        }
    }

    // Thieu tham so hoac mat du lieu session -> quay lai trang thong ke.
    if (invoice == null || startDateParam == null || endDateParam == null
            || startDateParam.trim().isEmpty() || endDateParam.trim().isEmpty()) {
        response.sendRedirect(statUrl);
        return;
    }

    String startDateStr = startDateParam.trim();
    String endDateStr = endDateParam.trim();

    Supplier supplier = invoice.getSupplier();

    ImportDetail[] listDetail = null;
    String errorMessage = null;
    boolean loaded = false;
    try (ImportDetailDAO dao = new ImportDetailDAO()) {
        listDetail = dao.getDetailsByInvoice(invoice);
        loaded = true;
    } catch (RuntimeException ex) {
        errorMessage = "Không truy vấn được chi tiết hóa đơn. Vui lòng thử lại sau.";
        listDetail = null;
    }

    request.setAttribute("supplier", supplier);
    request.setAttribute("invoice", invoice);
    request.setAttribute("listDetail", listDetail);
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
    <a href="<c:url value='/view/Manager/ImportHistory.jsp'>
            <c:param name="supplierId" value="${supplier.id}"/>
            <c:param name="startDate" value="${startDateStr}"/>
            <c:param name="endDate" value="${endDateStr}"/>
        </c:url>">Lịch sử nhập hàng</a>
    <span class="breadcrumb__sep" aria-hidden="true">/</span>
    <span aria-current="page">Hóa đơn <c:out value="${invoice.invoiceID}"/></span>
</nav>

<section class="card">
    <div class="card__head">
        <h1 class="card__title">Hóa đơn nhập hàng</h1>
        <a class="btn btn-outline btn-sm" id="btnBack"
           href="<c:url value='/view/Manager/ImportHistory.jsp'>
                   <c:param name="supplierId" value="${supplier.id}"/>
                   <c:param name="startDate" value="${startDateStr}"/>
                   <c:param name="endDate" value="${endDateStr}"/>
               </c:url>">Quay lại</a>
    </div>

    <div class="summary">
        <div class="summary__item">
            <span class="summary__label">Nhà cung cấp</span>
            <span class="summary__value">
                <c:out value="${supplier.supplierName}"/>
                (<c:out value="${supplier.supplierID}"/>)
            </span>
        </div>
        <div class="summary__item">
            <span class="summary__label">Mã HĐ</span>
            <span class="summary__value"><c:out value="${invoice.invoiceID}"/></span>
        </div>
        <div class="summary__item">
            <span class="summary__label">Ngày nhập</span>
            <span class="summary__value">
                <fmt:formatDate value="${invoice.createdDate}" pattern="dd/MM/yyyy"/>
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
            <c:when test="${fn:length(listDetail) == 0}">
                <div class="alert alert-info" role="alert">
                    <span class="alert__icon" aria-hidden="true">i</span>
                    <span>Hóa đơn này không có chi tiết nguyên liệu.</span>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
            <table class="table" id="tblDetail">
                <caption class="sr-only">Chi tiết các dòng nguyên liệu trong hóa đơn</caption>
                <thead>
                <tr>
                    <th scope="col" class="col-id">Mã NL</th>
                    <th scope="col">Tên nguyên liệu</th>
                    <th scope="col">ĐVT</th>
                    <th scope="col" class="col-num">Số lượng</th>
                    <th scope="col" class="col-num">Đơn giá</th>
                    <th scope="col" class="col-num">Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="detail" items="${listDetail}">
                    <tr>
                        <td class="col-id"><c:out value="${detail.ingredient.ingredientID}"/></td>
                        <td class="col-strong"><c:out value="${detail.ingredient.ingredientName}"/></td>
                        <td><c:out value="${detail.ingredient.unit}"/></td>
                        <td class="col-num"><fmt:formatNumber value="${detail.quantity}" type="number"/></td>
                        <td class="col-num"><fmt:formatNumber value="${detail.unitPrice}" type="number"/></td>
                        <td class="col-num">
                            <fmt:formatNumber value="${detail.quantity * detail.unitPrice}" type="number"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
                </table>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <div class="total-row">
        <span class="total-row__label">Tổng</span>
        <span class="total-row__value">
            <fmt:formatNumber value="${invoice.totalAmount}" type="number"/> VNĐ
        </span>
    </div>
</section>

<%@ include file="../../WEB-INF/jspf/footer.jspf" %>
