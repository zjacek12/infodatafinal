<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<%
try {

	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");

	String loginName = request.getParameter("loginName");
	session.setAttribute("loginName", loginName);
  	String password = request.getParameter("password");
  	session.setAttribute("password", password);
	
  	if(loginName.equalsIgnoreCase("admin")) {
		response.sendRedirect("admin.jsp");
	}
  	
	String query = "SELECT loginName, password, RUID, isLocked FROM accounts WHERE loginName ='"+loginName+"' AND password ='"+password+"'";
	
	PreparedStatement ps = con.prepareStatement(query);
	ResultSet result = ps.executeQuery(query);
	if(result.next()){
		if(result.getInt("isLocked")==1){
			out.print("You are locked out.");
			response.sendRedirect("index.html");
		}
		session.setAttribute("ruid", result.getInt("RUID"));
		con.close();
		// out.print("Account Name: " + loginName + "<br> Password: " + password);
		out.print("<br>Logged In!");
		response.sendRedirect("profilePage.jsp");
	} else {
		con.close();
		out.print("Please go back and create an account!");
	}
	
	
	
} catch (Exception ex) {
	out.print("something failed failed" + "<br>");
	out.println("this is why" + ex.getMessage());
	ex.printStackTrace();
}
%>
</body>
</html>