<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>

<pg:html>

    <%-- hide the main nav on setup page --%>
    <c:set var="mainNav" value="false" scope="request"/>

    <!-- pg:head start -->
    <pg:head title="Setup" headTop="" headBottom="">

        <!-- head content -->

    </pg:head>
    <!-- pg:head end -->
    <!-- pg:body start -->
    <pg:body page="setup" id="xnat-setup" className="setup" bodyTop="" bodyBottom="">

        <jsp:include page="content.jsp"/>

    </pg:body>
    <!-- pg:body end -->
</pg:html>
