<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../js.plugin.jsp" flush="false"/>
<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li><a href="#">项目</a></li>
        <li class="active">添加（修改）报表配置</li>
    </div>
</div>
<div class="container">
    <form id="defaultForm" data-toggle="validator" class="form-horizontal"
          action="${action}" method="post">
        <div id="base_conf" class="form-conf-group">
            <fieldset>
                <legend><h4>基本配置</h4></legend>
                <jsp:include page="../item-base-form.jsp"/>
                <div class="form-group form-group-sm">
                    <div class="col-md-2 text-right checkbox">
                        <label>标题:</label>
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
                            id="back_home">取消
                    </button>
                    <button type="button" class="btn btn-sm btn-primary"
                            onclick="showTargetInputGroup('advance_conf')">下一步
                    </button>
                </div>
            </fieldset>
        </div>
        <div id="advance_conf" class="form-conf-group" style="display: none;">
            <jsp:include page="form_advance.jsp"/>
        </div>
    </form>
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
            }
        }
    };

    $(function () {

        getDataForSelectTag('${pageContext.request.contextPath}/element/get-all?elementType=D', 'dimension');
        getDataForSelectTag('${pageContext.request.contextPath}/element/get-all?elementType=S', 'statistical');

        var model = $('input[name="model"][value="${entity.model}"]').prop('checked', true);
        if ('${entity.model}' == 'E') {
            changedModel(model, 'calculation_model', 'statistical_model');
        }
        else {
            changedModel(model, 'statistical_model', 'calculation_model');
        }

        limitSelectedItem('dimension', 3);
        limitSelectedItem('statistical', 6);

        $('#expressionBtnGroup button').on('click', function () {
            $('#expression').insertContent($(this).html());
        });
    });

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
        }
        else {
            $('#expression').removeAttr('required');
            $('select[name="statistical"]').attr('required', true);
        }
        $('#' + show).find('input,select,textarea').attr('disabled', false);
        $('#' + hide).find('input,select,textarea').attr('disabled', true);
    }
</script>
