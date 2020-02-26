<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fieldset>
    <legend><h5>模板配置</h5></legend>
    <div class="form-group">
        <div class="col-md-4">选择报告模板：<a href="#" id="getTemplate"
                                        class="btn btn-xs btn-success"
                                        data-toggle="modal"
                                        data-target="#templateDialog">添加</a>
            <br/>
            <select multiple class="form-control" rows="5"
                    name="template_select"
                    onchange="itemOnClick(this, 'report_select')">
                <option value="1">网站分析月报</option>
                <option value="2">双十一活动</option>
            </select>
        </div>
        <div class="col-md-1 text-center">
            <br/>
            <br/>
            <a href="#" class="btn btn-xs btn-primary"
               onclick="appendToRightMulSelect('source_field','associated_conf');"><span
                    class="glyphicon glyphicon-chevron-right"></span></a>
            <br/>
            <br/>
            <a href="#" class="btn btn-xs btn-primary"
               onclick="removeFromMulSelect('associated_conf');"><span
                    class="glyphicon glyphicon-chevron-left"></span></a>
        </div>
        <div class="col-md-4">关联配置：
            <br>
            <select multiple class="form-control" rows="5" name="report_select">
                <option value="1">网站总体流量</option>
                <option value="2">网站跳出率</option>
                <option value="3">网页关键页面浏览时长</option>
                <option value="4">网站业务办理量</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-8">报告图标参数配置：<p/>

            <div class="panel panel-default" id="chart_params">
                <div class="panel-body">
                    <div class="panel-group">
                        <div class="col-md-8 text-center">
                            <div class="panel-group">
                                <div class="col-md-5 control-label text-right">
                                    表格单页行数
                                </div>
                                <div class="col-md-7">
                                    <input id="page_row" name="page_row"
                                           type="number"
                                           class="input-sm form-control">
                                </div>
                            </div>
                            <br/>

                            <div class="panel-group">
                                <div class="col-md-5 control-label text-right">
                                    表格总行数
                                </div>
                                <div class="col-md-7">
                                    <input id="all_row" name="all_row"
                                           type="number"
                                           class="input-sm form-control">
                                </div>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="col-md-4 pull-right">
                            <label class="checkbox-inline"><input
                                    type="checkbox" id="all_chart_checkbox"/>全选</label>
                        </div>
                    </div>

                    <br/>

                    <div class="panel-group text-center">
                        <label class="checkbox-inline"><input type="checkbox"
                                                              name="line"
                                                              value="line"/>折线图</label>
                        <label class="checkbox-inline"><input type="checkbox"
                                                              name="column"
                                                              value="column"/>柱状图</label>
                        <label class="checkbox-inline"><input type="checkbox"
                                                              name="pie"
                                                              value="pie"/>饼图</label>
                    </div>
                    <div class="panel-group text-center">
                        <label class="checkbox-inline"><input type="checkbox"
                                                              name="bar"
                                                              value="bar"/>条形图</label>
                        <label class="checkbox-inline"><input type="checkbox"
                                                              name="sky"
                                                              value="sky"/>星空图</label>
                        <label class="checkbox-inline"><input type="checkbox"
                                                              name="boxplot"
                                                              value="boxplot"/>箱线图</label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group modal-footer">
        <div class="col-md-11 text-right">
            <button type="button" class="btn btn-sm btn-warning"
                    onclick="reloadPage();">取消
            </button>
            <button type="button" class="btn btn-sm btn-warning"
                    onclick="showTargetInputGroup('ds_conf')">上一步
            </button>
            <button type="submit" class="btn btn-sm btn-primary"
                    onclick="submit_form();">提交
            </button>
        </div>
    </div>
