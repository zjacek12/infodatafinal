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
	
	String fromLocation = request.getParameter("fromLocation");
	String toLocation = request.getParameter("toLocation");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String userName = request.getParameter("userName");
		
	Statement stmt = conn.createStatement();
	String query;
	
	// All are null								#1
	if(fromLocation.equals("") && toLocation.equals("") && startTime.equals("") && endTime.equals("") && userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\"";
	
	// fromLocation or toLocation are set		#2
	} else if(!(fromLocation.equals("") && toLocation.equals("")) && startTime.equals("") && endTime.equals("") && userName.equals("")) {
		if(fromLocation.equals("")) {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND toLocation=\"" + toLocation + "\"";
		} else if(toLocation.equals("")) {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND fromLocation=\"" + fromLocation + "\"";
		} else {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND toLocation=\"" + toLocation + "\" AND fromLocation=\"" + fromLocation + "\"";
		}
	// startTime or endTime are set			#3
	} else if(fromLocation.equals("") && toLocation.equals("") && !(startTime.equals("") && endTime.equals("")) && userName.equals("")) {
		if(startTime.equals("")) {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND arrivalTime<" + endTime;
		} else if(endTime.equals("")) {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND arrivalTime>" + startTime;
		} else {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND arrivalTime<" + endTime + " AND arrivalTime>" + startTime;
		}
	// userName is set							#4
	} else if(fromLocation.equals("") && toLocation.equals("") && startTime.equals("") && endTime.equals("") && !userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog r JOIN finalproject.accounts a ON a.ruid=r.ruid WHERE r.role=\"Driver\" AND a.loginName=\"" + userName + "\"";
	// 2 and 3 are set
	} else if(!(fromLocation.equals("") && toLocation.equals("")) && !(startTime.equals("") && endTime.equals("")) && userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\"";
		if(!fromLocation.equals("")) {
			query += " AND fromLocation=\"" + fromLocation + "\"";
		}
		if(!toLocation.equals("")) {
			query += " AND toLocation=\"" + toLocation + "\"";
		}
		if(startTime.equals("")) {
			query += " AND arrivalTime<" + endTime;
		} else if(endTime.equals("")) {
			query += " AND arrivalTime>" + startTime;
		} else {
			query += " AND arrivalTime<" + endTime + " AND arrivalTime>" + startTime;
		}
	// 2 and 4 are set
	} else if(!(fromLocation.equals("") && toLocation.equals("")) && startTime.equals("") && endTime.equals("") && !userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog r JOIN finalproject.accounts a ON a.ruid=r.ruid WHERE r.role=\"Driver\" AND a.loginName=\"" + userName + "\"";
		if(!fromLocation.equals("")) {
			query += " AND r.fromLocation=\"" + fromLocation + "\"";
		}
		if(!toLocation.equals("")) {
			query += " AND r.toLocation=\"" + toLocation + "\"";
		}
	// 3 and 4 are set	
	} else if(fromLocation.equals("") && toLocation.equals("") && !(startTime.equals("") && endTime.equals("")) && !userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog r JOIN finalproject.accounts a ON a.ruid=r.ruid WHERE r.role=\"Driver\" AND a.loginName=\"" + userName + "\"";
		if(startTime.equals("")) {
			query += " AND r.arrivalTime<" + endTime;
		} else if(endTime.equals("")) {
			query += " AND r.arrivalTime>" + startTime;
		} else {
			query += " AND r.arrivalTime<" + endTime + " AND r.arrivalTime>" + startTime;
		}
	// all are set
	} else {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog r JOIN finalproject.accounts a ON a.ruid=r.ruid WHERE r.role=\"Driver\" AND a.loginName=\"" + userName + "\"";
		if(!fromLocation.equals("")) {
			query += " AND r.fromLocation=\"" + fromLocation + "\"";
		}
		if(!toLocation.equals("")) {
			query += " AND r.toLocation=\"" + toLocation + "\"";
		}
		if(startTime.equals("")) {
			query += " AND r.arrivalTime<" + endTime;
		} else if(endTime.equals("")) {
			query += " AND r.arrivalTime>" + startTime;
		} else {
			query += " AND r.arrivalTime<" + endTime + " AND r.arrivalTime>" + startTime;
		}
	}
	
	ResultSet rs = stmt.executeQuery(query);
	rs.next();
%>

<h4>Number of Rides Given:</h4>
<p><%out.println(rs.getInt("cnt"));%></p>
<p>The execute query used is as follows:</p>
<p><%out.println(query);%></p>

<%
	rs.close();
	stmt.close();
	conn.close();
	
} catch (Exception ex) {
		out.println("Oops!");
		out.println("Something went wrong!");
		out.println(ex.getMessage());
}
%>

</body>
</html>