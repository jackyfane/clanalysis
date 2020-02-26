<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="../js.plugin.jsp" flush="true"/>
    <style type="text/css">
        table {
            margin-top: 10px;
        }

        table td, th {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="panel panel-default">
    <ol class="panel-heading breadcrumb">
        <li><a href="#">项目</a></li>
        <li class="active">分类</li>
    </ol>
    <div class="panel-body">
        <!-- 管理列表 -->
        <div id="item_list">
            <div class="btn-toolbar" role="toolbar">
                <div class="btn-group btn-group-sm">
                    <button class="btn btn-success" data-toggle="modal"
                            aria-labelledby="modalLabel" data-target="#modal"
                            onclick="cleanForm();">
                        <span class="fa fa-plus-circle blue"
                              aria-hidden="true"></span>添加
                    </button>
                    <button class="btn btn-danger"
                            onclick="operation('delete')">
                        <span class="glyphicon glyphicon-remove-sign"></span>删除
                    </button>
                </div>
            </div>

            <table class="table table-bordered table-striped table-condensed"
                   id="searchable-container">
                <thead>
                <tr>
                    <th><label>全选 <input type="checkbox" id="checkall"/></label>
                    </th>
                    <th>名称</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="list-content"></tbody>
            </table>
            <div class="pagination pull-right" id="pagination"></div>
        </div>
    </div>
    <%-- 表单 --%>
    <div id="modal" class="modal fade" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">×
                    </button>
                    <h3>添加分类</h3>
                </div>
                <div class="modal-body">
                    <form data-toggle="validator" role="form" action="add"
                          method="post" id="defaultForm">
                        <input type="hidden" name="id" value=""/>

                        <div class="form-group">
                            <label class="control-label">分类名称:</label>
                            <input type="text" name="name" class="form-control"
                                   value="" placeholder="分类名称" required
                                   autofocus>
                            <span class="help-block with-errors"></span>
                        </div>
                        <div class="form-group modal-footer">
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal">取消
                            </button>
                            <button type="submit" class="btn btn-primary">提交
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript">
    verifyFieldsOptions = {
        message: 'This value is not valid',
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
            }
        }
    };

    /**
     * 渲染内容
     * @param list
     */
    function fillTbody(list) {
        var html = '';
        if (list == null || list == '') {
            html = '<tr><td colspan="4">没有数据</td></tr>';
        }
        else {
            $.each(list, function () {
                html += '<tr>\n';
                html += '\t<td><input type="checkbox" value="' + this.id + '"/></td>\n';
                html += '\t<td>' + this.name + '</td>\n';
                html += '\t<td>\n';
                html += '\t\t<a href="#" onclick="modifyCategory(\'' + this.id + '\', \'' + this.name + '\');" data-toggle="modal" data-target="#modal"><span class="fa fa-pencil-square-o"></span>编辑</a> |\n';
                html += '\t\t<a href="#" onclick="deleteRow(\'' + this.id + '\', this);"><span class="glyphicon glyphicon-remove"></span>删除</a>\n';
                html += '\t</td>\n';
                html += '</tr>\n';
            });
        }
        $("#list-content").html(html);
    }

    /**
     * 修改分类
     * @param id
     * @param name
     */
    function modifyCategory(id, name) {
        cleanForm('update');
        $('form').attr('action', 'update');
        $("input[name='id']").val(id);
        $("input[name='name']").val(name);
    }
</script>
