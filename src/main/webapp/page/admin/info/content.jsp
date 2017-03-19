<%@ page session="true" contentType="text/html" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>

<pg:content>

    <%-- static message - no redirect --%>
    <c:set var="message">
        Nope.
    </c:set>

    <pg:restricted msg="${message}">

        <h1>Some info</h1>

        <c:import url="/xapi/users" var="userList"/>

        <h2>Users</h2>
        <p id="user-list-raw">
                ${userList}
        </p>
        <p id="user-list"></p>
        <script>
            +function(){
                var userList = JSON.parse('${userList}');
                var ul       = spawn('ul#users');
                $.each(userList, function(i, name){
                    ul.appendChild(spawn('li', name))
                });
                $('#user-list').append(ul);
            }()
        </script>

        <br>

        <h2>Me</h2>
        <ul>
            <li><b>Logged in:</b> ${loggedIn} </li>
            <li><b>Username:</b> ${username} </li>
            <li><b>Is Admin?:</b> ${isAdmin} </li>
            <li><b>CSRF token:</b> ${csrfToken} </li>
            <li><b>Landing page:</b> ${landingPage} </li>
        </ul>

        <br>

        <div id="page-info">
            <p>request: ${requestScope.javamelody.request}</p>
            <p>sessionScope: <br>${sessionScope}</p>
            <p>applicationScope: <br> ${applicationScope}</p>
            <p>requestScope: <br> ${requestScope}</p>
            <p>pageScope: <br> ${pageScope}</p>
            <p>pageContext: <br> ${pageContext}</p>
            <p>param: <br> ${param}</p>
            <p>paramValues: <br> ${paramValues}</p>
            <p>header: <br> ${header}</p>
            <p>headerValues: <br> ${headerValues}</p>
            <p>cookie: <br> ${cookie}</p>
            <p>SPRING_SECURITY_LAST_USERNAME: <br> ${SPRING_SECURITY_LAST_USERNAME}</p>
        </div>

    </pg:restricted>

</pg:content>