<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Clanalysis-云和分析平台</title>
    <jsp:include page="js.plugin.jsp" flush="true"/>
    <script src="${pageContext.request.contextPath}/asset/js/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/asset/js/jquery.validate_zh.min.js"></script>
    <script src="${pageContext.request.contextPath}/asset/js/jquery.metadata.js"></script>


    <style type="text/css">
        body {
            padding: 0;
            position: relative;
        }

        #leftMenu {
            padding: 0 5px 0 0;
        }

        .tree, .tree ul {
            margin: 0;
            padding: 0;
            list-style: none
        }

        .tree ul {
            margin-left: 1em;
            position: relative
        }

        .tree ul ul {
            margin-left: .5em
        }

        .tree ul:before {
            content: "";
            display: block;
            width: 0;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            border-left: 1px solid
        }

        .tree li {
            margin: 0;
            padding: 0 1em;
            line-height: 2em;
            color: #369;
            font-weight: 700;
            position: relative
        }

        .tree ul li:before {
            content: "";
            display: block;
            width: 10px;
            height: 0;
            border-top: 1px solid;
            margin-top: -1px;
            position: absolute;
            top: 1em;
            left: 0
        }

        .tree ul li:last-child:before {
            background: #fff;
            height: auto;
            top: 1em;
            bottom: 0
        }

        .indicator {
            margin-right: 5px;
        }

        .tree li a {
            text-decoration: none;
            color: #369;
        }

        .tree li button, .tree li button:active, .tree li button:focus {
            text-decoration: none;
            color: #369;
            border: none;
            background: transparent;
            margin: 0px 0px 0px 0px;
            padding: 0px 0px 0px 0px;
            outline: 0;
        }
    </style>
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
<body class="">
<!--<![endif]-->
<div class="container-fluid content">
    <div class="row" id="header" style="height: 50px">
        <li class="col-lg-12">
            <div class="navbar navbar-inverse navbar-fixed-top">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">CAA日志分析系统</a>
                </div>
                <ul class="nav navbar-nav navbar-right"
                    style="padding-right: 30px">
                    <li class="dropdown">
                        <a id="accoutInfo" href="#" class="dropdown-toggle"
                           data-toggle="dropdown"
                           aria-haspopup="true" role="button"
                           aria-expanded="false"> <i class="fa fa-user"></i>
                            ${userInfo.name}
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu"
                            aria-labelledby="accoutInfo">
                            <li role="presentation">
                                <a role="menuitem" tabindex="-1"
                                   href="javascript:modifyPwdBox();"> <i
                                        class="fa fa-unlock-alt"></i>
                                    修改密码
                                </a>
                            </li>
                            <li role="presentation" class="divider"></li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="-1" href="logout">
                                    <span class="glyphicon glyphicon-log-out"></span>
                                    退出系统
                                </a>
                            </li>
                        </ul>
                    </li>
                    <%--
                    <li>
                    <a href="#">
                        <span class="glyphicon glyphicon-cog"></span>
                        设置
                        <span class="caret"></span>
                    </a>
                </li>
                --%>
                </ul>
            </div>
        </li>
    </div>
    <div class="row">
        <div class="col-md-2" id="leftMenu">
            <!-- <iframe width="100%" frameborder="0" border="0" src="left.html"></iframe>
        -->
            <div class="nav navbar panel panel-primary">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-home"></span>
                    系统导航菜单
                    <a href="#">
                        <span class="glyphicon glyphicon-indent-left pull-right"></span>
                    </a>
                </div>
                <div class="panel-body">
                    <div class="row" style="margin: 10px;">
                        <ul id="tree">
                            <li>
                                <a href="#">项目</a>
                                <ul>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/project/list"
                                                target="main">项目管理</a>
                                    </li>
                                    <li>
                                        <a href=“#”>模板管理</a>
                                        <ul>
                                            <li>
                                                <a
                                                        href="${pageContext.request.contextPath}/ts/list"
                                                        target="main">模板样式</a>
                                            </li>
                                            <li>
                                                <a
                                                        href="${pageContext.request.contextPath}/tpl/list"
                                                        target="main">模板管理</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/report/list"
                                                target="main">报表管理</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/filter/list"
                                                target="main">指标过滤器</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/element/list"
                                                target="main">指标管理</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/association/list"
                                                target="main">外部关联</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/category/list"
                                                target="main">分类</a>
                                    </li>
                                </ul>
                            </li>
                            <hr style="margin: 5px 0 5px 0"/>
                            <li>
                                <a href="#">数据源</a>
                                <ul>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/ds/list"
                                           target="main">数据源管理</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/dbc/list"
                                           target="main">数据库配置</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/dbsystem/list"
                                                target="main">数据库系统</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/dbs/list"
                                           target="main">数据库源</a>
                                    </li>
                                </ul>
                            </li>
                            <hr style="margin: 5px 0 5px 0"/>
                            <li>
                                <a href="#">系统设置</a>
                                <ul>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/menu/list"
                                                target="main">资源管理</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/dept/list"
                                                target="main">部门管理</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/user/list"
                                                target="main">用户管理</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/role/list"
                                                target="main">角色管理</a>
                                    </li>
                                    <li>
                                        <a
                                                href="${pageContext.request.contextPath}/privilege/list"
                                                target="main">权限管理</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-10" style="padding: 0">
            <%--<div id="main-content"></div>
        --%>
            <iframe name="main" width="100%" frameborder="0" border="0"
                    src="${pageContext.request.contextPath}/overview"></iframe>
        </div>
    </div>
    <div class="nav navbar-fixed-bottom" id="copyright"
         style="height: 50px;">
        <h6 align="center">
            <p style="font-size: 10px;">云和恩墨（北京）信息技术有限公司 拥有所有版权</p>

            <p style="font-size: 10px;">
                Yunhe Enmo (Beijing) Information
                Technology Co., Ltd / CopyRight © 2009-2013 enmotech.com, All
                rights reserved.
            </p>
        </h6>
    </div>
