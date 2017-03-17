<%@ tag description="Head Element" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<%@ attribute name="title" %>
<%@ attribute name="headTop" %>
<%@ attribute name="headBottom" %>

<%@ attribute name="baseJS" %>
<%@ attribute name="appJS" %>

<head>

    <c:if test="${empty requestScope.hasVars}">
        <pg:jsvars/>
    </c:if>

    ${headTop}

    <title>${empty title ? 'XNAT' : title}</title>

    <incl:base-js>
        ${baseJS}
    </incl:base-js>

    <script id="insert-scripts-before"></script>
    <!-- ^^ scripts inserted above ^^ -->

    <!-- sessionScope.themeName: ${sessionScope.themeName} -->
    <!-- sessionScope.siteRoot:  <c:url value="/"/> -->
    <!-- sessionScope.csrfToken: ${sessionScope.csrfToken} -->

    <incl:app-js>
        ${appJS}
    </incl:app-js>



    <jsp:doBody/>



    ${headBottom}

</head>
