<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>
    <script type="text/javascript">
        var database = '';

        $(function () {
            checkedRadio('srcType', '${entity.srcType}');

            showSrcTypeDesc('${entity.srcType}');
            $('input[name="srcType"]').on('change', function () {
                var srcType = $(this).val();
//          if(srcType == 'file') {
//              $('form').attr('action', 'upload/ds_local_file');
//              $('form').attr('enctype','multipart/form-data');
//                $('form').removeAttr('id', 'defaultForm');
//          } else {
//              $('form').attr('action', 'add');
//              $('form').attr('id', 'defaultForm');
//              $('form').removeAttr('enctype');
//          }

                console.log($('form').attr('id'));

                var showSrcTypeId = srcType + '_desc';
                showSrcTypeDesc(showSrcTypeId);
            });

            $('input[type="radio"][name="flag"]').on('click', function () {
                var flag = $(this).val();
                if (flag == 'table') {
                    $('#table_input').show();
                    //$('#sql_input').hide();
                    $('select[name="tableName"]').removeAttr('disabled');
                    var dbConfig = $('select[name="dbConfig"] option:selected').val();
                    if ($.isEmptyObject(dbConfig)) {
                        $('select[name="tableName"]').html('');
                        return
                    }
                    else if (database == dbConfig) {
                        return;
                    }
                    else {
                        getDataForSelectTag('${pageContext.request.contextPath}/dbc/tables?id=' + dbConfig, "tableName");
                    }
                }
                else {
                    //$('#sql_input').show();
                    $('#table_input').hide();
                    $('select[name=""]').html('');
                    database = $('select[name="dbConfig"] option:selected').val();
                    $('select[name="tableName"]').attr('disabled', 'disabled');
                }
            });

            $('select[name="docType"]').on('change', function () {
                if ($(this).val() == 'txt') {
                    $('#excelRegion').hide();
                    $('#txtSeparator').show();
                    clearExcelRegion();
                }
                else if ($(this).val() == 'csv') {
                    $('#excelRegion').hide();
                    $('#txtSeparator').hide();
                    clearExcelRegion();
                    clearTxtSeparator();
                }
                else {
                    $('#excelRegion').show();
                    $('#txtSeparator').hide();
                    clearTxtSeparator();
                    $($('input[name="sheetFlag"]')[0]).prop('checked', true);
                    $($('input[name="region"]')[0]).prop('checked', true);
                }
            });

            $('input[type="radio"][name="field"]').on('click', function () {
                var id = $(this).attr('id');
                if (id == null || id == '' || id == undefined) {
                    $('#field-select').show();
                }
                else {
                    $('#field-select').hide();
                }
            });

            $('input[type="radio"][name="region"]').on('click', function () {
                var val = $(this).val();
                if (val == 'region') {
                    $.each($('input[name="start"],[name="end"]'), function () {
                        $(this).removeAttr("disabled")
                    });
                }
                else {
                    $.each($('input[name="start"],[name="end"]'), function () {
                        $(this).attr("disabled", "disabled");
                        $(this).val('');
                    });
                }
            });

            getDataForSelectTag('', 'docType', '${entity.docType}');

            $('input[type="file"]').on('change', function (e) {
                var docType = $('select[name="docType"] option:selected').val();
                if ($.isEmptyObject(docType)) {
                    failureAlert('请选择文件类型');
                    $(this).val('');
                    return;
                }
                var path = $(this).val(), suffix = path.substring(path.lastIndexOf('.') + 1);
                if (suffix != docType) {
                    failureAlert('上传文件不匹配文件类型');
                    $(this).val('');
                    return;
                }
            });
        });

        function showSrcTypeDesc(srcTypeDescId) {
            if (!$.isEmptyObject(srcTypeDescId)) {
                $.each($('blockquote'), function () {
                    if ($(this).attr('id') == srcTypeDescId) {
                        $(this).show();
                    } else {
                        $(this).hide();
                    }
                });
            }
        }

        //获取配置数据库的所有用户表
        function getTables(object, target) {
            var confId = $(object).val(),
                    url = '${pageContext.request.contextPath}/dbc/tables?id=' + confId;
            if ($.isEmptyObject(confId)) return;
            getDataForSelectTag(url, target);
        }

        //获取选定表的所有字段
        function getFields(object, target) {
            var confId = $('select[name="dbConfig"] option:selected').val();
            var table = $(object).val();
            if ($.isEmptyObject(table) || $.isEmptyObject(confId)) return;
            var url = '${pageContext.request.contextPath}/dbc/fields?id=' + confId + "&table=" + table;
            getDataForSelectTag(url, target);
            $('select[name="fields"]').html('');
        }

        var otherVal = '';
        function checkOther(object, target) {
            if ($(object).prop('checked')) {
                $('input[name=' + target + ']').removeAttr('disabled');
                $('input[name=' + target + ']').val(otherVal);
            }
            else {
                $('input[name=' + target + ']').attr('disabled', 'disabled');
                otherVal = $('input[name=' + target + ']').val();
                $('input[name=' + target + ']').val('');
            }
        }

        /**
         * [showTargetInputGroup description]
         * @param  {[type]} target [description]
         * @return {[type]}        [description]
         */
        function showTargetInputGroup(target) {
            var srcType = '';
            if (!$.isEmptyObject(target)) {
                srcType = target.substring(0, target.indexOf('_'));
            }
            else {
                srcType = $("input[type='radio'][name='srcType']:checked").val();
                if (srcType == 'log') {
                    getDataForSelectTag('logsource', 'logType', '${entity.logType}');
                } else if (srcType == 'db') {
                    getDataForSelectTag('${pageContext.request.contextPath}/dbc/get-all', 'dbConfig', '${entity.dbConfig.id}');
                }
            }

            $.each($('.form-conf-group'), function () {
                if ($(this).attr('id') == srcType + '_conf') {
                    $(this).show();
                }
                else {
                    $(this).hide();
                }
            });

            showSrcTypeDesc(srcType + '_desc');
        }

        function clearExcelRegion() {
            $.each($('#excelRegion').find('input'), function () {
                var type = $(this).attr('type');
                if (type == 'radio' || type == 'checkbox') {
                    $(this).removeAttr('checked')
                }
                else {
                    $(this).val('');
                }
            });
        }

        function clearTxtSeparator() {
            $.each($('#txtSeparator').find('input'), function () {
                var type = $(this).attr('type');
                if (type == 'radio' || type == 'checkbox') {
                    $(this).removeAttr('checked')
                }
                else {
                    $(this).val('');
                }
            });
        }

        /**
         * 生成SQL
         * @return {[type]} [description]
         */
        function generateSQL() {
            var table = $('select[name="tableName"] option:selected').val();
            if ($.isEmptyObject(table)) {
                failureAlert("请选择表");
                return;
            }
            var fields = [];
            $.each($('select[name="fields"] option:selected'), function () {
                fields.push($(this).val());
            });
            //alert(fields.toString());
            var sql = 'select ' + (fields.length > 0 ? fields.toString() : '*') + ' from ' + table;
            $('textarea[name="sql"]').val(sql);
        }
    </script>

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
            <a href="#">数据源</a>
        </li>
        <li class="active">数据源信息</li>
    </div>
</div>
<div class="container">
    <form class="form-horizontal" action="upload/ds_local_file" method="post"
          enctype="multipart/form-data">
        <c:choose>
            <c:when test="${entity != null}">
                <input type="hidden" name="user"
                       value="${entity.user.id}"></c:when>
            <c:otherwise>
                <input type="hidden" name="user"
                       value="${userInfo.id}"></c:otherwise>
        </c:choose>
        <div id="base_conf" class="form-conf-group">
            <jsp:include page="base-form.jsp"/>
        </div>
        <!-- 标准日志-->
        <div id="log_conf" class="form-conf-group" style="display: none">
            <jsp:include page="log-form.jsp"/>
        </div>
        <!-- 数据库-->
        <div id="db_conf" class="form-conf-group" style="display: none">
            <jsp:include page="db-form.jsp"/>
        </div>
        <!-- 本地上传 -->
        <div id="file_conf" class="form-conf-group" style="display: none">
            <jsp:include page="file-form.jsp"/>
        </div>
    </form>
</div>
</body>
</html>
