<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/asset/css/ztree.css">
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/asset/css/zTreeStyle/zTreeStyle.css">

<jsp:include page="../js.plugin.jsp" flush="false"/>

<script src="${pageContext.request.contextPath}/asset/js/jquery.validate.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.validate_zh.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.ztree.core-3.5.min.js"></script>
<script src="${pageContext.request.contextPath}/asset/js/jquery.ztree.excheck-3.5.min.js"></script>

<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li>
            <a href="#">系统设置</a>
        </li>
        <li class="active">角色管理</li>
    </div>
    <div class="panel-body">
        <div class="panel panel-success">
            <div class="panel-heading">用户列表信息</div>
            <div class="panel-body">
                <div class="btn-toolbar" role="toolbar">
                    <div class="btn-group btn-group-sm" role="group"
                         aria-label="...">
                        <!-- <button type="button" class="btn btn-info" onclick="rud('add','add');">
                            <span class="fa fa-plus-circle blue"></span>
                            添加
                        </button>
                        <button type="button" class="btn btn-warning" onclick="rud('modify','update');">
                            <span class="fa fa-pencil-square-o"></span>
                            修改
                        </button> -->
                        <button type="button" class="btn btn-info"
                                data-toggle="modal" operate="add"
                                data-backdrop="static" data-target="#myModal">
                            <span class="fa fa-plus-circle blue"></span>
                            添加
                        </button>
                        <button type="button" class="btn btn-warning"
                                data-toggle="modal" operate="update"
                                data-target="#myModal">
                            <span class="fa fa-pencil-square-o"></span>
                            修改
                        </button>
                        <button type="button" class="btn btn-danger"
                                onclick="rud('delete', '');">
                            <span class="fa fa-trash-o"></span>
                            删除
                        </button>
                    </div>
                </div>
                <table class="table table-bordered table-striped table-condensed table-hover"
                       id="searchable-container">
                    <thead>
                    <tr>
                        <th>
                            <label>
                                全选
                                <input type="checkbox" id="checkall"/>
                            </label>
                        </th>
                        <th>角色名称</th>
                        <th>权限</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="list-content"></tbody>
                </table>
                <!-- 分页 -->
                <div class="pagination pull-right" id="pagination"></div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title"><i class="fa fa-info-circle"></i> 角色信息
                </h4>
            </div>
            <form id="roleForm" class="form form-horizontal" action="add">
                <div class="modal-body">
                    <div style="display: none;">
                        <input type="hidden" name="id" id="id">
                        <input type="hidden" name="createdTime"
                               id="createdTime">
                        <select name="menus" multiple="multiple"
                                id="menus"></select>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 text-right">角色名称：</div>
                        <div class="col-sm-6">
                            <input type="text" name="name" id="name"
                                   class="form-control input-sm" required></div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-3 text-right">权限设置：</div>
                        <div class="col-sm-6">
                            <input type="text" name="menuNames" id="menuNames"
                                   class="form-control input-sm"
                                   readonly="readonly" onclick="showMenu();"
                                   required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-sm btn-info">清空</button>
                    <button type="button" class="btn btn-sm btn-warning"
                            data-dismiss="modal">取消
                    </button>
                    <button type="submit" class="btn btn-sm btn-primary">保存
                    </button>
                </div>
            </form>
        </div>
    </div>
    <div id="menuContent" class="menuContent"
         style="display:none; position: absolute;">
        <ul id="menuNode" class="ztree"
            style="margin-top:0; width:180px; height: 300px;"></ul>
    </div>
</div>
</body>
</html>
<style type="text/css">
    .tree {
        text-align: right;
    }

    .tree ul {
        list-style: none;
        text-align: none;
    }

    .tree ul li {
        list-style: none;
        text-align: none;
    }
</style>

