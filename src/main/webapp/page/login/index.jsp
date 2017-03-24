<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>

<pg:html>

    <%-- hide the user info... --%>
    <c:set var="userBar" value="hide" scope="request"/>

    <%-- ...unless 'guest' logins are allowed --%>
    <c:if test="${loggedIn == true && isGuest == true}">
        <c:set var="userBar" value="show" scope="request"/>
    </c:if>

    <%-- hide the main nav on login page --%>
    <c:set var="mainNav" value="hide" scope="request"/>

    <!-- pg:head start -->
    <pg:head title="Login" headTop="" headBottom="">

        <!-- head content -->

    </pg:head>
    <!-- pg:head end -->
    <!-- pg:body start -->
    <pg:body page="login" id="xnat-login" className="" bodyTop="" bodyBottom="">

        <%--<c:set var="hasInit" value="true" scope="request"/>--%>
        <jsp:include page="content.jsp"/>

    </pg:body>
    <!-- pg:body end -->
</pg:html>
