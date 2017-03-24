<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>

<pg:html>
    <!-- pg:head start -->
    <pg:head title="Home" headTop="" headBottom="">

        <!-- head content -->

    </pg:head>
    <!-- pg:head end -->
    <!-- pg:body start -->
    <pg:body page="home" id="xnat-home" className="home" bodyTop="" bodyBottom="">

        <jsp:include page="content.jsp"/>

    </pg:body>
    <!-- pg:body end -->
</pg:html>
