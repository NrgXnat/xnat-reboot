<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>

<pg:html>
    <!-- pg:head start -->
    <pg:head title="" headTop="" headBottom="">

        <!-- head content -->

    </pg:head>
    <!-- pg:head end -->
    <!-- pg:body start -->
    <pg:body id="" className="" bodyTop="" bodyBottom="">


        <%-- get /page/content.jsp by default --%>
        <c:set var="content" value="content.jsp"/>
        <jsp:include page="${content}"/>



    </pg:body>
    <!-- pg:body end -->
</pg:html>
