<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Tìm thông tin món ăn"/>
<%@ include file="../../WEB-INF/jspf/auth-customer.jspf" %>
<%@ include file="../../WEB-INF/jspf/header.jspf" %>
<%@ page import="com.restman.dao.DishDAO" %>
<%@ page import="com.restman.model.Dish" %>
<%
    request.setCharacterEncoding("UTF-8");

    // keyword == null  -> lan mo dau: chi hien form, chua co bang.
    // keyword rong/trang -> canh bao, khong truy van.
    String keywordParam = request.getParameter("keyword");
    String keyword = keywordParam == null ? "" : keywordParam.trim();

    String notice = null;
    String errorMessage = null;
    boolean searched = false;
    Dish[] listDish = null;

    if (keywordParam != null) {
        if (keyword.isEmpty()) {
            notice = "Vui lòng nhập tên món ăn.";
        } else {
            try (DishDAO dao = new DishDAO()) {
                listDish = dao.searchDishByName(keyword);
                searched = true;
            } catch (RuntimeException ex) {
                errorMessage = "Không truy vấn được dữ liệu món ăn. Vui lòng thử lại sau.";
                listDish = null;
            }
        }
    }

    request.setAttribute("listDish", listDish);
    request.setAttribute("searched", searched);
    request.setAttribute("notice", notice);
    request.setAttribute("errorMessage", errorMessage);
%>

<section class="card">
    <div class="card__head">
        <h1 class="card__title">Tìm thông tin món ăn</h1>
        <a class="btn btn-outline btn-sm" id="btnBack" href="<c:url value='/view/Customer/CustomerHome.jsp'/>">Quay lại</a>
    </div>

    <form method="get" action="<c:url value='/view/Customer/SearchDish.jsp'/>" class="form form-inline">
        <div class="field field-grow">
            <label for="txtKeyword">Tên món ăn</label>
            <input type="text" id="txtKeyword" name="keyword" value="<c:out value='${keyword}'/>"
                   placeholder="Ví dụ: Cá" autofocus/>
        </div>
        <div class="field field-action">
            <button type="submit" id="btnSearch" class="btn btn-primary">Tìm kiếm</button>
        </div>
    </form>

    <c:if test="${not empty notice}">
        <div class="alert alert-warning" role="alert">
            <span class="alert__icon" aria-hidden="true">!</span>
            <span><c:out value="${notice}"/></span>
        </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-error" role="alert">
            <span class="alert__icon" aria-hidden="true">!</span>
            <span><c:out value="${errorMessage}"/></span>
        </div>
    </c:if>

    <c:if test="${searched}">
        <c:choose>
            <c:when test="${fn:length(listDish) == 0}">
                <div class="alert alert-info" role="alert">
                    <span class="alert__icon" aria-hidden="true">i</span>
                    <span>Không tìm thấy món ăn nào chứa từ khóa “<c:out value="${keyword}"/>”.</span>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table class="table" id="tblDish">
                        <caption class="sr-only">Danh sách món ăn tìm thấy</caption>
                        <thead>
                        <tr>
                            <th scope="col" class="col-id">ID</th>
                            <th scope="col">Tên món ăn</th>
                            <th scope="col">Loại</th>
                            <th scope="col" class="col-num">Giá (VNĐ)</th>
                            <th scope="col" class="col-action">Chọn</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="dish" items="${listDish}">
                            <tr>
                                <td class="col-id"><c:out value="${dish.id}"/></td>
                                <td class="col-strong"><c:out value="${dish.dishName}"/></td>
                                <td><span class="chip"><c:out value="${dish.category}"/></span></td>
                                <td class="col-num"><fmt:formatNumber value="${dish.price}" type="number"/></td>
                                <td class="col-action">
                                    <a class="btn btn-primary btn-sm chooseDish"
                                       href="<c:url value='/view/Customer/DishDetail.jsp'>
                                               <c:param name="id" value="${dish.id}"/>
                                               <c:param name="keyword" value="${keyword}"/>
                                           </c:url>">Chọn</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <p class="result-count">
                    Tìm thấy <strong><c:out value="${fn:length(listDish)}"/></strong> món ăn
                    với từ khóa “<c:out value="${keyword}"/>”.
                </p>
            </c:otherwise>
        </c:choose>
    </c:if>
</section>

<%@ include file="../../WEB-INF/jspf/footer.jspf" %>
