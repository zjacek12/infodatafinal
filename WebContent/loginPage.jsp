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

	Statement stmt = con.createStatement();

	String str = "SELECT COUNT(*) as cnt FROM `accounts`";

	ResultSet result = stmt.executeQuery(str);

	result.next();
	int countAcc = result.getInt("cnt");

	String loginName = request.getParameter("loginName");
  	String password = request.getParameter("password");

	String query = "SELECT * FROM `accounts` WHERE loginName = "+ loginName +" AND password = " + password;
	
	Statement ps = con.createStatement();

	ResultSet result1 = stmt.executeQuery(str);


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
	out.print("Account Name: " + loginName + "<br> Password: " + password);

	out.print("<br>Query succeeded");
} catch (Exception ex) {
	out.print("insert failed" + "<br>");
	out.println("this is why");
	ex.printStackTrace();
}
%>
</body>
</html>