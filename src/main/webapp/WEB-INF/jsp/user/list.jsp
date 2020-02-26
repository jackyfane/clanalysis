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
<script src="${pageContext.request.contextPath}/asset/js/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.validate_zh.min.js"></script>

<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li>
            <a href="#">系统设置</a>
        </li>
        <li class="active">用户管理</li>
    </div>
    <div class="panel-body">
        <div class="panel panel-success">
            <div class="panel-heading">用户列表信息</div>
            <div class="panel-body">
                <div class="btn-toolbar" role="toolbar">
                    <div class="btn-group btn-group-sm" role="group"
                         aria-label="...">
                        <!-- <button type="button" class="btn btn-info" onclick="rud('add','add');">
                        <span class="fa fa-plus-circle blue"></span>
                        添加
                    </button>
                    <button type="button" class="btn btn-warning" onclick="rud('modify','update');">
                        <span class="fa fa-pencil-square-o"></span>
                        修改
                    </button>
                    -->
                        <button type="button" class="btn btn-info" operate="add"
                                data-toggle="modal" data-target="#myModal"
                                data-backdrop="static">
                            <span class="fa fa-plus-circle blue"></span>
                            添加
                        </button>
                        <button type="button" class="btn btn-warning"
                                operate="update" data-toggle="modal"
                                data-target="#myModal" data-backdrop="static">
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
                        <th>账户</th>
                        <th>名称</th>
                        <th>Email</th>
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
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <form id="userForm" action="" class="form-horizontal">
            <jsp:include page="../form-common-hidden.jsp"/>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title"><i class="fa fa-info-circle"></i>
                        用户信息
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="col-sm-3 text-right">用户名：</div>
                        <div class="col-sm-7">
                            <input type="text" class="form-control input-sm"
                                   id="username" name="username" required></div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 text-right">中文名称：</div>
                        <div class="col-sm-7">
                            <input type="text" class="form-control input-sm"
                                   id="name" name="name" required></div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 text-right">E-mail：</div>
                        <div class="col-sm-7">
                            <input type="text" class="form-control input-sm"
                                   id="email" name="email" required></div>
                    </div>
                    <!-- <div class="form-group">
                    <div class="col-sm-3 text-right">所属部门：</div>
                    <div class="col-sm-7">
                        <select class="form-control input-sm" id="department" name="department" required></select>
                    </div>
                </div>
                -->
                    <div class="form-group">
                        <div class="col-sm-3 text-right">用户角色：</div>
                        <div class="col-sm-7">
                            <select id="roles" name="roles" class="form-control"
                                    multiple="multiple"></select>
                        </div>
                    </div>
                    <!-- <div class="form-group">
                    <div class="col-sm-3 text-right">用户资源：</div>
                    <div class="col-sm-7">
                        <input type="text" class="form-control input-sm" id="name" name="name" value=""></div>
                </div>
                -->
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
        $('#myModal').on('hidden.bs.modal', function () {
            var $form = document.getElementById('userForm');
            $form.reset();
        });

        $('#myModal').on('show.bs.modal', function (e) {
            // console.log(e.relatedTarget);
            var operate = $(e.relatedTarget).attr('operate');
            if (operate == 'update') {
                var checkedObj = $('#list-content').find('input[type="checkbox"]:checked');
                var len = checkedObj.length;
                if (len <= 0) {
                    failureAlert('请选择修改的数据！');
                    e.preventDefault();//阻止事件发生，阻止modal框显示
                    return;
                }
                if (len > 1) {
                    failureAlert('每次只能修改一条记录！');
                    e.preventDefault();//阻止事件发生，阻止modal框显示
                    return;
                }

                fillForm($(checkedObj).val());
            }

            $('#userForm').attr('action', operate);
        });

        $('#userForm').validate({
            submitHandler: function (form) {
                var $form = $(form);
                console.log($form.serializeJson());
                formHandler($form.attr('action'), $form);
                $('#myModal').modal("toggle");
            }
        });

        getDataForSelectTag('${pageContext.request.contextPath}/role/get-all', 'roles');
    });


    /**
     * [modifyRole description]
     * @param  {[type]} id [description]
     * @return {[type]}    [description]
     */
    function modifyRow(id) {
        fillForm(id);
        $('#privilegeForm').attr("action", 'update');
    }

    /**
     * [fillForm description]
     * @param  {[type]} id [description]
     * @return {[type]}    [description]
     */
    function fillForm(id) {
        $.getJSON('${pageContext.request.contextPath}/user/queryOne', {id: id}, function (user) {
                    for (var key in user) {
                        if (key == 'roles') {
                            var uRoles = user[key];
                            for (var i = 0; i < uRoles.length; i++) {
                                $('#' + key).val(uRoles[i].id);
                            }
                        } else {
                            $('#' + key).val(user[key]);
                        }
                    }
                }
        );
    }


    function fillTbody(list) {
        var html = '';
        if (list == null || list == '') {
            html = '<tr><td colspan="6">没有数据</td></tr>';
        } else {
            $.each(list, function () {
                html += '<tr>\n';
                html += '\t<td><input type="checkbox" value="' + this.id + '"/></td>\n';
                html += '\t<td>' + this.username + '</td>\n';
                html += '\t<td>' + this.name + '</td>\n';
                html += '\t<td>' + this.email + '</td>\n';
                html += '\t<td>' + getFormatDateByLong(this.createdTime, 'yyyy/MM/dd hh:mm:ss') + '</td>\n';
                html += '\t<td>\n';
                html += '\t\t<a href="#" data-toggle="modal" data-target="#myModal" onclick="modifyRow(\'' + this.id + '\');" data-backdrop="static"><span class="fa fa-pencil-square-o"></span>编辑</a> |\n';
                //html += '\t\t<a href="#" onclick="detail(\''+this.id+'\');"><span class="fa fa-list"></span>详细</a> |\n';
                html += '\t\t<a href="#" onclick="deleteRow(\'' + this.id + '\');"><span class="fa fa-trash"></span>删除</a>\n';
                html += '\t</td>\n';
                html += '</tr>\n';
            });
        }
        $("#list-content").html(html);
    }
</script>
