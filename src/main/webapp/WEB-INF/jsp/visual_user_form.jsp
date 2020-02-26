<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
<div class="form-group">
<div class="col-md-3 radio text-right">
<label class="control-label">
<input type="radio" name="user_radio" id="all_user" checked="checked" onclick="selectStatusByRadio('user_select',false, '','','visibleUser');"> 所有用户可见
</label>
</div>
<div class="col-md-6 radio text-right">
<label class="control-label">
<input type="radio" name="user_radio" onclick="selectStatusByRadio('user_select',true, '${pageContext.request.contextPath}/user/get-all','all_user','visibleUser');"> 指定用户可见
</label>
</div>
</div>
<div id="user_select" class="form-group" style="display:none">
<div class="col-md-4 col-md-offset-1">
所有用户 <button type="button" class="btn btn-xs btn-info pull-right" onclick="getDataForSelectTag('${pageContext.request.contextPath}/user/get-all', 'all_user');">刷新</button>
<select name="all_user" multiple class="form-control" size="5"></select>
</div>
<div class="col-md-1 text-center" style="margin-top: 40px;">
<button type="button" onclick="appendToRightMulSelect('all_user','visibleUser')" class="btn btn-xs btn-primary">
<span class="glyphicon glyphicon-chevron-right"></span>
</button>
<br/>
<br/>
<button type="button" class="btn btn-xs btn-primary" onclick="removeFromMulSelect('visibleUser')">
<span class="glyphicon glyphicon-chevron-left"></span>
</button>
</div>
<div class="col-md-4">
选定用户
<select name="visibleUser" multiple class="form-control" size="5">
<c:forEach var="user" items="${entity.visibleUser}">
    <option value="${user.id}">${user.name}</option>
</c:forEach>
</select>
</div>
</div>
-->
<div class="form-group">
    <div class="col-md-2 checkbox text-right">
        <label class="control-label">选择可见用户:</label>
    </div>
    <div class="col-md-5">
        <select name="visibleUser" multiple class="form-control"
                size="5"></select>
    </div>
    <div class="col-md-1">
        <button type="button" class="btn btn-xs btn-info pull-right"
                onclick="getDataForSelectTag('${pageContext.request.contextPath}/user/get-all', 'visibleUser');">
            刷新
        </button>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        <%--if(!$.isEmptyObject('${entity.visibleUser}'))--%>
        <%--{--%>
        <%--$($('input[type="radio"][name="user_radio"]')[1]).attr('checked', true);--%>
        <%--$('#user_select').show();--%>
        <%--getDataForSelectTag('${pageContext.request.contextPath}/user/get-all', 'all_user');--%>
        <%--}--%>

        $.getJSON('${pageContext.request.contextPath}/user/get-all', function (data) {
            var visibleUser = [];
            <c:forEach var="user" items="${entity.visibleUser}">
            visibleUser.push("${user.id}");
            </c:forEach>

            var optHtml = '';
            $.each(data, function () {
                var temp = this, isSelected = false;
                $.each(visibleUser, function () {
                    if (temp.id == this) {
                        isSelected = true;
                        return;
                    }
                });
                var selected = isSelected ? 'selected' : '';
                optHtml += '<option value="' + this.id + '" ' + selected + '>' + this.name + '</option>\n';
            });
            $('select[name="visibleUser"]').html(optHtml);
        });
    });
</script>

