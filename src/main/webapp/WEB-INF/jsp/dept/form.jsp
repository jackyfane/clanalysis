<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>

    <script type="text/javascript">
        $(function () {
            getDataForSelectTag('${pageContext.request.contextPath}/dept/get-all', 'parent');
        });
    </script>
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
<%--
<link rel="stylesheet" type="text/css"
      href="${pageContext.request.contextPath}/Scripts/multiselect/css/bootstrap-multiselect.css">
<script type="text/javascript"
    src="${pageContext.request.contextPath}/Scripts/multiselect/js/bootstrap-multiselect.js"></script>
--%>
<div class="panel panel-default">
    <ul class="panel-heading navbar-fixed-top breadcrumb">
        <li>
            <a href="#">部门管理</a>
        </li>
        <li class="active">部门信息</li>
    </ul>
    <div class="panel-body">
        <div class="container-fluid">
            <form class="form-horizontal" data-toggle="validator" role="form"
                  action="${action}" method="post">
                <fieldset>
                    <legend>
                        <h4>基本信息</h4>
                    </legend>
                    <jsp:include page="../form-common-hidden.jsp"/>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="name">部门名称：</label>
                        </div>
                        <div class="col-md-3">
                            <input type="text" id="name" name="name"
                                   class="form-control input-sm"
                                   value="${entity.name}" placeholder="部门名称"
                                   required autofocus></div>
                        <div class="col-md-2 checkbox text-right">
                            <label for="parent">所属部门：</label>
                        </div>
                        <div class="col-md-3">
                            <select name="parent" id="parent"
                                    class="form-control input-sm requried"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="description">部门描述：</label>
                        </div>
                        <div class="col-md-8">
                            <textarea class="form-control" rows="3"
                                      id="description"
                                      name="description">${entity.description}</textarea>
                        </div>
                    </div>
                    <legend>
                        <h4>角色分配</h4>
                    </legend>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="roles">角色：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" id="roles" name="roles"
                                    multiple="multiple">
                                <option value="1">超级管理员</option>
                                <option value="2">管理员</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group modal-footer">
                        <button type="button" class="btn btn-sm btn-default"
                                onclick="reloadPage();">取消
                        </button>
                        <button type="reset" class="btn btn-sm btn-warning">重置
                        </button>
                        <button type="submit" class="btn btn-sm btn-primary">
                            提交
                        </button>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</div>
</body>
</html>
