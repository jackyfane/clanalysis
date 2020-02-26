<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../js.plugin.jsp" flush="false"/>
<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li><a href="#">项目</a></li>
        <li class="active">报表配置</li>
    </div>
</div>
<div class="container-fluid">
    <form id="defaultForm" data-toggle="validator" class="form-horizontal"
          action="${action}" method="post">
        <fieldset>
            <legend><h4>基本配置</h4></legend>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label for="name" class="control-label">名称：</label>
                        </div>
                        <div class="col-md-3">
                            <input type="text" class="form-control input-sm"
                                   name="name" id="name" value="${entity.name}"
                                   required>
                        </div>
                        <div class="col-md-2 text-right">
                            <label for="category"
                                   class="control-label">分类：</label>
                        </div>
                        <div class="col-md-3">
                            <select class="form-control input-sm"
                                    name="category" id="category"
                                    required></select>
                        </div>
                        <div>
                            <button class="btn btn-sm btn-info" type="button"
                                    id="refreshCategory">
                                <span class="fa fa-refresh"></span>
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label for="title" class="control-label">标题：</label>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="title" name="title"
                                   class="form-control input-sm"
                                   value="${entity.title}" required>
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
                        <div class="col-md-2 text-right">
                            <label for="visibleUser" class="control-label">选在可见用户：</label>
                        </div>
                        <div class="col-md-4">
                            <select class="form-control" id="visibleUser"
                                    name="visibleUser"
                                    multiple="multiple"></select>
                        </div>
                        <div class="col-md-1">
                            <button type="button" class="btn btn-sm btn-info"
                                    id="refreshVisibleUser">
                                <span class="fa fa-refresh"></span>
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label for="description"
                                   class="control-label">描述：</label>
                        </div>
                        <div class="col-md-6">
                            <textarea id="description" name="description"
                                      class="form-control"
                                      rows="3">${entity.description}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <legend><h4>指标配置</h4></legend>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label for="dimension"
                                   class="control-label">数据源:</label>
                        </div>
                        <div class="col-md-3">
                            <select name="logSource" id="logSource"
                                    class="form-control input-sm"
                                    required></select>
                        </div>
                        <div class="col-md-2 text-right">
                            <label for="dimension"
                                   class="control-label">访客ID定义:</label>
                        </div>
                        <div class="col-md-3">
                            <select name="vid" id="vid"
                                    class="form-control input-sm"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label for="dimension"
                                   class="control-label">报表维度:</label>
                        </div>
                        <div class="col-md-6">
                            <select multiple="multiple" name="dimension"
                                    id="dimension" size="6" class="form-control"
                                    required></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-5 col-md-offset-1 text-center radio">
                            <label>
                                <input type="radio" name="model" value="S"
                                       checked="checked"
                                       onclick="changedModel(this, 'statistical_model','calculation_model');">
                                统计模式
                            </label>
                        </div>
                        <div class="col-md-5 radio">
                            <label>
                                <input type="radio" name="model" value="E"
                                       onclick="changedModel(this, 'calculation_model','statistical_model');">
                                计算模式
                            </label>
                        </div>
                    </div>

                    <div class="form-group" id="statistical_model">
                        <div class="col-md-2 text-right">
                            <label for="statistical"
                                   class="control-label">所有指标:</label>
                        </div>
                        <div class="col-md-6">
                            <select multiple="multiple" name="statistical"
                                    id="statistical" class="form-control"
                                    required>
                                <option value="PV">访问量</option>
                                <option value="UV">用户量</option>
                                <option value="VT">访次</option>
                            </select>
                        </div>
                    </div>

                    <div id="calculation_model" style="display: none;">
                        <div class="form-group">
                            <div class="col-md-4 col-md-offset-1">
                                <div style="padding-bottom: 5px;">所有指标:</div>
                                <div>
                                    <select id="elements" name="elements"
                                            multiple class="form-control">
                                        <option value="PV">访问量</option>
                                        <option value="UV">用户量</option>
                                        <option value="VT">访次</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-1 text-center"
                                 style="padding-top: 60px;">
                                <button type="button"
                                        onclick="fromMulSelect2Textarea('elements','expression')"
                                        class="btn btn-xs btn-primary">
                                    <span class="fa fa-angle-double-right"></span>
                                </button>
                            </div>
                            <div class="col-md-4">
                                <div style="padding-bottom: 5px;">算式表达式:
                                    <button type="button"
                                            class="btn btn-xs btn-success pull-right">
                                        维度统计
                                    </button>
                                </div>
                                <textarea rows="5" class="form-control"
                                          name="expression"
                                          id="expression"></textarea>

                                <div class="btn-group btn-group-sm" role="group"
                                     id="expressionBtnGroup">
                                    <button type="button" class="btn btn-sm">+
                                    </button>
                                    <button type="button" class="btn btn-sm">-
                                    </button>
                                    <button type="button" class="btn btn-sm">*
                                    </button>
                                    <button type="button" class="btn btn-sm">/
                                    </button>
                                    <button type="button" class="btn btn-sm">(
                                    </button>
                                    <button type="button" class="btn btn-sm">)
                                    </button>
                                </div>
                                <button type="button"
                                        class="btn btn-xs btn-warning pull-right"
                                        onclick="clearTextarea('expression');">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
        <jsp:include page="../form-action.jsp"/>
    </form>
