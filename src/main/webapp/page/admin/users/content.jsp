<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<pg:content>

    <c:set var="message">
        <pg:redirect delay="3000">
            <div class="error">Not authorized. Redirecting...</div>
        </pg:redirect>
    </c:set>

    <pg:restricted msg="${message}">

        <c:set var="SITE_ROOT" value="${sessionScope.siteRoot}"/>

        <div id="page-body">
            <div class="pad">

                <div id="user-admin-page">
                    <header id="content-header">
                        <h2 class="pull-left">Manage Users</h2>
                        <div class="clearfix"></div>
                    </header>

                    <!-- Plugin Settings tab container -->
                    <div id="users-groups-tabs">
                        <div class="content-tabs xnat-tab-container">

                                <%--
                                <div class="xnat-nav-tabs side pull-left">
                                    <!-- ================== -->
                                    <!-- Admin tab flippers -->
                                    <!-- ================== -->
                                </div>
                                <div class="xnat-tab-content side pull-right">
                                    <!-- ================== -->
                                    <!-- Admin tab panes    -->
                                    <!-- ================== -->
                                </div>
                                --%>

                        </div>
                    </div>

                    <%--<c:import url="/xapi/users/profiles" var="userProfiles"/>--%>
                    <c:import url="/xapi/users/active" var="activeUsers"/>
                    <c:import url="/xapi/siteConfig" var="siteConfig"/>

                    <script>
                        (function(){

                            XNAT.data =
                                getObject(XNAT.data);

                            XNAT.xapi =
                                getObject(XNAT.xapi);

                            XNAT.xapi.users =
                                getObject(XNAT.xapi.users);

                            <c:if test="${not empty activeUsers}">
                            XNAT.xapi.users.active =
                                XNAT.data['/xapi/users/active'] =
                                    XNAT.data.activeUsers = ${activeUsers};
                            </c:if>

                            <c:if test="${not empty userProfiles}">
                            XNAT.xapi.users.profiles =
                                XNAT.data['/xapi/users/profiles'] =
                                    XNAT.data.userProfiles = ${userProfiles};
                            </c:if>

                            <c:if test="${not empty siteConfig}">
                            XNAT.data.siteConfig =
                                XNAT.data['/xapi/siteConfig'] = ${siteConfig};
                            </c:if>

                            // these properties MUST be set before spawning 'tabs' widgets
                            XNAT.tabs.container = $('#users-groups-tabs').find('div.content-tabs');
                            //XNAT.tabs.layout = 'top';

                        })();
                    </script>

                    <script src="${SITE_ROOT}/scripts/xnat/admin/usersGroups.js"></script>

                </div>

            </div>
        </div>
        <!-- /#page-body -->

        <div id="xnat-scripts"></div>

    </pg:restricted>

</pg:content>
