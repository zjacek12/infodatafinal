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
	
	String email = request.getParameter("email");
	
	String query = "SELECT COUNT(*) as cnt FROM finalproject.accounts WHERE email='"+email+"'";
	
	PreparedStatement ps = con.prepareStatement(query);
	ResultSet result = ps.executeQuery(query);
	result.next();
	int cnt = result.getInt("cnt");
	if(cnt == 1){
		out.print("<br>You have already recieved an email...<br>"); 
		query = "SELECT loginName, password FROM finalproject.accounts WHERE email='"+email+"'";
		PreparedStatement ps1 = con.prepareStatement(query);
		ResultSet result1 = ps1.executeQuery(query);
		result1.next();
		String loginName = result1.getString("loginName");
		String password = result1.getString("password");
		String insert = "INSERT INTO finalproject.SEND_EMAIL"+
				"(fromEmail, "+
				"toEmail, "+
				"datetime, "+
				"subject, "+
				"content)"+
				"VALUES"+
				"('rideshare@rides.com', "+
				"'"+email+"', "+
				"NOW(), "+
				"'RideShare Login Credentials', "+
				"'Login: "+loginName+" Password: "+password+"')";
		PreparedStatement ps2 = con.prepareStatement(insert);
		ps2.executeUpdate();
		/* out.print("<br>login: "+result.getString("loginName"));
		out.print("<br>password: "+result.getString("password")); */
		result.close();
		ps.close();
 		ps1.close();
 		ps2.close();
		con.close();
		response.sendRedirect("index.html");
	} else {
		result.close();
		ps.close();
		con.close();
		out.print("Please go back and create an account!");
	}
} catch(Exception ex) {
	
}
%>

</body>
</html>