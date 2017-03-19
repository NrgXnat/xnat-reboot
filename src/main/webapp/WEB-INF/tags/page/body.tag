<%@ tag description="Body Element" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<%@ attribute name="id" %>
<%@ attribute name="className" %>
<%@ attribute name="bodyTop" %>
<%@ attribute name="bodyBottom" %>

<c:set var="idAttr" value="${empty id ? '' : 'id=\"' + id + '\"'}"/>
<c:set var="classValue" value="${empty className ? 'xnat' : 'xnat '+ className}"/>

<body ${idAttr} class="${classValue}">

<input type="hidden" name="pageName" value="${requestScope.pageName}">

<div id="old-ie">
    <!--[if lt IE 7]><p class="browsehappy">You are using an extremely
    <strong>outdated</strong> browser that is not supported. Please
    <a href="http://browsehappy.com/">upgrade your browser</a> for complete functionality.</p><![endif]-->
    <!--[if IE 8]><p class="browsehappy">Internet Explorer 8 and earlier are not officially supported. Please
    <a href="http://browsehappy.com/">upgrade your browser</a> to ensure proper functionality.</p><![endif]-->
</div>
<!-- /#old-ie -->

${bodyTop}

<incl:user-bar logoutUrl="${SITE_ROOT}/app/action/LogoutUser"/>
<incl:main-nav>
    <!-- incl:main-nav -->
</incl:main-nav>

<%--<incl:header/>--%>



        <jsp:doBody/>



<%--<incl:footer/>--%>

${bodyBottom}

</body>
