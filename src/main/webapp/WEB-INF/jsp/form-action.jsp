<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 隐藏公共字段 --%>
<jsp:include page="form-common-hidden.jsp"/>
<div class="form-group modal-footer">
    <%-- 表单按钮操作 --%>
    <div class="pull-right" style="padding-right: 20px;padding-bottom: 10px;">
        <button type="button" class="btn btn-sm btn-warning"
                onclick="reloadPage();">取消
        </button>
        <button type="reset" class="btn btn-sm btn-warning">重置</button>
        <button type="submit" class="btn btn-sm btn-primary">提交</button>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $.getJSON('${pageContext.request.contextPath}/user/get-all', function (data) {
            var optHtml = '';
            <c:forEach items="${entity.visibleUser}" var="user">
            optHtml += '<option value="${user.id}" selected>${user.name}</option>\n';
            </c:forEach>
            $.each(data, function () {
                var flag = false;
                <c:forEach items="${entity.visibleUser}" var="user">
                if ('${user.id}' == this.id) {
                    flag = true;
                }
                </c:forEach>
                if (!flag) {
                    optHtml += '<option value="' + this.id + '">' + this.name + '</option>\n';
                }
                ;
            });
            $('select[name="visibleUser"]').html(optHtml);
        });

        if (!$.isEmptyObject('${entity.editByCreator}')) {
            $('input[name="editByCreator"]').attr('checked', true);
        }

        if ($('select[name="category"]').find('option').length <= 0) {
            getDataForSelectTag('${pageContext.request.contextPath}/category/get-all', 'category', '${entity.category.id}');
        }

        /*刷新类别*/
        $('#refreshCategory').on('click', function () {
            getDataForSelectTag('${pageContext.request.contextPath}/category/get-all', 'category', '${entity.category.id}');
        });

        /*刷新可见用户*/
        $('#refreshVisibleUser').on('click', function () {
            getDataForSelectTag('${pageContext.request.contextPath}/user/get-all', 'visibleUser');
        });
    });
</script>
