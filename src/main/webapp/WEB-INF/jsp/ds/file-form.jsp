<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fieldset>
    <legend><h5>目标配置</h5></legend>
    <div class="form-group form-group-sm">
        <div class="col-md-2 text-right checkbox">
            <label>文件类型:</label>
        </div>
        <div class="col-md-5">
            <select name="docType" class="form-control">
                <option value="">请选择文件类型</option>
                <option value="xls">Excel(98-2003)(*.xls)</option>
                <option value="xlsx">Excel(2007~)(*.xlsx)</option>
                <option value="csv">逗号分隔符(*.csv)</option>
                <option value="txt">文本(*.txt)</option>
            </select>
        </div>
    </div>

    <div class="form-group form-group-sm">
        <div class="col-md-2 text-right checkbox">
            <label for="file">导入文件:</label>
        </div>
        <div class="col-md-8">
            <input type="file" id="file" name="file">
        </div>
    </div>

    <div id="excelRegion">
        <div class="form-group">
            <legend><h5 style="padding-left:80px;">工作表范围界定</h5></legend>
        </div>
        <div class="form-group form-group-sm">
            <div class="col-md-2 text-right checkbox">
                <label>选择工作表:</label>
            </div>
            <div class="col-md-3 radio">
                <label><input type="radio" name="sheetFlag" value="index"
                              checked="checked"> 按索引</label>
            </div>
            <div class="col-md-2 radio">
                <label><input type="radio" name="sheetFlag" value="sheet">
                    按表名</label>
            </div>
            <div class="col-md-4">
                <input type="text" name="sheetMode" class="form-control">
            </div>
        </div>
        <div class="form-group form-group-sm">
            <div class="col-md-2 text-right checkbox">
                <label>工作表范围:</label>
            </div>
            <div class="col-md-3 radio form-inline">
                <label><input type="radio" name="region" value="notNull"
                              checked="checked"> 范围从第一个非空开始</label>
            </div>
            <div class="col-md-2 radio form-inline">
                <label><input type="radio" name="region" value="region">
                    指定范围</label>
            </div>
            <div class="col-md-4">
                <div class="col-md-4"><input type="number" name="start"
                                             class="form-control" disabled>
                </div>
                <div class="col-md-4"><input type="number" name="end"
                                             class="form-control" disabled>
                </div>
            </div>
        </div>
    </div>

    <div id="txtSeparator" style="display: none;">
        <div class="form-group">
            <legend><h5 style="padding-left:80px;">分隔符</h5></legend>
        </div>
        <div class="form-inline">
            <label class="col-md-1"></label>

            <div class="col-md-2 checkbox">
                <label><input type="checkbox" name="space" value="S">空白</label>
            </div>
            <div class="col-md-2 checkbox">
                <label><input type="checkbox" name="comma" value="C"> 逗号</label>
            </div>
            <div class="col-md-2 checkbox">
                <label><input type="checkbox" name="tab" value="T"> TAB</label>
            </div>
            <div class="col-md-4 checkbox">
                <label><input type="checkbox"
                              onclick="checkOther(this, 'other')">其他 <input
                        type="text" name="other" class="form-control input-sm"
                        disabled="disabled"></label>
            </div>
        </div>
    </div>
    <%--
    <legend><h5>数据列限定</h5></legend>
    <div class="form-group form-group-sm">
        <label class="col-md-2"></label>
        <div class="col-md-6 checkbox">
            <label><input type="checkbox" name="firstRow4Cols" value="true"> 第一行存在列名</label>
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-2 text-right checkbox">
            <label>选择列:</label>
        </div>
        <div class="col-md-8">
            <select name="headers" multiple class="form-control" size="5"></select>
        </div>
    </div>
    --%>
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
