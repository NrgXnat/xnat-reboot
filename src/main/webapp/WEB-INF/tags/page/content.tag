<%@ tag description="Body Element" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<%@ attribute name="contentTop" %>
<%@ attribute name="contentBottom" %>

<div id="page-wrapper">

    <div id="page-body">
        <div class="pad">
            ${contentTop}



            <jsp:doBody/>



            ${contentBottom}
        </div>
    </div>
    <!-- /#page-body -->

</div>