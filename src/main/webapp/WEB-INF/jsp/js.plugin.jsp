<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="uripath"
       value="http://${pageContext.request.serverName}:${pageContext.request.serverPort}/${pageContext.request.contextPath}"
       scope="application"/>

<link rel="stylesheet" type="text/css"
      href="${uripath}/asset/css/bootstrap.min.css"/>
<%--
<link rel="stylesheet" type="text/css" href="${uripath}/asset/css/bootstrap-theme.min.css"/>
--%>
<link rel="stylesheet" type="text/css"
      href="${uripath}/asset/css/bootstrap-treeview.min.css"/>
<link rel="stylesheet" type="text/css"
      href="${uripath}/asset/css/sweetalert.css"/>
<link rel="stylesheet" type="text/css"
      href="${uripath}/asset/css/themes/facebook/facebook.css"/>
<link rel="stylesheet" type="text/css"
      href="${uripath}/asset/css/bootstrapValidator.min.css"/>
<link rel="stylesheet" type="text/css"
      href="${uripath}/asset/css/font-awesome.min.css"/>
<link rel="stylesheet" type="text/css" href="${uripath}/asset/css/style.css"/>

<!--[if IE 7]>
<link rel="stylesheet" href="${uripath}/asset/css/font-awesome-ie7.min.css"/>
<![endif]-->
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="${uripath}/asset/css/jquery.ui.1.10.0.ie.css"/>
<![endif]-->

<script src="${uripath}/asset/js/jquery-2.1.3.min.js"></script>
<script src="${uripath}/asset/js/jquery-ui-1.9.2.custom.min.js"></script>
<script src="${uripath}/asset/js/bootstrap.min.js"></script>
<script src="${uripath}/asset/js/bootstrap-treeview.min.js"></script>
<script src="${uripath}/asset/js/sweetalert.min.js"></script>
<script src="${uripath}/asset/js/bootstrapValidator.min.js"></script>
<script src="${uripath}/asset/js/jquery.bootpag.min.js"></script>
<script src="${uripath}/asset/js/xlsx.full.min.js"></script>
<script src="${uripath}/asset/js/papaparse.min.js"></script>

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
<script src="${uripath}/asset/js/html5shiv.min.js"></script>
<![endif]-->

<%-- Custom JS--%>
<script src="${uripath}/asset/js/common.js"></script>
<script src="${uripath}/asset/js/dateutil.js"></script>
