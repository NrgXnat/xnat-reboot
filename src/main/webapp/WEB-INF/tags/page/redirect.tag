<%@ tag description="Main Nav Menu" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>--%>
<%--<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>--%>

<%@ attribute name="href" %>
<%@ attribute name="delay" %>

<%-- redirect message --%>
<jsp:doBody/>

<script>
    console.log('redirect?');
    setTimeout(function(){
        window.location.href = '<c:url value="${empty href ? '/' : href}"/>'
    }, +${empty delay ? '2000' : delay})
</script>
