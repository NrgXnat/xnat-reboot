<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>

<div id="page-content"></div>

<script>
    (function(){

        var customPage   = XNAT.app.customPage;
        var $pageContent = $('#page-content').html('loading...');

        customPage.getPage(null, $pageContent);

        //        window.onhashchange = function(){
        //            customPage.getPage('', $pageContent);
        //        }

    })();
</script>
