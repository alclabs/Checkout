<%@ page import="org.jetbrains.annotations.NotNull" %>
<%@ page import="com.controlj.green.addonsupport.access.*" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Iterator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  final String locString = request.getParameter("loc");
  final String contentIn = request.getParameter("content");
  final StringBuilder content = new StringBuilder();
  try {
        DirectAccess access = DirectAccess.getDirectAccess();
        SystemConnection connection = access.getUserSystemConnection(request);
        connection.runWriteAction("", new WriteAction() {
          @Override
          public void execute(@NotNull WritableSystemAccess access) throws Exception {
              if (locString == null) {
                  System.err.println("Checkout: no location provided");
                  content.append("ERROR: no location");
                  return;
              }
              //systemAccess.getDataStore()
              try {
                  Location loc = access.resolveGQLPath(locString);
                  DataStore ds = access.getDataStore(loc, "checkout");
                  String result;
                  if (contentIn != null) { // trying to post something
                      ds.getWriter().print(contentIn);
                      result = contentIn;
                  } else {
                      StringWriter wr = new StringWriter();
                      IOUtils.copy(ds.getReader(), wr);
                      result = wr.toString();
                  }

                content.append(result);
              } catch (UnresolvableException e) {
                   content.append("BAD location: "+locString);
              }
          }

        }
      );
    } catch (Exception e) {
        System.err.println("Error in Checkout addon:");
        e.printStackTrace(System.err);
        content.append("ERROR RUNNING ADDON:"+e.getMessage());
    }
%>
<textarea rows="5" cols="60" id="content"><%=content%></textarea>
<button id="doit">Save Comment</button>
<script type="text/javascript">
    $(function() {
        $('#doit').bind('click', function() {
            $.get('/checkout/include.jsp', {content: $("#content").text(), loc: frameManager.treeGqlLocation } )
      })
    })
</script>
