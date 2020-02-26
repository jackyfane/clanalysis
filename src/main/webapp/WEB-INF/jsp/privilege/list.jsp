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
        <li class="active">权限管理</li>
    </div>
    <div class="container-fluid">
        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group btn-group-sm" role="group" aria-label="...">
                <button type="button" class="btn btn-info" operate="add"
                        data-toggle="modal" data-target="#myModal"
                        data-backdrop="static">
                    <span class="fa fa-plus-circle blue"></span>
                    添加
                </button>
                <button type="button" class="btn btn-warning" operate="update"
                        data-toggle="modal" data-target="#myModal"
                        data-backdrop="static">
                    <span class="fa fa-pencil-square-o"></span>
                    修改
                </button>
                <%--
            <button type="button" class="btn btn-info" onclick="rud('add','add');">
                <span class="fa fa-plus-circle blue"></span>
                添加
            </button>
            <button type="button" class="btn btn-warning" onclick="rud('modify','update');">
                <span class="fa fa-pencil-square-o"></span>
                修改
            </button>
            --%>
                <button type="button" class="btn btn-danger"
                        onclick="rud('delete', '');">
                    <span class="fa fa-trash-o"></span>
                    删除
                </button>
            </div>
        </div>
        <table class="table table-bordered table-striped table-condensed table-hover"
               id="searchable-container">
            <thead>
            <tr>
                <th>
                    <label>
                        全选
                        <input type="checkbox" id="checkall"/>
                    </label>
                </th>
                <th>权限名称</th>
                <th>权限标识</th>
                <th>图标</th>
                <th>权限描述</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="list-content"></tbody>
        </table>
        <!-- 分页 -->
        <div class="pagination pull-right" id="pagination"></div>
    </div>
</div>
<div id="myModal" class="modal fade" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title"><i class="fa fa-info-circle"></i>
                    权限配置
                </h4>
            </div>
            <form id="privilegeForm" class="form-horizontal"
                  data-toggle="validator" method="post">
                <div class="modal-body">
                    <input type="hidden" name="id" id="id">

                    <div class="form-group">
                        <div class="col-md-3 checkbox text-right">
                            <label for="name">权限名称：</label>
                        </div>
                        <div class="col-md-6">
                            <input class="form-control input-sm" name="name"
                                   id="name" required></div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-3 checkbox text-right">
                            <label for="identify">权限标识：</label>
                        </div>
                        <div class="col-md-6">
                            <input class="form-control input-sm" name="identify"
                                   id="identify" required></div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-3 checkbox text-right">
                            <label for="icon">图标：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="icon" id="icon"
                                    class="form-control input-sm"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-3 checkbox text-right">
                            <label for="description">描述：</label>
                        </div>
                        <div class="col-md-6">
                            <textarea rows="3" class="form-control"
                                      name="description"
                                      id="description"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm"
                            data-dismiss="modal">关闭
                    </button>
                    <button type="reset" class="btn btn-sm btn-warning">重置
                    </button>
                    <button type="submit" class="btn btn-sm btn-primary">提交
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>

<script type="text/javascript">
    $(function () {

        $('#privilegeForm').validate({
            submitHandler: function (form) {
                var $form = $(form);
                console.log($form.serializeJson());
                formHandler($form.attr('action'), $form);
                $('#myModal').modal("toggle");
            }
        });

        $('#myModal').on('hide.bs.modal', function () {
            document.getElementById('privilegeForm').reset();
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

            $('#privilegeForm').attr('action', operate);
        });
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
     * 从后台加载数据填充表单信息
     * @param  {[type]} id [description]
     * @return {[type]}    [description]
     */
    function fillForm(id) {
        $.getJSON('${pageContext.request.contextPath}/privilege/queryOne', {id: id}, function (rs) {
                    for (var key in rs) {
                        $('#' + key).val(rs[key]);
                    }
                }
        );
    }

    function fillTbody(list) {
        var html = '';
        if (list == null || list == '') {
            html = '<tr><td colspan="6">没有数据</td></tr>';
        }
        else {
            $.each(list, function () {
                html += '<tr>\n';
                html += '\t<td><input type="checkbox" value="' + this.id + '"/></td>\n';
                html += '\t<td>' + this.name + '</td>\n';
                html += '\t<td>' + this.identify + '</td>\n';
                html += '\t<td>' + this.icon + '</td>\n';
                html += '\t<td>' + this.description + '</td>\n';
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
