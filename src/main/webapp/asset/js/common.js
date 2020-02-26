/**
 * 全局变量
 * 表单校验字段
 * @type {{}}
 */
var verifyFieldsOptions = {};

var page = 1,
    size = 8,
    total = 0;

$(function () {
    getList();

    $('#checkall').click(function () {
        var isChecked = $(this).prop('checked');
        $("input[type='checkbox'][id!='checkall']").prop("checked", isChecked);
    });

    validatorForm();
});

function getList() {
    var data = '';
    if ($('#search-condition').length > 0) {
        data = $('#search-condition').serialize();
    }
    //console.info(data);
    //分页数据，每个list页面都必须去实现fillTbody方法进行渲染，否则页面显示不了内容
    $.getJSON('list/' + page + '/' + size, data, function (rows) {
        var _total = rows.total;
        total = Math.ceil(_total / size);
        fillTbody(rows.list);
        $('#pagination').bootpag({
            total: total,
            page: page,
            maxVisible: 10,
            leaps: true,
            firstLastUse: true,
            first: '←',
            last: '→',
            wrapClass: 'pagination',
            activeClass: 'active',
            disabledClass: 'disabled',
            nextClass: 'next',
            prevClass: 'prev',
            lastClass: 'last',
            firstClass: 'first'
        }).on("page", function (event, num) {
            $.getJSON('list/' + num + '/' + size, function (data) {
                fillTbody(rows.list);
            });
        });
    });
}

function fillTbody() {
};

//表单校验及提交表单
function validatorForm() {
    $('#defaultForm').bootstrapValidator(verifyFieldsOptions).on('success.form.bv', function (e) {
        //console.info(verifyFieldsOptions);
        // Prevent form submission
        e.preventDefault();
        // 获取表单实例
        var $form = $(e.target);
        // 获取表单检验器实例
        var bv = $form.data('bootstrapValidator');
        // 提交数据
        formHandler($form.attr('action'), $form);
        //$.ajax({
        //    type:'post',
        //    url:$form.attr('action'),
        //    data:$form.serializeJson(),
        //    contentType:"application/json",
        //    dataType: 'json',
        //    success: function (r)
        //    {
        //        if (r.success)
        //        {
        //            successAlert(r.message);
        //            location.href="list";
        //        } else {
        //            failureAlert(r.message);
        //        }
        //    },
        //    error: function (e)
        //    {
        //        location.href = getContextPath() + '/'+e.status+'.html';
        //    }
        //});
    });
}

function formHandler(url, form) {
    $.ajax({
        type: 'post',
        url: url,
        data: form.serializeJson(),
        contentType: "application/json",
        dataType: 'json',
        success: function (r) {
            if (r.success) {
                successAlert(r.message);
                location.href = "list";
            } else {
                failureAlert(r.message);
            }
        },
        error: function (e) {
            location.href = getContextPath() + '/' + e.status + '.html';
        }
    });
}

function getContextPath() {
    var pathName = document.location.pathname;
    var index = pathName.substr(1).indexOf("/");
    var result = pathName.substr(0, index + 1);
    return result;
}

/**
 * 清空表单
 */
function cleanForm(action) {
    //如果没有传入行为，则默认是添加
    if (action == null || action == undefined) {
        action = 'add';
    }
    //如果form的action和传入的action一样，则保留缓存
    if (action == $('form').attr('action')) return;
    $('form').attr('action', action);
    $.each($('form').find('input'), function () {
        $(this).val('');
    });
}


function detail(id) {
    location.href = 'detail?id=' + id;
}

/**
 * 删除单行数据
 * @param id
 * @param object
 */
function deleteRow(id) {
    swal({
        title: '告警！',
        text: "您确定要删除选定的数据吗？",
        type: "error",
        confirmButtonClass: 'btn-sm btn-danger',
        cancelButtonText: "取消",
        confirmButtonText: "确定",
        showCancelButton: true,
        cancelButtonClass: "btn-sm",
        closeOnConfirm: false
//        closeOnCancel: false
    }, function (isConfirm) {
        if (isConfirm) {
            $.getJSON('delete/' + id, function (result) {
                if (result.success) {
                    successAlert(result.message);
                } else {
                    failureAlert(result.message);
                }
            });
        }
//        else {
//            swal("温馨提示", "您取消了删除！", "info");
//        }
    });
}

