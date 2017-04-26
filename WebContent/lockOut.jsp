<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html>
<html>
<body>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<%
try {
	
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");

	String uname = request.getParameter("uname");
	
	String query = "update accounts set isLocked=1 where loginName='"+uname+"'";
  	
	PreparedStatement ps = con.prepareStatement(query);
	int valid = ps.executeUpdate(query);
	
	if(valid == 1){
		out.print(""+uname+" has been locked out.");
		%><button onclick="history.back()">Ok</button><%
		// redirect here!! get rid of ^
		// response.sendRedirect("");
		con.close();
	} else {
		out.print("failed.");
		%><button onclick="history.back()">Ok</button><%
		// redirect here!! get rid of ^
		// response.sendRedirect("");
		con.close();
	}
  }catch(Exception e){}
  %>
  </body>
  </html>