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

	int cid = Integer.parseInt(request.getParameter("company"));
	
	String query = "select * from ads where companyID="+cid;
	
	PreparedStatement ps = con.prepareStatement(query);
	ResultSet result = ps.executeQuery(query);
	
	%>
	<table style="width:100%" class="w3-table-all">
			
	<% while(result.next()){
		%><tr>
			<td><b><%out.print(result.getString("description")); %></b></td>
			<td><b><%out.print(result.getInt("numShown")); %></b></td>
		</tr>
	<% }
	
	%>
	
	</table>
	<button onclick="history.back()">Ok</button>
	
	<% 
}catch(Exception e){}
%>

</body>
</html>
	
	