<script type="text/javascript">
    var zTreeNodes, listDataNodes = [], roleNodes = [];
    var setting = {
        check: {
            enable: true,
            chkStyle: "checkbox",
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

    $(function () {

        $('#roleForm').validate({
            submitHandler: function (form) {
                var $form = $(form);
                // console.log($form.serializeJson());
                formHandler($form.attr('action'), $form);
            }
        });

        $('#myModal').on('hide.bs.modal', function () {
            document.getElementById('roleForm').reset();
        });

        $('#myModal').on('show.bs.modal', function (e) {
            // console.log(e.relatedTarget);
            var operate = $(e.relatedTarget).attr('operate');
            if (operate == 'update') {
                var checkedObj = $('#list-content').find('input[type="checkbox"]:checked');
                var len = checkedObj.length;
                if (len <= 0) {
                    failureAlert('请选择修改的数据！');
                    e.preventDefault();//阻止事件发生，阻止modal框显示
                    return;
                }
                if (len > 1) {
                    failureAlert('每次只能修改一条记录！');
                    e.preventDefault();//阻止事件发生，阻止modal框显示
                    return;
                }

                fillForm($(checkedObj).val());
            }

            $('#roleForm').attr('action', operate);
        });

        $.getJSON('${pageContext.request.contextPath}/menu/menuZTree', function (data) {
            zTreeNodes = data;
            // console.log(JSON.stringify(data));
            // getMenuZTree(data);
            $.fn.zTree.init($('#menuNode'), setting, zTreeNodes);
        });
    });

    /**
     * [modifyRole description]
     * @param  {[type]} id [description]
     * @return {[type]}    [description]
     */
    function modifyRow(id) {
        fillForm(id);
        $('#roleForm').attr("action", 'update');
    }

    /**
     * 从后台加载数据填充表单信息
     * @param  {[type]} id [description]
     * @return {[type]}    [description]
     */
    function fillForm(id) {
        $.getJSON('${pageContext.request.contextPath}/role/queryOne', {id: id}, function (rs) {
                    for (var key in rs) {
                        // $.each($('#roleForm').find('input,select,textarea'), function(){
                        //     var name=$(this).attr('name'), tagname = $(this).get(0).tagName;
                        //     if(key == name) {
                        //         $(tagname+'[name='+name+']').val(rs[key]);
                        //         return;
                        //     }
                        // });
                        $('#' + key).val(rs[key]);
                    }
                }
        );
    }

    /**
     * 显示菜单树
     * @return {[type]} [description]
     */
    function showMenu() {
        var menuNames = $("#menuNames");
        var menuNamesOffset = $("#menuNames").offset();
        var left = menuNamesOffset.left,
                top = menuNamesOffset.top + menuNames.outerHeight(),
                width = menuNames.outerWidth(),
                height = $(document).height() - top - 150;
        // pHeight = $(window.parent.document).height()-100,
        $("#menuNode").css('width', width).css('height', height);
        $("#menuContent").css({
            left: left + "px",
            top: top + "px"
        }).slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }

    /**
     *
     * @return {[type]} [description]
     */
    function resetZTreeNodes() {
        var id = $('tbody').find('input[type="checkbox"]:checked').val();
        var resoureIds, len = listDataNodes.length;
        for (var i = 0; i < len; i++) {
            var roleObj = listDataNodes[i];
            if (roleObj.id == id) {
                resoureIds = listDataNodes[i].menuids;
                break;
            }
        }
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
        var menusOpts = '', menuNames = [];
        for (var i = 0; i < nodes.length; i++) {
            menusOpts += '<option value="' + nodes[i].id + '" selected="selected">' + nodes[i].name + '</option>';
            menuNames.push(nodes[i].name);
        }
        $("#menus").html(menusOpts);
        $("#menuNames").val(menuNames.toString());
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
                obj.open = false;
            zTreeNodes.push(obj);
            if (menu.children.length) {
                getMenuZTree(menu.children);
            }
        }
    }

    /**
     * [selectedRow description]
     * @param  {[type]} obj [description]
     * @return {[type]}     [description]
     */
    function selectedRow(row) {
        $.each($(row).children('td'), function (i) {
            switch (i) {
                case 0:
                    var id = $($(this).find('input')).val();
                    $('#id').val(id);
                    $('tbody').find('input[value="' + id + '"]').prop('checked', true);
                    $('tbody').find('input:not([value="' + id + '"])').prop('checked', false);
                    for (var i = 0; i < listDataNodes.length; i++) {
                        if (listDataNodes[i].id == id) {
                            var menuIds = listDataNodes[i].menuids;
                            var names = listDataNodes[i].names;
                            var menusOpts = '';
                            for (var j = 0; j < menuIds.length; j++) {
                                menusOpts += '<option value="' + menuIds[j] + '" selected="selected">' + names[j] + '</option>';
                            }
                            $("#menus").html(menusOpts);
                            $("#menuNames").val(names.toString());
                            break;
                        }
                    }
                    break;
                case 1:
                    $('#name').val($(this).text());
                    break;
                case 2:
                    break;
                case 3:
                    $('#createdTime').val($(this).text());
                    break;
                default:
                    break;
            }
        });
    }

    /**
     * [fillTbody description]
     * @param  {[type]} list [description]
     * @return {[type]}      [description]
     */
    function fillTbody(list) {
        var html = '';
        if (list == null || list == '') {
            html = '<tr><td colspan="6">没有数据</td></tr>';
        } else {
            $.each(list, function (i) {
                html += '<tr onclick="selectedRow(this);">\n';
                html += '\t<td><input type="checkbox" value="' + this.id + '"/></td>\n';
                html += '\t<td>' + this.name + '</td>\n';
                html += '\t<td><div id="role-tree-' + i + '" class="ztree"></div></td>\n';
                html += '\t<td>' + this.createdTime + '</td>\n';
                html += '\t<td>\n';
                html += '\t\t<a href="#" data-toggle="modal" data-target="#myModal" onclick="modifyRow(\'' + this.id + '\');" data-backdrop="static"><span class="fa fa-pencil-square-o"></span>编辑</a> |\n';
                //html += '\t\t<a href="#" onclick="detail(\''+this.id+'\');"><span class="fa fa-list"></span>详细</a> |\n';
                html += '\t\t<a href="#" onclick="deleteRow(\'' + this.id + '\');"><span class="fa fa-trash"></span>删除</a>\n';
                html += '\t</td>\n';
                html += '</tr>\n';

                changeToZTree('role-tree-' + i, this.id, this.menus);
            });
        }
        $("#list-content").html(html);

        var len = roleNodes.length;
        for (var i = 0; i < len; i++) {
            $.fn.zTree.init($('#' + roleNodes[i].id), {
                data: {
                    simpleData: {
                        enable: true
                    }
                }
            }, roleNodes[i].nodes);
        }
    }

    /**
     * [formatterRole description]
     * @return {[type]} [description]
     */
    function changeToZTree(treeNodeId, id, rsdata) {
        var nodes = [], menuIds = [], menuNames = [], zNodes = [];
        for (var i = 0; i < rsdata.length; i++) {
            var rs = rsdata[i], node = {};
            if (menuIds.indexOf(rs.id) == -1) {
                menuIds.push(rs.id);
                if (rs.parent) {
                    if (menuIds.indexOf(rs.parent.id) == -1) {
                        menuIds.push(rs.parent.id);
                    }
                }
            }

            if (menuNames.indexOf(rs.name) == -1) {
                menuNames.push(rs.name);
                if (rs.parent) {
                    if (menuNames.indexOf(rs.parent.name) == -1) {
                        menuNames.push(rs.parent.name);
                    }
                }
            }

            if (rs.parent) {
                node.id = rs.parent.id;
                node.name = rs.parent.name;
                node.children = [{id: rs.id, name: rs.name, children: []}];
            } else {
                node.id = rs.id;
                node.name = rs.name;
                node.children = [];
            }

            if (nodes.length == 0) {
                nodes.push(node);
                continue;
            }

            var cNode = node['children'][0],
                    isRoot = true;

            for (var j = 0; j < nodes.length; j++) {
                if (node.id == nodes[j].id) {
                    if (!$.isEmptyObject(cNode)) {
                        nodes[j]['children'].push(cNode);
                    }
                    isRoot = false;
                } else {
                    for (var k = 0; k < nodes[j].children.length; k++) {
                        var child = nodes[j].children[k];
                        if (node.id == child.id) {
                            if (!$.isEmptyObject(cNode)) {
                                nodes[j].children[k]['children'].push(cNode);
                                isRoot = false;
                                break;
                            }
                        }
                    }
                }
                if (!isRoot) break;
            }
            if (isRoot) {
                nodes.push(node);
            }
        }

        listDataNodes.push({id: id, menuids: menuIds, names: menuNames});
        roleNodes.push({
            id: treeNodeId,
            nodes: [{name: '拥有权限', children: nodes}]
        });
    }

    /**
     * [createTreeNodes description]
     * @param  {[type]} rsdata [description]
     * @return {[type]}        [description]
     */
    function createTreeNodes(rsdata) {
        var zNodes = [];
        for (var i = 0; i < rsdata.length; i++) {
            var rs = rsdata[i], node = {};

            var n = createTreeNode(rs);
            console.log(JSON.stringify(n));
            if (rs.parent) {
                node.id = rs.parent.id;
                node.name = rs.parent.name;
                node.children = [{id: rs.id, name: rs.name, children: []}];
            } else {
                node.id = rs.id;
                node.name = rs.name;
                node.children = [];
            }

            if (zNodes.length == 0) {
                zNodes.push(node);
                continue;
            }

            var cNode = node['children'][0],
                    isRoot = true;

            for (var j = 0; j < zNodes.length; j++) {
                if (node.id == zNodes[j].id) {
                    if (!$.isEmptyObject(cNode)) {
                        zNodes[j]['children'].push(cNode);
                    }
                    isRoot = false;
                } else {
                    for (var k = 0; k < zNodes[j].children.length; k++) {
                        var child = zNodes[j].children[k];
                        if (node.id == child.id) {
                            if (!$.isEmptyObject(cNode)) {
                                zNodes[j].children[k]['children'].push(cNode);
                                isRoot = false;
                                break;
                            }
                        }
                    }
                }
                if (!isRoot) break;
            }
            if (isRoot) {
                zNodes.push(node);
            }
        }
    }


    /**
     * 创建节点树
     * @param  {[type]} nodes [description]
     * @return {[type]}       [description]
     */
    function createRolesNodeTree(nodes) {
        var ntree = '<ul><i class="fa-plus-circle fa"></i>';
        for (var i = 0; i < nodes.length; i++) {
            var node = nodes[i];
            ntree += '<li>' + node.name;
            if (node.child.length > 0) {
                ntree += createRolesNodeTree(node.child);
            }
            ntree += '</li>'
        }
        return ntree += '</ul>';
    }

</script>
