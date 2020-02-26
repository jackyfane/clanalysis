<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <a href="#">模板管理</a>
        </li>
        <li class="active">模板样式</li>
    </div>
</div>
<div class="container-fluid">
    <form id="defaultForm" data-toggle="validator" class="form-horizontal"
          action="${action}" method="post">
        <fieldset>
            <legend>
                <h5>模板样式</h5>
            </legend>
            <div>
                <jsp:include page="../form-common-hidden.jsp"/>
                <c:choose>
                    <c:when test="${entity != null}">
                        <input type="hidden" name="user"
                               value="${entity.user.id}"></c:when>
                    <c:otherwise>
                        <input type="hidden" name="user"
                               value="${userInfo.id}"></c:otherwise>
                </c:choose>
                <input type="hidden" name="id" value="${entity.id}"></div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group form-group-sm">
                        <label class="col-md-2 control-label text-right">名称:</label>

                        <div class="col-md-8">
                            <input type="text" name="name"
                                   value="${entity.name}" class="form-control"
                                   autofocus required></div>
                    </div>
                    <div class="form-group form-group-sm">
                        <label class="col-md-2 control-label text-right">分类:</label>

                        <div class="col-md-6">
                            <select name="category" class="form-control"
                                    required></select>
                        </div>
                        <div class="col-md-1">
                            <button type="button" class="btn btn-sm btn-info"
                                    onclick="getDataForSelectTag('${pageContext.request.contextPath}/category/get-all', 'category','${entity.category}');">
                                刷新
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label text-right">描述:</label>

                        <div class="col-md-9">
                            <textarea class="form-control" name="description"
                                      placeholder="在这里输入简要描述..."
                                      rows="3">${entity.description}</textarea>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div>
                        <div class="row">
                            <div class="col-md-3">
                                <label class="control-label">配置选项：</label>
                            </div>
                            <div class="col-md-4 checkbox">
                                <label>
                                    <input type="checkbox">图形</label>
                            </div>
                            <div class="col-md-4 checkbox">
                                <label>
                                    <input type="checkbox">表格</label>
                            </div>
                        </div>
                        <div class="row" style="margin-top:10px;">
                            <div class="col-md-6">
                                <div class="text-center">文本类</div>
                                <div>
                                    <select multiple rows="12"
                                            class="form-control">
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="text-center">图形类</div>
                                <div>
                                    <select multiple row="8"
                                            class="form-control">
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                        <option>asdfasdfasdfasdf</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="font-component">
                        <div id="font">
                            <div class="col-md-12"><strong>字体</strong>
                            </div>
                            <div class="col-md-12">
                                <select class="form-control input-sm">
                                    <option>Arial</option>
                                </select>
                            </div>
                            <div>
                                <div class="col-md-9">
                                    <select class="form-control input-sm">
                                        <option>Normal</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <select class="form-control input-sm">
                                        <option>13</option>
                                    </select>
                                </div>
                            </div>
                            <div>
                                <div class="btn-toolbar">
                                    <div class="btn-group col-md-3"
                                         role="group">
                                        <button type="button"
                                                class="btn btn-sm btn-default">
                                            <span class="fa fa-bold"></span>
                                        </button>
                                        <button type="button"
                                                class="btn btn-sm btn-default">
                                            <span class="fa fa-italic"></span>
                                        </button>
                                        <button type="button"
                                                class="btn btn-sm btn-default">
                                            <span class="fa fa-underline"></span>
                                        </button>
                                    </div>
                                    <div class="btn-group btn-group-sm col-md-3"
                                         role="group">
                                        <button type="button"
                                                class="btn btn-sm btn-default">
                                            <span class="glyphicon glyphicon-text-color"
                                                  id="text-color"></span>
                                        </button>
                                        <button type="button"
                                                class="btn btn-sm dropdown-toggle"
                                                onclick="popColorPicker(this, 'text-color');">
                                            <span class="caret"></span>
                                        </button>
                                    </div>
                                    <div class="btn-group btn-group-sm col-md-3"
                                         role="group">
                                        <button type="button"
                                                class="btn btn-sm btn-default">
                                            <span class="fa fa-list-ol"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="split-line"></div>
                        <div id="border">
                            <div class="col-md-12"><strong>填充, 线型 + 边框</strong>
                            </div>
                            <div class="btn-toolbar col-md-12">
                                <div class="btn-group btn-group-sm" role="group"
                                     style="margin-right:20px;">
                                    <button type="button"
                                            class="btn btn-sm btn-default">
                                        <span class="fa fa-pencil-square-o"></span>
                                    </button>
                                    <button type="button"
                                            class="btn dropdown-toggle"
                                            data-toggle="dropdown"
                                            aria-haspopup="true"
                                            aria-expanded="false">
                                        <span class="caret"></span>
                                    </button>
                                </div>
                                <div class="btn-group btn-group-sm" role="group"
                                     style="margin-right:20px;">
                                    <button type="button"
                                            class="btn btn-sm btn-default">
                                        <span class="glyphicon glyphicon-text-color"></span>
                                    </button>
                                    <button type="button"
                                            class="btn dropdown-toggle"
                                            data-toggle="dropdown"
                                            aria-haspopup="true"
                                            aria-expanded="false">
                                        <span class="caret"></span>
                                    </button>
                                </div>
                                <div class="btn-group btn-group-sm" role="group"
                                     style="margin-right:20px;">
                                    <button type="button"
                                            class="btn btn-sm btn-default">
                                        <span class="glyphicon glyphicon-text-color"></span>
                                    </button>
                                    <button type="button"
                                            class="btn btn-sm dropdown-toggle"
                                            data-toggle="dropdown"
                                            aria-haspopup="true"
                                            aria-expanded="false">
                                        <span class="caret"></span>
                                    </button>
                                </div>
                                <div class="btn-group btn-group-sm"
                                     role="group">
                                    <button type="button"
                                            class="btn btn-sm btn-default">
                                        <span class="glyphicon glyphicon-text-color"></span>
                                    </button>
                                    <button type="button"
                                            class="btn dropdown-toggle"
                                            data-toggle="dropdown"
                                            aria-haspopup="true"
                                            aria-expanded="false">
                                        <span class="caret"></span>
                                    </button>
                                </div>
                            </div>

                            <div class="btn-toolbar">
                                <div class="btn-group btn-group-sm col-md-3"
                                     role="group">
                                    <button type="button"
                                            class="btn btn-sm btn-default">
                                        <span class="glyphicon glyphicon-text-color"></span>
                                    </button>
                                    <button type="button"
                                            class="btn dropdown-toggle"
                                            data-toggle="dropdown"
                                            aria-haspopup="true"
                                            aria-expanded="false">
                                        <span class="caret"></span>
                                    </button>
                                </div>
                                <div class="btn-group form-inline">
                                    透明度：
                                    <input type="text"
                                           class="form-control input-sm">
                                    <strong>%</strong>
                                </div>
                            </div>
                        </div>
                        <div class="split-line"></div>
                        <div id="alignment">
                            <div class="col-md-12">
                                <strong>对齐 + 边框</strong>
                            </div>
                            <div class="col-md-12">
                                <div class="btn-toolbar">
                                    <div class="btn-group">
                                        <button type="button"
                                                class="btn btn-sm btn-default"
                                                aria-label="Left Align">
                                            <span class="glyphicon glyphicon-align-left"
                                                  aria-hidden="true"></span>
                                        </button>
                                        <button type="button"
                                                class="btn btn-sm btn-default"
                                                aria-label="Center Align">
                                            <span class="glyphicon glyphicon-align-center"
                                                  aria-hidden="true"></span>
                                        </button>
                                        <button type="button"
                                                class="btn btn-sm btn-default"
                                                aria-label="Right Align">
                                            <span class="glyphicon glyphicon-align-right"
                                                  aria-hidden="true"></span>
                                        </button>
                                        <button type="button"
                                                class="btn btn-sm btn-default"
                                                aria-label="Justify">
                                            <span class="glyphicon glyphicon-align-justify"
                                                  aria-hidden="true"></span>
                                        </button>
                                    </div>
                                    <div class="btn-group col-md-5 text-center">
                                        <button type="button"
                                                class="btn btn-sm btn-default"
                                                aria-label="Left Align">
                                            <span class="glyphicon glyphicon-align-left"
                                                  aria-hidden="true"></span>
                                        </button>
                                        <button type="button"
                                                class="btn btn-sm btn-default"
                                                aria-label="Center Align">
                                            <span class="glyphicon glyphicon-align-center"
                                                  aria-hidden="true"></span>
                                        </button>
                                        <button type="button"
                                                class="btn btn-sm btn-default"
                                                aria-label="Right Align">
                                            <span class="glyphicon glyphicon-align-right"
                                                  aria-hidden="true"></span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 form-inline checkbox">
                                填充：
                                <labe>上</labe>
                                <input type="text" class="form-control input-sm"
                                       size="3">
                                <labe>右</labe>
                                <input type="text" class="form-control input-sm"
                                       size="3">
                                <labe>下</labe>
                                <input type="text" class="form-control input-sm"
                                       size="3">
                                <labe>左</labe>
                                <input type="text" class="form-control input-sm"
                                       size="3"></div>
                            <div class="col-md-12 form-inline">
                                行距：
                                <select class="form-control input-sm">
                                    <option>--</option>
                                </select>
                            </div>
                        </div>
                        <br>

                        <div style="clear: both;"></div>
                    </div>
                </div>
            </div>
            <div class="form-group modal-footer">
                <a href="#" type="button" class="btn btn-sm btn-warning"
                   onclick="reloadPage();">取消</a>
                <button class="btn btn-sm btn-primary">提交</button>
            </div>
        </fieldset>
    </form>
</div>
</body>
</html>
<style type="text/css">
    .font-component {
        background-color: #f4f4f4;
    }

    .font-component div {
        padding-top: 5px;
    }

    .font-component .input-group div {
        padding-top: 0;
    }

    .split-line {
        margin-top: 8px;
        border-bottom: solid 1px #c0c0c0;
    }
</style>
<!-- Custom JS -->
<script type="text/javascript">
    function popColorPicker(object, target) {
        $(object).colorpicker();
    }
</script>