/**
 * 根据ID获取修改的表单数据
 * @param id
 */
function modify(id) {
    var option = {
        type: "error",
        text: "您确定要修改选定的记录吗？",
        confirmButtonClass: 'btn-sm btn-warning',
        title: '告警！',
        cancelButtonText: "取消",
        confirmButtonText: "确定",
        showCancelButton: true,
        cancelButtonClass: "btn-sm",
        closeOnConfirm: false,
        closeOnCancel: false
    };
    swal(option, function (isConfirm) {
        if (isConfirm) {
            location.href = 'form?action=update&id=' + id;
        } else {
            swal("取消操作", "您取消了操作！", "info");
        }
    });
}

/**
 * 增删改
 * @param  {[type]} operate [description]
 * @param  {[type]} action [description]
 * @return {[type]}        [description]
 */
function rud(operate, action) {
    if (operate == "add") {
        location.href = 'form?action=' + action;
        return;
    }
    var array = getIdArray();
    if (array.length <= 0) {
        swal("温馨提示", "请选择你要操作的数据！", "info");
        return;
    } else if (operate == "modify" && array.length > 1) {
        swal("温馨提示", "每次只能修改一条记录！", "info");
        return;
    } else {
        var option = {};
        if (operate == "delete") {
            option.text = "您确定要删除选定的记录吗？";
        } else {
            option.text = "您确定要修改选定的记录吗？";
        }

        option.type = "error";
        option.confirmButtonClass = 'btn-sm btn-warning';
        option.title = '告警！';
        option.cancelButtonText = "取消";
        option.confirmButtonText = "确定";
        option.showCancelButton = true;
        option.cancelButtonClass = "btn-sm";
        option.closeOnConfirm = false;
//        option.closeOnCancel = false;

        swal(option, function (isConfirm) {
            if (isConfirm) {
                if (operate == "delete") {
                    $.ajax({
                        url: 'delete',
                        data: JSON.stringify(array),
                        type: 'post',
                        contentType: "application/json",
                        dataType: 'json',
                        success: function (r) {
                            if (r.success) {
                                successAlert(r.message);
                            } else {
                                failureAlert(r.message);
                            }
                        },
                        error: function (er) {
                            console.info(er);
                        }
                    });
                } else {
                    location.href = 'form?action=' + action + '&id=' + array[0].id;
                }
            }
//            else {
//                swal("取消操作", "您取消了操作！", "info");
//            }
        });
    }
}


/**
 * 更改状态
 * @param  {[type]} status [description]
 * @return {[type]}        [description]
 */
function changeStatus(status) {

}

/**
 * 检查checbox的选中状态并转换为JSON返回
 * @returns {null}
 */
function getIdArray() {
    var array = new Array();
    $("input[type='checkbox'][id!='checkall']").prop('checked', function (i, val) {
        if (val) {
            array.push({
                id: $(this).val()
            });
        }
    });

    return array;
}


/**
 * 从指定的下拉多选框追加到指定的目标下拉多选框
 * [appendToRightMulSelect description]
 * @param  {[type]} original  [description]
 * @param  {[type]} target [description]
 * @return {[type]}                 [description]
 */
function appendToRightMulSelect(original, target) {
    if ($('select[name="' + original + '"] option:checked').length > 0) {
        $('select[name="' + original + '"] option:checked').each(function () {
            var option = this,
                flag = false;
            $.each($.find('select[name="' + target + '"] option'), function () {
                if ($(option).val() == $(this).val()) {
                    flag = true;
                    return;
                }
            });
            if (!flag) {
                var optHtml = '<option value="' + $(this).val() + '">' + $(this).text() + '</option>';
                $('select[name="' + target + '"]').append(optHtml);
            }
        });
    } else {
        swal('温馨提示', '请选择添加的项！');
    }
}

