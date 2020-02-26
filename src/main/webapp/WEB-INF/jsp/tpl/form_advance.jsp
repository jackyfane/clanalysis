<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<legend><h4><span class="fa fa-pie-chart fa-lg"></span> 图表配置</h4></legend>
<div class="container-fluid">
    <div class="chart-layout">
        <div class="panel panel-default">
            <div class="panel-heading">
                <!--模板头-->
                <div class="box-set">
                    <div class="btn-group" role="group">
                        <div class="btn-group" role="group">
                            <button type="button"
                                    class="btn btn-default dropdown-toggle  btn-lg"
                                    data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                <span class="fa fa-square-o"
                                      aria-hidden="true"></span>
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu"
                                style="width: 120px; padding: 10px;">
                                <li>
                                    <div class="input-group">
                                        <input type="number"
                                               class="form-control input-sm"
                                               id="borderSize"
                                               data-toggle="tooltip"
                                               data-placement="top"
                                               title="边框尺寸"/><span
                                            class="input-group-addon">PX</span>
                                    </div>
                                </li>
                                <li role="separator" class="divider"></li>
                                <li>
                                    <input type="text"
                                           class="pick-a-color form-control input-sm"
                                           id="borderColor"
                                           data-toggle="tooltip"
                                           data-placement="top" title="边框颜色">
                                </li>
                                <li role="separator" class="divider"></li>
                                <li>
                                    <input type="text"
                                           class="pick-a-color form-control input-sm"
                                           id="objBgColor" data-toggle="tooltip"
                                           data-placement="top" title="背景颜色">
                                </li>
                            </ul>
                        </div>

                        <div class="btn-group " role="group"
                             id="execCommandBotton">
                            <button type="button"
                                    class="btn  btn-default btn-lg"
                                    value="bold"><span
                                    class="fa fa-bold"></span>
                            </button>
                            <button type="button"
                                    class="btn  btn-default btn-lg"
                                    value="italic"><span
                                    class="fa fa-italic"></span>
                            </button>
                            <button type="button"
                                    class="btn  btn-default btn-lg"
                                    value="underline"><span
                                    class="fa fa-underline"></span>
                            </button>
                        </div>

                        <button type="button" class="btn  btn-default btn-lg "
                                style="padding: 7px;">
                            <select class="form-control input-sm"
                                    id="fontSelect" style="margin: 0;">
                                <option value="宋体" style="font-family: 宋体;">宋体
                                </option>
                                <option value="!Microsoft YaHei!&微软雅黑&黑体"
                                        style="font-family: 'Microsoft YaHei',微软雅黑, 黑体;">
                                    微软雅黑
                                </option>
                                <option value="楷体" style="font-family: 楷体">楷体
                                </option>
                                <option value="黑体" style="font-family: 黑体">黑体
                                </option>
                                <option value="隶书" style="font-family: 隶书">隶书
                                </option>

                                <option value="andale mono"
                                        style="font-family: andale mono">andale
                                    mono
                                </option>
                                <option value="helvetica&sans-serif"
                                        style="font-family:helvetica, sans-serif">
                                    arial
                                </option>
                                <option value="!arial black!&!avant garde!"
                                        style="font-family:'arial black', 'avant garde'">
                                    arial black
                                </option>
                                <option value="!comic sans ms!"
                                        style="font-family:'comic sans ms'">
                                    comic sans ms
                                </option>
                                <option value="impact&chicago"
                                        style="font-family: impact, chicago;">
                                    impact
                                </option>
                                <option value="!times new roman!"
                                        style="font-family: 'times new roman';">
                                    roman
                                </option>

                            </select></button>
                        <button type="button" class="btn  btn-default btn-lg"
                                style="padding: 7px;">
                            <select class="form-control input-sm"
                                    id="fontSizeSelect">
                                <option value="12px">12</option>
                                <option value="14px">14</option>
                                <option value="16px">16</option>
                                <option value="18px">18</option>
                                <option value="20px">20</option>
                                <option value="22px">22</option>
                                <option value="24px">24</option>
                                <option value="36px">36</option>
                                <option value="48px">48</option>
                                <option value="72px">72</option>
                            </select>
                        </button>
                        <button type="button" class="btn  btn-default btn-lg"
                                style="padding: 7px; width: 150px;">
                            <input type="text"
                                   class="pick-a-color form-control input-sm"
                                   id="fontColor">
                        </button>
                    </div>
                </div>

                <div class="dropdown" style="float: right;">
                    <button id="dLabel" type="button"
                            class="btn btn-default dropdown-toggle "
                            data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false">
                        报表属性 <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dLabel"
                        style="width: 270px;">
                        <li>
                            <div class="form-inline">
                                <label class="radio-inline">报告尺寸(PX)：
                                    <input id="canvasWidth" name="canvasWidth"
                                           type="text"
                                           class="form-control input-sm"
                                           size="2" value="640"/> x
                                    <input id="canvasHeight" name="canvasHeight"
                                           type="text"
                                           class="form-control input-sm"
                                           size="2" value="600"/>
                                </label>
                            </div>
                            <br/>

                            <div class="row">
                                <div class="col-md-5 text-right checkbox">
                                    背景颜色：
                                </div>
                                <div class="col-md-6">
                                    <input type="text"
                                           class="pick-a-color form-control input-sm"
                                           id="setBackground" value="fff">
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>

                <!--模板头END-->
                <div style="clear: both;"></div>
            </div>
            <div class="panel-body canvas">
                <div class="canvas-content" id="canvas-content"></div>
            </div>
        </div>
    </div>
    <div class="chart-setting">
        <ul class="nav nav-tabs config-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#chartC"
                                                      aria-controls="home"
                                                      role="tab"
                                                      data-toggle="tab">图表</a>
            </li>
            <li role="presentation"><a href="#tableC" aria-controls="profile"
                                       role="tab" data-toggle="tab">表格</a>
            </li>
            <li role="presentation"><a href="#textC" aria-controls="messages"
                                       role="tab" data-toggle="tab">文本</a>
            </li>
            <li role="presentation"><a href="#icoC" aria-controls="messages"
                                       role="tab" data-toggle="tab">图标</a>
            </li>
        </ul>
        <div class="chart-conf">
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="chartC">
                    <!--图表配置开始-->
                    <div class="form-inline chart-type-img">
                        <img src="${pageContext.request.contextPath}/images/line.png"
                             alt="折线图"
                             type="chart" subtype="line" draggable="true"
                             class="chart-botton"/>
                        <img src="${pageContext.request.contextPath}/images/pie.png"
                             alt="饼图"
                             type="chart" subtype="pie" draggable="true"
                             class="chart-botton"/>
                        <img src="${pageContext.request.contextPath}/images/bar.png"
                             alt="条形图"
                             type="chart" subtype="bar" draggable="true"
                             class="chart-botton"/>
                        <img src="${pageContext.request.contextPath}/images/column.png"
                             alt="柱状图"
                             type="chart" subtype="column" draggable="true"
                             class="chart-botton"/>
                        <img src="${pageContext.request.contextPath}/images/area.png"
                             alt="区域图"
                             type="chart" subtype="area" draggable="true"
                             class="chart-botton"/>
                        <img src="${pageContext.request.contextPath}/images/polar.png"
                             alt="雷达图"
                             type="chart" subtype="polar" draggable="true"
                             class="chart-botton"/>
                        <img src="${pageContext.request.contextPath}/images/scatter.png"
                             alt="散列图"
                             type="chart" subtype="scatter" draggable="true"
                             class="chart-botton"/>

                    </div>
                    <div class="form-group"></div>
                    <div class="form-group">
                        <div class="col-md-4 checkbox text-right">
                            <label>报告：</label>
                        </div>
                        <div class="col-md-6">
                            <select class="form-control input-sm"
                                    id="chartReport"></select>
                        </div>
                    </div>
                    <%--
                    <div class="form-group">
                        <div class="col-md-3 checkbox">
                            <label>指标:</label>
                        </div>
                        <div class="col-md-7">
                            <select multiple class="form-control"
                                    id="chartTarget">
                                <option value="日期">日期</option>
                                <option value="页面流量">页面流量</option>
                                <option value="访次">访次</option>
                                <option value="访客">访客</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-6 text-center">
                            <button type="button" class="btn btn-xs"
                                    id="chartAddX"><span
                                    class="fa fa-angle-double-down"
                                    style="cursor: pointer;"></span>

                            </button>
                        </div>
                        <div class="col-md-6">
                            <button type="button" class="btn btn-xs"
                                    id="chartAddY"><span
                                    class="fa fa-angle-double-down"
                                    style="cursor: pointer;"></span>

                            </button>
                        </div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="col-md-5">
                            <div>x轴：</div>
                            <input type="text" name="axis_x" class="form-control input-sm" id="chartXTarget"
                            value="" />
                        </div>
                        <div class="col-md-7">
                            <div>y轴：</div>
                            <div class="Y-Pointer" id='Y-Pointer'>

                            </div>
                        </div>
                    </div>
                    --%>
                    <div class="form-group">
                        <div class="col-md-4 text-right checkbox">
                            <label>计算指标：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="chartElement" id="chartElement"
                                    class="form-control input-sm">
                                <option value="" selected="selected">请选择指标
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group pieNone">
                        <div class="col-md-4 text-right checkbox">
                            <label>X坐标轴：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="chartXTarget" id="chartXTarget"
                                    class="form-control input-sm"></select>
                        </div>
                    </div>
                    <div class="form-group pieNone">
                        <div class="col-md-4 text-right checkbox">
                            <label>Y坐标轴：</label>
                        </div>
                        <div class="col-md-6">
                            <div class="Y-Pointer" id='Y-Pointer'>
                                <table class="table table-striped table-condensed"
                                       style="padding:0px;margin:0px;"></table>
                            </div>
                        </div>
                        <div class="col-md-1 text-left">
                            <button type="button" class="btn btn-xs btn-info"
                                    data-toggle="modal"
                                    data-target="#yTargetIndexDialog">指标</span>
                            </button>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-4 text-right  checkbox">
                            <label>图表样式：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="" class="form-control input-sm">
                                <option value="">样式一</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-4 text-right checkbox">
                            <label>图表主标题：</label>
                        </div>
                        <div class="col-md-6">
                            <input name="title" type="text"
                                   class="form-control input-sm"
                                   id="chartTitle"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-4 text-right  checkbox">
                            <label>图表副标题：</label>
                        </div>
                        <div class="col-md-6">
                            <input name="subtitle" type="text"
                                   class="form-control input-sm"
                                   id="chartSubTitle"/>
                        </div>
                    </div>
                    <div class="form-group pieNone">
                        <div class="col-md-4 text-right  checkbox">
                            <label>X轴标签：</label>
                        </div>
                        <div class="col-md-6">
                            <input name="xAxis" type="text"
                                   class="form-control input-sm"
                                   id="chartXAxis"/>
                        </div>
                    </div>
                    <div class="form-group pieNone">
                        <div class="col-md-4 text-right  checkbox">
                            <label>Y轴标签：</label>
                        </div>
                        <div class="col-md-6">
                            <input name="yAxis" type="text"
                                   class="form-control input-sm"
                                   id="chartYAxis"/>
                        </div>
                    </div>
                    <!--图表结束-->
                </div>
                <div role="tabpanel" class="tab-pane" id="tableC">
                    <!--表格开始-->
                    <div class="form-group" style="padding-top: 5px;">
                        <div class="col-md-2" style="margin-left: 15px;">
                        <span class="glyphicon glyphicon-th chart-botton"
                              aria-hidden="true"
                              subtype="table" type="table" draggable="true"
                              style="font-size: 22px;"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-5 text-right  checkbox">
                            <label for="tableReport">选择报告：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="" class="form-control input-sm"
                                    id="tableReport">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-5 text-right  checkbox">
                            <label for="tableElement">计算指标：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="tableElement"
                                    class="form-control input-sm"
                                    id="tableElement">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-5 text-right  checkbox">
                            <label>图表样式：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="" class="form-control input-sm"
                                    id="tableFormat">
                                <option value="table">无边框表格</option>
                                <option value="table table-striped">无边框+条纹状
                                </option>
                                <option value="table table-hover">无边框+鼠标响应
                                </option>
                                <option value="table table-bordered">有边框表格
                                </option>
                                <option value="table table-bordered table-striped">
                                    有边框表格+条纹状
                                </option>
                                <option value="table table-bordered table-hover">
                                    有边框表格+鼠标响应
                                </option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-5 text-right  checkbox">
                            <label>表格行总数：</label>
                        </div>
                        <div class="col-md-6">
                            <input type="number" class="form-control input-sm"
                                   id="tableCount" value="10"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-5 text-right  checkbox">
                            <label>每页显示行数：</label>
                        </div>
                        <div class="col-md-6">
                            <input type="number" class="form-control input-sm"
                                   id="tableRow" value="5"/>
                        </div>
                    </div>

                    <!--表格结束-->
                </div>
                <div role="tabpanel" class="tab-pane" id="textC">
                    <!--文本开始-->
                    <div class="form-group" style="padding-top: 5px;">
                        <div class="col-md-4 text-center">	<span
                                class="fa fa-pencil-square-o chart-botton"
                                aria-hidden="true"
                                subtype="edit" type="text" draggable="true"
                                style="font-size: 22px;" data-toggle="tooltip"
                                data-placement="bottom" title="可编辑文本"></span>
                            <span class="glyphicon glyphicon-th-list chart-botton"
                                  aria-hidden="true"
                                  subtype="list" type="text" draggable="true"
                                  style="font-size: 22px;" data-toggle="tooltip"
                                  data-placement="bottom" title="可编辑列表"></span>
                             <span class="glyphicon glyphicon-font chart-botton"
                                   aria-hidden="true"
                                   subtype="auto" type="text" draggable="true"
                                   style="font-size: 22px;"
                                   data-toggle="tooltip" data-placement="bottom"
                                   title="报表指标"></span>

                        </div>
                        <div class="col-md-3 ">
                            <label class="control-label">数值样式：</label>
                        </div>
                        <div class="col-md-4 checkbox ">
                            <input type="checkbox" id="textFormat" value="1"/>数值
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-5 text-right  checkbox">
                            <label>报告：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="" class="form-control input-sm"
                                    id="textReport"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-5 text-right  checkbox">
                            <label>计算指标：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="textElement" id="textElement"
                                    class="form-control input-sm"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-5 text-right  checkbox">
                            <label>显示指标：</label>
                        </div>
                        <div class="col-md-6">
                            <select name="textTarget" id="textTarget"
                                    class="form-control input-sm">
                                <option value="PV">浏览量</option>
                                <option value="UV">用户量</option>
                                <option value="VT">访客量</option>
                            </select>
                        </div>
                    </div>


                    <!--文本结束-->
                </div>
                <div role="tabpanel" class="tab-pane" id="icoC">

                    <ul class="bs-glyphicons-list">
                        <li> <span
                                class="glyphicon chart-botton glyphicon-asterisk"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-plus"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-euro"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-eur"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-minus"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-cloud"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-envelope"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-pencil"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-glass"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-music"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-search"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-heart"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-star"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-star-empty"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-user"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-film"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-th-large"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-th"
                                   aria-hidden="true" draggable="true"
                                   type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-th-list"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-ok"
                                   aria-hidden="true" draggable="true"
                                   type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-remove"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-zoom-in"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-zoom-out"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-off"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-signal"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-cog"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-trash"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-home"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-file"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-time"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-road"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-download-alt"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-download"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-upload"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-inbox"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-play-circle"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-repeat"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-refresh"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-list-alt"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-lock"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-flag"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-headphones"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-volume-off"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-volume-down"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-volume-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-qrcode"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-barcode"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-tag"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-tags"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-book"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-bookmark"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-print"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-camera"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-font"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-bold"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-italic"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-text-height"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-text-width"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-align-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-align-center"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-align-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-align-justify"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-list"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-indent-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-indent-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-facetime-video"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-picture"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-map-marker"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-adjust"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-tint"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-edit"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-share"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-check"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-move"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-step-backward"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-fast-backward"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-backward"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-play"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-pause"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-stop"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-forward"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-fast-forward"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-step-forward"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-eject"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-chevron-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-chevron-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-plus-sign"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-minus-sign"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-remove-sign"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-ok-sign"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-question-sign"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-info-sign"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-screenshot"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-remove-circle"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-ok-circle"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-ban-circle"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-arrow-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-arrow-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-arrow-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-arrow-down"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-share-alt"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-resize-full"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-resize-small"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-exclamation-sign"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-gift"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-leaf"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-fire"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-eye-open"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-eye-close"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-warning-sign"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-plane"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-calendar"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-random"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-comment"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-magnet"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-chevron-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-chevron-down"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-retweet"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-shopping-cart"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-folder-close"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-folder-open"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-resize-vertical"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-resize-horizontal"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-hdd"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-bullhorn"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-bell"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-certificate"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-thumbs-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-thumbs-down"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-hand-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-hand-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-hand-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-hand-down"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-circle-arrow-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-circle-arrow-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-circle-arrow-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-circle-arrow-down"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-globe"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-wrench"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-tasks"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-filter"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-briefcase"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-fullscreen"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-dashboard"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-paperclip"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-heart-empty"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-link"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-phone"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-pushpin"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-usd"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-gbp"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-sort"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sort-by-alphabet"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sort-by-alphabet-alt"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sort-by-order"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sort-by-order-alt"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sort-by-attributes"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sort-by-attributes-alt"
                                aria-hidden="true" draggable="true"
                                type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-unchecked"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-expand"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-collapse-down"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-collapse-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-log-in"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-flash"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-log-out"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-new-window"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-record"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-save"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-open"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-saved"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-import"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-export"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-send"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-floppy-disk"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-floppy-saved"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-floppy-remove"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-floppy-save"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-floppy-open"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-credit-card"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-transfer"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-cutlery"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-header"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-compressed"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-earphone"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-phone-alt"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-tower"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-stats"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sd-video"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-hd-video"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-subtitles"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sound-stereo"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sound-dolby"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sound-5-1"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sound-6-1"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sound-7-1"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-copyright-mark"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-registration-mark"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-cloud-download"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-cloud-upload"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-tree-conifer"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-tree-deciduous"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-cd"
                                   aria-hidden="true" draggable="true"
                                   type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-save-file"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-open-file"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-level-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-copy"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-paste"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-alert"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-equalizer"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-king"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-queen"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-pawn"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-bishop"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-knight"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-baby-formula"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-tent"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-blackboard"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-bed"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-apple"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-erase"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-hourglass"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-lamp"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-duplicate"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-piggy-bank"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-scissors"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-bitcoin"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-btc"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-xbt"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-yen"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-jpy"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-ruble"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-rub"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-scale"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-ice-lolly"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-ice-lolly-tasted"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-education"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-option-horizontal"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-option-vertical"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-menu-hamburger"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-modal-window"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span class="glyphicon chart-botton glyphicon-oil"
                                   aria-hidden="true"
                                   draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-grain"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-sunglasses"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-text-size"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-text-color"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-text-background"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-object-align-top"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-object-align-bottom"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-object-align-horizontal"
                                aria-hidden="true" draggable="true"
                                type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-object-align-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-object-align-vertical"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-object-align-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-triangle-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-triangle-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-triangle-bottom"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-triangle-top"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-console"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-superscript"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-subscript"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-menu-left"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-menu-right"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-menu-down"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>

                        </li>
                        <li> <span
                                class="glyphicon chart-botton glyphicon-menu-up"
                                aria-hidden="true"
                                draggable="true" type="ico"></span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="yTargetIndexDialog" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-mission="modal"
                        aira-label="Close"><span aria-hidden="true"></span>
                </button>
                <h4 class="modal-title">指标</h4>
            </div>
            <div class="modal-body">
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th>
                            <label><input type="checkbox" id="checkall"/>
                                全选</label>
                        </th>
                        <th>指标名称</th>
                    </tr>
                    </thead>
                    <tbody id="yindex-modal-list"></tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-default"
                        data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-sm btn-primary"
                        onclick="choosedIndex('yTargetIndexDialog');">确定
                </button>
            </div>
        </div>
    </div>
</div>
<%--
<div class="form-group modal-footer" style="margin: 10px 0;">
    <button type="button" class="btn btn-sm btn-primary"
            onclick="loadReportTemplate();">载入测试
    </button>
    <button type="button" class="btn btn-sm btn-primary" onclick="save();">保存
    </button>
    <button type="button" class="btn btn-sm btn-warning"
            onclick="reloadPage();">取消
    </button>
    <button type="button" class="btn btn-sm btn-primary"
            onclick="showTargetInputGroup('base_conf')">上一步
    </button>
    <button type="submit" class="btn btn-sm btn-primary">提交</button>
</div>
--%>
