/**
 * 元素容器类
 * @param id
 * @constructor
 */
var ClanalysisContainer = function (id, left, top, width, height, type, subtype, data, isReport) {

    this.box = null;
    this.id = id;
    this.left = left < 0 ? 0 : left;
    this.top = top < 0 ? 0 : top;
    this.height = height == 0 ? 320 : height;
    this.width = width == 0 ? 480 : width;
    this.type = type;
    this.subType = subtype;
    this.border = 0;
    this.data = data ? data : false;
    this.config = data ? data.config : {};
    this.isReport = isReport;
    this.createEl();
};

/**
 *创建图表节点元素
 */
ClanalysisContainer.prototype.createEl = function () {
    var divStr = '';
    if (!this.isReport) {
        divStr = '<div class="chart chart-border" style="left:' + this.left + 'px; top:' + this.top + 'px;height:' + this.height + 'px; width:' + this.width + 'px; " type="' + this.type + '" >'
            + '<div style="position: absolute;top:0px;right: 1px; z-index:1000;width="30px" id="toolsBox" >'
            + '<span class="fa fa-minus-circle" style="cursor: pointer;" onclick="removeEl(this);"></span>'
            + '</div>'
            + '</div>';

        ////获取工具条
        //var toolsBox = $(divStr).find('#toolsBox');
        ////绑定删除事件
        //$($(toolsBox).find(".fa-remove")).on("click", removeEl(this));
    } else {
        divStr = '<div class="chart chart-border" style="left:' + this.left + 'px; top:' + this.top + 'px;height:' + this.height + 'px; width:' + this.width + 'px; " type="' + this.type + '" ></div>';
    }

    divStr = $(divStr);
    $('.canvas-content').append(divStr);
    this.box = divStr;

    //创建内容
    switch (this.type) {
        case "chart":
            reportChart(this);
            break;
        case "text":
            reportText(this);
            break;
        case "ico":
            reportIco(this);
            break;
        case "table":
            reportTable(this);
            break;
    }

    reportObject[this.id] = this;
    //绑定移动,改变大小事件
    if (!this.isReport) {
        divStr.on({
            click: this.setFocusObj,
            mousedown: this.setFocusObj
        });

        this.setPos(this.id);
        this.setFocusObj(divStr);
    }
}

ClanalysisContainer.prototype.setFocusObj = function (obj) {

    event.stopPropagation();
    $(targetChart).css("border", "");
    $(targetChart).addClass("chart-border");

    if ($(obj).attr("class") == undefined) {
        targetChart = $(this);
    } else {
        targetChart = obj
    }

    $(targetChart).removeClass("chart-border");
    $(targetChart).css("border", "#265A88 2px dotted");

    contentBox = $(targetChart).find(".contentBox");
    elObject = reportObject[$(contentBox).attr("id")];

    //显示相关设置面板
    $('a[href="#' + elObject.type + 'C"]').tab('show')
    //显示相关按钮
    if (elObject.type == 'ico') {
        $("#execCommandBotton").hide()
        $($("#fontSelect").parent()).hide()
        $($("#fontSizeSelect").parent()).hide()
    } else {
        $("#execCommandBotton").show()
        $($("#fontSelect").parent()).show()
        $($("#fontSizeSelect").parent()).show()
    }

    $("#borderSize").val(elObject.border);//边框
    $("#borderColor").val(elObject.borderColor);//边框颜色
    $("#objBgColor").val(elObject.bgColor);//背景颜色

    $("#fontColor").val($(contentBox).css("color"));
    var reg = new RegExp("'", "g");
    var font = $(contentBox).css("font-family").replace(reg, "!");
    reg = new RegExp(", ", "g");
    font = font.replace(reg, "&");
    $("#fontSelect").val(font);

    $("#fontSizeSelect").val($(contentBox).css("font-size"));

    switch (elObject.type) {
        case "chart":
            $("#chartReport").val(elObject.config.report);
            $("#chartTitle").val(elObject.config.title);
            $("#chartSubTitle").val(elObject.config.subTitle);
            $("#chartXTarget").val(elObject.config.xTarget);
            $("#chartXAxis").val(elObject.config.xAxis);
            $("#chartYAxis").val(elObject.config.yAxis);
            var html = loadYTarget(elObject.config.yTarget);
            $('#Y-Pointer').html(html);
            if (elObject.subType == "pie" || elObject.subType == "polar") {
                $(".pieNone").hide()
            } else {
                $(".pieNone").show()
            }
            break;
        case "text":
            if (elObject.config.format == '1') {
                $("#textFormat").attr("checked", 'true');
            } else {
                $("#textFormat").removeAttr("checked")
            }
            $("#textReport").val(elObject.config.report);
            $("#textTarget").val(elObject.config.target);
            $("#textElement").val(elObject.config.element);
            break;
        case "ico":
            //
            break;
        case "table":
            $("#tableReport").val(elObject.config.report);
            $("#tableFormat").val(elObject.config.format);
            $("#tableCount").val(elObject.config.count);
            $("#tableRow").val(elObject.config.row);
            break;
    }
}


