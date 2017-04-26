<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html>
<html>
<body>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<%
try {
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Connection conn = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");

	int ruid = Integer.parseInt(session.getAttribute("ruid").toString());
	Statement stmt = conn.createStatement();

	String score = request.getParameter("score");
	String cmnt = request.getParameter("cmnt");
	String toid = request.getParameter("toRUID");
	String role = request.getParameter("role");
	
	String query="INSERT INTO finalproject.ratings (fromRUID, toRUID, role, rating, thecomment) VALUES (" + ruid + ", " + toid + ", \"" + role + "\", " + score + ", \"" + cmnt + "\")";

	stmt.executeUpdate(query);
	
	stmt.close();
	conn.close();
	
	response.sendRedirect("rating.jsp");

} catch (Exception ex) {
	out.print("Something went wrong.");
	/* out.print("Account already exists!" + "<br>");
	out.print("maybe something went wrong"); */
	out.print("<br>" +"this may be why : " +ex.getMessage());
	ex.printStackTrace();
}
%>


</body>
</html>