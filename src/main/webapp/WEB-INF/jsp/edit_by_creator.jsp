<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="form-group form-group-sm">
    <div class="checkbox">
        <label class="col-md-offset-2 col-md-5">
            <input type="checkbox" name="editByCreator" value="true">仅创建用户可编辑
        </label>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        if (!$.isEmptyObject('${entity.editByCreator}')) {
            $('input[name="editByCreator"]').attr('checked', true);
        }
    });
</script>