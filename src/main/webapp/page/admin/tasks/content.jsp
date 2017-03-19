<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<pg:content>

    <c:set var="message">
        <incl:redirect delay="3000">
            <div class="error">Not authorized. Redirecting...</div>
        </incl:redirect>
    </c:set>

    <pg:restricted msg="${message}">

        <script src="${SITE_ROOT}/scripts/xnat/admin/xnatTaskSettings.js"></script>

        <div id="admin-page">
            <header id="content-header">
                <h2 class="pull-left"></h2>
                <div class="clearfix"></div>
            </header>

            <!-- Task Settings tab container -->
            <div id="task-settings-tabs">
            </div>
            <script>
                XNAT.admin.xnatTaskSettings.populateDisplay();
            </script>

        </div>

        <div id="xnat-scripts"></div>

    </pg:restricted>

</pg:content>