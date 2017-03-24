<%@ tag description="Initialize Variables" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

    var _app = {
        siteRoot: '${sessionScope.siteRoot}',
        themeName: '${requestScope.themeName}',
        themeRoot: '${requestScope.themeName}',
        pageRoot: '${requestScope.themeName}',
        landingPage: '${requestScope.themeName}',
        isDialog: '${isDialog}',
        isModal: '${isModal}',
        session: {
            username: '${sessionScope.username}',
            token: '${sessionScope.csrfToken}',
            expiration: '${sessionScope.sessionExpiration}'
        }
    };

    _app.session.startTime   = ('${sessionScope.sessionExpiration}'.split(',')[0]) * 1;
    _app.session.startString = new Date(_app.session.startTime).toString();
    _app.session.duration    = ('${sessionScope.sessionExpiration}'.split(',')[1]) * 1;
    _app.session.endTime     = (_app.session.startTime + _app.session.duration);
    _app.session.endString   = new Date(_app.session.endTime).toString();
    _app.session.timeout     = _app.session.endTime;

    console.log('_app:');
    console.log(_app);

    window.PAGE = _app;

</script>

<c:set var="hasVars" value="true" scope="request"/>
