/**
 * [modifyRole description]
 * @param  {[type]} id [description]
 * @return {[type]}    [description]
 */
function modifyRole(form, url, id) {
    form.attr("action", 'update');
    //从后台加载数据填充表单信息
    $.getJSON('${pageContext.request.contextPath}/' + url + '/queryOne', {id: id}, function (rs) {
            for (var key in rs) {
                $.each(form.find('input,select,textarea'), function () {
                    var name = $(this).attr('name'), tagname = $(this).get(0).tagName;
                    if (key == name) {
                        $(tagname + '[name=' + name + ']').val(rs[key]);
                        return;
                    }
                });
            }
        }
    );
}

/**
 * 从后台加载数据填充表单信息
 * @param  {[type]} id [description]
 * @return {[type]}    [description]
 */
function fillForm(form, url, id) {
    $.getJSON('${pageContext.request.contextPath}/' + url + '/queryOne', {id: id}, function (rs) {
            for (var key in rs) {
                $.each(form.find('input,select,textarea'), function () {
                    var name = $(this).attr('name'), tagname = $(this).get(0).tagName;
                    if (key == name) {
                        $(tagname + '[name=' + name + ']').val(rs[key]);
                        return;
                    }
                });
            }
        }
    );
}