</div>
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
                message: '名称为必填项！',
                validators: {
                    notEmpty: {
                        message: '名称不能为空！'
                    },
                    stringLength: {
                        min: 1,
                        max: 50,
                        message: '名称的长度在1到50个字符！'
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
            title: {
                message: '标题为必填项！',
                validators: {
                    notEmpty: {
                        message: '标题不能为空！'
                    },
                    stringLength: {
                        min: 1,
                        max: 50,
                        message: '标题的长度在1到50个字符！'
                    }
                }
            },
            logSource: {
                message: '请选择日志源！',
                validators: {
                    notEmpty: {
                        message: '请选择日志源！'
                    }
                }
            },
            dimension: {
                message: '请选择指标！',
                validators: {
                    notEmpty: {
                        message: '请选择指标！'
                    }
                }
            }
        }
    };

    $(function () {
        $.getJSON('${pageContext.request.contextPath}/ds/logsource', function (data) {
            var opts = '<option value="">请选择日志源</option>';
            $.each(data, function () {
                if ('${entity.logSource}') {
                    opts += '<option value="' + this.id + '" selected>' + this.name + '</option>';
                } else {
                    opts += '<option value="' + this.id + '">' + this.name + '</option>';
                }
            });
            $('select[name="logSource"]').html(opts);
        });

        if ('${entity.logSource}') {
            getElementsBySid('${entity.logSource}');
            getVidOptions('${entity.logSource}');
        }

        $('select[name="logSource"]').on('change', function () {
            if ($(this).val()) {
                getElementsBySid($(this).val());
                getVidOptions($(this).val());
            }
        });

        <c:forEach items="${entity.statistical}" var="s">
        $('select[name="statistical"]').val('${s}');
        </c:forEach>

        var model = $('input[name="model"][value="${entity.model}"]').prop('checked', true);
        if ('${entity.model}' == 'E') {
            changedModel(model, 'calculation_model', 'statistical_model');
        } else {
            changedModel(model, 'statistical_model', 'calculation_model');
        }

        limitSelectedItem('dimension', 3);
        limitSelectedItem('statistical', 6);

        $('#expressionBtnGroup button').on('click', function () {
            $('#expression').insertContent($(this).html());
        });
    });


    function getVidOptions(sid) {
        $.getJSON('${pageContext.request.contextPath}/ds/vids', {sid: sid}, function (vids) {
            var html = '<option value="">请选择访客ID</option>';
            for (var key in vids) {
                if ('${entity.vid}' == key) {
                    html += '<option value="' + key + '" selected>' + vids[key] + '</option>';
                } else {
                    html += '<option value="' + key + '">' + vids[key] + '</option>';
                }
            }
            ;
            $('#vid').html(html);
        });
    }

    /**
     * 获取日志下面的指标
     * @param  {[type]} sid [description]
     * @return {[type]}     [description]
     */
    function getElementsBySid(sid) {
        $.getJSON('${pageContext.request.contextPath}/element/get-all', function (data) {
            var dimensionHtml = '', statisticalHtml = '';

            <c:forEach items="${entity.dimension}" var="d">
            if ('${d.logSource}' == sid) {
                dimensionHtml += '<option value="${d.id}" selected>${d.name}</option>\n';
            }
            </c:forEach>
            <%--<c:forEach items="${entity.statistical}" var="s">--%>
            <%--if('${s.logSource}' == sid) {--%>
            <%--statisticalHtml += '<option value="${s.id}" selected>${s.name}</option>\n';--%>
            <%--}--%>
            <%--</c:forEach>--%>

            $.each(data, function () {

                if (this.logSource != sid)  return;

                if (this.elementType == 'D') {
                    if ('${entity.dimension}') {
                        var isExists = false;
                        <c:forEach items="${entity.dimension}" var="d">
                        if ('${d.id}' == this.id) {
                            isExists = true;
                        }
                        </c:forEach>
                        if (!isExists) {
                            dimensionHtml += '<option value="' + this.id + '">' + this.name + '</option>\n';
                        }
                    } else {
                        dimensionHtml += '<option value="' + this.id + '">' + this.name + '</option>\n';
                    }
                }
                <%--else if(this.elementType == 'S') {--%>
                <%--if('${entity.statistical}') {--%>
                <%--var isExists = false;--%>
                <%--<c:forEach items="${entity.statistical}" var="s">--%>
                <%--if ('${s.id}' == this.id) {--%>
                <%--isExists = true;--%>
                <%--}--%>
                <%--</c:forEach>--%>
                <%--if(!isExists) {--%>
                <%--statisticalHtml += '<option value="'+this.id+'">'+this.name+'</option>\n';--%>
                <%--}--%>
                <%--} else {--%>
                <%--statisticalHtml += '<option value="'+this.id+'">'+this.name+'</option>\n';--%>
                <%--}--%>
                <%--}--%>
            });

            $('select[name="dimension"]').html(dimensionHtml);
            // $('select[name="statistical"]').html(statisticalHtml);
        });
    }
    /**
     * Radio显示|隐藏
     * @param  {[type]} show [显示的组件ID]
     * @param  {[type]} hide [隐藏的组件ID]
     */
    function changedModel(object, show, hide) {
        $('#' + show).show();
        $('#' + hide).hide();
        if (show == "calculation_model") {
            $('#expression').attr('required', true);
            $('select[name="statistical"]').removeAttr('required');

            if ($('select[name="statistical"] option').length <= 0) {
                getDataForSelectTag('${pageContext.request.contextPath}/element/get-all?elementType=S', 'element');
            }
            else {
                $('select[name="elements"]').html($('select[name="statistical"] option').clone())
            }
        } else {
            $('#expression').removeAttr('required');
            $('select[name="statistical"]').attr('required', true);
        }

        $('#' + show).find('input,select,textarea').attr('disabled', false);
        $('#' + hide).find('input,select,textarea').attr('disabled', true);
    }
</script>
