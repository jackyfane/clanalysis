<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>

    <script src="${pageContext.request.contextPath}/asset/js/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/asset/js/jquery.validate_zh.min.js"></script>
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
        <li class="active">部门管理</li>
    </div>
    <div class="panel-body">
        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group btn-group-sm" role="group" aria-label="...">
                <!-- <button type="button" class="btn btn-info" onclick="rud('add','add');">
                <span class="fa fa-plus-circle blue"></span>
                添加
              </button>
              -->
                <button type="button" class="btn btn-info" data-toggle="modal"
                        data-target="#myModal" data-backdrop="static">
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
                <th>部门名称</th>
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
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <form id="deptForm" action="" class="form-horizontal">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title"><i class="fa fa-info-circle"></i>
                        部门信息
                    </h4>
                </div>
                <div class="modal-body">
                    <jsp:include page="../form-common-hidden.jsp"/>
                    <div class="form-group">
                        <div class="col-md-3 checkbox text-right">
                            <label for="name">部门名称：</label>
                        </div>
                        <div class="col-md-6">
                            <input type="text" id="name" name="name"
                                   class="form-control input-sm"
                                   value="${entity.name}" placeholder="部门名称"
                                   required autofocus></div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-3 checkbox text-right">
                            <label for="parent">上级部门：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="parent" id="parent"
                                    class="form-control input-sm requried"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-3 checkbox text-right">
                            <label for="roles">角色：</label>
                        </div>
                        <div class="col-md-6">
                            <select class="form-control" id="roles" name="roles"
                                    multiple="multiple">
                                <option value="1">超级管理员</option>
                                <option value="2">管理员</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-3 checkbox text-right">
                            <label for="description">部门描述：</label>
                        </div>
                        <div class="col-md-6">
                            <textarea class="form-control" rows="3"
                                      id="description"
                                      name="description"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-sm btn-info">重置</button>
                    <button type="button" class="btn btn-sm btn-warning"
                            data-dismiss="modal">取消
                    </button>
                    <button type="submit" class="btn btn-sm btn-success">保存
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
<script type="text/javascript">
    $(function () {
        $('#deptForm').validate({
            submitHandler: function (form) {
                var $form = $(form);
                formHandler($form.attr('action'), $form);
                $('#myModal').modal("toggle");
            }
        });

        $('#myModal').on('hidden.bs.modal', function () {
            document.getElementById('deptForm').reset();
        });
    });
    function fillTbody(list) {
        var html = '';
        if (list == null || list == '') {
            html = '<tr><td colspan="4">没有数据</td></tr>';
        } else {
            $.each(list, function () {
                html += '<tr>\n';
                html += '\t<td><input type="checkbox" value="' + this.id + '"/></td>\n';
                html += '\t<td>' + this.name + '</td>\n';
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
