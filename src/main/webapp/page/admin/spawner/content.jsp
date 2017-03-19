<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>
<%--<%@ taglib prefix="sp" tagdir="/WEB-INF/tags/spawner" %>--%>

<pg:content>

    <%-- static message --%>
    <c:set var="message">
        <div class="error">No spawning allowed.</div>
    </c:set>

    <pg:restricted msg="${message}">

        <c:set var="SITE_ROOT" value="${sessionScope.siteRoot}"/>

        <div class="panel panel-default">

            <div class="panel-heading">
                <h3 class="panel-title">XNAT Spawner Elements</h3>
            </div>

            <div class="panel-body">

                <div data-name="spawnerElements" class="panel-element" style="overflow:visible;">

                    <div class="description" style="margin:20px 5px 0">View and manage XNAT Spawner elements.</div>

                        <%--<label class="element-label" for="!?"></label>--%>
                        <%--<div class="element-wrapper">--%>

                    <style type="text/css">
                        #spawner-element-list td {
                            padding: 4px;
                        }
                    </style>

                    <table id="spawner-element-list" class="xnat-table highlight alt1 clean" style="width:100%;border:none;">
                        <!-- list of available namespaces will show here -->
                    </table>

                        <%--</div>--%>

                </div>
            </div>

            <div class="hidden"></div>

        </div>

        <!-- button element will be rendered in this span -->
        <span id="view-json"></span>

        <script src="${SITE_ROOT}/page/admin/spawner/spawner-admin.js"></script>

    </pg:restricted>

</pg:content>