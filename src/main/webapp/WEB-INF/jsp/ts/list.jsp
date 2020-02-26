<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
            <a href="#">模板管理</a>
        </li>
        <li class="active">
            <a href="#">模板样式</a>
        </li>
    </div>
    <div class="panel-body">
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
                <th>分类</th>
                <%--<th>描述</th>
            --%>
                <th>创建用户</th>
                <th>创建时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="list-content"></tbody>
        </table>
        <!-- 分页 -->
        <div class="pagination pull-right" id="pagination"></div>
    </div>
</div>
</body>
</html>
<script type="text/javascript">
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
                html += '\t<td>' + this.category.name + '</td>\n';
//                html += '\t<td>'+this.description+'</td>\n';
                html += '\t<td>' + this.user.name + '</td>\n';
                html += '\t<td>' + getFormatDateByLong(this.createdTime, 'yyyy/MM/dd hh:mm:ss') + '</td>\n';
                html += '\t<td>\n';
                html += '\t\t<a href="#" onclick="modify(\'' + this.id + '\');"><span class="fa fa-pencil-square-o"></span>编辑</a> |\n';
                //html += '\t\t<a href="#" onclick="detail(\''+this.id+'\');"><span class="fa fa-list"></span>详细</a> |\n';
                html += '\t\t<a href="#" onclick="deleteRow(\'' + this.id + '\');"><span class="fa fa-trash"></span>删除</a>\n';
                html += '\t</td>\n';
                html += '</tr>\n';
            });
        }
        $("#list-content").html(html);
    }
</script>