/**
 * 从指定的下拉多选框中移除
 * [removeFromMulSelect description]
 * @param  {[type]} targetSelectName [description]
 */
function removeFromMulSelect(target) {
    if ($('select[name="' + target + '"] option:checked').length > 0) {
        $('select[name="' + target + '"] option:checked').remove();
    } else {
        swal('温馨提示', '请选择移除的项！');
    }
}

function getVisibleUser() {
    var vUser = [];
    $.each($('select[name="visibleUser"] option:selected'), function () {
        vUser.push($(this).val());
    });
    console.log(vUser);
}

/**
 * 当前单选框或者复选框被选中时，获取src的值并通过异步加载将数据添加到目标select
 * [loadAllItemsToTarget description]
 * @param  {[type]} object [checkbox or radio]
 * @param  {[type]} original [源select的name属性]
 * @param  {[type]} target [目标select的name属性]
 * @param  {[type]} selectGroupId [目标selectGroupId]
 * @return {[type]}        [description]
 */
function loadAllItemsToTarget(object, original, target, url, selectGroupId) {
    if ($(object).prop('checked')) {
        var optHtml = '';
        var items = [];
        $.each($('select[name=' + original + '] option'), function () {
            if (!$.isEmptyObject(url)) {
                items.push({
                    id: $(this).val()
                });
            } else {
                optHtml += '<option value=' + $(this).val() + '>' + $(this).text() + '</option>\n';
            }
        });
        if (!$.isEmptyObject(url)) {
            $.getJSON(url, JSON.stringify(items), function (json) {
                $.each(json.list, function () {
                    optHtml += '<option value=' + this.id + '>' + this.name + '</option>\n';
                });
            });
        }
        $('select[name=' + target + ']').html(optHtml);
    }
    if (!$.isEmptyObject(selectGroupId)) {
        $('#' + selectGroupId).toggle();
    }
}

/**
 * 显示指定目标，并隐藏同组的其他标签
 * @param  {[type]} target [description]
 * @return {[type]}        [description]
 */
function showTargetInputGroup(target) {
    $.each($('form').find('.form-conf-group'), function () {
        if ($(this).attr('id') == target) {
            $(this).show();
        } else {
            $(this).hide();
        }
    });
}


/**
 * 弹出窗口的'确定'逻辑处理事件
 * @param  {[type]} target [加载数据的前缀，select的命名规则为：target_select,数据列表ID命名规则为：target-content]
 * @param  {[type]} dialog [显示的模态框对话框]
 * @return {[type]}        [description]
 */
function ensure(target, dialog) {
    $('#' + target + '-content input[type="checkbox"]').prop('checked', function (i, checked) {
        if (checked) {
            var flag = false;
            var value = $(this).val();
            var text = $($(this).parents('tr').find('td')[1]).text();
            $('select[name=' + target + '_select] option').each(function () {
                if ($(this).val() == value) {
                    flag = true;
                    return;
                }
            });
            if (!flag) {
                $('select[name=' + target + '_select]').append('<option value="' + value + '">' + text + '</option>');
            }
        }
        $('#' + dialog).modal('hide');
    });
}

/**
 * 从URL获取数据到指定的select标签
 * @param url
 * @param selectName
 * @param id
 */
function getDataForSelectTag(url, selectName, id) {
    if ($.isEmptyObject(url)) {
        var select = $('select[name=' + selectName + ']');
        if (select.attr('multiple') == undefined && select.find('option').length > 0) {
            $.each(select.find('option'), function () {
                if (id == $(this).val()) {
                    $(this).attr('selected', true);
                }
            });
        }
    } else {
        $.getJSON(url, function (data) {
            var optHtml = '';
            //如果是单选框
            if (!$('select[name="' + selectName + '"]').attr('multiple')) {
                optHtml += '<option value="" selected>请选择</option>\n'
            }
            $.each(data, function () {
                var selected = this.id == id ? ' selected' : '';
                optHtml += '<option value="' + this.id + '" ' + selected + '>' + this.name + '</option>\n';
            });

            $('select[name="' + selectName + '"]').html(optHtml);
        });
    }
}

