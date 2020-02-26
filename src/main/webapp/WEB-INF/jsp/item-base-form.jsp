<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="form-common-hidden.jsp"/>
<c:choose>
    <c:when test="${entity != null}">
        <input type="hidden" name="user" value="${entity.user.id}">
    </c:when>
    <c:otherwise>
        <input type="hidden" name="user" value="${userInfo.id}">
    </c:otherwise>
</c:choose>
<input type="hidden" name="id" value="${entity.id}">

<div class="form-group form-group-sm">
    <label class="col-md-2 control-label text-right">名称:</label>

    <div class="col-md-4">
        <input type="text" name="name" id="name" value="${entity.name}"
               class="form-control" autofocus required>
    </div>
</div>
<div class="form-group form-group-sm">
    <label class="col-md-2 control-label text-right">分类:</label>

    <div class="col-md-3">
        <select name="category" id="category" class="form-control"
                required></select>
    </div>
    <div class="col-md-1">
        <button type="button" class="btn btn-sm btn-info"
                onclick="getDataForSelectTag('${pageContext.request.contextPath}/category/get-all', 'category','${entity.category}');">
            刷新
        </button>
    </div>
</div>
<div class="form-group">
    <label class="col-md-2 control-label text-right">描述:</label>

    <div class="col-md-7">
        <textarea class="form-control" name="description" id="description"
                  placeholder="在这里输入简要描述..."
                  rows="3">${entity.description}</textarea>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        if ($('select[name="category"]').find('option').length <= 0) {
            getDataForSelectTag('${pageContext.request.contextPath}/category/get-all', 'category', '${entity.category.id}');
        }
    });
</script>