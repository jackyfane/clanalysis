<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<legend><h5>目标配置</h5></legend>
<div class="form-group form-group-sm">
    <div class="col-md-5 radio  text-center">
        <label>
            <input type="radio" name="flag" value="table" checked> 表
        </label>
    </div>
    <div class="col-md-5 radio  text-center">
        <label>
            <input type="radio" name="flag" value="sql"> SQL
        </label>
    </div>
</div>
<div class="form-group form-group-sm">
    <div class="col-md-2 checkbox text-right">
        <label for="dbConfig">数据源:</label>
    </div>
    <div class="col-md-3">
        <select name="dbConfig" id="dbConfig" class="form-control"
                onchange="getTables(this, 'tableName')"></select>
    </div>
    <div class="col-md-2 checkbox text-right">
        <label for="tableName">表名称:</label>
    </div>
    <div class="col-md-3">
        <select name="tableName" id="tableName" class="form-control"
                onchange="getFields(this, 'fields')"></select>
    </div>
</div>
<div id="table_input" class="form-group">
    <div class="col-md-2 checkbox text-right">
        <label>选择字段</label>
    </div>
    <div class="col-md-6">
        <select name="fields" multiple class="form-control" rows="5"></select>
    </div>
    <div class="col-md-2">
        <button type="button" class="btn btn-sm btn-primary"
                onclick="generateSQL();">生成SQL
        </button>
    </div>
</div>

<div class="form-group">
    <div class="col-md-2 checkbox text-right">
        <label>SQL:</label>
    </div>
    <div class="col-md-8">
        <textarea name="sql" class="form-control"
                  rows="4">${entity.sql}</textarea>
    </div>
    <span class="help-block with-errors"></span>
</div>
<div class="form-group modal-footer">
    <button type="button" class="btn btn-sm btn-warning" onclick="reloadPage()">
        取消
    </button>
    <button type="button" class="btn btn-sm btn-warning"
            onclick="showTargetInputGroup('base_conf')">上一步
    </button>
    <button type="submit" class="btn btn-sm btn-primary">提交</button>
</div>