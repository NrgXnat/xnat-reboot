<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="vel" uri="http://velocity.apache.org/velocity-view" %>
<%--<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%--<jsp:useBean id="siteConfigPreferences" class="org.nrg.xdat.preferences.SiteConfigPreferences"/>--%>
<%--<jsp:useBean scope="request" id="siteConfigPreferences" type="org.nrg.xdat.preferences.SiteConfigPreferences"/>--%>
<jsp:useBean scope="request" id="themeService" class="org.nrg.xdat.services.impl.ThemeServiceImpl"/>
<%--<jsp:useBean scope="request" id="jsonParse" class="com.google.gson.JsonParser"/>--%>

<c:set var="pageName" value="login" scope="page"/>

<pg:init>

    <script> console.log('login/content.jsp: sessionScope.loggedIn "${loggedIn}"') </script>

    <c:if test="${loggedIn == true}">
        <pg:redirect href="/" delay="5000">
            <div class="message">Already logged in. Redirecting to home page...</div>
        </pg:redirect>
    </c:if>

    <%--<fmt:setBundle basename="messages"/>--%>

    <%--<fmt:message key="message.username" var="noUser"/>--%>
    <%--<fmt:message key="message.password" var="noPass"/>--%>

    <%-- show login box only if not already logged in --%>
    <pg:content show="${loggedIn == false}">

        <script src="${SCRIPTS}/lib/epicEditor/js/epiceditor.js"></script>

        <%-- TODO: handle login errors --%>

        <%--<c:if test="${param.error != null}">--%>
        <%--<div class="error">--%>
        <%--<spring:message code="message.badCredentials"/>--%>
        <%--</div>--%>
        <%--</c:if>--%>

        <%--<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">--%>
        <%--<div class="error">--%>
        <%--<spring:message code="message.logoutError"/>--%>
        <%--</div>--%>
        <%--</c:if>--%>
        <%--<c:if test="${param.success == true}">--%>
        <%--<div class="success">--%>
        <%--<spring:message code="message.logoutSucc"/>--%>
        <%--</div>--%>
        <%--</c:if>--%>

        <script>
            console.log('themeService.theme');
            console.log('${themeService.theme}');
        </script>

        <%-- TODO: directly access these properties, rather than separate requests --%>
        <c:import scope="request" var="siteDescriptionType" url="/xapi/siteConfig/siteDescriptionType"/>
        <c:import scope="request" var="siteDescriptionPage" url="/xapi/siteConfig/siteDescriptionPage"/>
        <c:import scope="request" var="siteDescriptionText" url="/xapi/siteConfig/siteDescriptionText"/>

        <script>
            console.log('siteId: ${siteId}');
            console.log('siteLogoPath: ${siteLogoPath}');
            console.log('siteDescriptionType: ${siteDescriptionType}');
            console.log('siteDescriptionPage: ${siteDescriptionPage}');
            console.log('siteDescriptionPage: ${siteDescriptionText}');
        </script>

        <div id="login-page">

            <div id="login-welcome">

                <a id="header_logo" href="${SITE_ROOT}/" title="XNAT version Unknown">
                    <%--<c:set var="logoPath"><c:url var="logoPath" value="${not empty siteLogoPath ? siteLogoPath : '/images/logo.png'}"/></c:set>--%>
                    <img class="logo-img" src="${SITE_ROOT}/images/logo.png" style="border:none;">
                </a>

                <c:if test="${siteDescriptionType.toLowerCase().contains('page')}">
                    <c:catch var="siteDescriptionPageError">
                        <jsp:include page="${siteDescriptionPage}"/>
                    </c:catch>
                    <c:if test="${not empty siteDescriptionPageError}">
                        <script> console.error('${siteDescriptionPageError}') </script>
                        <c:catch var="defaultDescriptionPageError">
                            <jsp:include page="/page/_incl/site-description.jsp"/>
                        </c:catch>
                        <c:if test="${not empty defaultDescriptionPageError}">
                            <script> console.error('${defaultDescriptionPageError}') </script>
                            <div class="error">The site description page was not found or there was an error retrieving or parsing it.</div>
                        </c:if>
                    </c:if>
                </c:if>
                <c:if test="${siteDescriptionType.toLowerCase().contains('text')}">
                    <div id="site-description"></div>
                    <textarea id="site-description-md" class="hidden">${siteDescriptionText}</textarea>
                    <script>
                        (function(){
                            var mdSource = $('#site-description-md').text();
                            var mdOutput = marked(mdSource);
                            $('#site-description').html(mdOutput);
                        })();
                    </script>
                </c:if>
            </div>

            <div id="login-box">

                <c:if test="${param.failed == true}">
                    <div class="error">Login failed.</div>
                    <br>
                    <script> window.failedLogin = true; </script>
                </c:if>

                <c:if test="${param.logout == true}">
                    <div class="message">Logged out.</div>
                    <br>
                </c:if>

                <form name="site-login" id="login-form" action="${SITE_ROOT}/login" method="post" class="xnat-form validate" style="background:#f0f0f0;">
                    <div class="pad">
                        <p>
                            <label for="username">Username:</label>
                            <input type="text" id="username" name="username" title="User" data-validate="not-empty" data-message="Username cannot be blank.">
                        </p>

                        <p>
                            <label for="password">Password:</label>
                            <input type="password" id="password" name="password" autocomplete="off" title="Password" data-validate="not-empty" data-message="Password cannot be blank.">
                        </p>

                        <p class="form-submit">
                        <span id="register-forgot">
                            <%--<a href="${SITE_ROOT}/app/template/Register.vm">Register</a>--%>
                            <%--<a href="${SITE_ROOT}/app/template/ForgotLogin.vm">Forgot login or password?</a>--%>

                            <%-- we will switch to using dialogs for registration and forgot forms --%>
                            <a class="link" id="user-register" href="#!register">Register</a>
                            <a class="link" id="user-forgot" href="#!forgot">Forgot login or password?</a>
                        </span>
                            <button class="submit btn" id="login-button" type="submit" name="login">Login</button>
                        </p>
                    </div>
                </form>

                <script>
                    (function(){
                        var $username$password = $('#username, #password').removeClass('valid invalid');
                        if (window.failedLogin) {
                            $username$password.addClass('invalid');
                        }
                    })();
                </script>

            </div>

            <div class="clear"></div>

        </div>

    </pg:content>

</pg:init>
