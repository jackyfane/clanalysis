<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <%-- 私有隐藏域 --%>
        <div>
            <input type="hidden" name="dataSourceConfig"
                   value="${entity.dataSourceConfig}"/>
        </div>
        <fieldset>
            <legend><h4><span class="fa fa-database fa-lg"></span> 基本配置</h4>
            </legend>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="name">名称：</label>
                        </div>
                        <div class="col-md-3">
                            <input type="text" class="form-control input-sm"
                                   name="name" id="name" value="${entity.name}"
                                   required>
                        </div>
                        <div class="col-md-2 checkbox text-right">
                            <label for="category">分类：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm"
                                    name="category" id="category"
                                    required></select>
                        </div>
                        <div>
                            <button class="btn btn-sm btn-info" type="button"
                                    id="refreshCategory">刷新
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="zoneTime">时区：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm"
                                    name="zoneTime" id="zoneTime">
                                <option value="UTC+8">东8区</option>
                            </select>
                        </div>
                        <div class="col-md-2 checkbox text-right">
                            <label for="language">语言：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm"
                                    name="language" id="language">
                                <option value="zh">简体中文</option>
                                <option value="en">英文</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="website">网站主页：</label>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="website" name="website"
                                   class="form-control input-sm"
                                   value="${entity.website}" required>
                        </div>
                        <div class="col-md-3 checkbox text-center">
                            <label>
                                <input type="checkbox" value="true"
                                       name="editByCreator" id="editByCreator">
                                仅创建用户可编辑
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="visibleUser">选在可见用户：</label>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" id="visibleUser"
                                    name="visibleUser"
                                    multiple="multiple"></select>
                        </div>
                        <div class="col-md-1">
                            <button type="button" class="btn btn-sm btn-info"
                                    id="refreshVisibleUser">刷新
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="description">描述：</label>
                        </div>
                        <div class="col-md-6">
                            <textarea id="description" name="description"
                                      class="form-control"
                                      rows="3">${entity.description}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <legend><h4><span class="fa fa-database fa-lg"></span> 数据源</h4>
            </legend>
            <div class="panel panel-default">
                <!-- <div class="panel-heading">关联关系配置</div> -->
                <div class="panel-body" id="ds-input-group">
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="master">主数据源：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm" name="master"
                                    id="master"></select>
                        </div>
                        <div class="col-md-2 checkbox text-right">
                            <label for="master_field">字段：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm"
                                    name="master_field"
                                    id="master_field"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="slave">关联数据源：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm" name="slave"
                                    id="slave"></select>
                        </div>
                        <div class="col-md-2 checkbox text-right">
                            <label for="slave_field">字段：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm"
                                    name="slave_field"
                                    id="slave_field"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 checkbox text-right">
                            <label for="relation">关联关系：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control" name="relation"
                                    id="relation">
                                <option value="=">等于</option>
                                <option value="!=">不等于</option>
                                <option value=">">大于</option>
                                <option value=">=">大于等于</option>
                                <option value="<">小于</option>
                                <option value="<=">小于等于</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-sm btn-default"
                                    id="datasource_add">添加
                            </button>
                        </div>
                    </div>
                    <div class="conf-list">
                        <table class="table table-bordered table-striped table-condensed">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>主数据源</th>
                                <th>字段</th>
                                <th>关联数据源</th>
                                <th>字段</th>
                                <th>关联关系</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="datasource-conf-list"></tbody>
                        </table>
                    </div>
                </div>
            </div>
            <legend><h4><span class="fa fa-database fa-lg"></span> 模板配置</h4>
            </legend>
            <div class="form-group">
                <div class="col-md-2 checkbox text-right">
                    <label for="templates">模板：</label>
                </div>
                <div class="col-md-4">
                    <select class="form-control" id="templates" name="templates"
                            multiple="multiple" required></select>
                </div>
            </div>
        </fieldset>
        <jsp:include page="../form-action.jsp"/>
    </form>
</div>
</body>
</html>
<style type="text/css">
    .conf-list {
        overflow: auto;
        border: solid 1px #c0c0c0;
        border-radius: 2px;
        height: 130px;
    }

    .conf-list table {
        margin-top: 0px;
        border: none;
    }
