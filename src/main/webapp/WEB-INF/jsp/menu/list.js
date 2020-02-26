var menuTreeGrid, rowIdLabel, zTreeNodes = [{
    id: '',
    pid: '',
    name: '作为顶级菜单',
    open: true
}];
var setting = {
    check: {
        enable: true,
        chkStyle: "radio",
        radioType: "all"
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        onClick: onClick,
        onCheck: onCheck
    }
};

jQuery(function ($) {
    $("#form-dialog").dialog({
        autoOpen: false,
        resizable: false,
        bgiframe: true,
        modal: true,
        width: 780,
        title: "<div class='widget-header'><h4 class='smaller'><i class='fa fa-info-circle blue'></i> 设置菜单</h4></div>",
        title_html: true
    });

    $.getJSON('${pageContext.request.contextPath}/menu/menuZTree', function (data) {
        getMenuZTree(data);
        $.fn.zTree.init($('#menuNode'), setting, zTreeNodes);
    });

    menuTreeGrid = $('#treegrid').jqGrid({
        treeGrid: true,
        treeIcons: {
            plus: 'ui-icon-triangle-1-e',
            minus: 'ui-icon-triangle-1-s',
            leaf: 'ui-icon-radio-off'
        },
        styleUI: 'bootstrap',
        treeGridModel: 'adjacency',
        ExpandColumn: 'name',
        ExpandColClick: true,
        url: '${pageContext.request.contextPath}/menu/treegrid',
        datatype: "json",
        mtype: 'get',
        pgtext: '第{0}页 共{1}页',
        recordtext: '第 {0} - {1}条记录 ',
        height: $(document).height() * 0.68,
        altRows: true,
        multiselect: true,
        multiboxonly: true,
        rowNum: -1,//全部显示
        autowidth: true,
        shrinkToFit: true,
        sortname: 'position',
        sortorder: 'asc',
        loadtext: '请稍等，正在加载数据.....',
        loaderror: '系统异常，请联系管理员！',
        emptyrecords: '没有数据',
        caption: '系统菜单信息',
        onselectrow: true,
        pager: '#pager',
        colNames: ['菜单名称', '父级菜单', '菜单标识', '路径', '图标', '是否显示', '是否启用', '描述', '操作'],
        colModel: [
            {
                name: 'name',
                index: 'name',
                editable: true,
                sortable: true
            },
            {
                name: 'parent',
                editable: true,
                hidden: true,
                sortable: true
            },
            {
                name: 'identify',
                index: 'identify',
                align: 'center',
                editable: true,
                sortable: true
            },
            {
                name: 'linkURL',
                index: 'linkURL',
                align: 'center',
                editable: true,
                sortable: true
            },
            {
                name: 'icon',
                index: 'icon',
                align: 'center',
                editable: true,
                sortable: true
            },
            {
                name: 'visible',
                index: 'visible',
                align: 'center',
                formatter: function (el, cells, opts) {
                    if (opts.enable) {
                        return '显示';
                    } else {
                        return '隐藏';
                    }
                },
                editable: true,
                edittype: 'select',
                editoptions: {
                    value: "1:显示;0:隐藏"
                }
            },
            {
                name: 'enable',
                index: 'enable',
                align: 'center',
                formatter: function (el, cells, opts) {
                    if (opts.enable) {
                        return '启用';
                    } else {
                        return '禁用';
                    }
                },
                editable: true,
                edittype: 'select',
                editoptions: {
                    value: "1:启用;0:禁用"
                }
            },
            {
                name: 'description',
                index: 'description',
                align: 'center',
                editable: true
            },
            {
                name: '',
                index: '',
                align: 'center',
                formatter: operateFormatter
            }
        ],
        jsonReader: {
            root: 'rows',
            repeatitems: false
        }
        // ondblClickRow:function(rowid, col,cell){
        //     if(rowIdLabel != rowid){
        //         menuTreeGrid.jqGrid('showCol', 'parent');
        //         menuTreeGrid.jqGrid('editRow',rowid, true);
        //         rowIdLabel = rowid;
        //     }
        // },
        // onSelectRow:function(rowid, col,cell) {
        //     console.log(typeof rowIdLabel)
        //     if(!rowIdLabel) return;
        //     if(rowIdLabel && rowIdLabel != rowid) {
        //         var rowData = menuTreeGrid.jqGrid('getRowData', rowIdLabel);
        //         console.log(rowData['name']);
        //     }
        // }
    }).navGrid('#pager', {
        add: false,
        edit: false,
        del: false,
        search: false,
        refresh: false
    }).navButtonAdd('#pager', {
        caption: '',
        buttonicon: "ui-icon-plus",
        title: "添加",
        onClickButton: function () {
            showFormDialog('add');
        }
    }).navButtonAdd('#pager', {
        caption: '',
        buttonicon: "ui-icon-penceil",
        position: "second",
        title: "修改",
        onClickButton: function () {
            showFormDialog('update');
        }
    }).navButtonAdd('#pager', {
        caption: '',
        buttonicon: "ui-icon-remove",
        onClickButton: function () {

        }
    }).navButtonAdd('#pager', {
        caption: '',
        buttonicon: "ui-icon-refresh",
        onClickButton: function () {
            menuTreeGrid.trigger('reloadGrid');
        }
    });

    $('#menuForm').validate({
        submitHandler: function (form) {
            var $form = $(form);
            //console.log($form.serializeJson());
            formHandler($form.attr('action'), $form);
            $("#form-dialog").dialog("close");
        }
    });
});

$('#treegrid').jqGrid('getGridParam', 'selarrrow');

/**
 * 显示菜单树
 * @return {[type]} [description]
 */
