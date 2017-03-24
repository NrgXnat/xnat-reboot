<%@ tag description="Main Nav Menu" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<%@ attribute name="page" %>
<%@ attribute name="logoutUrl" %>

<c:set var="userBar" value="${!empty requestScope.userBar ? requestScope.userBar : 'show'}"/>

<c:if test="${userBar != 'show' || (page == 'login' || page == 'setup')}">
    <c:set var="userBar" value="hide" scope="request"/>
</c:if>

<script> console.log('userBar "${userBar}"') </script>

<div id="user-bar">
    <div class="inner">

        <c:if test="${!empty userBar && userBar == 'show'}">

            <img id="attention_icon" src="${SITE_ROOT}/images/attention.png" style="display:none;" alt="attention needed - click for more info" title="attention needed - click for more info">
            <span id="user_info">Logged in as: &nbsp;<a href="${SITE_ROOT}/app/template/XDATScreen_UpdateUser.vm">${_user}</a> <b>|</b>
                <span class="tip_icon" style="margin-right:3px;left:2px;top:3px;">
                    <span class="tip shadowed" style="top:20px;z-index:10000;white-space:normal;left:-150px;width:300px;background-color:#ffc;">
                        Your XNAT session will auto-logout after a certain period of inactivity.
                        You can reset the timer without reloading thepage by clicking "renew."
                    </span>
                </span>
                Auto-logout in:
                <b id="timeLeft">-:--:--</b> -
                <a id="timeLeftRenew" href="#!">renew</a>
                <b>|</b>
                <a id="logout-user" href="${logoutUrl}">Logout</a>
            </span>
            <script src="${SCRIPTS}/xnat/app/timeout.js"></script>

            <jsp:doBody/>

        </c:if>

        <div class="clear"></div>
    </div>
</div>
<!-- /user-bar -->
