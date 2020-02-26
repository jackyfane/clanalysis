<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Clanalysis Admin</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="js.plugin.jsp" flush="true"/>

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
    <script type="text/javascript">
        $(function () {
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
        });

        //菜单树
        $.fn.extend({
            treed: function (o) {
                var openedClass = 'glyphicon-minus-sign';
                var closedClass = 'glyphicon-plus-sign';

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
                    branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
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

    </script>
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
<body class="">
<!--<![endif]-->
<div class="container-fluid content">
    <div class="row" id="header" style="height:50px">
        <li class="col-lg-12">
            <div class="navbar navbar-inverse navbar-fixed-top">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">CAA日志分析系统</a>
                </div>
                <ul class="nav navbar-nav navbar-right"
                    style="padding-right:30px">
                    <li class="dropdown">
                        <a id="accoutInfo" href="#" class="dropdown-toggle"
                           data-toggle="dropdown" aria-haspopup="true"
                           role="button" aria-expanded="false">
                            <span class="icon-user" aria-hidden="true"></span>
                            张小米
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu"
                            aria-labelledby="accoutInfo">
                            <li role="presentation"><a role="menuitem"
                                                       tabindex="-1" href="#">Action</a>
                            </li>
                            <li role="presentation"><a role="menuitem"
                                                       tabindex="-1" href="#">Another
                                action</a></li>
                            <li role="presentation"><a role="menuitem"
                                                       tabindex="-1" href="#">Something
                                else here</a></li>
                            <li role="presentation" class="divider"></li>
                            <li role="presentation"><a role="menuitem"
                                                       tabindex="-1" href="#">Separated
                                link</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="#">
                            <span class="glyphicon glyphicon-cog"></span> 设置
                            <span class="caret"></span>
                        </a>
                    </li>
                </ul>
            </div>
        </li>
    </div>
    <div class="row">
        <div class="col-md-2" id="leftMenu">
            <!-- <iframe width="100%" frameborder="0" border="0" src="left.html"></iframe> -->
            <div class="nav navbar panel panel-primary">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-home"></span> 系统导航菜单
                    <a href="#"><span
                            class="glyphicon glyphicon-indent-left pull-right"></span></a>
                </div>
                <div class="panel-body">
                    <div class="row" style="margin:10px;">
                        <ul id="tree">
                            <li><a href="#">项目</a>
                                <ul>
                                    <li><a href="project/list.jsp"
                                           target="main">项目管理</a>
                                    </li>
                                    <li><a href="tpl_mgr.html" target="main">模板管理</a>
                                    </li>
                                    <li><a href="#">报表管理</a></li>
                                    <li><a href="#">维度管理</a></li>
                                    <li><a href="#">指标管理</a></li>
                                    <li><a href="#">过滤器</a></li>
                                    <li><a href="#">外部关联</a></li>
                                    <li><a href="#">分类</a></li>
                                </ul>
                            </li>
                            <hr style="margin: 5px 0 5px 0"/>
                            <li><a href="#">系统设置</a>
                                <ul>
                                    <li><a href="#">资源管理</a></li>
                                    <li><a href="#">部门管理</a></li>
                                    <li><a href="#">用户管理</a></li>
                                    <li><a href="#">角色管理</a></li>
                                    <li><a href="#">功能管理</a></li>
                                    <li><a href="#">权限管理</a></li>
                                </ul>
                            </li>
                            <hr style="margin: 5px 0 5px 0"/>
                            <li><a href="#">系统设置</a>
                                <ul>
                                    <li><a href="#">资源管理</a></li>
                                    <li><a href="#">部门管理</a></li>
                                    <li><a href="#">用户管理</a></li>
                                    <li><a href="#">角色管理</a></li>
                                    <li><a href="#">功能管理</a></li>
                                    <li><a href="#">权限管理</a></li>
                                </ul>
                            </li>
                            <hr style="margin: 5px 0 5px 0"/>
                            <li><a href="#">系统设置</a>
                                <ul>
                                    <li><a href="#">资源管理</a></li>
                                    <li><a href="#">部门管理</a></li>
                                    <li><a href="#">用户管理</a></li>
                                    <li><a href="#">角色管理</a></li>
                                    <li><a href="#">功能管理</a></li>
                                    <li><a href="#">权限管理</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-10" style="padding:0">
            <iframe name="main" width="100%" frameborder="0" border="0"
                    src="${pageContext.request.contextPath}/content.html"></iframe>
        </div>

    </div>
    <div class="nav navbar-fixed-bottom" id="copyright" style="height: 50px;">
        <h6 align="center">
            <p style="font-style: 10px">云和恩墨（北京）信息技术有限公司 拥有所有版权</p>

            <p style="font-style: 10px">Yunhe Enmo (Beijing) Information
                Technology Co., Ltd / CopyRight © 2009-2013 enmotech.com, All
                rights reserved.</p>
        </h6>
    </div>
</div>
</body>
</html>
