<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
            <a href="#">项目</a>
        </li>
        <li class="active">过滤器信息</li>
    </div>
</div>
<div class="container">
    <form id="defaultForm" class="form-horizontal" action="${action}"
          method="post">
        <fieldset>
            <div id="base_conf" class="form-conf-group">
                <legend>
                    <h5>基本配置</h5>
                </legend>
                <jsp:include page="../item-base-form.jsp"/>
                <jsp:include page="../visual_user_form.jsp"/>
                <jsp:include page="../edit_by_creator.jsp"/>
                <div class="form-group modal-footer">
                    <button type="button" class="btn btn-sm btn-warning"
                            onclick="reloadPage();">取消
                    </button>
                    <button type="button" class="btn btn-sm btn-primary"
                            onclick="showTargetInputGroup('advance_conf');">下一步
                    </button>
                </div>
            </div>
            <div id="advance_conf" class="form-conf-group"
                 style="display: none">
                <jsp:include page="advance-form.jsp"/>
            </div>
        </fieldset>
    </form>
    <c:set var="ruleConfSize" value="${fn:length(entity.ruleConf)}"/>

</div>
</body>
</html>
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

    $(function () {
        getDataForSelectTag('${pageContext.request.contextPath}/element/get-all', 'element');

        $('select[name="ruleConf"]').on('click', function () {
            var arr = $('select[name="ruleConf"] option:checked').val().split('_');
            $('select[name="element"] option[value="' + arr[0] + '"]').attr("selected", true);
            $('input[name="expressType"][value=' + arr[1] + ']').prop('checked', true);
            $('input[name="condition"]').val(arr[2]);

        });
    });

    function joinCondToTarget(target) {
        var element = $('select[name="element"] option:selected').val();
        var selectText = $('select[name="element"] option:selected').text();
        if ($.isEmptyObject(element)) {
            failureAlert('请选择指标！');
            return;
        }
        var flag = $('input[name="expressType"]:checked').val();
        var flagText = '';
        if (flag == 'T') {
            flagText = '文本';
        }
        else if (flag == 'E') {
            flagText = '算式';
        }
        else {
            flagText = '正则表达式';
        }

        var condition = $('input[name="condition"]').val();
        if ($.isEmptyObject(condition)) {
            failureAlert('请输入条件！');
            return;
        }

        var optVal = element + '_' + flag + '_' + condition;
        var optText = selectText + condition + ':' + flagText;
        var isExists = false;
        if ($('select[name="' + target + '"] option[value="' + optVal + '"]').length) {
            isExists = true;
        }

        if (!isExists) {
            $('select[name="' + target + '"]').append('<option value="' + optVal + '">' + optText + '</option>');
        }
    }

    function showTargetInputGroup(target) {
        $.each($('form').find('.form-conf-group'), function () {
            if ($(this).attr('id') == target) {
                $(this).show();
                $(!$.isEmptyObject('${entity.ruleConf}'))
                {
                    var html = '';
                    <c:forEach var="rc" items="${entity.ruleConf}">
                    var val = '${rc}';
                    var spval = val.split('_');
                    html += '<option value="' + val + '">';
                    html += $('select[name="element"] option[value="' + spval[0] + '"]').html();
//                    $.each($('select[name="element"] option[value="'+spval[0]+'"]'), function()
//                    {
//                        if($(this).val() == spval[0])
//                        {
//                            html += $(this).html();
//                        }
//                    });
                    var txt = spval[1] == 'T' ? '文本' : (spval[1] == 'E' ? '算式' : '正则表达式');
                    html += spval[2] + ":" + txt;
                    html += '</option>';
                    </c:forEach>
                    $('select[name="ruleConf"]').html(html);
                }
            }
            else {
                $(this).hide();
            }
        });
    }
</script>
