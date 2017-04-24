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
	
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String password = request.getParameter("lastName");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	
	if(firstName.equals("") || lastName.equals("") || password.equals("") || phone.equals("") || email.equals("") || address.equals("")) {
		out.println("Missing parameters! Fill all fields to create a System Support Account.");
	
	} else {
		String query = "INSERT INTO finalproject.staffAccounts (password, firstName, lastName, phone, email, address) VALUES (\"" + password + "\",\"" + firstName + "\",\"" + lastName + "\",\"" + phone + "\",\"" + email + "\",\"" + address + "\")";
		PreparedStatement ps = conn.prepareStatement(query);
		ps.executeUpdate();
	
		ps.close();
		conn.close();
		
%>
 
 

<%
		
		response.sendRedirect("admin.jsp");
	}
	
	conn.close();
	
} catch (Exception ex) {
		out.println("Oops!");
		out.println("Something went wrong!");
		out.println(ex.getMessage());
}
%>

<

</body>
</html>