function clearSelect(property) {
    $('select[name="' + property + '"]').html('');
}

/**
 * 根据Radio被选择时显示和隐藏select组并
 * @param {[type]}  showobj     select标签组ID
 * @param {Boolean} isShow      是否显示
 * @param {[type]}  url         从后台获取数据的请求连接
 * @param {[type]}  leftSelect  左下拉多选框name属性
 * @param {[type]}  rightSelect 右下拉多选框name属性
 */
function selectStatusByRadio(showobj, isShow, url, leftSelect, rightSelect) {
    if ($.isEmptyObject(leftSelect)) {
        $('select[name="' + rightSelect + '"]').attr('disabled', true);
    } else {
        $('select[name="' + rightSelect + '"]').removeAttr('disabled');
    }

    if (isShow) {
        $('#' + showobj).show();
        if ($.isEmptyObject(url)) {
            failureAlert('URL不能为空！');
            return;
        }
        if ($('select[name="' + leftSelect + '"]').find('option').length <= 0) {
            getDataForSelectTag(url, leftSelect);
        }
        //设置为必选
        //$('select[name='+rightSelect+']').attr('required','required');
    } else {
        $('#' + showobj).hide();
        //if($('select[name="'+rightSelect+']"').attr('required'))
        //{
        //    $('select[name="'+rightSelect+'"]').removeAttr('required');
        //}
    }
}

function checkedRadio(radioName, value) {
    if (!$.isEmptyObject(value)) {
        $.each($('input[type="radio"][name=' + radioName + ']'), function () {
            if ($(this).val() == value) {
                $(this).attr('checked', true);
            }
        });
    }
}

function reloadPage() {
    window.location.href = 'list';
}

function clearTextarea(target) {
    $('textarea[name=' + target + ']').val('');
}

function fromMulSelect2Textarea(selectName, textarea, hiddenExpTag) {
    if ($('select[name="' + selectName + '"] option:checked').length > 0) {
        var text = $('select[name="' + selectName + '"] option:checked').text(),
            val = $('select[name="' + selectName + '"] option:checked').val();
        $('#' + textarea).insertContent(val);
        //var express = $('#'+textarea).val().replaceAll(text, val);
        //$('#'+hiddenExpTag).val(express);
    } else {
        swal('温馨提示', '请选择添加的项！');
    }
}

/**
 * 成功提示信息
 * @param msg
 */
function successAlert(msg) {
    swal({
        title: "温馨提示",
        text: msg,
        type: "success",
        confirmButtonClass: 'btn-success',
        confirmButtonText: '关闭'
    }, function () {
        reloadPage();
    });
}

/**
 * 失败提示信息
 * @param msg
 */
function failureAlert(msg) {
    swal({
        title: "温馨提示",
        text: msg,
        type: "warning",
        confirmButtonClass: 'btn-warning',
        confirmButtonText: '关闭'
    });
}

/**
 * 序列化表单为JSON格式数据
 * @returns {{}}
 */
//$.fn.serializeJson=function(){
//    var serializeObj={};
//    var array=this.serializeArray();
//    $(array).each(function(){
//        if(serializeObj[this.name]){
//            if($.isArray(serializeObj[this.name])){
//                serializeObj[this.name].push(this.value);
//            }else{
//                serializeObj[this.name]=[serializeObj[this.name],this.value];
//            }
//        }else{
//            serializeObj[this.name]=this.value;
//        }
//    });
//    return serializeObj;
//};

/**
 *序列化表单为JSON格式数据
 *@returns {{}}
 */
