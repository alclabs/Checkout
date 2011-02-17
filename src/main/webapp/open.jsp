<%@ page import="java.util.Date" %>
<%@ page import="com.controlj.green.addonsupport.web.Link" %>
<%@ page import="com.controlj.green.addonsupport.web.UITree" %>
<%@ page import="com.controlj.green.addonsupport.access.Location" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head><title>Open JSP</title></head>
  <body>
  <div>
      This location is relatively unprotected.  You must be logged into WebCTRL to get here, but
      it doesn't require any special privileges.
  </div>
  <div>BTW, just to make sure this loaded, the time is <%= new Date()%></div>
  <br/>
  <div>Links:</div>
  <div><a href="<%= Link.getURL(request, UITree.GEO, "/trees/geographic")%>">Geo Root</a></div>
  <div></div><a href="<%= Link.getURL(request, UITree.GEO, "/trees/geographic/basement/lstat_test")%>">Logistat Test in Testsystem</a></div>
  </body>
</html>