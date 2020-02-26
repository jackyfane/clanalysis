<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../js.plugin.jsp" flush="false"/>
<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li><a href="#">项目</a></li>
        <li class="active">指标信息</li>
    </div>
</div>
<div class="container">
    <form id="defaultForm" class="form-horizontal" action="${action}"
          method="post" enctype="multipart/form-data">
        <div id="base_conf" class="form-conf-group">
            <fieldset>
                <legend><h4>基本配置</h4></legend>
                <jsp:include page="../item-base-form.jsp"/>
                <div class="form-group form-group-sm">
                    <div class="col-md-2 text-right checkbox">
                        <label>图表显示:</label>
                    </div>
                    <div class="col-md-4">
                        <input type="text" name="title" class="form-control"
                               value="${entity.title}" required>
                    </div>
                </div>
                <jsp:include page="../visual_user_form.jsp"/>
                <jsp:include page="../edit_by_creator.jsp"/>
                <div class="form-group modal-footer">
                    <button type="button" class="btn btn-sm btn-warning"
                            onclick="reloadPage();">取消
                    </button>
                    <button type="button" class="btn btn-sm btn-primary"
                            onclick="showTargetInputGroup('advance-form')">下一步
                    </button>
                </div>
            </fieldset>
        </div>
        <div id="advance-form" class="form-conf-group" style="display: none;">
            <jsp:include page="advance-form.jsp"/>
        </div>
    </form>
</div>
</body>
</html>
<style type="text/css">
    .param-list {
        overflow: auto;
        border: solid 1px #c0c0c0;
    }
