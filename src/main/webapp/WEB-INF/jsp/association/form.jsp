<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>
    <script type="text/javascript">
        if (typeof require !== 'undefined') {
            XLSX = require('xlsx');
        }
        var parser = XLSX;

        $(function () {
            if (!$.isEmptyObject('${entity.filePath}')) {
                $('input[name="config"]').val('${entity.config}');
                $('#file').removeAttr('required');
            }
            var uploadFile = document.getElementById('file');
            if (uploadFile.addEventListener) {
                uploadFile.addEventListener('change', function (e) {
                    var files = e.target.files;
                    var f = files[0], name = f.name,
                            docType = name.substring(name.lastIndexOf('.') + 1).toLowerCase();
                    switch (docType) {
                        //Excel处理
                        case 'xls':
                        case 'xlsx':
                            var reader = new FileReader();
                            reader.readAsBinaryString(f);
                            reader.onload = function (e) {
                                var data = e.target.result;
                                var wb = parser.read(data, {type: 'binary'});
                                $('input[name="config"]').val(to_json(wb));
                            }
                            break;
                        case 'csv':
                            Papa.parse(f, {
                                header: true,
                                complete: function (results) {
                                    $('input[name="config"]').val(JSON.stringify(results.data, 2, 2));
                                }
                            });
                            break;
                        default :
                            var reader = new FileReader();
                            reader.readAsText(f);
                            reader.onload = function (e) {
                                var data = e.currentTarget.result;
                                $('input[name="config"]').val(data);
                            }
                            break;
                    }
                }, false);
            }

            //将Excel转化为JSON格式数据
            function to_json(workbook) {
                var result = [], colHeaders;
                workbook.SheetNames.forEach(function (sheetName) {
                    var csv = parser.utils.sheet_to_csv(workbook.Sheets[sheetName]);
                    var rows = csv.split('\n');
                    colHeaders = rows[0].split(',');
                    for (var i = 1; i < rows.length - 1; i++) {
                        var row = rows[i].split(','), map = {};
                        for (var j = 0; j < colHeaders.length; j++) {
                            map[colHeaders[j]] = row[j];
                        }
                        result.push(map);
                    }
                });
                return JSON.stringify(result, 2, 2);
            }

            $.getJSON('${pageContext.request.contextPath}/user/get-all', function (data) {
                var visibleUser = [];
                <c:forEach var="user" items="${entity.visibleUser}">visibleUser.push("${user.id}");
                </c:forEach>

                var optHtml = '';
                $.each(data, function () {
                    var temp = this, isSelected = false;
                    $.each(visibleUser, function () {
                        if (temp.id == this) {
                            isSelected = true;
                            return;
                        }
                    });
                    var selected = isSelected ? 'selected' : '';
                    optHtml += '<option value="' + this.id + '" ' + selected + '>' + this.name + '</option>\n';
                });
                $('select[name="visibleUser"]').html(optHtml);
            });
        });
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
            <a href="#">项目</a>
        </li>
        <li class="active">外部关联信息</li>
    </div>
</div>
<div class="container">
    <form class="form-horizontal" action="${action}/association" method="post"
          enctype="multipart/form-data">
        <fieldset>
            <legend>
                <h5>基本配置</h5>
            </legend>
            <input type="hidden" name="config">
            <jsp:include page="../item-base-form.jsp"/>
            <div class="form-group form-group-sm">
                <div class="col-md-2 checkbox text-right">
                    <label for="file">关联文件:</label>
                </div>
                <div class="col-md-8">
                    <input type="file" id="file" name="file" required></div>
            </div>
            <div class="form-group">
                <div class="col-md-2 checkbox text-right">
                    <label class="control-label">选择可见用户:</label>
                </div>
                <div class="col-md-5">
                    <select name="visibleUser" multiple class="form-control"
                            size="5"></select>
                </div>
                <div class="col-md-1">
                    <button type="button" class="btn btn-xs btn-info pull-right"
                            onclick="getDataForSelectTag('${pageContext.request.contextPath}/user/get-all', 'visibleUser');">
                        刷新
                    </button>
                </div>
            </div>
            <jsp:include page="../edit_by_creator.jsp"/>
            <div class="form-group modal-footer">
                <button type="button" class="btn btn-sm btn-warning"
                        onclick="reloadPage();">取消
                </button>
                <button type="submit" class="btn btn-sm btn-primary">提交</button>
            </div>
        </fieldset>
    </form>
</div>
</body>
</html>
