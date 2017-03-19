<%@ tag description="Main Nav Menu" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>--%>
<%--<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>--%>

<%-- redirect message --%>
<jsp:doBody/>

<%@ attribute name="delay" %>

<c:if test="${empty delay}">
    <c:set var="delay" value="2000"/>
</c:if>

<script>
    setTimeout(function(){
        window.location.href = '<c:url value="/"/>'
    }, +${delay})
</script>