</style>
<script type="text/javascript">
    var datasource = [];
    $(function () {
        $.getJSON('${pageContext.request.contextPath}/ds/get-all', function (data) {
            var optHtml = '<option value="" selected>请选择</option>\n';
            $.each(data, function () {
                optHtml += '<option value="' + this.id + '">' + this.name + '</option>\n';
            });
            $('select[name="master"],select[name="slave"]').html(optHtml);
        });

        $('select[name="master"],select[name="slave"]').on('change', function () {
            var name = $(this).attr('name'), field,
                    url = '${pageContext.request.contextPath}/ds/fields?sid=' + $(this).val();
            if (name == 'master') {
                field = 'master_field';
                if ($('select[name="slave"]').val() == $(this).val()) {
                    failureAlert('不能重复选择数据源！');
                    $('select[name="master_field"]').html('');
                    return;
                }

            } else {
                field = 'slave_field';
                if ($('select[name="master"]').val() == $(this).val()) {
                    failureAlert('不能重复选择数据源！');
                    $('select[name="slave_field"]').html('');
                    return;
                }
            }
            getDataForSelectTag(url, field);
        });

        $.getJSON('${pageContext.request.contextPath}/tpl/get-all', function (data) {
            var optHtml = '';
            <c:forEach var="tpl" items="${entity.templates}">
            optHtml += '<option value="${tpl.id}" selected>${tpl.name}</option>\n';
            </c:forEach>

            $.each(data, function () {
                var flag = false;
                <c:forEach var="tpl" items="${entity.templates}">
                if (this.id == '${tpl.id}') {
                    flag = true;
                }
                </c:forEach>
                if (!flag) {
                    optHtml += '<option value="' + this.id + '">' + this.name + '</option>\n';
                }
            });
            $('select[name="templates"]').html(optHtml);
        });

        /**
         * 添加数据源
         * */

        $('#datasource_add').on('click', function () {
            var param = {}, trHtml = '', len = 0;
            $.each($('#ds-input-group').find('select option:selected'), function (i) {
                if (!$.isEmptyObject($(this).val())) {
//                    trHtml += '<td>'+$(this).text()+'</td>';
                    switch (i) {
                        case 0:
                            param.mid = $(this).val();
                            param.mtext = $(this).text();
                            break;
                        case 1:
                            param.mfield = $(this).val();
                            param.mftext = $(this).text();
                            break;
                        case 2:
                            param.sid = $(this).val();
                            param.stext = $(this).text();
                            break;
                        case 3:
                            param.sfield = $(this).val();
                            param.sftext = $(this).text();
                            break;
                        case 4:
                            param.opt = $(this).val();
                            param.opttext = $(this).text();
                            break;
                    }
                    // param[$(this).text()] = $(this).val();
                    len++;
                }
            });
            if (len < 5) {
                failureAlert('请选择数据项');
                return;
            }

            var isExists = false;
            for (var i = 0; i < datasource.length; i++) {
                if (equals(datasource[i], param)) {
                    isExists = true;
                    break;
                }
            }
            if (!isExists) {
                datasource.push(param);
                ;
                generateHtml(datasource);
            }
        });

        if ('${entity.dataSourceConfig}') {
            datasource = JSON.parse('${entity.dataSourceConfig}');
            generateHtml(datasource);
        }
    });

    /**
     * 根据添加的数据源对象生成html
     * @param  {[type]} ds 数据源对象
     * @return {[type]}    无
     */
    function generateHtml(ds) {
        var html = '';
        for (var i = 0; i < ds.length; i++) {
            var obj = ds[i];
            html += '<tr>';
            html += '<td>' + (i + 1) + '</td>';
            html += '<td>' + obj.mtext + '</td>';
            html += '<td>' + obj.mftext + '</td>'
            html += '<td>' + obj.stext + '</td>';
            html += '<td>' + obj.sftext + '</td>';
            html += '<td>' + obj.opttext + '</td>';
            html += '<td><a href="javascript:void(0);" onclick="removeRow(this);">删除</a></td>';
            html += '</tr>\n';
        }
        $('#datasource-conf-list').html(html);
        $('input[name="dataSourceConfig"]').val(JSON.stringify(ds));
    }

    /**
     * 删除行
     * @param  {[type]} obj
     */
    function removeRow(obj) {
        var td = $(obj).parents('tr').find('td')[0], index = $(td).text();
        datasource.splice(index - 1);
        generateHtml(datasource);
    }
</script>
