<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<fieldset>
    <legend><h5>基本配置</h5></legend>
    <jsp:include page="../form-common-hidden.jsp"/>
    <div class="form-group form-group-sm">
        <div class="col-md-2 checkbox text-right">
            <label>数据源名称:</label>
        </div>
        <div class="col-md-5">
            <input type="text" name="name" value="${entity.name}"
                   class="form-control" autofocus required>
        </div>
    </div>
    <div class="form-group form-group-sm">
        <div class="col-md-2 checkbox text-right">
            <label>数据源分类:</label>
        </div>
        <div class="col-md-2 radio">
            <label>
                <input type="radio" name="srcType" value="log"
                       checked="checked"> 标准日志
            </label>
        </div>
        <div class="col-md-2 radio">
            <label>
                <input type="radio" name="srcType" value="db"> 数据库
            </label>
        </div>
        <div class="col-md-2 radio">
            <label>
                <input type="radio" name="srcType" value="file"> 本地上传
            </label>
        </div>
    </div>
    <div class="form-group" id="srcTypeDesc">
        <blockquote class="bg-warning" id="log_desc">
            <h4>标准日志
                <small>指已经配置于服务器中的日志文件数据，只能选择指定的数据</small>
            </h4>
        </blockquote>
        <blockquote class="bg-warning" id="db_desc" style="display: none">
            <h4>数据库
                <small>指通过连接指定的数据库，选择配置表和字段</small>
            </h4>
        </blockquote>
        <blockquote class="bg-warning" id="file_desc" style="display: none">
            <h4>本地上传
                <small>当前仅支持EXCEL、CSV、非结构化文本（仅数据挖掘有效）</small>
            </h4>
        </blockquote>
    </div>
    <div class="form-group">
        <div class="col-md-2 checkbox text-right">
            <label>描述:</label>
        </div>
        <div class="col-md-8">
            <textarea class="form-control" name="description"
                      placeholder="在这里输入简要描述..."
                      rows="3">${entity.description}</textarea>
        </div>
    </div>
    <jsp:include page="../visual_user_form.jsp"/>
    <jsp:include page="../edit_by_creator.jsp"/>
    <div class="form-group modal-footer">
        <button type="button" class="btn btn-sm btn-warning"
                onclick="reloadPage();">取消
        </button>
        <button type="button" class="btn btn-sm btn-primary"
                onclick="showTargetInputGroup()">下一步
        </button>
    </div>
</fieldset>
