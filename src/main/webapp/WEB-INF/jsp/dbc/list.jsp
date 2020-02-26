<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>
    <script type="text/javascript">
        /**
         * 渲染内容
         * @param list
         */
        function fillTbody(list) {
            var html = '';
            if (list == null || list == '') {
                html = '<tr><td colspan="7">没有数据</td></tr>';
            }
            else {
                $.each(list, function () {
                    html += '<tr>\n';
                    html += '\t<td><input type="checkbox" value="' + this.id + '"/></td>\n';
                    html += '\t<td>' + this.name + '</td>\n';
                    html += '\t<td>' + this.host + '</td>\n';
                    if (!$.isEmptyObject(this.dbSystem) && this.port == null) {
                        html += '\t<td>' + this.dbSystem.port + '</td>\n';
                    }
                    else {
                        html += '\t<td>' + this.port + '</td>\n';
                    }
                    html += '\t<td>' + this.instance + '</td>\n';
                    html += '\t<td>' + this.username + '</td>\n';
                    html += '\t<td>\n';
                    html += '\t\t<a href="#" onclick="modify(\'' + this.id + '\');" data-toggle="modal" data-target="#modal"><span class="fa fa-pencil-square-o"></span>编辑</a> |\n';
                    html += '\t\t<a href="#" onclick="deleteRow(\'' + this.id + '\');"><span class="fa fa-trash"></span>删除</a>\n';
                    html += '\t</td>\n';
                    html += '</tr>\n';
                });
            }
            $("#list-content").html(html);
        }
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
            <a href="#">数据源</a>
        </li>
        <li class="active">数据库配置</li>
    </div>
    <div class="panel-body">
        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group btn-group-sm" role="group" aria-label="...">
                <button type="button" class="btn btn-info"
                        onclick="rud('add','add');">
                    <span class="fa fa-plus-circle blue"></span>
                    添加
                </button>
                <button type="button" class="btn btn-warning"
                        onclick="rud('modify','update');">
                    <span class="fa fa-pencil-square-o"></span>
                    修改
                </button>
                <button type="button" class="btn btn-danger"
                        onclick="rud('delete', '');">
                    <span class="fa fa-trash-o"></span>
                    删除
                </button>
            </div>
        </div>
        <table class="table table-bordered table-striped table-condensed"
               id="searchable-container">
            <thead>
            <tr>
                <th>
                    <label>
                        全选
                        <input type="checkbox" id="checkall"/>
                    </label>
                </th>
                <th>名称</th>
                <th>主机</th>
                <th>端口</th>
                <th>数据库实例</th>
                <th>登录用户</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="list-content"></tbody>
        </table>
        <div class="pagination pull-right" id="pagination"></div>
    </div>
</div>
</body>
</html>
