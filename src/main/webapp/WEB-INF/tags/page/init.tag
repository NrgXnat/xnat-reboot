<%--@elvariable id="siteConfigPreferences" type="org.nrg.xdat.preferences.SiteConfigPreferences"--%>
<%--@elvariable id="themeService" type="org.nrg.xdat.services.impl.ThemeServiceImpl"--%>
<%@ tag description="Initialize Variables" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:if test="${empty requestScope.hasInit}">

    <script> console.log('init') </script>

    <%--<jsp:useBean scope="request" id="siteConfigPreferences" class="org.nrg.xdat.preferences.SiteConfigPreferences"/>--%>
    <%--<jsp:useBean scope="request" id="siteConfigPreferences" type="org.nrg.xdat.preferences.SiteConfigPreferences"/>--%>
    <%--<jsp:useBean scope="request" id="themeService" class="org.nrg.xdat.services.impl.ThemeServiceImpl"/>--%>

    <%-- set empty user info --%>
    <c:set var="loggedIn" value="false" scope="session"/>
    <c:set var="username" value="-" scope="session"/>
    <c:set var="isAdmin" value="false" scope="session"/>
    <c:set var="isGuest" value="false" scope="session"/>

    <%-- set vars for user --%>
    <sec:authorize access="isAuthenticated()">
        <c:set var="loggedIn" value="true" scope="session"/>
        <c:set var="username" value="${pageContext.request.userPrincipal.name}" scope="session"/>
    </sec:authorize>
    <script> console.log('pageContext.request.userPrincipal.name "${pageContext.request.userPrincipal.name}"') </script>

    <script> console.log('init.tag: sessionScope.loggedIn "${sessionScope.loggedIn}"') </script>

    <%-- REDIRECT IF NOT LOGGED IN (username will be '-') --%>
    <c:if test="${sessionScope.loggedIn == false}">
        <%--<c:redirect url="/page/login/?active=false"/>--%>
    </c:if>

    <script> console.log('username "${username}"') </script>

    <sec:authorize access="hasAnyRole('ADMIN')">
        <c:set var="isAdmin" value="true" scope="session"/>
    </sec:authorize>
    <script> console.log('isAdmin "${isAdmin}"') </script>

    <sec:authorize access="hasAnyRole('ANONYMOUS')">
        <c:set var="isGuest" value="true" scope="session"/>
    </sec:authorize>
    <script> console.log('isGuest "${isGuest}"') </script>

    <%--<sec:authentication property="username" var="USERNAME" scope="session"/>--%>
    <%--<!-- ${USERNAME} -->--%>

    <%-- set 'siteRoot' to the root of your web app --%>
    <c:set var="siteRoot" value="${pageContext.request.contextPath}" scope="session"/>

    <%-- add a leading slash if siteRoot is not empty and doesn't already start with a slash --%>
    <c:if test="${siteRoot != '' && !fn:startsWith(siteRoot,'/')}">
        <c:set var="siteRoot" value="/${pageContext.request.contextPath}" scope="session"/>
    </c:if>

    <c:set var="themeName" value="${themeService.theme.name}" scope="request"/>
    <c:set var="themePath" value="${themeService.theme.path}" scope="request"/>

    <%-- if there's a theme specified in the request, use that --%>
    <c:if test="${empty themeName && not empty param.theme}">
        <c:set var="themeName" value="${param.theme}" scope="session"/>
        <c:set var="themePath" value="${siteRoot}/themes/${themeName}" scope="request"/>
    </c:if>

    <c:set var="themeRoot" value="${siteRoot}/themes/${themeName}" scope="request"/>
    <c:set var="pageRoot" value="${themeRoot}/page" scope="request"/>

    <%-- if no themeName is found, set vars to use root items --%>
    <c:if test="${empty themeName && empty themePath}">
        <c:set var="themeRoot" value="${siteRoot}" scope="request"/>
        <c:set var="pageRoot" value="${siteRoot}/page" scope="request"/>
    </c:if>

    <%-- get session expiration time --%>
    <c:set var="sessionExpiration" value="${cookie.SESSION_EXPIRATION_TIME.value}" scope="session"/>

    <c:set var="csrfToken" value="0" scope="session"/>
    <c:set var="landingPage" value="${pageRoot}/login/#!" scope="session"/>

    <c:if test="${loggedIn == true}">
        <c:set var="csrfToken" value="${sessionScope.XNAT_CSRF}" scope="session"/>
        <c:set var="landingPage" value="${pageRoot}/home/#!" scope="session"/>
    </c:if>

    <%-- is this page in a modal/dialog box --%>
    <c:set var="isModal" value="${not empty param.modal && param.modal == 'true'}" scope="page"/>
    <c:set var="isDialog" value="${not empty param.dialog && param.dialog == 'true'}" scope="page"/>

    <%-- set vars here -- they should be accessible everywhere --%>
    <c:set var="SITE_ROOT" value="${siteRoot}" scope="session"/>
    <c:set var="THEME_ROOT" value="${themeRoot}" scope="session"/>
    <c:set var="USERNAME" value="${username}" scope="session"/>
    <c:set var="csrfToken" value="${csrfToken}" scope="session"/>
    <c:set var="SCRIPTS" value="${SITE_ROOT}/scripts" scope="session"/>
    <c:set var="versionString" value="v=1.7.3r1" scope="session"/>

    <c:set var="hasInit" value="true" scope="request"/>

</c:if>

<%-- inject content on init--%>
<jsp:doBody/>