$.fn.serializeJson = function () {
    var obj = {};
    $.each(this.find('input,select,textarea'), function () {
        if ($.isEmptyObject($(this).attr('name'))) {
            return;
        }
        if ($(this).get(0).tagName == 'INPUT') {
            var type = $(this).attr('type');
            if (type == 'radio') {
                if ($(this).prop('checked')) {
                    obj[$(this).attr('name')] = $(this).val();
                }
            } else if (type == 'checkbox') {
                if ($(this).prop('checked')) {
                    obj[$(this).attr('name')] = $(this).val();
                }
            } else {
                obj[$(this).attr('name')] = $(this).val();
            }
        } else if ($(this).get(0).tagName == 'SELECT') {
            if ($(this).attr('multiple')) {
                var select = this;
                $.each($(this).find('option:selected'), function () {
                    if ($.isArray(obj[$(select).attr('name')])) {
                        obj[$(select).attr('name')].push($(this).val());
                    } else {
                        obj[$(select).attr('name')] = [$(this).val()];
                    }
                });
            } else {
                obj[$(this).attr('name')] = $(this).val();
            }
        } else if ($(this).get(0).tagName == 'TEXTAREA') {
            obj[$(this).attr('name')] = $(this).val();
        }
    });
    //console.info(JSON.stringify(obj));
    return JSON.stringify(obj);
}

/**
 * 限定Select可选择的最大项目
 * @param  {[type]} selectName select标签名称
 * @param  {[type]} maxLen     最大可选择项目数
 * @return {[type]}            无
 */
function limitSelectedItem(selectName, maxLen) {

    var selectElm = [];
    $('select[name="' + selectName + '"]').on('click', function () {
        var options = this.options;
        for (var i = 0; i < options.length; i++) {
            var val = $(options[i]).val(),
                index = $.inArray(val, selectElm);
            if ($(options[i]).is(":selected")) {
                if (index == -1) {
                    selectElm.push(val);
                }
            } else {
                if (index != -1) {
                    selectElm.splice(index, 1);
                }
            }
        }
        if (selectElm.length > maxLen) {
            failureAlert('最多只能选择' + maxLen + '项');
            $(this).find('option').attr("selected", false);
            for (var i = 0; i < maxLen; i++) {
                $(this).find('option[value="' + selectElm[i] + '"]').attr('selected', 'selected');
            }
        }
    });
}

$.fn.insertContent = function (myValue, t) {
    var $t = $(this)[0];
    if (document.selection) { //ie
        this.focus();
        var sel = document.selection.createRange();
        sel.text = myValue;
        this.focus();
        sel.moveStart('character', -l);
        var wee = sel.text.length;
        if (arguments.length == 2) {
            var l = $t.value.length;
            sel.moveEnd('character', wee + t);
            t <= 0 ? sel.moveStart("character", wee - 2 * t - myValue.length) : sel.moveStart("character", wee - t - myValue.length);
            sel.select();
        }
    } else if ($t.selectionStart || $t.selectionStart == '0') {
        var startPos = $t.selectionStart;
        var endPos = $t.selectionEnd;
        var scrollTop = $t.scrollTop;
        $t.value = $t.value.substring(0, startPos) + myValue + $t.value.substring(endPos, $t.value.length);
        this.focus();
        $t.selectionStart = startPos + myValue.length;
        $t.selectionEnd = startPos + myValue.length;
        $t.scrollTop = scrollTop;
        if (arguments.length == 2) {
            $t.setSelectionRange(startPos - t, $t.selectionEnd + t);
            this.focus();
        }
    } else {
        this.value += myValue;
        this.focus();
    }
};

/**
 * 判断两个对象的值是否相等
 * @param obj1
 * @param obj2
 */
var equals = function (obj1, obj2) {
    if (obj1.length != obj2.length) {
        return false;
    }

    for (var key in obj1) {
        if (obj1[key] != obj2[key]) {
            return false
        }
    }

    return true;
}

/**
 * 重写jquery ui dialog标题
 */
$.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
    _title: function (title) {
        var $title = this.options.title || '&nbsp;'
        if (("title_html" in this.options) && this.options.title_html == true)
            title.html($title);
        else title.text($title);
    }
}));
