<%@ tag description="Document Wrapper" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<!--[if lt IE 9]><html class="ie ltie9 ltie10 no-js"><![endif]-->
<!--[if IE 9]><html class="ie ie9 ltie10 no-js"><![endif]-->
<!--[if gt IE 9]><!--><html class="no-js"><!--<![endif]-->

<c:if test="${empty requestScope.hasInit}">
    <pg:init/>
</c:if>

<%-- set vars here -- they should be accessible everywhere --%>
<c:set var="SITE_ROOT" value="${sessionScope.siteRoot}" scope="session"/>
<c:set var="THEME_ROOT" value="${sessionScope.themeRoot}" scope="session"/>
<c:set var="USERNAME" value="${sessionScope.username}" scope="session"/>
<c:set var="csrfToken" value="${sessionScope.csrfToken}" scope="session"/>
<c:set var="SCRIPTS" value="${SITE_ROOT}/scripts" scope="session"/>
<c:set var="versionString" value="v=1.7.3r1" scope="session"/>

<%@ attribute name="page" %>
<c:set var="PAGE" value="${page}"/>

<jsp:doBody/>

</html>
