<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fieldset>
    <legend><h5>目标配置</h5></legend>
    <div class="form-group form-group-sm">
        <div class="col-md-2 text-right">
            <label>指定数据源:</label>
        </div>
        <div class="col-md-3">
            <select name="logType" class="form-control"></select>
        </div>
        <span class="help-block with-errors"></span>
    </div>
    <div class="form-group modal-footer">
        <button type="button" class="btn btn-sm btn-warning"
                onclick="reloadPage()">取消
        </button>
        <button type="button" class="btn btn-sm btn-primary"
                onclick="showTargetInputGroup('base_conf')">上一步
        </button>
        <button type="submit" class="btn btn-sm btn-info">提交</button>
    </div>
</fieldset>
