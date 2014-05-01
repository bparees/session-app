<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<html>
<head>
<title>Using a DataSource</title>
</head>
<body>
<h1>Using a DataSource</h1>
<%
    DataSource ds = null;
    Connection conn = null;
    ResultSet result = null;
    Statement stmt = null;
    ResultSetMetaData rsmd = null;
    try{
      Context context = new InitialContext();
      //Context envCtx = (Context) context.lookup("java:jboss/datasources/MysqlDS");
      //ds =  (DataSource)envCtx.lookup("datasources/MysqlDS");
      ds = (DataSource) context.lookup("java:jboss/datasources/MySQLDS");
      if (ds != null) {
        conn = ds.getConnection();
        stmt = conn.createStatement();
        try {
          stmt.executeUpdate("DROP TABLE FOO");
        } catch(Exception e) {
          System.out.println(e);
        }

      	try {
      	  stmt.executeUpdate("CREATE TABLE FOO(ID BIGINT UNSIGNED)");
      	} catch(Exception e) {
      	  System.out.println(e);
      	}
	      stmt.executeUpdate("INSERT INTO FOO VALUES ("+System.currentTimeMillis()+")");

        result = stmt.executeQuery("SELECT * FROM FOO");
       }
     }
     catch (Exception e) {
        System.out.println("Error occurred " + e);
     }
     int columns=0;
     try {
        rsmd = result.getMetaData();
        columns = rsmd.getColumnCount();
     }
     catch (Exception e) {
        System.out.println("Error occurred " + e);
     }
 %>
 <table width="90%" border="1">
   <tr>
   <% // write out the header cells containing the column labels
      try {
         for (int i=1; i<=columns; i++) {
              out.write("<th>" + rsmd.getColumnLabel(i) + "</th>");
         }
   %>
   </tr>
   <% // now write out one row for each entry in the database table
         while (result.next()) {
            out.write("<tr>");
            for (int i=1; i<=columns; i++) {
              out.write("<td>" + result.getString(i) + "</td>");
            }
            out.write("</tr>");
         }
 
         // close the connection, resultset, and the statement
         result.close();
         stmt.close();
         conn.close();
      } // end of the try block
      catch (Exception e) {
         System.out.println("Error " + e);
      }
      // ensure everything is closed
    finally {
     try {
       if (stmt != null)
        stmt.close();
       }  catch (Exception e) {}
       try {
        if (conn != null)
         conn.close();
        } catch (SQLException e) {}
    }
 
    %>
</table>
</body>
</html>
