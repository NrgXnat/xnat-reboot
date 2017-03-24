<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>

<pg:html>

    <c:set var="headBottom">
        <!-- insert right before </head> -->
    </c:set>

    <!-- pg:head start -->
    <pg:head title="" headTop="" headBottom="${headBottom}">

        <!-- head content -->

    </pg:head>
    <!-- pg:head end -->
    <!-- pg:body start -->
    <pg:body id="" className="" bodyTop="" bodyBottom="">


        <%-- get /page/content.jsp by default --%>
        <c:set var="content" value="content.jsp"/>

        <%-- or get a page that's requested in the 'view' query string parameter --%>
        <%-- /page/?view=pagename --%>
        <c:if test="${not empty param.view}">
            <c:set var="content" value="/page/${param.view}/content.jsp"/>
        </c:if>



        <jsp:include page="${content}"/>



    </pg:body>
    <!-- pg:body end -->
</pg:html>
