Access to pages in this directory should be restricted to only site administators. 
To enforce admin-only  access on _any_ JSP page (not just in `/page/admin/`)...
 
 Make sure the `pg` taglib is included:
 ```jsp
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
```
 Then wrap restricted content wih the `restricted` tag and an optional message 
 (`msg`) for users without access:
 ```jsp
<pg:restricted msg="Access not allowed">
    <p>Only admins can read this.</p>
</pg:restricted>
```
> NOTE: Content that's not inside a `restricted` tag will be accessible to any user.

A message to non-admin users can also be defined as any content that could 
normally be on any page:

```jsp
<c:set var="warning">
    <div class="warning">Not authorized. Redirecting...</div>
    <script> window.location.href = '<c:url value="/"/>' </script>
</c:set>

<pg:restricted msg="${warning}">
    <p>Only admins can read this.</p>
</pg:restricted>
```

There's also a `<pg:redirect/>` convenience tag for wrapping a message with a timeout 
duration (how long, in milliseconds, that the message will be shown before redirecting.)

```jsp
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<c:set var="message">
    <pg:redirect delay="3000">
        <div class="error">Not authorized. Redirecting...</div>
    </pg:redirect>
</c:set>
```
