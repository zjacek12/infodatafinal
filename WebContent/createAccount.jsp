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

	
	Statement stmt = con.createStatement();

	
	String str = "SELECT COUNT(*) as cnt FROM `accounts`";

	
	ResultSet result = stmt.executeQuery(str);

	
	result.next();
	
	int countAcc = result.getInt("cnt");

	
	String loginName = request.getParameter("loginName");
  	String password = request.getParameter("password");

	
	String insert = "INSERT INTO `accounts`(loginName, password)"
			+ "VALUES ('"+loginName+"', '"+password+"')";
	
	PreparedStatement ps = con.prepareStatement(insert);

	
	ps.executeUpdate();

	
	str = "SELECT COUNT(*) as cnt FROM `accounts`";
	result = stmt.executeQuery(str);
	result.next();
	System.out.println("Here");
	int countAccN = result.getInt("cnt");
	System.out.println(countAccN);

	
	con.close();

	 
	int updateAcc = (countAcc != countAccN) ? 1 : 0;
	;
	System.out.println(updateAcc);
	if (updateAcc > 0) {
		
		out.print("New Account Name: " + loginName + "<br> Password: " + password);
	} else {
		out.print("<br>Account already exists.");
	}

	out.print("<br>insert succeeded");
} catch (Exception ex) {
	out.print("insert failed" + "<br>");
	out.println("this is why");
	out.print(ex.getMessage());
}
%>

</body>
</html>