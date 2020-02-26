<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../js.plugin.jsp" flush="false"/>
<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li><a href="#">项目</a></li>
        <li class="active">项目信息</li>
    </div>
</div>
<div class="container-fluid">
    <form id="defaultForm" data-toggle="validator" class="form-horizontal"
          action="${action}" method="post">
        <div id="base_conf" class="form-conf-group">
            <fieldset>
                <legend><h5>基本配置</h5></legend>
                <jsp:include page="../item-base-form.jsp"/>
                <div class="form-group form-group-sm">
                    <div class="col-md-2 checkbox text-right">
                        <label>时区:</label>
                    </div>
                    <div class="col-md-3">
                        <select name="timeZone" class="form-control">
                            <option value="8">东8区</option>
                        </select>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <div class="col-md-2 checkbox text-right">
                        <label>语言:</label>
                    </div>
                    <div class="col-md-3">
                        <select name="language" class="form-control">
                            <option value="en">英语</option>
                            <option value="cn">简体中文</option>
                        </select>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <div class="col-md-2 checkbox text-right">
                        <label>网站主页:</label>
                    </div>
                    <div class="col-md-5">
                        <input type="text" name="website" class="form-control"
                               autofocus required>
                    </div>
                </div>
                <jsp:include page="../visual_user_form.jsp"/>
                <jsp:include page="../edit_by_creator.jsp"/>
                <div class="form-group modal-footer">
                    <a href="#" type="button" class="btn btn-sm btn-warning"
                       onclick="reloadPage();">取消</a>
                    <button type="button" class="btn btn-sm btn-primary"
                            onclick="showTargetInputGroup('ds_conf')">下一步
                    </button>
                </div>
            </fieldset>
        </div>
        <div id="ds_conf" class="form-conf-group" style="display: none;">
            <jsp:include page="ds-form.jsp"/>
        </div>
        <div id="tpl_conf" class="form-conf-group" style="display:none;">
            <jsp:include page="tpl-form.jsp"/>
        </div>
    </form>
</div>
</body>
</html>
<style type="text/css">
    .param-list {
        overflow: auto;
        border: solid 1px #c0c0c0;
        border-radius: 2px;
        height: 220px;
    }

    .param-list table {
        border: none;
    }
</style>
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

    /**
     * 模态框数据列表
     * @param  {[type]} list [description]
     * @return {[type]}      [description]
     */
    function listContent(list, target) {
        var html = '';
        if (list == null || list == '') {
            html = '<tr><td colspan="2">没有数据</td></tr>';
        }
        else {
            $.each(list, function () {
                html += '<tr>\n';
                html += '\t<td><input type="checkbox" value="' + this.id + '"/></td>\n';
                html += '\t<td>' + this.name + '</td>\n';
                html += '</tr>\n';
            });
        }
        $("#" + target).html(html);
    }
</script>
