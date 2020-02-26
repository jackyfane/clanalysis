<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <li class="active">指标信息</li>
    </div>
</div>
<div class="container-fluid">
    <form id="defaultForm" class="form-horizontal" action="${action}"
          method="post" enctype="multipart/form-data">
        <%--<input type="hidden" name="idxs" id="idxs" value="${entity.idxs}"/>
        --%>
        <fieldset>
            <legend>
                <h4>基本配置</h4>
            </legend>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label class="control-label" for="name">名称:</label>
                        </div>
                        <div class="col-md-3">
                            <input type="text" class="form-control input-sm"
                                   name="name" id="name" value="${entity.name}"
                                   required></div>
                        <div class="col-md-2 text-right">
                            <label for="category"
                                   class="control-label">分类:</label>
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
                            <label for="title"
                                   class="control-label">图表显示标题:</label>
                        </div>
                        <div class="col-md-4">
                            <input type="text" id="title" name="title"
                                   class="form-control input-sm"
                                   value="${entity.title}" required></div>
                        <div class="col-md-3 checkbox text-center">
                            <label>
                                <input type="checkbox" value="true"
                                       name="editByCreator" id="editByCreator">仅创建用户可编辑</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label class="control-label" for="visibleUser">选在可见用户:</label>
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
                            <label class="control-label"
                                   for="description">描述:</label>
                        </div>
                        <div class="col-md-6">
                            <textarea id="description" name="description"
                                      class="form-control"
                                      rows="3">${entity.description}</textarea>
                        </div>
                    </div>
                </div>
            </div>

            <legend>
                <h4>指标配置</h4>
            </legend>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="breadcrumb">
                        <div class="form-group">
                            <div class="col-md-2 text-right">
                                <label class="control-label">统计方法:</label>
                            </div>
                            <div class="col-md-8 radio">
                                <label class="control-label">
                                    <input type="radio" name="elementType"
                                           value="D" checked="checked">分类。用于文本字符，仅用作维度。</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-2">
                                <label class="control-label"></label>
                            </div>
                            <div class="col-md-8 radio">
                                <label class="control-label">
                                    <input type="radio" name="elementType"
                                           value="S">求和。应用于纯数值类型数据，非数值数据用0代替计算，可识别负数。</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label class="control-label"
                                   for="logSource">日志源:</label>
                        </div>
                        <div class="col-md-3">
                            <select name="logSource" id="logSource"
                                    class="form-control input-sm" required>
                                <option value="">请选择日志</option>
                            </select>
                        </div>
                        <div class="col-md-2 text-right">
                            <label class="control-label"
                                   for="family">基础字段:</label>
                        </div>
                        <div class="col-md-3">
                            <select name="family" id="family"
                                    class="form-control input-sm" required>
                                <option value="">请选择基础字段</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div id="queryLabel" style="display: none">
                            <div class="col-md-2 text-right">
                                <label class="control-label">查询标识:</label>
                            </div>
                            <div class="col-md-3" id="queryTag"></div>
                        </div>
                        <!-- <div class="col-md-2 text-right">
                        <label for="vid" class="control-laebl">访客ID:</label>
                    </div>
                    <div class="col-md-3">
                        <select name="vid" id="vid" class="form-control input-sm">
                            <option value=""></option>
                            <option value="">请选择访客ID</option>
                        </select>
                    </div>
                    <div class="col-md-1 text-center">
                        <button class="btn btn-primary btn-sm" type="button" onclick="addParamToTable();">
                            <span class="fa fa-plus-circle"></span>
                        </button>
                    </div>
                    -->
                    </div>
                    <!--
                    <div class="form-group">
                    <div class="col-md-2">
                        <label class="control-label"></label>
                    </div>
                    <div class="col-md-8 param-list">
                        <table class="table table-bordered table-striped table-condensed">
                            <thead>
                                <tr>
                                    <th>基础字段</th>
                                    <th>列族</th>
                                    <th>查询标识</th>
                                    <th>访客ID</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="param-grid"></tbody>
                        </table>
                    </div>
                </div>
                -->
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label for="expType"
                                   class="control-label">指标过滤:</label>
                        </div>
                        <div class="col-md-3">
                            <select name="expType" id="expType"
                                    class="form-control input-sm">
                                <option value="">匹配所有值</option>
                                <option value="F">含有固定部分</option>
                                <option value="R">正则表达式</option>
                            </select>
                        </div>
                        <div class="col-md-1 text-right">
                            <label class="control-label"></label>
                        </div>
                        <div class="col-md-3" id="fixedPortion"
                             style="display: none">
                            <input type="text" class="form-control input-sm"
                                   name="fixedPortion"
                                   value="${entity.fixedPortion}"/>
                        </div>
                        <div class="col-md-4" id="expressRegular"
                             style="display: none">
                            <div class="col-md-10">
                                <input type="text" name="expressRegular"
                                       class="form-control input-sm"
                                       value="${entity.expressRegular}"
                                       disabled></div>
                            <div class="col-md-1">
                                <button type="button"
                                        class="btn btn-sm btn-primary"
                                        onclick="verifyRegular();">测试
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-2 text-right">
                            <label for="currencyUnit">货币单位:</label>
                        </div>
                        <div class="col-md-3">
                            <select name="currencyUnit" id="currencyUnit"
                                    class="form-control input-sm">
                                <option value="">无</option>
                            </select>
                        </div>
                    </div>
                    <legend>
                        <label class="control-label">
                            <h5>
                                <input type="checkbox" name="convert"
                                       value="true">使用字符转换</h5>
                        </label>
                    </legend>
                    <div style="display: none;" id="char_param">
                        <div class="form-group">
                            <label class="col-md-2 control-label text-right">字符名称转换:</label>

                            <div class="col-md-5">
                                <select name="association"
                                        class="form-control input-sm"></select>
                            </div>
                            <div class="col-md-1">
                                <button type="button"
                                        class="btn btn-xs btn-success"
                                        onclick="freshAssociation()">
                                    <span class="fa fa-refresh"></span>
                                </button>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 control-label text-right">源字符位置:</label>

                            <div class="col-md-2">
                                <input type="number" name="srcChrIndex"
                                       class="form-control input-sm"
                                       value="${entity.srcChrIndex}"></div>
                            <label class="col-md-2 control-label text-right">转换字符位置:</label>

                            <div class="col-md-2">
                                <input type="number" name="convertChrIndex"
                                       class="form-control input-sm"
                                       value="${entity.convertChrIndex}"></div>
                        </div>
                    </div>

                    <legend>
                        <label class="control-label">
                            <h5>
                                <input type="checkbox" name="composite"
                                       value="true">复合指标</h5>
                        </label>
                    </legend>
                    <div class="form-group" id="compositeElConf"
                         style="display: none;">
                        <div class="col-md-1"></div>
                        <div class="col-md-4">
                            <div>
                                所有指标
                                <button type="button"
                                        class="btn btn-xs btn-success pull-right"
                                        onclick="freshElement();">
                                    <span class="fa fa-refresh"></span>
                                </button>
                            </div>
                            <select name="elements" multiple
                                    class="form-control" size="6"></select>
                        </div>
                        <div class="col-sm-1 text-center"
                             style="margin-top:60px;">
                            <button type="button" class="btn btn-xs btn-primary"
                                    onclick="fromMulSelect2Textarea('elements','complexExp')">
                                <span class="fa fa-angle-double-right"></span>
                            </button>
                        </div>
                        <div class="col-md-6">
                            <div>新指标表达式</div>
                            <textarea rows="5" class="form-control"
                                      id="complexExp"
                                      name="complexExp">${entity.complexExp}</textarea>

                            <div class="btn-group btn-group-sm" role="group"
                                 id="expressionBtnGroup">
                                <button type="button" class="btn btn-xs">+
                                </button>
                                <button type="button" class="btn btn-xs">-
                                </button>
                                <button type="button" class="btn btn-xs">*
                                </button>
                                <button type="button" class="btn btn-xs">/
                                </button>
                                <button type="button" class="btn btn-xs">(
                                </button>
                                <button type="button" class="btn btn-xs">)
                                </button>
                            </div>
                            <button type="button"
                                    class="btn btn-xs btn-warning pull-right"
                                    onclick="clearTextarea('complexExp');">清空
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </fieldset>
        <jsp:include page="../form-action.jsp"/>
    </form>
