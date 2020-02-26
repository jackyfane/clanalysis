<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <jsp:include page="../js.plugin.jsp" flush="false"/>
    <link rel="stylesheet"
          href="${uripath}/asset/datatables/css/dataTables.bootstrap.min.css"/>
    <script type="text/javascript"
            src="${uripath}/asset/datatables/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript"
            src="${uripath}/asset/datatables/js/dataTables.bootstrap.min.js"></script>
    <%--Highchart插件 --%>
    <script type="text/javascript"
            src="${uripath}/asset/highcharts/highcharts.js"></script>
    <script type="text/javascript"
            src="${uripath}/asset/highcharts/highcharts-more.js"></script>
    <script type="text/javascript"
            src="${uripath}/asset/highcharts/highcharts-3d.js"></script>
    <script type="text/javascript"
            src="${uripath}/asset/highcharts/modules/exporting.js"></script>

    <%--自定义图表工具JS --%>
    <script type="text/javascript"
            src="${uripath}/asset/js/reportContainer.class.js"></script>
    <script type="text/javascript"
            src="${uripath}/asset/js/reportElement.class.js"></script>
    <script type="text/javascript"
            src="${uripath}/asset/laydate/laydate.js"></script>
    <style type="text/css">
        .container-fluid {
            text-align: center;
        }

        .canvas {
            /*overflow: auto;*/
            position: relative;
        }

        .chart {
            position: absolute;
        }

        .project-breadcrumb {
            list-style: none;
            background: none;
            margin: 0;
            padding: 0;
        }

        .report-navbar {
            float: right;
        }

        .report-navbar div {
            margin: 0;
            padding: 0;
        }

        input, label, ul, li {
            padding: 0;
            margin: 0;
        }

        .form-control {
            height: 24px;
            padding: 0;
        }

        .description {
            padding: 10px;
            border-bottom: 1px solid #e1e8ed;
            margin: 10px;
            color: #777;
        }
    </style>
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
    <div class="panel-heading navbar-fixed-top">
        <div class="report-navbar">
            <div class="form-inline text-center">
                <div class="form-group checkbox">
                    <label for="template">模板：</label>
                    <select class="form-control"
                            name="template" id="template">
                        <option value="">请选择模板</option>
                    </select>
                </div>
                <div class="form-group checkbox">
                    <label for="startTime">开始时间：</label>
                    <input
                            class="form-control laydate-icon" name="startTime"
                            id="startTime"></div>
                <div class="form-group checkbox">
                    <label for="endTime">结束时间：</label>
                    <input
                            class="form-control laydate-icon" name="endTime"
                            id="endTime"></div>
                <div class="form-group checkbox">
                    <label for="group">分组：</label>
                    <select class="form-control"
                            name="group" id="group">
                        <option value="">请选择分组</option>
                        <option value="10">按时</option>
                        <option value="6">按天</option>
                        <option value="3">按周</option>
                        <option value="2">按月</option>
                        <option value="4">按季度</option>
                        <option value="5">按半年</option>
                        <option value="1">按年</option>
                    </select>
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-xs btn-info"
                            onclick="inputChangeListener();">
                        <span class="fa fa-search"></span>
                    </button>
                </div>
                <div class="form-group">
                    <div class="dropdown">
                        <a id="dLabel" data-target="#" href="#"
                           data-toggle="dropdown" role="button"
                           aria-haspopup="true"
                           aria-expanded="false">
                            <span class="fa fa-download"></span>
                            导出
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="dLabel">
                            <li>
                                <a href="javascript:void(0);"
                                   onclick="exportDocument('pdf');">
                                        <span
                                                class="fa fa-file-pdf-o"></span>
                                    pdf
                                </a>
                            </li>
                            <!-- <li role="presentation" class="divider"></li>
                            <li>
                                <a href="#">
                                    <span class="fa fa-file-word-o"></span>
                                    word
                                </a>
                            </li>
                            <li role="presentation" class="divider"></li>
                            <li>
                                <a href="#">
                                    <span class="fa fa-file-excel-o"></span>
                                    excel
                                </a>
                            </li>
                            <li role="presentation" class="divider"></li>
                            <li>
                                <a href="#">
                                    <span class="fa fa-file-powerpoint-o"></span>
                                    PPT
                                </a>
                            </li> -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <ul class="project-breadcrumb breadcrumb">
            <li>
                <a href="#">项目</a>
            </li>
            <li class="active">
                <a href="javascript:void(0);">${entity.name} - 报告</a>
            </li>
        </ul>
    </div>
