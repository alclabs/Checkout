<%@ page import="org.jetbrains.annotations.NotNull" %>
<%@ page import="com.controlj.green.addonsupport.access.*" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Iterator" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript" src="/checkout/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="/checkout/js/test.js"></script>
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
              content.append("\nPASSED: Good location: "+locString);
              } catch (UnresolvableException e) {
                   content.append("\nFAILED: Bad location: "+locString);
              }
          }

        }
      );
    } catch (Exception e) {
        System.err.println("Error in Checkout addon:");
        e.printStackTrace(System.err);
        content.append("ERROR RUNNING ADDON:"+e.getMessage());
    }
    String display = request.getParameter("display");
    if(display==null)
      content.append("\nMISSING \"display\" parameter");
    else
      content.append("\n"+display);
%>
<textarea rows="4" cols="100" id="content"><%=content%></textarea><br>
<button id="doit">Save Comment</button><input type="text" id="comment" value="Comment added to datastore after pressing 'Save' button" style="width:270px;">
<script type="text/javascript">
    $(function() {
        $('#doit').bind('click', function() {
            $.get('/checkout/include.jsp', {content: $("#comment").val(), loc: "<%=locString%>" } )
        });
    })

   var currentValue = $("#content").val()
   if(window.testAddonVariable)
      $("#content").val(currentValue+"\n"+testAddonVariable);
   else
      $("#content").val(currentValue+"\nFAILED: external js variable not defined");

</script>
