<%@ tag description="Base Scripts" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<%-- Base JavaScript and CS --%>

<c:set var="js" value="js"/>

<%-- load non-minified js if ?debug=true --%>
<c:if test="${param.debug && param.debug == true}" var="debug">
    <c:set var="js" value="min.js"/>
</c:if>

<%-- only load once --%>
<c:if test="${empty baseJS}">

    <!-- load polyfills before ANY other JavaScript -->
    <script src="${SCRIPTS}/polyfills.js"></script>

    <!-- XNAT global functions (no dependencies) -->
    <script src="${SCRIPTS}/globals.js"></script>

    <!-- set global vars that are used often -->
    <script>

        var XNAT = getObject(XNAT);
        var serverRoot = '${SITE_ROOT}';
        var csrfToken = '${csrfToken}';
        <%--
        var showReason = realValue('$!showReason');
        var requireReason = realValue('$!requireReason');
        --%>

    </script>
    <%--## separate script tags so not everything breaks if showReason or requireReason blows up--%>

    <!-- required libraries -->
    <script src="${SCRIPTS}/lib/loadjs/loadjs.${js}"></script>
    <script src="${SCRIPTS}/lib/jquery/jquery.${js}"></script>
    <script src="${SCRIPTS}/lib/jquery/jquery-migrate.${js}"></script>
    <script>
        // alias jQuery to jq
        var jq = jQuery;
    </script>

    <!-- jQuery plugins -->
    <link rel="stylesheet" type="text/css" href="${SCRIPTS}/lib/jquery-plugins/chosen/chosen.min.css?${versionString}">
    <script src="${SCRIPTS}/lib/jquery-plugins/chosen/chosen.jquery.${js}"></script>
    <script src="${SCRIPTS}/lib/jquery-plugins/jquery.maskedinput.${js}"></script>
    <script src="${SCRIPTS}/lib/jquery-plugins/jquery.hasClasses.js"></script>
    <script src="${SCRIPTS}/lib/jquery-plugins/jquery.dataAttr.js"></script>
    <script src="${SCRIPTS}/lib/jquery-plugins/jquery.form.js"></script>
    <script src="${SCRIPTS}/lib/dateTimePicker/jquery.datetimepicker.${js}"></script>

    <!-- other libraries -->
    <script src="${SCRIPTS}/lib/spawn/spawn.js"></script>
    <script src="${SCRIPTS}/lib/js.cookie.js"></script>
    <script src="${SCRIPTS}/lib/yamljs/dist/yaml.js"></script>
    <script src="${SCRIPTS}/lib/form2js/src/form2js.js"></script>
    <script src="${SCRIPTS}/lib/ace/ace.js"></script>

    <!-- XNAT utility functions -->
    <script src="${SCRIPTS}/utils.js"></script>


    <%-- insert page-specific js libraries in the body of <incl:base-js> tag --%>
    <jsp:doBody/>


    <!-- base-js is loaded -->
    <c:set var="baseJS" value="true" scope="request"/>

</c:if>

