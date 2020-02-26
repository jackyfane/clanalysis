<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<legend><h5>过滤配置</h5></legend>
<div class="form-group">
    <label class="col-md-2 control-label">选择指标:</label>

    <div class="col-md-4">
        <select name="element" class="form-control"></select>
    </div>
</div>
<div class="form-group">
    <label class="col-md-2"></label>

    <div class="col-md-3 radio">
        <label class="control-label"><input type="radio" name="expressType"
                                            value="T" checked="checked">
            文本</label>
    </div>
    <div class="col-md-3 radio">
        <label class="control-label"><input type="radio" name="expressType"
                                            value="E"> 算式</label>
    </div>
    <div class="col-md-3 radio">
        <label class="control-label"><input type="radio" name="expressType"
                                            value="R"> 正则表达式</label>
    </div>
</div>
<div class="form-group form-group-sm">
    <label class="col-md-2 control-label">条件:</label>

    <div class="col-md-6">
        <input type="text" name="condition" class="form-control">
    </div>
    <div class="col-md-1">
        <button type="button" class="btn btn-sm btn-default"
                onclick="joinCondToTarget('ruleConf');">加入
        </button>
    </div>
</div>

<div class="form-group">
    <div class="col-md-2"></div>
    <div class="col-md-6">
        <select name="ruleConf" multiple class="form-control" rows="5"></select>
    </div>
    <div class="col-md-4 form-horizontal" style="padding-top: 25px;">
        <div class="input-group radio">
            <label><input type="radio" name="matchMode" value="false" checked>匹配任何一条规则</label>
        </div>
        <div class="input-group radio">
            <label><input type="radio" name="matchMode"
                          value="true">匹配所有规则</label>
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
    <button type="submit" class="btn btn-sm btn-success">提交</button>
</div>
