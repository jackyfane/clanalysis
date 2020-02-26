<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Clanalysis Admin</title>
    <jsp:include page="js.plugin.jsp"/>
    <style type="text/css">
        body {
            padding-top: 120px;
            padding-bottom: 40px;
            background-color: #eee;

        }

        .btn {
            outline: 0;
            border: none;
            border-top: none;
            border-bottom: none;
            border-left: none;
            border-right: none;
            box-shadow: inset 2px -3px rgba(0, 0, 0, 0.15);
        }

        .btn:focus {
            outline: 0;
            -webkit-outline: 0;
            -moz-outline: 0;
        }

        .fullscreen_bg {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background-size: cover;
            background-position: 50% 50%;
            background-image: url('${pageContext.request.contextPath}/images/color-splash.jpg');
            background-repeat: repeat;
        }

        .form-signin {
            max-width: 280px;
            padding: 15px;
            margin: 0 auto;
            margin-top: 50px;
        }

        .form-signin .form-signin-heading, .form-signin {
            margin-bottom: 10px;
        }

        .form-signin .form-control {
            position: relative;
            font-size: 16px;
            height: auto;
            padding: 10px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        .form-signin .form-control:focus {
            z-index: 2;
        }

        .form-signin input[type="text"] {
            margin-bottom: -1px;
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0;
            border-top-style: solid;
            border-right-style: solid;
            border-bottom-style: none;
            border-left-style: solid;
            border-color: #000;
        }

        .form-signin input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
            border-top-style: none;
            border-right-style: solid;
            border-bottom-style: solid;
            border-left-style: solid;
            border-color: rgb(0, 0, 0);
            border-top: 1px solid rgba(0, 0, 0, 0.08);
        }

        .form-signin-heading {
            color: #fff;
            text-align: center;
            text-shadow: 0 2px 2px rgba(0, 0, 0, 0.5);
        }
    </style>
</head>
<!--[if lt IE 7 ]>
<body class="ie ie6"> <![endif]-->
<!--[if IE 7 ]>
<body class="ie ie7 "> <![endif]-->
<!--[if IE 8 ]>
<body class="ie ie8 "> <![endif]-->
<!--[if IE 9 ]>
<body class="ie ie9 "> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<div class="" scroll="no">
    <!--<![endif]-->
    <div id="fullscreen_bg" class="fullscreen_bg"/>
    <div class="container">
        <form id="loginForm" class="form-signin"
              action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-signin-heading text-muted">
                <img src="${pageContext.request.contextPath}/images/avatar_2x.png"
                     class="img-circle"/>
            </div>
            <div id="error"></div>
            <div class="form-group">
                <input type="text" id="name" name="username"
                       class="form-control" placeholder="用户名" required=""
                       autofocus>
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password"
                       class="form-control" placeholder="密码" required=""/>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">登 录
            </button>
        </form>
    </div>
</div>
</body>
</html>
<script type="text/javascript">
    $(function () {
        $('#loginForm').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    validators: {
                        notEmpty: {
                            message: '<h5 style="font-size: large;color: orangered">用户名不能为空！</h5>'
                        },
                        stringLength: {
                            min: 1,
                            max: 12,
                            message: '<h5 style="font-size: large;color: orangered">用户名的长度在1到12个字符！</h5>'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '<h5 style="font-size: large;color: orangered">密码称不能为空！</h5>'
                        },
                        stringLength: {
                            min: 1,
                            max: 18,
                            message: '<h5 style="font-size: large;color: orangered">密码的长度在1到18个字符！</h5>'
                        }
                    }
                }
            }
        }).on('success.form.bv', function (e) {
            e.preventDefault();
            var $form = $(e.target);
            var bv = $form.data('bootstrapValidator');
            $.ajax({
                url: $form.attr('action'),
                data: $form.serialize(),
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    if (data.success) {
                        location.href = "${pageContext.request.contextPath}/";
                    } else {
                        $('#error').html('<h5 align="center" style="font-size: large;color: orangered">' + data.message + '</h5>');
                        return;
                    }
                }
            });
        });
    });
</script>
