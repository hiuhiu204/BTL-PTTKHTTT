<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Chi tiết món ăn"/>
<%@ include file="../../WEB-INF/jspf/auth-customer.jspf" %>
<%@ include file="../../WEB-INF/jspf/header.jspf" %>
<%@ page import="com.restman.dao.DishDAO" %>
<%@ page import="com.restman.model.Dish" %>
<%
    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("id");
    String keyword = request.getParameter("keyword");
    if (keyword == null) {
        keyword = "";
    }

    Dish dish = null;
    String errorMessage = null;

    if (idParam == null || idParam.trim().isEmpty()) {
        errorMessage = "Không tìm thấy món ăn.";
    } else {
        try {
            int id = Integer.parseInt(idParam.trim());
            try (DishDAO dao = new DishDAO()) {
                dish = dao.getDishDetail(id);
            }
            if (dish == null) {
                errorMessage = "Không tìm thấy món ăn.";
            }
        } catch (NumberFormatException ex) {
            errorMessage = "Không tìm thấy món ăn.";
        } catch (RuntimeException ex) {
            errorMessage = "Không truy vấn được dữ liệu món ăn. Vui lòng thử lại sau.";
        }
    }

    // Duong dan quay lai luon giu lai tu khoa tim kiem truoc do.
    String backUrl;
    if (keyword.isEmpty()) {
        backUrl = request.getContextPath() + "/view/Customer/SearchDish.jsp";
    } else {
        backUrl = request.getContextPath() + "/view/Customer/SearchDish.jsp?keyword="
                + java.net.URLEncoder.encode(keyword, "UTF-8");
    }

    String imageUrl = null;
    if (dish != null && dish.getImage() != null && !dish.getImage().trim().isEmpty()) {
        imageUrl = request.getContextPath() + "/assets/img/" + dish.getImage().trim();
    }
    String placeholderUrl = request.getContextPath() + "/assets/img/placeholder-dish.svg";

    request.setAttribute("dish", dish);
    request.setAttribute("errorMessage", errorMessage);
    request.setAttribute("backUrl", backUrl);
    request.setAttribute("imageUrl", imageUrl);
    request.setAttribute("placeholderUrl", placeholderUrl);
%>

<section class="card">
    <div class="card__head">
        <h1 class="card__title">Chi tiết món ăn</h1>
        <a class="btn btn-outline btn-sm" id="btnBack" href="<c:out value='${backUrl}'/>">Quay lại</a>
    </div>

    <c:choose>
        <c:when test="${not empty errorMessage}">
            <div class="alert alert-error" role="alert">
                <span class="alert__icon" aria-hidden="true">!</span>
                <span><c:out value="${errorMessage}"/></span>
            </div>
        </c:when>
        <c:otherwise>
            <div class="detail">
                <div class="detail__media">
                    <c:choose>
                        <c:when test="${not empty imageUrl}">
                            <img class="detail__image" src="<c:out value='${imageUrl}'/>"
                                 alt="<c:out value='${dish.dishName}'/>"
                                 onerror="this.onerror=null;this.src='<c:out value='${placeholderUrl}'/>';"/>
                        </c:when>
                        <c:otherwise>
                            <img class="detail__image" src="<c:out value='${placeholderUrl}'/>"
                                 alt="<c:out value='${dish.dishName}'/>"/>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="detail__body">
                    <h2 class="detail__name"><c:out value="${dish.dishName}"/></h2>
                    <span class="chip chip-lg"><c:out value="${dish.category}"/></span>

                    <dl class="detail__list">
                        <dt>ID</dt>
                        <dd><c:out value="${dish.id}"/></dd>

                        <dt>Mã món</dt>
                        <dd><c:out value="${dish.dishID}"/></dd>

                        <dt>Tên món</dt>
                        <dd><c:out value="${dish.dishName}"/></dd>

                        <dt>Loại</dt>
                        <dd><c:out value="${dish.category}"/></dd>

                        <dt>Giá</dt>
                        <dd class="detail__price">
                            <fmt:formatNumber value="${dish.price}" type="number"/> VNĐ
                        </dd>

                        <dt>Mô tả</dt>
                        <dd><c:out value="${dish.description}"/></dd>
                    </dl>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</section>

<%@ include file="../../WEB-INF/jspf/footer.jspf" %>
