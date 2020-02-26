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
        <li>
            <a href="#">数据源</a>
        </li>
        <li class="active">数据源信息</li>
    </div>
</div>
<div class="container">
    <form id="defaultForm" class="form-horizontal" action="${action}"
          method="post" enctype="multipart/form-data"
          data-bv-message="This value is not valid"
          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
        <fieldset>
            <legend>
                <h5>目标配置</h5>
            </legend>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label text-right">指定数据源:</label>

                <div class="col-md-3">
                    <select name="logSource" class="form-control"
                            required></select>
                </div>
                <span class="help-block with-errors"></span>
            </div>
            <div class="form-group modal-footer">
                <button type="button" class="btn btn-sm btn-warning"
                        onclick="reloadPage()">取消
                </button>
                <button type="button" class="btn btn-sm btn-primary"
                        onclick="showTargetInputGroup('base_conf')">上一步
                </button>
                <button type="submit" class="btn btn-sm btn-info">提交</button>
            </div>
        </fieldset>
    </form>
</div>

<script type="text/javascript">

    verifyFieldsOptions = {
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            name: {
                message: '名称为必填项',
                validators: {
                    notEmpty: {
                        message: '名称不能为空！'
                    },
                    stringLength: {
                        min: 1,
                        max: 30,
                        message: '名称长度为1到30个字符！'
                    }
                }
            }
        }
    };
</script>
