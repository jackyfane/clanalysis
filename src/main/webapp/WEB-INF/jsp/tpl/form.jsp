<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/asset/css/jquery-ui-1.9.2.custom.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/asset/css/pick-a-color-1.2.3.min.css">

    <%--Highchart插件 --%>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/asset/highcharts/highcharts.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/asset/highcharts/highcharts-more.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/asset/highcharts/highcharts-3d.js"></script>

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/asset/js/tinycolor.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/asset/js/pick-a-color-1.2.3.min.js"></script>

    <%--自定义图表工具JS --%>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/asset/js/reportContainer.class.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/asset/js/reportElement.class.js"></script>
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
        <li class="active">模板配置</li>
    </div>
</div>
<div class="container-fluid">
    <form id="defaultForm" data-toggle="validator" class="form-horizontal"
          action="${action}" method="post">
        <%-- 私有隐藏域 --%>
        <div>
            <input type="hidden" name="chartConfig" id="chartConfig"/>
        </div>
        <fieldset>
            <legend>
                <h4>
                    <span class="fa fa-database fa-lg"></span>
                    基本配置
                </h4>
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
                                   required></div>
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
                            <label for="title">标题：</label>
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
            <jsp:include page="form_advance.jsp"/>
            <jsp:include page="../form-action.jsp"/>
        </fieldset>
    </form>
