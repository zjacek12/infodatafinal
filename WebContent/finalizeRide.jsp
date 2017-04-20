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
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");
	int ruid = Integer.parseInt(session.getAttribute("ruid").toString());
  int rideID = Integer.parseInt(request.getParameter("offerID"));

  Statement stmt = con.createStatement();
  String str = "SELECT * from offeredRides where offerID="+rideID;
  ResultSet result = stmt.executeQuery(str);
  result.next();



}
