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
	
	String toName = request.getParameter("toName");
	String message = request.getParameter("message");
	
	Statement stmt = conn.createStatement();
	
	String query = "SELECT loginName, ruid FROM finalproject.accounts WHERE loginName=\"" + toName + "\"";
	ResultSet result = stmt.executeQuery(query);
	result.next();
	
	if(!result.getString("loginName").equalsIgnoreCase(toName)) {
		out.println(toName + " is not a valid userName!");
		out.println("Received userName: " + result.getString("loginName"));
	
	} else {
		query = "INSERT INTO finalproject.messages (fromRUID, toRUID, message, time) VALUES (" + myruid + "," + result.getInt("ruid") + ",\"" + message + "\", DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -4 HOUR))";
		PreparedStatement ps = conn.prepareStatement(query);
		ps.executeUpdate();
		
		query = "SELECT emailForward, email FROM finalproject.accounts WHERE RUID=" + result.getInt("ruid");
		
		result = stmt.executeQuery(query);
		result.next();
		
		if(result.getInt("emailForward")==1) {
			query = "INSERT INTO finalproject.SENT_EMAIL (fromRUID, toEmail, content, datetime) VALUES (" + myruid + ", '" + result.getString("email") + "', '" + message + "', DATE_ADD(CURRENT_TIMESTAMP, INTERVAL -4 HOUR))";
			ps = conn.prepareStatement(query);
			ps.executeUpdate();
		}
				
		stmt.close();
		result.close();
		ps.close();
		conn.close();
		
		response.sendRedirect("messenger.jsp");
	}
	
	result.close();
	stmt.close();
	conn.close();
	
} catch (Exception ex) {
		out.println("Oops!");
		out.println("Unable to send message!");
		out.println(ex.getMessage());
}
%>

</body>
</html>