<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <li><a href="#">项目</a></li>
        <li class="active">分类</li>
    </div>
</div>
<div class="container">
    <form id="defaultForm" class="form-horizontal" role="form"
          action="${action}" method="post">
        <fieldset>
            <legend><h5>基本配置</h5></legend>
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
                    <input type="text" name="name" class="form-control"
                           value="${entity.name}" placeholder="分类名称" required
                           autofocus>
                </div>
                <span class="help-block with-errors"></span>
            </div>
            <div class="form-group modal-footer">
                <button type="button" class="btn btn-sm btn-default"
                        onclick="reloadPage();">取消
                </button>
                <button type="submit" class="btn btn-sm btn-primary">提交</button>
            </div>
        </fieldset>
    </form>
</div>
<script type="text/javascript">
    verifyFieldsOptions = {
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            name: {
                message: '分类名称为必填项！',
                validators: {
                    notEmpty: {
                        message: '分类名称不能为空！'
                    },
                    stringLength: {
                        min: 1,
                        max: 30,
                        message: '分类名称的长度在1到30个字符！'
                    }
                }
            }
        }
    };
</script>
