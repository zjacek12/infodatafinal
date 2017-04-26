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
  	String nPW = request.getParameter("newPW");
  	String cPW = request.getParameter("confirmPW");
  	
  	if(nPW.equals(cPW)){
  		
  		String query = "update accounts set password='"+nPW+"' where loginName='"+uname+"'";
  		PreparedStatement ps = con.prepareStatement(query);
  		int valid = ps.executeUpdate();
  		
  		if(valid == 1){
  			out.print("Password of "+uname+" successfully changed.");
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
  	}else{
  		out.print("Passwords don't match! Please try again.");
  		%><button onclick="history.back()">Ok</button><%
  		con.close();
  	}

	
}catch(Exception e){}
%>

</body>
</html>