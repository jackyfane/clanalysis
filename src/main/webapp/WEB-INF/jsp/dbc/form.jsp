<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../js.plugin.jsp"/>

    <script type="text/javascript">
        $(function () {
            getDataForSelectTag('', 'driverClass', '${entity.driverClass}');
        });
    </script>
</head>
<!--[if lt IE 7 ]>
<body class="ie ie6">
<![endif]-->
<!--[if IE 7 ]>
<body class="ie ie7 ">
<![endif]-->
<!--[if IE 8 ]>
<body class="ie ie8 ">
<![endif]-->
<!--[if IE 9 ]>
<body class="ie ie9 ">
<![endif]-->
<!--[if (gt IE 9)|!(IE)]>
<!-->
<body>
<div class="panel panel-default">
    <div class="panel-heading navbar-fixed-top breadcrumb">
        <li>
            <a href="#">数据源</a>
        </li>
        <li class="active">数据库配置</li>
    </div>
</div>
<div class="container">
    <form id="defaultForm" data-toggle="validator" role="form"
          class="form-horizontal" action="${action}" method="post"
          style="margin: 10px;">
        <jsp:include page="../form-common-hidden.jsp"/>
        <input type="hidden" id="id" name="id" value="${entity.id}"/>

        <div class="form-group form-group-sm">
            <label for="name" class="col-md-2 control-label">名称:</label>

            <div class="col-md-6">
                <input type="text" class="form-control" id="name" name="name"
                       value="${entity.name}" required autofocus></div>
        </div>
        <div class="form-group form-group-sm">
            <label for="driverClass"
                   class="col-md-2 control-label">数据库系统:</label>

            <div class="col-md-4">
                <select name="driverClass" id="driverClass" class="form-control"
                        required>
                    <option value="">--请选择--</option>
                    <option value="com.mysql.jdbc.Driver">MySQL</option>
                    <option value="oracle.jdbc.driver.OracleDriver">Oracle
                    </option>
                    <option value="com.microsoft.jdbc.sqlserver.SQLServerDriver">
                        SqlServer 2000
                    </option>
                    <option value="com.microsoft.sqlserver.jdbc.SQLServerDriver">
                        SqlServer 2005
                    </option>
                    <option value="org.postgresql.Driver">PostgreSQL</option>
                    <option value="com.sybase.jdbc2.jdbc.SybDriver">Sybase
                    </option>
                    <option value="com.ibm.db2.jdbc.net.DB2Driver">DB2</option>
                    <option value="com.informix.jdbc.IfxDriver">Informix
                    </option>
                </select>
            </div>
        </div>
        <div class="form-group form-group-sm">
            <label for="host" class="col-md-2 control-label">主机(IP):</label>

            <div class="col-md-6">
                <input type="text" class="form-control" id="host" name="host"
                       value="${entity.host}" required></div>
        </div>
        <div class="form-group form-group-sm">
            <label for="port" class="col-md-2 control-label">端口:</label>

            <div class="col-md-6">
                <input type="number" class="form-control" id="port" name="port"
                       value="${entity.port}" required></div>
        </div>
        <div class="form-group form-group-sm">
            <label for="instance" class="col-md-2 control-label">数据库实例:</label>

            <div class="col-md-6">
                <input type="text" class="form-control" id="instance"
                       name="instance" value="${entity.instance}" required>
            </div>
        </div>
        <div class="form-group form-group-sm">
            <label for="username" class="col-md-2 control-label">登录用户:</label>

            <div class="col-md-6">
                <input type="text" class="form-control" id="username"
                       name="username" value="${entity.username}" required>
            </div>
        </div>
        <div class="form-group form-group-sm">
            <label for="password" class="col-md-2 control-label">登录密码:</label>

            <div class="col-md-6">
                <input type="text" class="form-control" id="password"
                       name="password" value="${entity.password}" required>
            </div>
        </div>
        <div class="form-group modal-footer">
            <button type="button" class="btn btn-sm btn-default">取消</button>
            <button type="submit" class="btn btn-sm btn-primary">提交</button>
        </div>
    </form>
</div>
</body>
</html>
