<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <a href="#">数据源</a>
        </li>
        <li class="active">数据源信息</li>
    </div>
</div>
<div class="container">
    <form id="defaultForm" class="form-horizontal" action="${action}"
          method="post" enctype="multipart/form-data"
          data-bv-message="This value is not valid"
          data-bv-feedbackicons-valid="glyphicon glyphicon-ok"
          data-bv-feedbackicons-invalid="glyphicon glyphicon-remove"
          data-bv-feedbackicons-validating="glyphicon glyphicon-refresh">
        <fieldset>
            <legend>
                <h5>目标配置</h5>
            </legend>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label text-right">文件类型:</label>

                <div class="col-md-5">
                    <select name="fileType" class="form-control">
                        <option>-------请选择-------</option>
                        <option value="xls">Excel(98-2003)(*.xls)</option>
                        <option value="xlsx">Excel(2007~)(*.xlsx)</option>
                        <option value="txt">文本(*)</option>
                    </select>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <label class="col-md-2 control-label">导入文件:</label>

                <div class="col-md-8">
                    <input name="file" type="file" required></div>
            </div>

            <div id="excelRegion">
                <legend>
                    <h5>工作表范围界定</h5>
                </legend>
                <div class="form-group form-group-sm">
                    <label class="col-md-2 control-label">选择工作表:</label>

                    <div class="col-md-3 radio">
                        <label>
                            <input type="radio" name="sheetFlag" value="index"
                                   checked="checked">按索引</label>
                    </div>
                    <div class="col-md-2 radio">
                        <label>
                            <input type="radio" name="sheetFlag" value="sheet">按表名</label>
                    </div>
                    <div class="col-md-4 control-label">
                        <input type="text" name="sheetMode" class="form-control"
                               required></div>
                </div>
                <div class="form-group form-group-sm">
                    <label class="col-md-2 control-label">工作表范围:</label>

                    <div class="col-md-3 radio form-inline">
                        <label>
                            <input type="radio" name="region" value="notNull"
                                   checked>范围从第一个非空开始</label>
                    </div>
                    <div class="col-md-2 radio form-inline">
                        <label>
                            <input type="radio" name="region" value="region">指定范围</label>
                    </div>
                    <div class="col-md-4">
                        <div class="col-md-4 control-label">
                            <input type="number" name="start"
                                   class="form-control" disabled></div>
                        <div class="col-md-4 control-label">
                            <input type="number" name="end" class="form-control"
                                   disabled></div>
                    </div>
                </div>
            </div>

            <div id="txtSeparator" style="display: none;">
                <legend>
                    <h5>分隔符</h5>
                </legend>
                <div class="form-group form-group-sm form-inline">
                    <label class="col-md-1"></label>

                    <div class="col-md-2 checkbox">
                        <label>
                            <input type="checkbox" name="space"
                                   value="S">空白</label>
                    </div>
                    <div class="col-md-2 checkbox">
                        <label>
                            <input type="checkbox" name="comma"
                                   value="C">逗号</label>
                    </div>
                    <div class="col-md-2 checkbox">
                        <label>
                            <input type="checkbox" name="tab"
                                   value="T">TAB</label>
                    </div>
                    <div class="col-md-4 checkbox">
                        <label>
                            <input type="checkbox"
                                   onclick="checkOther(this, 'other')">
                            其他
                            <input type="text" name="other"
                                   class="form-control input-sm"
                                   disabled="disabled"></label>
                    </div>
                </div>
            </div>

            <legend>
                <h5>数据列限定</h5>
            </legend>
            <div class="form-group form-group-sm">
                <label class="col-md-1"></label>

                <div class="col-md-6 checkbox">
                    <label>
                        <input type="checkbox" name="firstRow4Cols"
                               value="true">第一行存在列名</label>
                </div>
            </div>
            <div class="form form-group">
                <div class="col-md-4 radio text-center">
                    <label>
                        <input type="radio" name="field" id="test"
                               checked="checked">所有列</label>
                </div>
                <div class="col-md-6 radio text-center">
                    <label>
                        <input type="radio" name="field">指定列</label>
                </div>
            </div>
            <div id="field-select" class="form-group" style="display:none">
                <label class="col-md-1 control-label"></label>

                <div class="col-md-4">
                    所有列
                    <select name="all_fields" multiple class="form-control"
                            size="5"></select>
                </div>
                <div class="col-md-1 text-center" style="margin-top: 40px;">
                    <button type="button" class="btn btn-xs btn-primary"
                            onclick="appendToRightMulSelect('all_fields','fields')">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </button>
                    <br/>
                    <br/>
                    <button type="button" class="btn btn-xs btn-primary"
                            onclick="removeFromMulSelect('fields')">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </button>
                </div>
                <div class="col-md-4">
                    指定列
                    <select name="fields" multiple class="form-control"
                            size="5"></select>
                </div>
            </div>
            <div class="form-group modal-footer">
                <button type="button" class="btn btn-sm btn-warning"
                        onclick="reloadPage()">取消
                </button>
                <button type="button" class="btn btn-sm btn-warning"
                        onclick="showTargetInputGroup('base_conf')">上一步
                </button>
                <button type="submit" class="btn btn-sm btn-primary">提交</button>
            </div>
        </fieldset>
    </form>
</div>
