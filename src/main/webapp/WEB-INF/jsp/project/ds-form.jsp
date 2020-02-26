<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<legend><h4><span class="fa fa-database fa-lg"></span> 数据源</h4></legend>
<div class="panel panel-success">
    <div class="panel-heading">关联配置</div>
    <div class="panel-body">
        <div class="form-group">
            <div class="col-md-2 checkbox text-right">
                <label>主数据源：</label>
            </div>
            <div class="col-md-3">
                <select class="form-control input-sm">
                    <option>SDC日志</option>
                    <option>WEBServer日志</option>
                    <option>数据库</option>
                </select>
            </div>
            <div class="col-md-2 checkbox text-right">
                <label>字段：</label>
            </div>
            <div class="col-md-3">
                <select class="form-control input-sm"></select>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-2 checkbox text-right">
                <label>关联数据源：</label>
            </div>
            <div class="col-md-3">
                <select class="form-control input-sm">
                    <option>SDC日志</option>
                    <option>WEBServer日志</option>
                    <option>数据库</option>
                </select>
            </div>
            <div class="col-md-2 checkbox text-right">
                <label>字段：</label>
            </div>
            <div class="col-md-3">
                <select class="form-control input-sm"></select>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-2 checkbox text-right">
                <label>关联关系：</label>
            </div>
            <div class="col-md-3">
                <select class="form-control">
                    <option>等于</option>
                    <option>大于</option>
                    <option>大于等于</option>
                    <option>小于</option>
                    <option>小于等于</option>
                </select>
            </div>
            <div class="col-md-2">
                <button class="btn btn-sm btn-default">添加</button>
            </div>
        </div>
        <div class="param-list">
            <table class="table table-bordered table-striped table-condensed"
                   style="margin-top: 0px;">
                <thead>
                <tr>
                    <th>主数据源</th>
                    <th>字段</th>
                    <th>关联数据源</th>
                    <th>字段</th>
                    <th>关联关系</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="list-content">
                <tr>
                    <td>SDC日志</td>
                    <td>phone</td>
                    <td>数据库1</td>
                    <td>phoneNumber</td>
                    <td>=</td>
                    <td>删除</td>
                </tr>
                <tr>
                    <td>WEBServer日志</td>
                    <td>phone</td>
                    <td>数据库1</td>
                    <td>phoneNumber</td>
                    <td>=</td>
                    <td>删除</td>
                </tr>
                <tr>
                    <td>SDC日志</td>
                    <td>phone</td>
                    <td>数据库1</td>
                    <td>phoneNumber</td>
                    <td>=</td>
                    <td>删除</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<legend><h5>模板配置</h5></legend>
<div class="form-group">
    <div class="col-md-1"></div>
    <div class="col-md-4">选择报告模板：
        <br/>
        <select multiple class="form-control" rows="5" name="template_select"
                onchange="itemOnClick(this, 'report_select')">
            <option value="1">网站分析月报</option>
            <option value="2">双十一活动</option>
        </select>
    </div>
    <div class="col-md-1 text-center">
        <div style="padding-top:50px;">
            <button type="button" class="btn btn-xs btn-primary"
                    onclick="appendToRightMulSelect('source_field','associated_conf');">
                <span class="fa fa-angle-double-right"></span>
            </button>
        </div>
    </div>
    <div class="col-md-4">
        <br/>
        <select multiple class="form-control" rows="5" name="report_select">
            <option value="1">网站总体流量</option>
            <option value="2">网站跳出率</option>
            <option value="3">网页关键页面浏览时长</option>
            <option value="4">网站业务办理量</option>
        </select>
    </div>
</div>
<div class="form-group modal-footer">
    <button type="button" class="btn btn-sm btn-warning"
            onclick="reloadPage();">
        取消
    </button>
    <button type="button" class="btn btn-sm btn-warning"
            onclick="showTargetInputGroup('base_conf')">
        上一步
    </button>
    <!--
    <button type="button" class="btn btn-sm btn-primary" onclick="showTargetInputGroup('tpl_conf')">
        下一步
    </button>
    -->
    <button type="submit" class="btn btn-sm btn-primary">提交</button>
</div>
<%--
<div id="datasource" class="modal fade" role="dialog" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                    <h5 class="modal-title">数据源选择框</h5>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th><label>全选 <input type="checkbox" id="all_datasource"/></label></th>
                        <th>数据源</th>
                    </tr>
                    </thead>
                    <tbody id="datasource-content"></tbody>
                </table>
                <div class="pagination" id="ds-pagination"></div>
            </div>
            <div class="modal-footer">
                <div>
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-sm btn-success" onclick="ensure('datasource', 'datasource');">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>
--%>
<script type="text/javascript">
    var rows = 5;
    function getDataSource() {

        //分页数据，每个list页面都必须去实现fillTbody方法进行渲染，否则页面显示不了内容
        $.getJSON('${pageContext.request.contextPath}/ds/list/1/5', function (data) {
            var _total = data.total;
            total = Math.ceil(_total / rows);
            listContent(data.list, 'datasource-content');
            $('#ds-pagination').bootpag(
                    {
                        total: total,
                        page: page,
                        maxVisible: 10,
                        leaps: true,
                        firstLastUse: true,
                        first: '←',
                        last: '→',
                        wrapClass: 'pagination',
                        activeClass: 'active',
                        disabledClass: 'disabled',
                        nextClass: 'next',
                        prevClass: 'prev',
                        lastClass: 'last',
                        firstClass: 'first'
                    }).on("page", function (event, num) {
                        $.getJSON('${pageContext.request.contextPath}/ds/list/' + num + '/5', function (data) {
                            listContent(data.list, 'datasource-content');
                        });
                    });
        });

        $('#all_datasource').click(function () {
            $('#datasource-content').find('input[type="checkbox"]').prop('checked', $(this).prop('checked'));
        });
    }
</script>