<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<legend><h4>高级配置</h4></legend>
<div class="form-group">
    <div class="col-md-2 text-right checkbox">
        <label for="dimension">报表维度:</label>
    </div>
    <div class="col-md-6">
        <select multiple="multiple" name="dimension" id="dimension" size="6"
                class="form-control" required></select>
    </div>
</div>
<div class="form-group">
    <div class="col-md-5 col-md-offset-1 text-center radio">
        <label>
            <input type="radio" name="model" value="S" checked="checked"
                   onclick="changedModel(this, 'statistical_model','calculation_model');">
            统计模式
        </label>
    </div>
    <div class="col-md-5 radio">
        <label>
            <input type="radio" name="model" value="E"
                   onclick="changedModel(this, 'calculation_model','statistical_model');">
            计算模式
        </label>
    </div>
</div>

<div class="form-group" id="statistical_model">
    <div class="col-md-2 text-right checkbox">
        <label for="statistical">所有指标:</label>
    </div>
    <div class="col-md-6">
        <select multiple="multiple" name="statistical" id="statistical" rows="5"
                class="form-control" size="6" required></select>
    </div>
</div>

<div id="calculation_model" style="display: none;">
    <div class="form-group">
        <div class="col-md-4 col-md-offset-1">
            <div style="padding-bottom: 5px;">所有指标:</div>
            <div>
                <select name="elements" multiple class="form-control"
                        size="6"></select>
            </div>
        </div>
        <div class="col-sm-1 text-center" style="padding-top: 60px;">
            <button type="button"
                    onclick="fromMulSelect2Textarea('elements','expression')"
                    class="btn btn-xs btn-primary">
                <span class="fa fa-angle-double-right"></span>
            </button>
        </div>
        <div class="col-md-5">
            <div style="padding-bottom: 5px;">算式表达式:
                <button type="button" class="btn btn-xs btn-success pull-right">
                    维度统计
                </button>
            </div>
            <textarea rows="5" class="form-control" name="expression"
                      id="expression"></textarea>

            <div class="btn-group btn-group-sm" role="group"
                 id="expressionBtnGroup">
                <button type="button" class="btn btn-sm">+</button>
                <button type="button" class="btn btn-sm">-</button>
                <button type="button" class="btn btn-sm">*</button>
                <button type="button" class="btn btn-sm">/</button>
                <button type="button" class="btn btn-sm">(</button>
                <button type="button" class="btn btn-sm">)</button>
            </div>
            <button type="button" class="btn btn-xs btn-warning pull-right"
                    onclick="clearTextarea('expression');">清空
            </button>
        </div>
    </div>
</div>
<div class="form-group modal-footer">
    <button type="button" class="btn btn-sm btn-warning"
            onclick="reloadPage();">取消
    </button>
    <button type="button" class="btn btn-sm btn-primary"
            onclick="showTargetInputGroup('base_conf')">上一步
    </button>
    <button type="submit" class="btn btn-sm btn-primary">提交</button>
</div>