</div>
</body>
</html>
<style type="text/css">
    .chart-layout {
        float: left;
    }

    .chart-setting {
        width: 400px;
        float: right;
    }

    .config-tabs li {
        font-weight: bold;
    }

    .canvas {
        overflow: auto;

        position: relative;

    }

    #canvas-content {
        margin: 0 auto;
    }

    .chart-conf {
        border: solid 1px #e0e0e0;
        border-top: 0;
        -moz-border-radius-topleft: 0;
        -moz-border-radius-topright: 0;

        border-radius: 4px;
    }

    .chart-title {
        height: 32px;
        border-bottom: solid 1px #c0c0c0;
        background-color: #f4f4f4;
        line-height: 30px;
        padding-left: 5px;
        cursor: pointer;
    }

    .content-conf {
        overflow: auto;
        height: 300px;
        display: none;
        border-left: solid 1px #c0c0c0;
        border-right: solid 1px #c0c0c0;
        border-bottom: solid 1px #c0c0c0;
    }

    .chart-type-img {
        padding: 10px;
    }

    .chart-type-img img {
        padding: 3px;
        border: 1px solid #e0e0e0;
        border-radius: 4px;
    }

    .Y-Pointer {
        overflow: auto;
        height: 120px;
        border: solid 1px #c0c0c0;
    }

    .Y-Pointer div {
        padding-left: 8px;
    }

    .Y-Pointer div label {
        margin-left: 20px;
    }

    .chart {
        width: 480px;
        height: 320px;
        position: absolute;
        margin: 3px;
        cursor: pointer;
    }

    .chart-border:hover {
        border: dotted 1px #e1e8ed;

    }

    .contentBox {
        border: 0px solid #000;
        overflow: hidden;
    }

    #toolsBox {
        display: none;
    }

    .chart:hover #toolsBox {
        display: block;
    }

    .split-line {
        background: #e4b9c0;
        height: 1px;
        width: 100%;
        position: absolute;
        cursor: pointer;
    }

    .box-set {
        float: left;
    }

    .tab-content {
        max-height: 735px;
    }

    .bs-glyphicons-list {
        list-style: none;
        padding: 5px;
        margin: 0;
        height: 655px;
        overflow: auto;
        overflow-x: hidden;
    }

    .bs-glyphicons-list li {
        display: inline;
        font-size: 50px;
        padding: 0;
        margin: 0;
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
    }
    //当前选中的容器
    var targetChart = null;
    //当选现在的对象
    var elObject = null;
    //报表中的对象列表
    var reportObject = [];
    // 维度
    var reportDIndex = [];
    // 指标
    var reportSIndex = [];
    $(function () {
        $.getJSON('${pageContext.request.contextPath}/report/get-all', function (data) {
            var optHtml = '';
            $.each(data, function (i) {
                var id = this.id, dIndexOpts = '', sIndexOpts = '';
                optHtml += '<option value="' + this.id + '">' + this.name + '</option>\n';

                $.each(this.dimension, function () {
                    dIndexOpts += '<option value="' + this.id + '">' + this.name + '</option>\n';
                    // $('#yindex-modal-list').append('<tr><td><input type="checkbox" value="'+this.id+'"></td><td>'+this.name+'</td>');
                });

                $.each(this.statistical, function () {
                    var name = '';
                    if (this == 'PV') {
                        name = '浏览量';
                    } else if (this == 'UV') {
                        name = '用户量';
                    } else if (this == 'VT') {
                        name = '访问量';
                    }
                    sIndexOpts += '<option value="' + this + '">' + name + '</option>\n';
                    $('#yindex-modal-list').append('<tr><td><input type="checkbox" value="' + this + '"></td><td>' + name + '</td>');
                });

                if (i == 0) {
                    $("#chartElement").html(dIndexOpts);
                    var opt = $("#chartElement").find("option:selected");
                    var cxTarget = '<option value="">请选择</option>';
                    cxTarget += '<option value="' + $(opt).val() + '">' + $(opt).text() + '</option>';
                    $('#chartXTarget').html(cxTarget);
                    $('#tableElement').html(dIndexOpts);
                    $("#textElement").html(dIndexOpts);

//                    $('#textTarget').html(sIndexOpts);
                }
                reportDIndex.push({'id': id, 'html': dIndexOpts});
                reportSIndex.push({'id': id, 'html': sIndexOpts});
            });

            $('#chartReport, #tableReport, #textReport').html(optHtml);
        });

        // #tableReport
        $('#chartReport,#tableReport,#textReport').on('change', function () {
            var report = $(this).val(), dIdxOpts = '';
            for (var i = 0; i < reportDIndex.length; i++) {
                if (reportDIndex[i].id == report) {
                    dIdxOpts = reportDIndex[i].html;
                    break;
                }
            }

            var objId = $(this).attr('id'), element;
            if ('chartReport' == objId) {
                $("#chartElement").html(dIdxOpts);
                var opt = $("#chartElement").find("option:selected");
                var cxTarget = '<option value="">请选择</option>';
                cxTarget += '<option value="' + $(opt).val() + '">' + $(opt).text() + '</option>';
                $('#chartXTarget').html(cxTarget);
                element = $('#chartElement').val();

                elObject.config.xTarget = $('#chartXTarget').val();
            } else if ('tableReport' == objId) {
                $('#tableElement').html(dIndexOpts);
                element = $('#tableElement').val();
            } else if ('textReport' == objId) {
                $('#textElement').html(dIndexOpts);
                element = $('#textElement').val();
            }
            elObject.config.report = report;
            elObject.config.element = element;
        });

        $("#chartElement, #tableElement, #textElement").on('change', function () {

            if ($(this).attr('id') == 'chartElement') {
                var opt = $("#chartElement").find("option:selected");
                var cxTarget = '<option value="">请选择</option>';
                cxTarget += '<option value="' + $(opt).val() + '">' + $(opt).text() + '</option>';
                $('#chartXTarget').html(cxTarget);
                elObject.config.xTarget = $('#chartXTarget').val();
            }

            elObject.config.element = $(this).val();
        });

        $('#chartXTarget').on('change', function () {
            elObject.config.xTarget = $(this).val();
        });

        $('#textTarget').on('change', function () {
            elObject.config.target = $(this).val();
        });

        //点击空白取消当前选中
        $(".canvas").on("click", function () {
            $(targetChart).css("border", "");
            $(targetChart).addClass("chart-border");
            if ($(targetChart).attr("type") == "text") {
                $(targetChart).draggable("enable");
                $(".contentBox").blur();
            }
            targetChart = null;
            elObject = null;

        })

        //颜色选择
        $(".pick-a-color").pickAColor({
            showSpectrum: true,
            showSavedColors: true,
            saveColorsPerElement: true,
            fadeMenuToggle: true,
            showAdvanced: false,
            showBasicColors: true,
            showHexInput: true,
            allowBlank: false,
            inlineDropdown: false
        });
        //提示框
        $('[data-toggle="tooltip"]').tooltip()


        $('.chart-layout').css("width", $(document).width() - $('.chart-setting').width() - 100);
        var canvasWidth = Math.round($(document).width() * 0.7), canvasHeight = Math.round($(document).height()) - 300;
        canvasHeight = 700;
        $('#canvasWidth').val(canvasWidth);
        $('#canvasHeight').val(canvasHeight);

        //初始化报表大小
        $('.canvas-content').css('width', canvasWidth).css('height', canvasHeight);
        //画布最小高度
        $('.canvas').css('height', canvasHeight + 10);

        //设置报表宽度
        $('#canvasWidth').on('input propertychange', function () {
            $('.canvas-content').css('width', $('#canvasWidth').val());
        });
        //设置报表高度
        $('#canvasHeight').on('input propertychange', function () {
            $('.canvas-content').css('height', $('#canvasHeight').val());
        });
        //设置报表背景颜色
        $('#setBackground').on('change', function () {
            $('#canvas-content').css('background', "#" + $(this).val());
        });

        //设置对象背景颜色
        $("#objBgColor").on('change', function () {
            if (!elObject) {
                return;
            }
            elObject.bgColor = $(this).val();
            $("#" + elObject.id).css("background", "#" + $(this).val());

        })

        //设置对象的边框尺寸
        $("#borderSize").on('change', function () {
            if (!elObject) {
                return;
            }
            elObject.border = $(this).val();
            $("#" + elObject.id).css("border-width", elObject.border + "px");

        })

        //设置对象的边框颜色
        $("#borderColor").on('change', function () {
            if (!elObject) {
                return;
            }
            elObject.borderColor = $(this).val();
            $("#" + elObject.id).css("border-color", "#" + elObject.borderColor);
        })

        //表格设置事件绑定
        $("#tableReport").on('change', function () {
            if (!elObject || elObject.type != "table") {
                return;
            }
            elObject.config.report = $(this).val();
        })

        $("#tableFormat").on('change', function () {
            if (!elObject || elObject.type != "table") {
                return;
            }
            elObject.config.format = $(this).val();
            $("#" + elObject.id).html(createTable($("#tableRow").val(), $(this).val()))
        })

        $("#tableCount").on('change', function () {
            if (!elObject || elObject.type != "table") {
                return;
            }
            elObject.config.count = $(this).val();
        })
        $("#tableRow").on('change', function () {
            if (!elObject || elObject.type != "table") {
                return;
            }
            elObject.config.row = $(this).val();
            $("#" + elObject.id).html(createTable($(this).val(), $("#tableFormat").val()))
        })

        //文本
        $("#textReport").on('change', function () {
            if (!elObject || elObject.type != "text") {
                return;
            }
            elObject.config.report = $(this).val();
        })

        $("#textFormat").on('click', function () {
            if (!elObject || elObject.type != "text") {
                return;
            }
            elObject.report = $(this).is(':checked') ? $(this).val() : 0;
        })

        $("#textTarget").on('change', function () {
            if (!elObject || elObject.type != "text") {
                return;
            }
            elObject.target = $(this).val();
            $("#" + elObject.id).html("指标:" + $(this).val())
        })


        //文本按钮事件绑定
        $.each($("#execCommandBotton button"), function () {
            $(this).on("click", function () {

                if (!elObject) {
                    return;
                }

                var type = $(this).val();
                switch (type) {
                    case 'bold':
                        if ($("#" + elObject.id).css("font-weight") != "bold") {
                            $("#" + elObject.id).css("font-weight", "bold");
                        } else {
                            $("#" + elObject.id).css("font-weight", "normal");
                        }

                        break;
                    case 'italic':
                        if ($("#" + elObject.id).css("font-style") != "italic") {
                            $("#" + elObject.id).css("font-style", "italic");
                        } else {
                            $("#" + elObject.id).css("font-style", "normal");
                        }
                        break;
                    case 'underline':
                        if ($("#" + elObject.id).css("text-decoration") != "underline") {
                            $("#" + elObject.id).css("text-decoration", "underline");
                        } else {
                            $("#" + elObject.id).css("text-decoration", "none");
                        }
                        break;
                }
            })
        });

        //字体大小事件绑定
        $("#fontSizeSelect").on("change", function () {
            if ($(targetChart).attr('type') != 'ico' && elObject) {
                $("#" + elObject.id).css("font-size", $(this).val());
            }

        })

        //字体选择绑定
        $("#fontSelect").on("change", function () {
            if ($(targetChart).attr('type') != 'ico' && elObject) {
                var reg = new RegExp("!", "g");
                var font = $(this).val().replace(reg, "'");
                reg = new RegExp("&", "g");
                font = font.replace(reg, ",");
                $("#" + elObject.id).css("font-family", font);
            }
        })

        $("#fontColor").on("change", function () {
            if (!elObject) {
                return;
            }
            $("#" + elObject.id).css("color", "#" + $(this).val());
        })

        //图表拖动面板事件绑定
        $.each($(".chart-botton"), function () {

            var type = $(this).attr('type');
            if (type == 'ico') {
                var subtype = $(this).attr('class').replace("glyphicon chart-botton ", "")
            } else {
                var subtype = $(this).attr('subtype');
            }

            $(this)[0].ondragstart = function (event) {
                event.dataTransfer.setData('subtype', subtype);
                event.dataTransfer.setData('type', type);
            };
        });

        $('.canvas-content')[0].ondrop = function (event) {
            event.preventDefault();//阻止默认行为
            //console.log({X: event.offsetX, Y:event.offsetY});
            var subtype = event.dataTransfer.getData('subtype'), seq = 1;
            var type = event.dataTransfer.getData('type');
            if (!type) {
                return;
            }

            $.each($('.canvas-content').children('div.chart'), function () {
                var subtypeID = $($(this).find('.contentBox')[0]).attr('id');
                var _subtype = subtypeID.substring(0, subtypeID.lastIndexOf('-'));
                if (_subtype == subtype) {
                    seq = new Number(subtypeID.substring(subtypeID.lastIndexOf('-') + 1)) + 1;
                }
            });
            var id = subtype + '-' + seq;
            var Container = new ClanalysisContainer(id, event.offsetX, event.offsetY, 0, 0, type, subtype);
            saveSettings();
        };


        $('.canvas-content')[0].ondragover = function (event) {
            event.preventDefault();
        }

        $('.canvas-content')[0].ondragenter = function (event) {
        }

        $('.canvas-content')[0].ondragleave = function (event) {

        }

        $('.canvas-content')[0].ondragend = function (event) {

        }

        //对图表配置参数绑定实时输入事件
        $('#chartC').find('input, select').bind('input propertychange', function () {

            if ($(targetChart).attr("type") == 'chart') {
                targetChart = $($($(targetChart).find('.contentBox')[0])).highcharts();
            }
            // console.log(targetChart);
            if (targetChart) {
                //获取图表对象
                var val = $(this).val();

                switch ($(this).attr('name')) {
                    case 'title':
                        var title = {
                            text: val
                        };
                        targetChart.setTitle(title);
                        elObject.config.title = val;
                        break;
                    case 'subtitle':
                        var subtitle = {
                            text: val
                        }
                        targetChart.setTitle(null, subtitle);
                        elObject.config.subTitle = val;
                        break;
                    case 'xAxis':
                        targetChart.xAxis[0].setTitle({
                            text: val
                        });
                        elObject.config.xAxis = val;
                        break;
                    case 'yAxis':
                        targetChart.yAxis[0].setTitle({
                            text: val
                        });
                        elObject.config.yAxis = val;
                        break;
                    case 'yAxis-s':
                        //targetChart.yAxis[1].setTitle({
                        //  text: val
                        // });
                        break;
                }
            }
        });

        $('#Y-Pointer').on('change', function () {
            elObject.config.yTarget = getYIndexConfig();
        });

        $('.chart-layout,.chart-setting').find('input,select').on('change', function () {
            saveSettings();
        });

        if ('${entity.chartConfig}') {
            var jsonObject = JSON.parse('${entity.chartConfig}');
            analysisTemplate(jsonObject, false);
            $('input[name="chartConfig"]').val('${entity.chartConfig}');
        }
    });

    function setCoordinate() {
        var coordinate = '';
        $(".coordinate").each(function () {
            coordinate += $(this).val() + ","
        });
        if (!elObject) {
            return;
        }
        elObject.config.coordinate = coordinate;
    }

    function configItemCollapse(item) {
        $('#' + item).toggle()
        var height = $('.chart-conf').height();
        $('.canvas').css('height', height);
    }

    function saveSettings() {
        var jsonObject = {
            "width": $("#canvasWidth").val(),
            "height": $("#canvasHeight").val(),
            "backGround": $("#setBackground").val(),
            "element": []
        }
        $.each($('.contentBox'), function () {
            var id = $(this).attr("id");
            var elObj = reportObject[id];
            var temp = {
                "id": elObj.id,
                "type": elObj.type,
                "subType": elObj.subType,
                "top": elObj.top,
                "left": elObj.left,
                "height": elObj.height,
                "width": elObj.width,
                "style": $(this).attr("style"),
                "config": elObj.config
            }
            if (elObj.type == 'text' || elObj.type == 'ico') {
                temp.config.html = $(this).html();
            }
            jsonObject.element.push(temp);
        });
        if (jsonObject.element.length <= 0) {
            $('input[name="chartConfig"]').val('');
            return;
        }
        //console.log(JSON.stringify(jsonObject));
        $('input[name="chartConfig"]').val(JSON.stringify(jsonObject));

    }

    function loadReportTemplate() {
        $.getJSON("http://127.0.0.1:8080/php/index.php?act=get", function (result) {
            analysisTemplate(result, false);
        });
    }

    function choosedIndex(dialog) {
        var trs = '';
        $.each($('#yindex-modal-list').find('input[type="checkbox"]:checked'), function () {
            var id = $(this).val(), textTd = $(this).parents('tr').find('td')[1].innerHTML;
            trs += '<tr><td>' + textTd + '</td><td class="checkbox"><label><input type="checkbox" value="' + id + '">次坐标</label></td>' +
                    '<td><a href="javascript:void(0);" onclick="removeRow(this)">删除</a></td></tr>';
        });
        $('#Y-Pointer > table').append(trs);
        $('#' + dialog).modal('hide');
        elObject.config.yTarget = getYIndexConfig();
        saveSettings();
    }

    /**
     * 删除行
     * @param  {[type]} obj
     */
    function removeRow(obj) {
        $(obj).parents('tr').remove();
        elObject.config.yTarget = getYIndexConfig();
        saveSettings();
    }

    /**
     * 载入数据
     * @param yTarget
     */
    function loadYTarget(yTarget) {
        var trs = '';
        $.each(yTarget, function () {
            var id = this.id, checked = '';
            //alert(this.secondAxis);
            if (this.secondAxis) {
                checked = 'checked';
            }
            trs += '<tr><td>' + this.text + '</td>' +
                    '<td class="checkbox"><label>' +
                    '<input type="checkbox" value="' + id + '" ' + checked + '>次坐标</label></td>' +
                    '<td><a href="javascript:void(0);" onclick="removeRow(this)">删除</a></td>' +
                    '</tr>';
        });
        $('#Y-Pointer > table').html(trs);
    }
</script>