</div>
</body>
</html>
<style type="text/css">
    .param-list {
        overflow: auto;
        margin-left: 15px;
        border: solid 1px #c0c0c0;
        border-radius: 2px;
        height: 130px;
        padding: 0;
    }

    .param-list table {
        margin-top: 0px;
        padding: 0;
        border: none;
    }
</style>
<script type="text/javascript">
    var logConf = {};
    $(function () {
        if ('${entity.elementType}') {
            $('input[name="elementType"][value="${entity.elementType}"]').prop('checked', true);
        }

        $.getJSON('${pageContext.request.contextPath}/ds/logsource', function (data) {
            $.each(data, function () {
                var logId = this["id"];
                logConf[logId] = [];
                if ('${entity.logSource}' == logId) {
                    $('select[name="logSource"]').append('<option value="' + this["id"] + '" selected>' + this['name'] + '</option>');
                } else {
                    $('select[name="logSource"]').append('<option value="' + this["id"] + '">' + this['name'] + '</option>');
                }

                $.each(this['cols'], function () {
                    var key = this['name'], selected = '';
                    if ('${entity.family}' == key) {
                        selected = 'selected';
                    }
                    var option = '<option value="' + this["name"] + '" ' + selected + '>' + this['name'] + '</option>';
                    logConf[logId].push(option);
                    logConf[logId][key] = [];
                    if (!$.isEmptyObject(this['searchFamily'])) {
                        var inputStr = '<input name="searchCol" id="searchCol" class="form-control input-sm" value="${entity.searchCol}">';
                        logConf[logId][key] = inputStr;
                    } else if (!$.isEmptyObject(this['subCols'])) {
                        var select = '<select name="searchCol" id="searchCol" class="form-control">';
                        $.each(this['subCols'], function () {
                            selected = '';
                            if ('${entity.searchCol}' == this["family"] + ':' + this["name"]) {
                                selected = 'selected';
                            }
                            select += '<option value="' + this["family"] + ':' + this["name"] + '"' + selected + '>' + this['name'] + '</option>';
                        });
                        select += '</select>';
                        logConf[logId][key].push(select);
                    }
                });
            });

            getFamily($('select[name="logSource"]').val());
            if ('${entity.searchCol}') {
                var root = $('select[name="logSource"]').val(), fam = $('select[name="family"]').val();
                $('#queryTag').html(logConf[root][fam]);
                $('#queryLabel').show();
                $('#searchCol').attr('required', 'required');
            }
            <%--if('${entity.idxs}') {--%>
            <%--var elementType = $('input[name="elementType"]:checked').val()--%>
            <%--resolveIdxsToTable(elementType, JSON.parse('${entity.idxs}'));--%>
            <%--}--%>
        });

        $('input[name="elementType"]').on('change', function () {
            generateIndexParams();
        });

        $('select[name="logSource"]').on('change', function () {
            getFamily($(this).val());
        });

        $('#vid').on('change', function () {
            $(this).attr('disabled', 'disabled');
        });

        $('select[name="family"]').on('change', function () {
            var root = $('select[name="logSource"]').val();
            if ($.isEmptyObject(logConf[root][$(this).val()])) {
                $('#queryLabel').hide();
                $('#queryLabel').find('select,input').html('');
                return;
            }
            $('#queryTag').html(logConf[root][$(this).val()]);
            $('#queryLabel').show();
            $('#searchCol').attr('required', 'required');
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
            } else {
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
            } else {
                $('#compositeElConf').hide();
                $('#compositeElConf').find('textarea,select').attr('disabled', true);
            }
        });

        expTypeChange('${entity.expType}');

        $('select[name="expType"]').change(function () {
            expTypeChange($(this).val());
        });

        $('#expressionBtnGroup button').on('click', function () {
            $('#complexExp').insertContent($(this).html());
        });
    });


    function getFamily(sid) {
        if (!sid) {
            $('select[name="family"]').html('<option value="">请选择基础字段</option>');
            return;
        }
        ;
        var html = '<option value="">请选基础字段</option>' + logConf[sid].toString();
        $('select[name="family"]').html(html);
        $('#queryLabel').hide();
        $('#queryLabel').find('select,input').html('');
    }

    function getVids() {
        var sid = $('select[name="logSource"]').val();
        $.getJSON('${pageContext.request.contextPath}/ds/vids', {sid: sid}, function (vids) {
            for (var key in vids) {
                $('#vid').append('<option value=' + key + '>' + vids[key] + '</option>');
            }
            ;
        });
    }

    function expTypeChange(stats) {
        if (stats == 'F') {
            $('#fixedPortion').show();
            $('#expressRegular').hide();
            $('input[name="fixedPortion"]').removeAttr('disabled');
            $('input[name="expressRegular"]').attr('disabled', true);
        } else if (stats == 'R') {
            $('#fixedPortion').hide();
            $('#expressRegular').show();
            $('input[name="expressRegular"]').removeAttr('disabled');
            $('input[name="fixedPortion"]').attr('disabled', true);
        } else {
            $('input[name="fixedPortion"]').attr('disabled', true);
            $('input[name="expressRegular"]').attr('disabled', true);
            $('#fixedPortion').hide();
            $('#expressRegular').hide();
        }
    }

    /**
     * [showTargetInputGroup description]
     * @param  {[type]} target [description]
     * @return {[type]}        [description]
     */
    function showTargetInputGroup(target) {
        $.each($('form').find('.form-conf-group'), function () {
            if ($(this).attr('id') == target) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    /**
     * 添加数据到表格
     */
    function addParamToTable() {
        var logSource = $('select[name="logSource"]').val(),
                family = $('select[name="family"]').val();
        if ($.isEmptyObject(logSource) || $.isEmptyObject(family)) {
            return;
        }

        var tr = '<tr><td>' + family + '</td>', obj = {};
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
        var vid = $('#vid').val();
        tr += '<td>' + vid + '</td>';
        tr += '<td><button type="button" onclick="removeRow(this)" class="btn btn-xs btn-warning"><span class="fa fa-remove"></span></button></td></tr>';

        $('#param-grid').append(tr);

        generateIndexParams();
    }

    /**
     * 删除行数据
     * @param  {[type]} obj
     */
    function removeRow(obj) {
        $(obj).parents('tr').remove();
        generateIndexParams();
    }

    /**
     * 生成指标参数
     * @return {[type]} [description]
     */
    function generateIndexParams() {
        var len = $('#param-grid').find('tr').length;
        if (len <= 0) return;
        $('#idxs').val($('#param-grid').getIndexParamJSON());
        console.log($('#idxs').val());
    }

    /**
     * [getIndexParamJSON description]
     * @return {[type]} [description]
     */
    $.fn.getIndexParamJSON = function () {
        var obj = {}, vid;
        var len = $(this).find('tr').length;
        for (var i = 0; i < len; i++) {
            var tr = $(this).find('tr')[i];
            var td = $(tr).find('td'), family = $(td[0]).html(),
                    family = $(td[1]).html(), queryTag = $(td[2]).html();
            vid = $(td[3]).html();
            var field;
            if (queryTag) {
                field = queryTag;
            } else {
                field = family;
            }

            if (obj[family]) {
                if ($.inArray(field, obj[family]) < 0) {
                    obj[family].push(field);
                }
            } else {
                obj[family] = [field];
            }
        }

        var fams = [];
        for (var key in obj) {
            var tmp = [];
            for (var i = 0; i < obj[key].length; i++) {
                tmp.push([key, obj[key][i]]);
            }
            fams.push(tmp);
        }

        var params = {};
        params['sid'] = $('select[name="logSource"]').val();
        params['vid'] = vid;
        params['cols'] = obj;
        params['fams'] = fams;

        return JSON.stringify(params);
    }

    /**
     * 普通/简单的指标
     * @return {[type]}     JSON数据
     */
    $.fn.generalIndexJSON = function () {
        var obj = {}, cols = {};
        var len = $(this).find('tr').length;
        for (var i = 0; i < len; i++) {
            var tr = $(this).find('tr')[i];
            var td = $(tr).find('td'), family = $(td[0]).html(),
                    family = $(td[1]).html(), queryTag = $(td[2]).html();
            var field;
            if (queryTag) {
                field = queryTag;
            } else {
                field = family;
            }

            if (cols[family]) {
                if ($.inArray(field, cols[family]) < 0) {
                    cols[family].push(field);
                }
            } else {
                cols[family] = [field];
            }
        }
        obj['sid'] = $('select[name="logSource"]').val();
        obj['col'] = cols;
        return JSON.stringify(obj);
    }

    /**
     * 访次相关的可自由组合计算指标
     * @return {[type]}     JSON数据
     */
    $.fn.visitIndexJSON = function () {
        var cols = {}, fields = {};
        var len = $(this).find('tr').length;
        for (var i = 0; i < len; i++) {
            var tr = $(this).find('tr')[i], td = $(tr).find('td');
            var family = $(td[0]).html(), family = $(td[1]).html(),
                    queryTag = $(td[2]).html(), vid = $(td[3]).html();
            var field;
            if (queryTag) {
                field = queryTag;
            } else {
                field = family;
            }

            if (cols[vid]) {
                if (cols[vid][family]) {
                    cols[vid][family].push(field);
                } else {
                    cols[vid][family] = [field];
                }
            } else {
                var tmp = {};
                tmp[family] = [field];
                cols[vid] = tmp;
            }
        }

        var indexArr = [];
        for (var key in cols) {
            var tmp = [];
            tmp.push($('select[name="logSource"]').val());
            tmp.push(key);
            tmp.push(cols[key]);
            for (var fk in cols[key]) {
                var f = [];
                for (var i = 0; i < cols[key][fk].length; i++) {
                    var p = [];
                    p.push(fk);
                    p.push(cols[key][fk][i]);
                    f.push(p);
                }
                tmp.push([f]);
            }
            indexArr.push(tmp);
        }
        ;
        return JSON.stringify(indexArr);
        // console.log(JSON.stringify(indexArr));
    }

    /**
     * 解析指标到表格
     * @param  {[type]} indexJson [description]
     * @return {[type]}           [description]
     */
    function resolveIdxsToTable(idxType, indexJson) {
        var html = '', sid = '';
        if (idxType == 'D') {
            sid = indexJson['sid'];
            var familys = indexJson['col'];
            for (var key in familys) {
                for (var j = 0; j < familys[key].length; j++) {
                    html += '<tr>\n';
                    html += '\t<td>' + familys[key][j] + '</td>\n';
                    html += '\t<td>' + key + '</td>\n';
                    html += '\t<td>' + familys[key][j] + '</td>\n';
                    html += '\t<td></td>\n';
                    html += '\t<td><button type="button" onclick="removeRow(this)" class="btn btn-xs btn-warning"><span class="fa fa-remove"></span></button></td>\n';
                    html += '</tr>\n';
                }
            }
        } else {
            for (var i = 0; i < indexJson.length; i++) {
                var arr = indexJson[i];
                sid = arr[0];
                for (var key in arr[2]) {
                    for (var j = 0; j < arr[2][key].length; j++) {
                        html += '<tr>\n';
                        html += '\t<td>' + arr[2][key][j] + '</td>\n';
                        html += '\t<td>' + key + '</td>\n';
                        html += '\t<td>' + arr[2][key][j] + '</td>\n';
                        html += '\t<td>' + arr[1] + '</td>\n';
                        html += '\t<td><button type="button" onclick="removeRow(this)" class="btn btn-xs btn-warning"><span class="fa fa-remove"></span></button></td>\n';
                        html += '</tr>\n';
                    }
                }
            }
        }

        $('select[name="logSource"]').val(sid);
        $('select[name="family"]').html(logConf[sid].toString());
        getVids();
        $('select[name="logSource"]').attr('disabled', 'disabled');
        $('#param-grid').html(html);
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
