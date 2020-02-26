<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="common-hidden-property">
    <c:choose>
        <c:when test="${entity != null}">
            <input type="hidden" name="user" value="${entity.user.id}">
        </c:when>
        <c:otherwise>
            <input type="hidden" name="user" value="${userInfo.id}">
        </c:otherwise>
    </c:choose>
    <input type="hidden" id="id" name="id" value="${entity.id}">
    <input type="hidden" id="status" name="status" value="${entity.status}">
    <input type="hidden" id="createdTime" name="createdTime"
           value="${entity.createdTime}">
</div>