</fieldset>
<div id="templateDialog" class="modal fade" role="dialog" tabindex="-1"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Cloase">
                    <span aria-hidden="true">&times;</span></button>
                <h5 class="modal-title">模板选择框</h5>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group form-group-sm">
                    <input type="search" class="form-control"
                           placeholder="模板名称">
                </div>
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th><label>全选 <input type="checkbox"
                                             onclick="checkAll(this, 'template')"/></label>
                        </th>
                        <th>模板名称</th>
                    </tr>
                    </thead>
                    <tbody id="template-content">
                    <tr>
                        <td><input type="checkbox" value="dzqd"/></td>
                        <td>电子渠道</td>
                    </tr>
                    </tbody>
                </table>
                <div class="pagination pull-right"
                     id="template-pagination"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-sm btn-default"
                        data-dismiss="modal">Close
                </button>
                <button type="button" class="btn btn-sm btn-success"
                        onclick="ensure('template','templateDialog');">选择
                </button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var option_id = '';
    var chart_params = new Array();

    $(function () {
        $('a[id="getTemplate"]').click(function () {
            $.getJSON('${pageContext.request.contextPath}/tpl/list/1/5', function (data) {
                var _total = data.total;
                total = Math.ceil(_total / rows);
                listContent(data.list, 'template-content');
                $('#template-pagination').bootpag({
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
                    $.getJSON('${pageContext.request.contextPath}/tpl/list/' + num + '/5', function (data) {
                        listContent(data.list, 'template-content');
                    });
                });
            });
        });

        //报告图标参数配置
        $('select[name="report_select"]').on('change', function () {
            //每次只能选择一个
            if ($(this).find('option:checked').length != 1) return;

            if ($.isEmptyObject(option_id)) {
                initInput('chart_params');
            }
            else {
                //1.一个新的项目被选中时，获取之前选中项目的报告图标参数配置
                var unindexed_array = $('#chart_params').find('input').serializeArray();
                var indexed_array = {};
                $.map(unindexed_array, function (n, i) {
                    indexed_array[n['name']] = n['value'];
                });
                indexed_array.id = option_id;
                //console.info(indexed_array);
                //2.判断报告图标参数配置是否存在，如果存在则移除
                $.each(chart_params, function () {
                    var target = this;
                    if (this.id == option_id) {
                        chart_params = $.grep(chart_params, function (obj) {
                            return target != obj;
                        });
                        return;
                    }
                });
                //3.将配置参数添加到数组中
                chart_params.push(indexed_array);

                //3.判断选中的项是否存在于chart_params,如果存在，则从中加载到报告图标参数配置视图，否则从数据从后台获取数据
                var isExists = false, prev_obj = this;
                $.each(chart_params, function () {
                    if (this.id == $(prev_obj).val()) {
                        //清空表单
                        initInput('chart_params');

                        for (var key in this) {
                            if (key == 'id') continue;
                            var inputObj = $('#chart_params').find('input[name="' + key + '"]');
                            if ('checkbox' == inputObj.attr('type')) {
                                inputObj.prop('checked', true);
                            }
                            else {
                                inputObj.val(this[key]);
                            }
                        }
                        isExists = true;
                        return;
                    }
                });
                if (!isExists) {
                    initInput('chart_params');
                }

                //console.info(JSON.stringify(chart_params));
            }
            //将option_id置为当前选中项的ID
            option_id = $(this).val().toString();
        });

        $('#all_chart_checkbox').click(function (checked) {
            var isChecked = $(this).prop('checked')
            $('#chart_params').find('input[type="checkbox"]').prop('checked', isChecked);
        });
    });

    /**
     * 初始化input
     * @param  {[type]} target [description]
     * @return {[type]}        [description]
     */
    function initInput(target) {
        $.each($('#' + target).find('input'), function () {
            var type = $(this).attr('type');
            if (type == 'checkbox') {
                $(this).prop('checked', false);
            }
            else {
                $(this).val(0);//设置默认为0
            }
        });
    }


    function checkAll(object, target) {
        var isChecked = $(object).prop('checked');
        $('#' + target + '-content').find('input[type="checkbox"]').prop('checked', isChecked);
    }


    /**
     * 下拉列表改变事件
     * @param  {[type]} object [description]
     * @param  {[type]} target [description]
     * @return {[type]}        [description]
     */
    function itemOnClick(object, target) {
        if ($(object).find('option:selected').length != 1) {
            alert('每次只能选择一个');
            return;
        }

        //从后台加载数据
        $.getJSON('url', $(object).find('option:checked').val(), function (json) {

        });
    }
</script>