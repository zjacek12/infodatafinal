<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<%
try {	
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");
	
	String loginName = request.getParameter("userName");
	
	String query = "SELECT loginName, password FROM accounts WHERE loginName ='"+loginName+"'";
	
	PreparedStatement ps = con.prepareStatement(query);
	ResultSet result = ps.executeQuery(query);
	if(result.next()){
		out.print("needs to be made into an email");
		out.print("<br>login: "+result.getString("loginName"));
		out.print("<br>password: "+result.getString("password"));
		con.close();
	} else {
		con.close();
		out.print("Please go back and create an account!");
	}
} catch(Exception ex) {
	
}
%>
</body>
</html>