</div>

<div class="container" id="report-document">
    <div class="row text-center">
        <div>
            <h2 id="title">${entity.name}</h2>
        </div>
        <div id="subTitle" class="description">${entity.description}</div>
    </div>
    <div class="canvas">
        <div class="canvas-content" id="canvas-content"></div>
    </div>
</div>

<div style="display: none">
    <form id="exportForm" target="_blank"
          action="${uripath}/reportExportServlet" method="post">
        <input type="hidden" name="docType" id="docType">
        <input type="hidden" name="element" id="element">
        <input type="hidden" name="html" id="chartHtml"></form>
</div>
</body>
</html>
<script type="text/javascript">
    var temp_tpl = '', elConfig;

    $(function () {
        laydate({
            elem: '#startTime',
            istime: true,
            format: 'YYYY-MM-DD hh:mm:ss',
            choose: inputChangeListener
        });

        laydate({
            elem: '#endTime',
            istime: true,
            format: 'YYYY-MM-DD hh:mm:ss',
            choose: inputChangeListener
        });

        <c:forEach items="${entity.templates}" var="template">
        var id = '${template.id}', name = '${template.name}';
        $('#template').append('<option value=' + id + '>' + name + '</option>');
        </c:forEach>

        $.each($('.report-navbar').find('input,select'), function () {
            $(this).on('change', inputChangeListener);
        });
    });

    /**
     * [loadDataByChange description]
     * @return {[type]} [description]
     */

    function inputChangeListener() {
        var tpl = $('#template').val(), startTime = $('#startTime').val(),
                endTime = $('#endTime').val(), g = $('#group').val();

        <c:forEach items="${entity.templates}" var="template">
        var tpl_id = $('#template').val();
        var config;
        if ('${template.id}' == tpl_id) {
            config = JSON.parse('${template.chartConfig}');
        }
        </c:forEach>

        if (!temp_tpl || temp_tpl != tpl_id) {
            analysisTemplate(config, true);
            temp_tpl = tpl_id;
            elConfig = config.element;
        }
        $('.canvas-content').css('height', new Number(config.height));

        if (!(startTime && endTime)) {
            return;
        }

        var s = new Date(startTime), e = new Date(endTime);
        if (s.getTime() > e.getTime()) {
            failureAlert('开始时间不能大于结束时间！');
            return;
        }
        if (!tpl || !g) return;

        if (g) {
            loadDataForChart(startTime, endTime, tpl, config, g);
        }
    }

    /**
     * 设置参数
     * @param {[type]} config [description]
     * @param {[type]} param  [description]
     */
    function loadDataForChart(startTime, endTime, template, config, group) {
        // console.log(JSON.stringify(config));
        $.each(config.element, function () {
            var targetId = this.id;
            var param = {}
            param.type = this.type;
            if (!this.subType) {
                var id = this.id;
                param.subType = id.substring(0, id.lastIndexOf('-'));
            } else {
                param.subType = this.subType;
            }
            if (param.type == 'text' && param.subType != 'auto') {
                return;
            }
            param.template = template;
            param.element = this.config.element;
            param.report = this.config.report;
            param.xAxis = this.config.xTarget;
            if (!param.xAxis) {
                param.xAxis = '';
            }
            if (param.type == 'text') {
                var id = this.config.target, text;
                if (id == "PV") {
                    text = "浏览量";
                } else if (id == "UV") {
                    text = "用户量";
                } else if (id == "VT") {
                    text = "访问量";
                }
                var obj = {'id': id, 'text': text};
                param.yAxis = [obj];
            } else {
                param.yAxis = this.config.yTarget;
            }
            if (!param.yAxis) {
                param.yAxis = [];
            }

            param.total = this.config.count;
            if (!param.total) {
                param.total = 0;
            }
            param.row = this.config.row;
            if (!param.row) {
                param.row = 0;
            }

            //X坐标不指定指标的图表以时间分片作为X轴，除了饼图和雷达图以为，其他图标必须指定yAxis,即y坐标
            if (this.type == 'chart' && $.isEmptyObject(param.xAxis) && param.subType != 'pie' && param.subType != 'polar') {
                $.getJSON('${uripath}/project/timestamp', {
                    startTime: startTime,
                    endTime: endTime,
                    calendarType: group
                }, function (timestamp) {
                    param.timestamp = timestamp;
                    getDataForChart(targetId, param);
                });
            } else {
                var start = new Number(startTime.replace(/-|\s|:/g, '')),
                        end = new Number(endTime.replace(/-|\s|:/g, ''));
                var times = [start, end];
                param.timestamp = [times];
                getDataForChart(targetId, param);
            }
        });
    }

    /**
     * 调用获取后台数据
     * @param  {[type]} chartId [description]
     * @param  {[type]} param   [description]
     * @return {[type]}         [description]
     */
    function getDataForChart(chartId, param) {
        $.ajax({
            type: 'post',
            url: '${uripath}/viewReport/view',
            data: JSON.stringify(param),
            contentType: "application/json",
            dataType: 'json',
            success: function (result) {
                if (param.type == 'table') {
                    var tabHtml = '', thead = '<thead>', tbody = '<tbody>';
                    for (var i = 0; i < result.rows.length; i++) {
                        var row = result.rows[i];
                        if (i == 0) {
                            thead += '<tr class="row">';
                            for (var j = 0; j < row.length; j++) {
                                thead += '<th>' + row[j] + '</th>';
                            }
                            thead += '</tr>';
                        } else {
                            tbody += '<tr class="row">';
                            for (var j = 0; j < row.length; j++) {
                                tbody += '<td>' + row[j] + '</td>';
                            }
                            tbody += '</tr>';
                        }
                    }
                    thead += '</thead>';
                    tbody += '</tbody>';
                    tabHtml = thead + tbody;
                    var targetTable = $('#' + chartId).find('table')[0];
                    $(targetTable).addClass('table-striped table-bordered table-condensed');
                    $(targetTable).html(tabHtml);
                    buildDataTables(result.size, targetTable);
                } else if (param.type == 'chart') {
                    var highChart = $('#' + chartId).highcharts();
                    var options = highChart.options;
                    if (!result.status) {
                        Highcharts.setOptions({
                            lang: {
                                loading: result.message
                            }
                        });
                        var chart = new Highcharts.Chart(options);
                        chart.showLoading();
                        return;
                    }
                    if (result.categories) {
                        options.xAxis[0].categories = result.categories;
                        delete options.xAxis[0].type;
                        delete options.xAxis[0].dateTimeLabelFormats;
                    } else {
                        delete options.xAxis[0].categories;
                    }
                    options.series = result.series;
                    var chart = new Highcharts.Chart(options);
                } else {
                    $('#' + chartId).addClass('text-danger');
                    $('#' + chartId).html('<h3><span class="bg-success">' + result[0].total + '</span></h3>');
                }
            }
        });
    }

    /**
     * 创建表格
     * @param  {[type]} rows     [description]
     * @param  {[type]} tableObj [description]
     * @return {[type]}          [description]
     */
    function buildDataTables(rows, tableObj) {
        var oTable1 = $(tableObj).dataTable({
            "bFilter": true, /*用搜索栏*/
            "iDisplayLength": rows, /*默认显示长度*/
            "aLengthMenu": [[10, 15, 20, 30, 50, -1], [10, 15, 20, 30, 50, "All"]], /*可选长度*/
            "bStateSave": true, /*记录cookie(记的东西太多了，不太建议用)*/
            "oLanguage": {
                "sSearch": "搜索：",
                "sLengthMenu": "每页显示 _MENU_ 行",
                "sZeroRecords": "<center><i class='fa fa-warning fa-2x'></i> 抱歉， 没有匹配结果！</center>",
                "sInfoEmpty": "没有数据",
                "sInfo": "当前显示 _START_ ～ _END_ 条，共 _TOTAL_ 条记录",
                "sInfoEmpty": "当前显示 0 ～ 0 条，共 0 条记录",
                "sInfoFiltered": "(从 _MAX_ 条记录中搜索)",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                }
            },
            "bAutoWidth": false
        });
    }

    /**
     * [exportDocument description]
     * @param  {[type]} docType [description]
     * @return {[type]}         [description]
     */
    function exportDocument(doctype) {

        var docElement = {};
        docElement.docName = $('#template').find("option:selected").text();
        docElement.title = $('#title').text();
        docElement.subTitle = $('#subTitle').text();
        docElement.width = $('#report-document').width();
        docElement.height = $('#report-document').height();
        docElement.elements = [];

        var chartsHtml = '';
        $.each(elConfig, function (index) {
            var obj = {};
            obj.type = this.type;
            obj.left = this.left;
            obj.top = this.top;
            obj.width = this.width;
            obj.height = this.height;

            var currentNode = document.getElementById(this.id),
                    parentNode = currentNode.parentNode,
                    childNode = currentNode.childNodes;

            var cls = '', style = '';
            if (childNode[0].attributes) {
                $(childNode[0]).css('height', this.height).css('width', this.width);
                if (childNode[0].attributes["class"]) {
                    cls = childNode[0].attributes["class"].value;
                }
                if (childNode[0].attributes["style"]) {
                    style = childNode[0].attributes["style"].value;
                }
            }

            chartsHtml += '<div class="' + parentNode.attributes["class"].value + '" style="' + parentNode.attributes["style"].value + '">';
            chartsHtml += '<div class="' + currentNode.attributes["class"].value + '" style="' + currentNode.attributes["style"].value + '">';
            if (this.type == "chart") {
                obj.svg = $('#' + this.id).highcharts().getSVG({
                    chart: {
                        width: this.width,
                        height: this.height
                    }
                });
                chartsHtml += '<div class="' + cls + '" style="' + style + '">';
                chartsHtml += 'img_path_' + index;
                chartsHtml += '</div>';
            } else if (this.type == "table") {
                chartsHtml += '<table class="' + cls + '" style="text-align:center; ' + style + ' table-layout:fixed; word-break:break-strict; height:' + this.height + 'px; width:' + this.width + 'px;">';
                chartsHtml += childNode[0].innerHTML;
                chartsHtml += '</table>';
                obj.svg = 'no';
            } else {
                chartsHtml += currentNode.innerHTML;
                obj.svg = 'no';
            }
            chartsHtml += '</div>';
            chartsHtml += '</div>';
            docElement.elements.push(obj);
        });

        docElement.html = createHtml(chartsHtml, docElement.width);

        $('#element').val(JSON.stringify(docElement));
        $('#docType').val(doctype);
        $("#exportForm").submit();
        return false;
    }

    function createHtml(chartsHtml, width) {
        var charts = $('.chart-border'), $lastElement = $(charts[charts.length - 1]);
        var top = $lastElement.css('top'), height = $lastElement.height(),
                pageHeight = new Number(top.substring(0, top.length - 2)) + new Number(height),
                pageWidth = new Number(width) + 200;
        //设置页面最小为A4纸
        pageHeight = pageHeight < 1123 ? 1123 : pageHeight;
        pageWidth = pageWidth < 794 ? 794 : pageWidth;

        var reportHtml = '<!DOCTYPE html><html lang="en">';
        reportHtml += '<head><meta charset="UTF-8"/>';
        //reportHtml += '<link rel="stylesheet" type="text/css" href="bootstrap_css_path"/>';
        reportHtml += '<link rel="stylesheet" type="text/css" href="report_css_path"/>';
        reportHtml += '<style type="text/css">@page{size:' + pageWidth + 'px ' + pageHeight + 'px}</style>';
        reportHtml += '</head>';
        reportHtml += '<body style="font-family:\'Arial Unicode MS\'">';
        reportHtml += '<div class="container" id="report-document">' +
                '<div class="row text-center"><div><h2 id="title">${entity.name}</h2></div>' +
                '<div id="subTitle" class="description">${entity.description}</div></div>' +
                '<div class="canvas"><div class="canvas-content" id="canvas-content">' + chartsHtml;
        reportHtml += '</div></div></div></body></html>';
        return reportHtml;
    }

    // function svg2img(svg){
    //     var canvas = document.createElement('canvas');
    //     canvg(canvas, svg);
    //     return canvas.toDataURL("image/png");
    // }


    // //以下是jspdf将页面导出为PDF导出pdf
    // function exportAsPDF(){
    //     //得到要导出pdf的html根节点

    //     // var chartCenter = document.getElementById("chart-center").outerHTML;

    //     var reportHtml = '<!DOCTYPE html>';
    //         reportHtml += '<html lang="en">';
    //         reportHtml += '<head>';
    //         reportHtml += '<link rel="stylesheet" type="text/css" href="${uripath}/asset/css/bootstrap.min.css"/>';
    //         reportHtml += '<link rel="stylesheet" type="text/css" href="${uripath}/asset/css/report.css"/>';
    //         reportHtml += '</head>';
    //         reportHtml += '<body>';
    //         reportHtml += document.getElementById("report-document").outerHTML;
    //         reportHtml += '</body></html>';

    //     var fbody = openWithIframe(reportHtml);
    //     svg2canvas(fbody);

    //     //html2canvas官网的标准方法
    //     html2canvas(fbody, {
    //         onrendered: function(canvas) {
    //             var myImage = canvas.toDataURL("image/png");
    //             // window.open(myImage);

    //             // canvas.toBlob(function(blob) {
    //             //     saveAs(blob, "report.png");
    //             // }, "image/png");
    //             //l:横向， p：纵向
    //             // var doc = new jsPDF('l', 'pt', 'a3');
    //             var width = $('#report-document').width(),height = $('#report-document').height();
    //             var doc = new jsPDF('p', 'pt', [width, height]);//默认是A4，由于我的报表比较大，所以专门设置了尺寸。
    //             doc.setFontSize(22);
    //             doc.setFontType("bolditalic");
    //             // doc.text(500, 30, "Ticket Report");  //x:500, y:30

    //             doc.addImage(myImage, 'PNG', 0, 0);  //写入位置：x:10, y:60

    //             doc.addPage();    //新建一页

    //             //这里就是把将table写入到pdf里面。
    //             var tables = document.getElementsByTagName("table");
    //             for(var i=0;i< tables.length;i++){
    //                 var res = doc.autoTableHtmlToJson(tables[i], true);
    //                 doc.autoTable(res.columns, res.data);
    //             }

    //             doc.save('ticket.report_'+new Date().getTime()+'.pdf');
    //             $('#myFrmame').remove(); //最后将iframe删除
    //         },
    //         background:"#fff",  //这里给生成的图片默认背景，不然的话，如果你的html根节点没有设置背景的话，会用黑色填充。
    //         allowTaint: true    //避免一些不识别的图片干扰，默认为false，遇到不识别的图片干扰则会停止处理html2canvas
    //     });

    // };

    // //将指定节点下面的所有svg转换成canvas
    // //这里需要:canvg.js
    // function svg2canvas (targetElem) {
    //     var nodesToRecover = [];
    //     var nodesToRemove = [];

    //     var svgElem = targetElem.find('svg');
    //     svgElem.each(function(index, node) {
    //         var parentNode = node.parentNode;
    //         var svg = node.outerHTML;
    //         var canvas = document.createElement('canvas');

    //         canvg(canvas, svg);

    //         nodesToRecover.push({
    //             parent: parentNode,
    //             child: node
    //         });
    //         parentNode.removeChild(node);

    //         nodesToRemove.push({
    //             parent: parentNode,
    //             child: canvas
    //         });

    //         parentNode.appendChild(canvas);
    //     });
    // }

    // //这里是将html(文本)在一个iframe里面打开
    // //主要是排除其它元素的干扰导致不成功，之前是一直输出不成功，所示才使用iframe
    // //这段代码是官网抠下来的。
    // //还有个问题就是：如果将页面的chart转换成canvas了，那web页面报表动态变化的功能将丢失。
    // function openWithIframe(html){

    //     var iframe = document.createElement('iframe');
    //     iframe.setAttribute("id", "myFrmame");

    //     var $iframe = $(iframe);
    //     $iframe.css({
    //       'visibility': 'hidden', 'position':'static', 'z-index':'4'
    //     }).width($(window).width()).height($(window).height());

    //     $('body').append(iframe);

    //     var ifDoc = iframe.contentWindow.document;

    //     ifDoc.open();
    //     ifDoc.write(html);
    //     ifDoc.close();

    //     var fbody = $iframe.contents().find("body");
    //     console.log(fbody);
    //     return fbody;
    // }

</script>
