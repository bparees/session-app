<HTML> 
<BODY>
<%
  StringBuilder a=new StringBuilder("aa");
  for(int i=0;i<21;i++)
  {
    a.append(a.toString());
  }
  System.out.println(a.toString());
%>

Wrote <%=a.length()/1024/1024 %> megs to the log.

</BODY>
</HTML>
