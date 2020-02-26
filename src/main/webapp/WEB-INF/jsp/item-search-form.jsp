<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style type="text/css">
    #search-condition {
        /*margin-top: 6px;*/
        padding-bottom: 0px;
        margin: 0px;
        height: 100px;
    }

    #search-condition .panel-body {
        padding: 10px;
    }
</style>
<form class="panel panel-success" id="search-condition">
    <div class="panel-heading">
        <span class="glyphicon glyphicon-search"></span>查询
    </div>
    <div class="panel-body form-horizontal">
        <div class="form-group form-group-sm">
            <label for="name" class="col-md-1 control-label">名称:</label>

            <div class="col-md-3">
                <input class="form-control input-sm" id="name" name="name"
                       placeholder="名称" onchange="getList();">
            </div>
            <label for="category" class="col-md-1 control-label">分类：</label>

            <div class="col-md-3">
                <select class="form-control input-sm" name="category"
                        id="category" onchange="getList();"></select>
            </div>
            <%--<div class="col-md-1">--%>
            <%--<button type="button" class="btn btn-sm btn-info" onclick="getDataForSelectTag('${pageContext.request.contextPath}/category/get-all', 'category');">刷新</button>--%>
            <%--</div>--%>

            <label for="status" class="col-md-1 control-label">状态:</label>

            <div class="col-md-2">
                <select class="form-control input-sm" name="status" id="status"
                        onchange="getList();">
                    <option value="">--请选择--</option>
                    <option value="1">正常</option>
                    <option value="2">关闭</option>
                </select>
            </div>
            <div class="col-md-1 pull-right">
                <button type="button" class="btn btn-sm btn-info"
                        onclick="getList();"><span
                        class="glyphicon glyphicon-search"></span>查询
                </button>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript">
    $(function () {
        if ($('select[name="category"]').find('option').length <= 0) {
            getDataForSelectTag('${pageContext.request.contextPath}/category/get-all', 'category');
        }
    });
</script>
