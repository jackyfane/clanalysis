<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../js.plugin.jsp" flush="false"/>
<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li><a href="#">项目</a></li>
        <li class="active">模板信息</li>
    </div>
</div>
<div class="container-fluid">
    <form id="defaultForm" data-toggle="validator" class="form-horizontal"
          action="${action}" method="post">
        <div id="base_conf" class="form-conf-group">
            <fieldset>
                <legend><h5>基本配置</h5></legend>
                <jsp:include page="../item-base-form.jsp"/>
                <jsp:include page="../visual_user_form.jsp"/>
                <jsp:include page="../edit_by_creator.jsp"/>
                <div class="form-group modal-footer">
                    <a href="#" type="button" class="btn btn-sm btn-warning"
                       onclick="reloadPage();">取消</a>
                    <button type="button" class="btn btn-sm btn-primary"
                            onclick="showTargetInputGroup('advance_conf')">下一步
                    </button>
                </div>
            </fieldset>
        </div>
        <div id="advance_conf" class="form-conf-group"
             style="margin-bottom: 0; display: none;">
            <jsp:include page="form_advance.jsp"/>
        </div>
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
        height: 80px;
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

    $(function () {

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
    });

    $("#chartReport").on("change", function () {
        elObject.config.report = $(this).val();

    })

    $("#chartAddX").on("click", function () {
        var val = $("#chartTarget  option:selected").val();
        $("#chartXTarget").val(val);
        if (!elObject) {
            return;
        }
        elObject.config.xTarget = val;
    })

    $("#chartAddY").on("click", function () {
        var val = "";
        var html = "";
        $("#chartTarget option:selected").each(function () {
            val += $(this).val() + ",";
            html += '<div class="checkbox">' + $(this).val()
                    + '<label>'
                    + '<input type="checkbox" name="coordinate" value="' + $(this).val() + '"  onclick="setCoordinate()" class="coordinate"/>次坐标'
                    + '</label>'
                    + '</div>'
        });

        $("#Y-Pointer").html(html);
        if (!elObject) {
            return;
        }
        elObject.config.yTarget = val;
        elObject.config.coordinate = '';
    })


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


    function save() {


        var jsonObject = {
            "width": $("#canvasWidth").val(),
            "height": $("#canvasHeight").val(),
            "backGround": $("#setBackground").val(),
            "name": $("#name").val(),
            "category": $("#category").val(),
            "description": $("#description").val(),
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

        $("#debug").text(JSON.stringify(jsonObject));

        $.post("http://127.0.0.1:8080/php/index.php", {content: JSON.stringify(jsonObject)}, function (res) {
            alert("保存成功");
        })
    }

    function loadReportTemplate() {
        $.getJSON("http://127.0.0.1:8080/php/index.php?act=get", function (result) {
            analysisTemplate(result);
        });
    }

    //解析模板
    function analysisTemplate(t) {

        $("#canvasWidth").val(t.width)
        $("#canvasHeight").val(t.height)
        $('.canvas-content').css('width', t.width).css('height', t.height);
        $("#setBackground").val(t.backGround)
        $("#name").val(t.name);
        $("#category").val(t.category);
        $("#description").val(t.description);
        $("#canvas-content").html('');

        targetChart = null;
        elObject = null;
        reportObject = [];


        var el = t.element;
        var l = el.length;
        var temp = [];
        for (var i = 0; i < l; i++) {
            temp = el[i];
            new ClanalysisContainer(temp.id, temp.left, temp.top, temp.width, temp.height, temp.type, temp.subtype, temp);
        }
    }

</script>