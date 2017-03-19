<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>

<script src="${SITE_ROOT}/scripts/xnat/app/customPage.js"></script>


<div id="page-content"></div>


<script>
    (function(){

        var customPage   = XNAT.app.customPage;
        var $pageContent = $('#page-content').html('loading...');

        var pageName = customPage.getPageName();
        console.log(pageName);

        customPage.getPage(null, $pageContent);

        $(window).on('hashchange', function(){
            var newPageName = customPage.getPageName();
            if (newPageName !== pageName) {
                customPage.getPage('', $pageContent);
            }
        });

    })();
</script>
