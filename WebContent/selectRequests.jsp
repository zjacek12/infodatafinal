<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->

<!DOCTYPE html>

<html>
<body>

<%
try {
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Connection conn = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");
	
	int myruid = Integer.parseInt(session.getAttribute("ruid").toString());
	
	
	
	out.println(myruid + ":");
	
	String[] ruidArray = request.getParameterValues("selected");
	String message = "'Your request has been selected by "+session.getAttribute("loginName")+" click Accept to secure a spot <br><a href=\"profilePage.jsp\" class=\"w3-button w3-white w3-hover-black\">Accept</a>'";
	
	for(String s : ruidArray){
		out.print("<br>ruid: "+s);
		String query = "INSERT INTO finalproject.messages (fromRUID, toRUID, message, time) VALUES ("+myruid+", "+Integer.parseInt(s)+", "+message+", CURRENT_TIMESTAMP)";
		PreparedStatement ps = conn.prepareStatement(query);
		ps.executeUpdate();
		ps.close();
	}
	
	conn.close();
	
	response.sendRedirect("messenger.jsp");
	
} catch (Exception ex) {
		out.println("Oops!");
		out.println("Unable to send message!");
		out.println(ex.getMessage());
}
%>

</body>
</html>