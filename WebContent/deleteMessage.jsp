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
	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");

	int ruid = Integer.parseInt(session.getAttribute("ruid").toString());
	out.print(request.getParameter("deleteID"));
	Statement delstmt = con.createStatement();
	String query = "DELETE FROM finalproject.messages WHERE toRUID=" + request.getParameter("to") + " AND fromRUID=" + request.getParameter("fro") + " AND time=\"" + request.getParameter("date") + "\" AND message=\"" + request.getParameter("context") + "\"";
	out.print("<br><br>"+query);
	delstmt.executeUpdate(query);
	delstmt.close();
	
	response.sendRedirect("messenger.jsp");

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