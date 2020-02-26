<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fieldset>
    <legend><h4>指标配置</h4></legend>
    <div class="row">
        <input type="hidden" name="idxs" id="idxs" value="${entity.idxs}"/>

        <div class="col-md-6 log-param-select">
            <div class="form-group form-group-sm">
                <div class="col-md-4 text-right checkbox">
                    <label>日志:</label>
                </div>
                <div class="col-md-8">
                    <select name="logType" class="form-control" required>
                        <option value="">请选择日志</option>
                    </select>
                </div>
            </div>
            <div class="form-group form-group-sm">
                <div class="col-md-4 text-right checkbox">
                    <label>基础字段:</label>
                </div>
                <div class="col-md-8">
                    <select name="baseField" class="form-control">
                        <option value="">请选择基础字段</option>
                    </select>
                </div>
            </div>
            <div id="queryLabel" class="form-group form-group-sm"
                 style="display: none">
                <div class="col-md-4 text-right checkbox">
                    <label>查询标识:</label>
                </div>
                <div class="col-md-8" id="queryTag"></div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="col-md-1 text-center">
                <button class="btn btn-primary btn-xs" type="button"
                        style="margin-top:40px" onclick="addParamToTable();">
                    <span class="fa fa-angle-double-right"></span>
                </button>
            </div>
            <div class="col-md-10 param-list">
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th>基础字段</th>
                        <th>列族</th>
                        <th>查询标识</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="param-grid"></tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <div class="radio col-md-2 text-right">
            <label class="control-label">
                <input type="radio" name="expType" value="" checked> 所有值
            </label>
        </div>
        <div class="radio col-md-5">
            <label class="control-label col-md-4 text-right">
                <input type="radio" name="expType" value="F">含有固定部分</label>

            <div class="col-md-8">
                <input type="text" name="fixedPortion" class="form-control"
                       value="${entity.fixedPortion}" disabled>
            </div>
        </div>
        <div class="radio col-md-5 text-right">
            <label class="control-label col-md-4">
                <input type="radio" name="expType" value="R"> 正则表达式
            </label>

            <div class="col-md-6">
                <input type="text" name="expressRegular" class="form-control"
                       value="${entity.expressRegular}" disabled>
            </div>
            <div class="col-md-1">
                <button type="button" class="btn btn-sm btn-primary"
                        onclick="verifyRegular();">测试
                </button>
            </div>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <div class="panel panel-default col-md-offset-1 col-md-10">
            <div class="panel-body">
                <div>统计方法：</div>
                <div class="radio">
                    <label class="col-md-offset-1 control-label">
                        <input type="radio" name="elementType" value="D"
                               checked="checked"> 分类。用于文本字符，仅用作维度。
                    </label>
                </div>
                <div class="radio">
                    <label class="col-md-offset-1 control-label">
                        <input type="radio" name="elementType" value="S">
                        求和。应用于纯数值类型数据，非数值数据用0代替计算，可识别负数。
                    </label>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <div class="col-md-2 text-right checkbox">
            <label>货币单位:</label>
        </div>
        <div class="col-md-4">
            <select name="currencyUnit" class="form-control">
                <option value="">无</option>
            </select>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <legend>
            <label class="control-label">
                <h5><input type="checkbox" name="convert" value="true">使用字符转换
                </h5>
            </label>
        </legend>
    </div>
    <div style="display: none;" id="char_param">
        <div class="form-group form-group-sm checkbox">
            <label class="col-md-2 control-label">字符名称转换:</label>

            <div class="col-md-5">
                <select name="association" class="form-control"></select>
            </div>
            <div class="col-md-1">
                <button type="button" class="btn btn-sm btn-success"
                        onclick="freshAssociation()">刷新
                </button>
            </div>
        </div>
        <div class="form-group form-group-sm checkbox">
            <label class="col-md-2 control-label">源字符位置:</label>

            <div class="col-md-2">
                <input type="number" name="srcChrIndex" class="form-control"
                       value="${entity.srcChrIndex}">
            </div>
            <label class="col-md-2 control-label text-right">转换字符位置:</label>

            <div class="col-md-2">
                <input type="number" name="convertChrIndex" class="form-control"
                       value="${entity.convertChrIndex}">
            </div>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <legend>
            <label class="control-label"><h5><input type="checkbox"
                                                    name="composite"
                                                    value="true">复合指标</h5>
            </label>
        </legend>
    </div>
    <div class="form-group" id="compositeElConf" style="display: none;">
        <div class="col-md-1"></div>
        <div class="col-md-4">
            <div>所有指标
                <button type="button" class="btn btn-xs btn-success pull-right"
                        onclick="freshElement();">刷新
                </button>
            </div>
            <select name="elements" multiple class="form-control"
                    size="6"></select>
        </div>
        <div class="col-sm-1 text-center" style="margin-top:60px;">
            <button type="button" class="btn btn-xs btn-primary"
                    onclick="fromMulSelect2Textarea('elements','complexExp')">
                <span class="fa fa-angle-double-right"></span>
            </button>
        </div>
        <div class="col-md-6">
            <div>新指标表达式</div>
            <textarea rows="5" class="form-control" id="complexExp"
                      name="complexExp">${entity.complexExp}</textarea>

            <div class="btn-group btn-group-sm" role="group"
                 id="expressionBtnGroup">
                <button type="button" class="btn btn-xs">+</button>
                <button type="button" class="btn btn-xs">-</button>
                <button type="button" class="btn btn-xs">*</button>
                <button type="button" class="btn btn-xs">/</button>
                <button type="button" class="btn btn-xs">(</button>
                <button type="button" class="btn btn-xs">)</button>
            </div>
            <button type="button" class="btn btn-xs btn-warning pull-right"
                    onclick="clearTextarea('complexExp');">清空
            </button>
        </div>
    </div>
    <div class="form-group modal-footer">
        <button type="button" class="btn btn-sm btn-warning"
                onclick="reloadPage()">取消
        </button>
        <button type="button" class="btn btn-sm btn-primary"
                onclick="showTargetInputGroup('base_conf')">上一步
        </button>
        <button type="submit" class="btn btn-sm btn-primary">提交</button>
    </div>
</fieldset>
