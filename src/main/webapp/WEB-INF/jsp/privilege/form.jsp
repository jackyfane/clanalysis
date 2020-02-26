<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>
</head>
<!--[if lt IE 7 ]>
<body class="ie ie6">
<![endif]-->
<!--[if IE 7 ]>
<body class="ie ie7 ">
<![endif]-->
<!--[if IE 8 ]>
<body class="ie ie8 ">
<![endif]-->
<!--[if IE 9 ]>
<body class="ie ie9 ">
<![endif]-->
<!--[if (gt IE 9)|!(IE)]>
<!-->
<body>
<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li>
            <a href="#">系统设置</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/menu/list">菜单管理</a>
        </li>
        <li class="active">菜单设置</li>
    </div>
</div>
<div class="container-fluid">
    <form id="defaultForm" class="form-horizontal" data-toggle="validator"
          action="${action}" method="post">
        <input type="hidden" name="id" value="${entity.id}">
        <fieldset>
            <legend>基本配置</legend>
            <div class="form-group">
                <div class="col-md-2 checkbox text-right">
                    <label for="name">权限名称：</label>
                </div>
                <div class="col-md-3">
                    <input class="form-control input-sm" name="name" id="name"
                           value="${entity.name}" required></div>
                <div class="col-md-2 checkbox text-right">
                    <label for="identifier">菜单标识：</label>
                </div>
                <div class="col-md-3">
                    <input class="form-control input-sm" name="identifier"
                           id="identifier" value="${entity.identifier}"
                           required></div>
            </div>
            <div class="form-group">
                <div class="col-md-2 checkbox text-right">
                    <label for="description">菜单描述：</label>
                </div>
                <div class="col-md-8">
                        <textarea rows="3" class="form-control"
                                  name="description"
                                  id="description">${entity.description}</textarea>
                </div>
            </div>
        </fieldset>
        <div class="form-group modal-footer">
            <%-- 表单按钮操作 --%>
            <div class="pull-right"
                 style="padding-right: 20px;padding-bottom: 10px;">
                <button type="button" class="btn btn-sm btn-warning"
                        onclick="reloadPage();">取消
                </button>
                <button type="reset" class="btn btn-sm btn-warning">重置</button>
                <button type="submit" class="btn btn-sm btn-primary">提交</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>