</style>
<script type="text/javascript">
    var logConf = {};
    $(function () {
        $.getJSON('${pageContext.request.contextPath}/ds/logsource', function (data) {
            $.each(data, function () {
                var logId = this["id"];
                logConf[logId] = [];
                $('select[name="logType"]').append('<option value="' + this["id"] + '">' + this['name'] + '</option>');
                $.each(this['cols'], function () {
                    var key = this['name'];
                    var option = '<option value="' + this["name"] + '">' + this['name'] + '</option>';
                    logConf[logId].push(option);
                    logConf[logId][key] = [];
                    if (!$.isEmptyObject(this['searchFamily'])) {
                        var inputStr = '<input name="searchCol" class="form-control input-sm">';
                        logConf[logId][key] = inputStr;
                    } else if (!$.isEmptyObject(this['subCols'])) {
                        var select = '<select name="searchCol" class="form-control">';
                        $.each(this['subCols'], function () {
                            select += '<option value="' + this["family"] + ':' + this["name"] + '">' + this['name'] + '</option>';
                        });
                        select += '</select>';
                        logConf[logId][key].push(select);
                    }
                });
            });
//            console.log(logConf);
        });

        $('select[name="logType"]').on('change', function () {
            if ($.isEmptyObject($(this).val())) {
                $('select[name="baseField"]').html('<option value="">请选择基础字段</option>');
                return;
            }
            ;
            $('select[name="baseField"]').html(logConf[$(this).val()].toString());
            $(this).attr('disabled', true);
        });
        $('select[name="baseField"]').on('change', function () {
            var root = $('select[name="logType"] option:selected').val();
            if ($.isEmptyObject(logConf[root][$(this).val()])) {
                $('#queryLabel').hide();
                $('#queryLabel').find('select,input').html('');
                changeParamListHeight();
                return;
            }
//            console.log(logConf[root][$(this).val()]);
            $('#queryTag').html(logConf[root][$(this).val()]);
            $('#queryLabel').show();
            changeParamListHeight();
        });

        if (!$.isEmptyObject('${entity.convert}')) {
            $('input[type="checkbox"][name="convert"]').prop('checked', true);
            $('#char_param').show();
            getDataForSelectTag('${pageContext.request.contextPath}/association/get-all', 'association', '${entity.association.id}');
        }

        $('input[type="checkbox"][name="convert"]').click(function () {
            if ($(this).prop('checked')) {
                $('#char_param').show();
                $('#char_param').find('input,select').removeAttr('disabled');
                if ($('select[name="association"] option').length <= 0) {
                    getDataForSelectTag('${pageContext.request.contextPath}/association/get-all', 'association', '${entity.association.id}');
                }
            }
            else {
                $('#char_param').hide();
                $('#char_param').find('input,select').attr('disabled', true);
            }
        });

        if (!$.isEmptyObject('${entity.composite}')) {
            $('input[type="checkbox"][name="composite"]').prop('checked', true);
            $('#compositeElConf').show();
            getDataForSelectTag('${pageContext.request.contextPath}/element/get-all', 'elements');
        }

        $('input[name="composite"]').click(function () {
            if ($(this).prop('checked')) {
                $('#compositeElConf').show();
                $('#compositeElConf').find('textarea,select').removeAttr('disabled');
                if ($('select[name="elements"] option').length <= 0) {
                    getDataForSelectTag('${pageContext.request.contextPath}/element/get-all', 'elements');
                }
            }
            else {
                $('#compositeElConf').hide();
                $('#compositeElConf').find('textarea,select').attr('disabled', true);
            }
        });

        expTypeChange('${entity.expType}');

        $('input[name="expType"]').click(function () {
            expTypeChange($(this).val());
        });

        $('#expressionBtnGroup button').on('click', function () {
            $('#complexExp').insertContent($(this).html());
        });
    });

    function showTargetInputGroup(target) {
        $.each($('form').find('.form-conf-group'), function () {
            if ($(this).attr('id') == target) {
                $(this).show();
            }
            else {
                $(this).hide();
            }
        });
        changeParamListHeight();
    }

    function changeParamListHeight() {
        var height = $('.log-param-select').height();
        $('.param-list').css('height', height - 15);
//        $('.btn-pos').css('height', height-15);
    }

    /**
     * 添加数据到表格
     */
    function addParamToTable() {
        var logType = $('select[name="logType"]').val(),
                baseField = $('select[name="baseField"]').val();
        if ($.isEmptyObject(logType) || $.isEmptyObject(baseField)) {
            return;
        }

        var tr = '<tr><td>' + baseField + '</td>', obj = {};
        if ($('#queryTag').find('select,input').length > 0) {
            $.each($('#queryTag').find('select,input'), function () {
                var val = $(this).val();
                if (!$.isEmptyObject(val) && val.indexOf(':') != -1) {

                    var fc = val.split(':');
                    tr += '<td>' + fc[0] + '</td><td>' + fc[1] + '</td>';
                } else {
                    val = val == null || val == 'null' ? "" : val;
                    tr += '<td>raw</td><td>' + val + '</td>';
                }
            });
        } else {
            tr += '<td>raw</td><td></td>';
        }
        tr += '<td><a href="javascript:void(0);" onclick="removeRow(this);">删除</a></td></tr>';

        $('#param-grid').append(tr);
        var json = $('#param-grid').serializeGridToJson(logType);
        $('#idxs').val(json);
        console.log($('#idxs').val());
    }

    /**
     * 删除行数据
     * @param  {[type]} obj
     */
    function removeRow(obj) {
        $(obj).parents('tr').remove();
        var sid = $('select[name="logType"]').val();
        var json = $('#param-grid').serializeGridToJson(sid);
        $('#idxs').val(json);
        console.log($('#idxs').val());
    }


    $.fn.serializeGridToJson = function (sid) {
        var obj = {}, cols = {};
        var len = $(this).find('tr').length;
        for (var i = 0; i < len; i++) {
            var tr = $(this).find('tr')[i];
            var td = $(tr).find('td'), baseField = $(td[0]).html(),
                    family = $(td[1]).html(), queryTag = $(td[2]).html();
            if ($.isEmptyObject(queryTag)) {
                if (cols[family]) {
                    if ($.inArray(baseField, cols[family]) < 0) {
                        cols[family].push(baseField);
                    }
                } else {
                    cols[family] = [baseField];
                }
            } else {
                if (cols[family]) {
                    if ($.inArray(queryTag, cols[family]) < 0) {
                        cols[family].push(queryTag);
                    }
                } else {
                    cols[family] = [queryTag];
                }
            }
        }
        obj['sid'] = sid;
        obj['col'] = cols;
        return JSON.stringify(obj);
    }

    function expTypeChange(stats) {
        if (stats == 'F') {
            $('input[name="fixedPortion"]').removeAttr('disabled');
            $('input[name="expressRegular"]').attr('disabled', true);
        }
        else if (stats == 'R') {
            $('input[name="expressRegular"]').removeAttr('disabled');
            $('input[name="fixedPortion"]').attr('disabled', true);
        }
        else {
            $('input[name="fixedPortion"]').attr('disabled', true);
            $('input[name="expressRegular"]').attr('disabled', true);
        }
    }

    /**
     * [freshAssociation description]
     * @return {[type]} [description]
     */
    function freshAssociation() {
        getDataForSelectTag('${pageContext.request.contextPath}/association/get-all', 'association', '${entity.association.id}');
    }

    /**
     * [freshElement description]
     * @return {[type]} [description]
     */
    function freshElement() {
        getDataForSelectTag('${pageContext.request.contextPath}/element/get-all', 'elements');
    }

    /**
     * 校验正则表达式
     * @param  {[type]} target 测试目标
     */
    function verifyRegular(target) {

    }

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
</script>
