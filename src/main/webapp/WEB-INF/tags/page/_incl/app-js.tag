<%@ tag description="App Scripts" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<%--## XNAT JavaScript and CSS --%>

<%--## only load once--%>
<c:if test="${empty appJS}">

    <!-- app.css loaded first -->
    <link rel="stylesheet" type="text/css" href="${SITE_ROOT}/style/app.css?${versionString}">

    <!-- Icon sets -->
    <link rel="stylesheet" type="text/css" href="${SITE_ROOT}/style/icons.css?${versionString}">
    <link rel="stylesheet" type="text/css" href="${SITE_ROOT}/page/admin/style.css?${versionString}">

    <link rel="stylesheet" type="text/css" href="${SCRIPTS}/xmodal-v1/xmodal.css?${versionString}">
    <script src="${SCRIPTS}/xmodal-v1/xmodal.js"></script>
    <script src="${SCRIPTS}/xmodal-v1/xmodal-migrate.js"></script>

    <!-- XNAT JLAPI scripts -->
    <script src="${SCRIPTS}/xnat/validate.js"></script>
    <script src="${SCRIPTS}/xnat/url.js"></script>
    <script src="${SCRIPTS}/xnat/xhr.js"></script>
    <script src="${SCRIPTS}/xnat/event.js"></script>
    <script src="${SCRIPTS}/xnat/element.js"></script>
    <script src="${SCRIPTS}/xnat/ui/templates.js"></script>
    <script src="${SCRIPTS}/xnat/ui/input.js"></script>
    <script src="${SCRIPTS}/xnat/ui/select.js"></script>
    <script src="${SCRIPTS}/xnat/ui/table.js"></script>
    <script src="${SCRIPTS}/xnat/ui/panel.js"></script>
    <script src="${SCRIPTS}/xnat/ui/tabs.js"></script>
    <script src="${SCRIPTS}/xnat/ui/banner.js"></script>
    <script src="${SCRIPTS}/xnat/ui/popup.js"></script>
    <script src="${SCRIPTS}/xnat/ui/dialog.js"></script>
    <script src="${SCRIPTS}/xnat/app/codeEditor.js"></script>

    <!-- The Spawner! -->
    <script src="${SCRIPTS}/xnat/spawner.js"></script>


    <jsp:doBody/>


    <!-- app-js is loaded -->
    <c:set var="appJS" value="true" scope="request"/>

</c:if>