</div>

<%-- modify password form --%>
<div id="pwdbox" class="modal fade bs-example-modal-sm" tabindex="-1"
     aria-labelledby="pwdModalLabel">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <form id="pwdform" class="form-horizontal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="pwdModalLabel">
                        <i class="fa fa-unlock-alt"></i>
                        修改密码
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="oldpwd"
                               class="col-sm-4 control-label">原始密码:</label>

                        <div class="col-sm-8">
                            <input type="password" class="form-control input-sm"
                                   id="oldpwd" name="oldpwd"></div>
                    </div>
                    <div class="form-group">
                        <label for="newpwd"
                               class="col-sm-4 control-label">新建密码:</label>

                        <div class="col-md-8">
                            <input type="password" class="form-control input-sm"
                                   id="newpwd" name="newpwd"></div>
                    </div>
                    <div class="form-group">
                        <label for="confirmpwd" class="col-sm-4 control-label">确认密码:</label>

                        <div class="col-md-8">
                            <input type="password" class="form-control input-sm"
                                   id="confirmpwd" name="confirmpwd"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-default"
                            data-dismiss="modal">取消
                    </button>
                    <button type="submit" class="btn btn-sm btn-primary">修改
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript">

    jQuery.validator.addMethod('notEqualTo', function (value, element, param) {
        return this.optional(element) || value != $(param).val();
    }, '<font color="red">新密码不能和原始密码一样！</font>');

    $(function () {
        $('#main-content').get('${pageContext.request.contextPath}/overview');

        var topNodes = [], childNodes = [];
        <c:forEach items="${userInfo.roles}" var="role">
        var menus = JSON.parse('${role.menus}'), len = menus.length;
        for (var i = 0; i < len; i++) {
            var menu = menus[i], node = {};

            node.pid = menu.parent;
            node.id = menu.id;
            node.name = menu.name;
            node.url = menu.linkURL;

            if (menu.parent) {
                if (childNodes.length <= 0) {
                    childNodes.push(node);
                    continue;
                }

                var isOk = false;
                for (var j = 0; j < childNodes.length; j++) {
                    var cNode = childNodes[j];
                    if (cNode.id == menu.parent) {
                        if (childNodes[j].children) {
                            childNodes[j].children.push(node);
                        } else {
                            childNodes[j].children = [node];
                        }
                        isOk = true;
                        break;
                    } else if (cNode.pid == menu.id) {
                        node.children = [cNode];
                        childNodes[j] = node;
                        isOk = true;
                        break;
                    }
                }
                if (!isOk) childNodes.push(node);
            } else {
                if (topNodes.length <= 0) {
                    topNodes.push(node);
                    continue;
                }

                for (var j = 0; j < topNodes.length; j++) {
                    if (menu.id != topNodes[j].id) {
                        topNodes.push(node);
                        break;
                    }
                }
            }
        }
        </c:forEach>

        var html = createTree(topNodes, childNodes);
        $('#tree').html(html);
        //树
        $('#tree').treed();
        //动态设置iframe的高度
        var header_height = $('#header').height();
        var copyright_height = $('#copyright').height();
        var height = $(this).height();
        var contentHeight = height - (header_height + copyright_height) - 8;
        $('iframe').each(function () {
            $(this).attr('height', contentHeight);
        });
        $('#leftMenu').css('height', contentHeight);

        $('#pwdbox').on('hidden.bs.modal', function () {
            document.getElementById('pwdform').reset();
        });
        initPwdForm();
    });

    /**
     * 初始化表单
     * @return {[type]} [description]
     */
    function initPwdForm() {
        $('#pwdform').validate({
            rules: {
                oldpwd: {
                    required: true,
                    remote: {
                        url: '${pageContext.request.contextPath}/user/checkpwd',
                        type: 'post',
                        data: {
                            password: function () {
                                return $('#oldpwd').val();
                            }
                        }
                    }
                },
                newpwd: {
                    required: true,
                    minlength: 6,
                    maxlength: 20,
                    notEqualTo: '#oldpwd'
                },
                confirmpwd: {
                    required: true,
                    equalTo: '#newpwd'
                }
            },
            messages: {
                oldpwd: {
                    required: '<font color="red">请输入旧密码</font>',
                    remote: '<font color="red">旧密码不正确。</font>'
                },
                newpwd: {
                    required: '<font color="red">请输入新密码</font>',
                    minlength: '<font color="red">密码不能小于6个字符</font>',
                    maxLength: '<font color="red">密码不能大于20个字符</font>'
                },
                confirmpwd: {
                    required: '<font color="red">请输入确认密码</font>',
                    equalTo: '<font color="red">两次输入密码不一致不一致</font>'
                }
            },
            submitHandler: function (form) {
                $('#pwdbox').modal("toggle");
                var $form = $(form);
                var _uid = '${userInfo.id}', passwd = $('#newpwd').val();
                $.getJSON('${pageContext.request.contextPath}/user/modifypwd', {
                    uid: _uid,
                    password: passwd
                }).done(function (rs) {
                    if (rs.flag) {
                        swal({
                            title: "温馨提示",
                            text: rs.msg,
                            type: "success",
                            confirmButtonClass: 'btn-success',
                            confirmButtonText: '关闭'
                        });
                    } else {
                        failureAlert(rs.msg);
                    }
                });
            }
        });
    }

    //菜单树
    $.fn.extend({
        treed: function (o) {
            var openedClass = 'fa fa-minus-circle';
            var closedClass = 'fa fa-plus-circle';

            if (typeof o != 'undefined') {
                if (typeof o.openedClass != 'undefined') {
                    openedClass = o.openedClass;
                }
                if (typeof o.closedClass != 'undefined') {
                    closedClass = o.closedClass;
                }
            }
            ;

            //initialize each of the top levels
            var tree = $(this);
            tree.addClass("tree");
            tree.find('li').has("ul").each(function () {
                var branch = $(this); //li with children ul
                branch.prepend("<i class='" + closedClass + "'></i>");
                branch.addClass('branch');
                branch.on('click', function (e) {
                    if (this == e.target) {
                        var icon = $(this).children('i:first');
                        icon.toggleClass(openedClass + " " + closedClass);
                        $(this).children().children().toggle();
                    }
                })
                branch.children().children().toggle();
            });
            //fire event from the dynamically added icon
            tree.find('.branch .indicator').each(function () {
                $(this).on('click', function () {
                    $(this).closest('li').click();
                });
            });
            //fire event to open branch if the li contains an anchor instead of text
            tree.find('.branch>a').each(function () {
                $(this).on('click', function (e) {
                    $(this).closest('li').click();
                    e.preventDefault();
                });
            });
            //fire event to open branch if the li contains a button instead of text
            tree.find('.branch>button').each(function () {
                $(this).on('click', function (e) {
                    $(this).closest('li').click();
                    e.preventDefault();
                });
            });
        }
    });

    /**
     * [buildNode description]
     * @param  {[type]} menuNodes [description]
     * @param  {[type]} node      [description]
     * @return {[type]}           [description]
     */
    function createTree(topNodes, childNodes) {
        var treeHtml = '';
        for (var i = 0; i < topNodes.length; i++) {
            var topNode = topNodes[i];
            treeHtml += '<li>';
            treeHtml += '<a href="' + topNode.url + '" target="main">' + topNode.name + '</a>';
            if (childNodes) {
                treeHtml += '<ul>';
                for (var j = 0; j < childNodes.length; j++) {
                    var cNode = childNodes[j];
                    if (topNode.id == cNode.pid) {
                        var obj = {};
                        obj.pid = cNode.pid;
                        obj.id = cNode.id;
                        obj.name = cNode.name;
                        obj.url = cNode.url;
                        var node = [obj];
                        treeHtml += createTree(node, cNode.children);
                    }
                }
                treeHtml += '</ul>';
            }
            treeHtml += '</li>';
            if (!topNode.pid) {
                treeHtml += '<hr style="margin: 5px 0 5px 0"/>';
            }
        }
        return treeHtml;
    }

    /*修改密码*/
    function modifyPwdBox() {
        $('#pwdbox').modal({
            keyboard: false,
            backdrop: 'static'
        });
    }
</script>