function showMenu() {
    var parentName = $("#parentName");
    var parentNameOffset = $("#parentName").offset();
    var dialog = $("#form-dialog");
    var dialogOffset = $("#form-dialog").offset();
    var left = parentNameOffset.left - dialogOffset.left,
        top = parentNameOffset.top - dialogOffset.top + parentName.outerHeight(),
        width = parentName.outerWidth(),
        height = dialog.outerHeight();

    $("#menuNode").css('width', width).css('height', height - 100);
    $("#menuContent").css({
        left: left + "px",
        top: top + "px"
    }).slideDown("fast");

    $("body").bind("mousedown", onBodyDown);
}

/**
 * 隐藏菜单树
 * @return {[type]} [description]
 */
function hideMenu() {
    $("#menuContent").fadeOut("fast");
    $("body").unbind("mousedown", onBodyDown);
}

function onBodyDown(event) {
    if (!(event.target.id == "menuBtn" || event.target.id == "parent" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
        hideMenu();
    }
}

/**
 * [onClick description]
 * @param  {[type]} e        [description]
 * @param  {[type]} treeId   [description]
 * @param  {[type]} treeNode [description]
 * @return {[type]}          [description]
 */
function onClick(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("menuNode");
    zTree.checkNode(treeNode, !treeNode.checked, null, true);
    return false;
}

/**
 * [onCheck description]
 * @param  {[type]} e        [description]
 * @param  {[type]} treeId   [description]
 * @param  {[type]} treeNode [description]
 * @return {[type]}          [description]
 */
function onCheck(e, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("menuNode"),
        nodes = zTree.getCheckedNodes(true);
    $("#parentName").val(nodes[0].name);
    $("#parent").val(nodes[0].id);
    hideMenu();
}

/**
 * 显示
 * @param  {[type]} action [description]
 * @return {[type]}        [description]
 */
function showFormDialog(action, rowid) {
    $("#form-dialog").removeClass('hide').dialog('open');
    $('#menuForm').attr('action', action);
    if ('update' == action && rowid) {
        $.getJSON('${pageContext.request.contextPath}/menu/getMenuJsonById', {id: rowid}, function (obj) {
            for (var key in obj) {
                if ($('#' + key).attr('name')) {
                    var value = obj[key], tagName = $('#' + key).get(0).tagName,
                        type = $('#' + key).attr('type');
                    if (tagName == 'TEXTAREA') {
                        $('textarea[name="' + key + '"]').text(value);
                    } else if (tagName == 'INPUT') {
                        if (type == 'checkbox' || type == 'radio') {
                            $('input[name="' + key + '"][value="' + value + '"]').prop('checked', true);
                        } else {
                            $('input[name="' + key + '"]').val(value);
                        }
                    } else if (tagName == 'SELECT') {
                        $('select[name="' + key + '"]').find('option[value="' + value + '"]').attr('select', true);
                    }
                }
            }
        });
    }
}

/**
 * [getMenuZTree description]
 * @param  {[type]} menus [description]
 * @return {[type]}       [description]
 */
function getMenuZTree(menus) {
    for (var i = 0; i < menus.length; i++) {
        var menu = menus[i], obj = {};
        obj.id = menu.id;
        obj.pId = menu.parent;
        obj.name = menu.name;
        if (!menu.parent)
            obj.open = true;
        zTreeNodes.push(obj);
        if (menu.children.length) {
            getMenuZTree(menu.children);
        }
    }
}

/**
 * 隐藏表单对话框
 * @return {[type]} [description]
 */
function hideFormDialog() {
    document.getElementById('menuForm').reset();
    $("#form-dialog").dialog('close');
}

function operateFormatter(el, cellVal, opts) {
    var rowid = opts.id;
    var html = '';
    html += '<a href="javascript:void(0);" onclick="showFormDialog(\'update\',\'' + rowid + '\');"><i class="fa fa-pencil"></i> 修改</a> | ';
    html += '<a href="javascript:void(0);" onclick="removeRowMenu(\'' + rowid + '\')"><i class="fa fa-trash"></i> 删除</a>';

    return html;
}

/**
 * [removeRow description]
 * @param  {[type]} rowid [description]
 * @return {[type]}       [description]
 */
function removeRowMenu(rowid) {
    $.getJSON('${pageContext.request.contextPath}/menu/getMenuJsonById', {id: rowid}, function (obj) {
        if (obj.children.length) {
            swal({
                title: "警告！",
                text: "不是子节点，请确认是否要删除？",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除!",
                cancelButtonText: "取消",
                closeOnConfirm: false
            }, function (isConfirm) {
                if (isConfirm) {
                    var opts = {
                        text: "你将删除当前节点及所有其子节点？",
                        confirmButtonText: "强制删除!",
                        id: rowid
                    };
                    deleteOperate(opts, rowid);
                }
            });
        } else {
            var opts = {
                text: "你确定删除此节点？",
                confirmButtonText: "删除!",
                id: rowid
            };
            deleteOperate(opts, rowid);
        }
    });
}

/**
 * [deleteOperate description]
 * @param  {[type]}  String  id            [description]
 * @param  {Boolean} isForce [description]
 * @return {[type]}          [description]
 */
function deleteOperate(opts) {
    swal({
        title: "警告！",
        text: opts.text,
        type: "error",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: opts.confirmButtonText,
        cancelButtonText: "取消",
        closeOnConfirm: false
    }, function (isConfirm) {
        if (isConfirm) {
            $.getJSON('${pageContext.request.contextPath}/menu/delete/' + opts.id, function (result) {
                if (result.success) {
                    successAlert(result.message);
                    menuTreeGrid.trigger('reloadGrid');
                } else {
                    failureAlert(result.message);
                }
            });
        }
    });
}