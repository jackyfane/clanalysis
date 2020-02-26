<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>
    <script type="text/javascript">
        verifyFieldsOptions = {
            message: '值无效',
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
                },
                category: {
                    message: '请选择分类！',
                    validators: {
                        notEmpty: {
                            message: '请选择分类！'
                        }
                    }
                },
                file: {
                    message: '请选择上传的文件！',
                    validators: {
                        notEmpty: {
                            message: '上传的文件不能为空！'
                        }
                    }
                }
            }
        };
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
<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li>
            <a href="#">项目</a>
        </li>
        <li class="active">外部关联信息</li>
    </div>
</div>
<div class="container">
    <form id="defaultForm" data-toggle="validator" class="form-horizontal"
          action="${action}" method="post" enctype="multipart/form-data">
        <fieldset>
            <legend>
                <h5>基本配置</h5>
            </legend>
            <jsp:include page="../form-common-hidden.jsp"/>
            <input type="hidden" name="id" value=""/>
            <input type="hidden" name="user" value=""/>

            <div class="form-group">
                <label class="col-md-2 control-label">数据库系统名称:</label>

                <div class="col-md-4">
                    <input type="text" name="name" class="form-control" value=""
                           placeholder="数据库系统名称" required autofocus></div>
                <span class="help-block with-errors"></span>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label">端口:</label>

                <div class="col-md-4">
                    <input type="number" name="port" class="form-control"
                           value="" placeholder="端口" required></div>
                <span class="help-block with-errors"></span>
            </div>
            <div class="form-group modal-footer">
                <button type="submit" class="btn btn-primary">提交</button>
            </div>
        </fieldset>
    </form>
</div>
</body>
</html>
