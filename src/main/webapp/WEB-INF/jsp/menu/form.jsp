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
                    <label for="name">菜单名称：</label>
                </div>
                <div class="col-md-3">
                    <input class="form-control input-sm" name="name" id="name"
                           value="${entity.name}" required></div>
                <div class="col-md-2 checkbox text-right">
                    <label for="parent">父级菜单：</label>
                </div>
                <div class="col-md-3">
                    <select class="form-control input-sm" name="parent"
                            id="parent">
                        <option>请选择父级菜单</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 checkbox text-right">
                    <label for="linkUrl">菜单路径：</label>
                </div>
                <div class="col-md-3">
                    <input class="form-control input-sm" name="linkURL"
                           id="linkURL" value="${entity.linkURL}" required>
                </div>
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
                    <label for="icon">图标：</label>
                </div>
                <div class="col-md-3">
                    <input class="form-control input-sm" name="icon" id="icon"
                           value="${entity.icon}"></div>
                <div class="col-md-2 checkbox text-right">
                    <label for="position">排序：</label>
                </div>
                <div class="col-md-2">
                    <input type="number" min="0" class="form-control input-sm"
                           name="position" id="position"
                           value="${entity.position}"></div>
                <div class="col-md-2 checkbox">
                    <label>
                        <input type="checkbox" name="visible" id="visible"
                               checked="checked" value="true">是否显示</label>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-2 checkbox text-right">
                    <label>菜单描述：</label>
                </div>
                <div class="col-md-8">
                        <textarea rows="3" class="form-control"
                                  name="description"
                                  id="description">${entity.description}</textarea>
                </div>
            </div>
        </fieldset>
    </form>
</div>
</body>
</html>
<script type="text/javascript">
    $(function () {
        getDataForSelectTag('${pageContext.request.contextPath}/menu/get-all', 'parent', '${entity.parent.id}');
    });
</script>