/**
 * 图表事件
 */

ClanalysisContainer.prototype.setPos = function (id) {

    elObject = reportObject[this.id];
    $(elObject.box).draggable({ //1. 根据鼠标拖动，获取位置
        stop: function (event, ui) {
            var left = elObject.left = ui.position.left < 0 ? 0 : ui.position.left;
            var top = elObject.top = ui.position.top < 0 ? 0 : ui.position.top;
            $(this).css('left', left).css('top', top);
            saveSettings();
        }
    }).resizable({ //2. 根据DIV高宽变化修改图表高宽
        stop: function (event, ui) {
            elObject = reportObject[id];

            //判断是否为分割线
            var isSplitLine = false, chartDIV = elObject.box;

            if ($(this).hasClass('split-line')) {
                isSplitLine = true;
            }

            if (isSplitLine) {
                $(this).css('height', ui.size.height <= 10 ? 1 : ui.size.height)
                    .css('width', ui.size.width <= 10 ? 1 : ui.size.width);
            } else {
                //1.设置图表最小高宽or最大高宽
                var width, height;
                if ($(this).attr("type") == 'chart') {
                    width = ui.size.width < 200 ? 200 : ui.size.width,
                        height = ui.size.height < 200 ? 200 : ui.size.height;
                    var size = {width: width, height: height};
                } else if ($(this).attr("type") == 'ico') {
                    if (ui.size.width > ui.size.height) {
                        height = ui.size.width;
                        width = ui.size.width;
                    } else {
                        height = ui.size.height;
                        width = ui.size.height;
                    }
                    var size = {width: width, height: height};
                } else {
                    var size = {width: ui.size.width, height: ui.size.height};
                }

                elObject.width = size.width - elObject.border * 2;
                elObject.height = size.height - elObject.border * 2;

                $(this).css('width', size.width).css('height', size.height);
                //设置文本框大小
                if ($(this).attr("type") == 'text') {
                    $(chartDIV).find(".contentBox").css("width", size.width).css("height", size.height);
                }
                //设置图表大小
                if ($(this).attr("type") == 'chart') {
                    var chart = $("#" + elObject.id).highcharts();
                    chart.setSize(elObject.width - 2, elObject.height - 2);
                }

                if ($(this).attr("type") == 'ico') {

                    $($(chartDIV).find(".contentBox")).css("font-size", elObject.height);
                    elObject.fontSize = elObject.height;
                }
            }
            saveSettings();
        }
    });

}

/**
 * 删除节点
 */
var removeEl = function (obj) {
    var chartDIV = $(obj).parent().parent('.chart');
    var id = $($(chartDIV).find(".contentBox")).attr("id");
    swal({
        title: '告警！',
        text: "您确定要删除选定的元素吗？",
        type: "error",
        confirmButtonClass: 'btn-sm btn-danger',
        cancelButtonText: "取消",
        confirmButtonText: "确定",
        showCancelButton: true,
        cancelButtonClass: "btn-sm",
        closeOnConfirm: false,
        closeOnCancel: false
    }, function (isConfirm) {
        if (isConfirm) {
            $(chartDIV).remove();
            reportObject[id] = undefined;
            saveSettings();
            swal({
                title: "温馨提示",
                text: '删除成功',
                type: "success",
                confirmButtonClass: 'btn-success',
                confirmButtonText: '关闭'
            });
        }
        else {
            swal("温馨提示", "您取消了删除！", "info");
        }
    });
}

//解析模板
var analysisTemplate = function (tpl, isReport) {
    $("#canvasWidth").val(tpl.width)
    $("#canvasHeight").val(tpl.height)
    $('.canvas-content').css('width', tpl.width).css('height', tpl.height);
    $("#setBackground").val(tpl.backGround);
    $("#canvas-content").html('');

    targetChart = null;
    elObject = null;
    reportObject = [];

    var el = tpl.element;
    var l = el.length;
    var temp = [];
    for (var i = 0; i < l; i++) {
        temp = el[i];
        new ClanalysisContainer(temp.id, temp.left, temp.top, temp.width, temp.height, temp.type, temp.subType, temp, isReport);
    }
}
