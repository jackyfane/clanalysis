<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
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
            <a href="#">项目</a>
        </li>
        <li>
            <a href="list">外部关联</a>
        </li>
        <li class="active">详细信息</li>
    </div>
</div>
<div class="container">
    <fieldset>
        <legend>
            <h3>
                <small>名称</small>
                ${entity.name}
            </h3>
        </legend>
        <div class="form-group">
            <div class="col-md-2 text-right">分类:</div>
            <div class="col-md-4">${entity.category.name}</div>
            <div class="col-md-2 text-right">描述:</div>
            <div class="col-md-4">${entity.description}</div>
        </div>
    </fieldset>
</div>
</body>
</html>
