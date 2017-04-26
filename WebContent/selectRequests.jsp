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
	
	String[] requestIDArray = request.getParameterValues("selected");
	String offerID = request.getParameter("offerID");
	
	Statement stmt1 = conn.createStatement();
	String nquery1 = "select * from finalproject.car c, finalproject.offeredRides o where o.offerID="+offerID+" AND o.RUID = c.RUID AND o.plate = c.plate";
	ResultSet nresult1 = stmt1.executeQuery(nquery1);
	nresult1.next();
	
	String initial = "INSERT INTO finalproject.messages (fromRUID, toRUID, message, time) VALUES (1111, "+myruid+", 'Your ride has been Created. Click Conclude Ride once you have completed the ride. The ride is from "+nresult1.getString("fromLocation")+" to "+nresult1.getString("toLocation")+" at "+nresult1.getString("departureTime")+" <form action=\"rating.jsp\" method=\"post\"><input type=\"hidden\" name=\"rideId\" value=\""+offerID+"\"/><input type=\"submit\" class=\"w3-button w3-white w3-hover-black\" value=\"Conclude Ride\"/></form>', DATE_ADD(current_timestamp,INTERVAL -4 HOUR))";
	PreparedStatement ps1 = conn.prepareStatement(initial);
	ps1.executeUpdate();
	ps1.close();
	String message = "";
	for(int i = 0; i < requestIDArray.length ; i++){
		Statement stmt = conn.createStatement();
		String nquery = "select ruid from finalproject.requestedRides "+
				"where requestID="+requestIDArray[i];
		ResultSet nresult = stmt.executeQuery(nquery);
		nresult.next();
		
		message = "'Your request has been selected by "+session.getAttribute("loginName")+
				" that drives a "+nresult1.getString("color")+" "+nresult1.getString("make")+" "+nresult1.getString("model")+"."+
				" Ride starting at "+nresult1.getString("departureTime").substring(11)+" on "+nresult1.getString("departureTime").substring(0, 10)+" "+
				" from "+nresult1.getString("fromLocation")+" "+nresult1.getString("parkinglot")+" "+nresult1.getString("toLocation")+". "+
				" Click Accept to secure a spot "+
				"<form action=\"matchRider.jsp\" method=\"post\">"+
				"<input type=\"hidden\" name=\"offerID\" value=\""+offerID+"\"/>"+
				"<input type=\"hidden\" name=\"requestID\" value=\""+requestIDArray[i]+"\"/>"+
				"<input type=\"submit\" class=\"w3-button w3-white w3-hover-black\" value=\"Accept\"/></form>'";
		out.print("<br>ruid: "+nresult.getInt("RUID")+" requestID: "+requestIDArray[i]);
		String query = "INSERT INTO finalproject.messages (fromRUID, toRUID, message, time) VALUES (1111, "+nresult.getInt("RUID")+", "+message+", DATE_ADD(current_timestamp,INTERVAL -4 HOUR))";
		
		PreparedStatement ps = conn.prepareStatement(query);
		ps.executeUpdate();
		
		ps.close();
		stmt.close();
		stmt1.close();
		nresult1.close();
		nresult.close();
	}
	
	conn.close();
	
	response.sendRedirect("messenger.jsp");
	
} catch (Exception ex) {
		out.println("Oops!");
		out.println("Unable to send message!");
		out.println(ex.getMessage());
}
%>

</body>
</html>