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
	String[] ruidArray = request.getParameterValues("selectedRUID");
	String offerID = request.getParameter("offerID");
	String message = "";
	for(int i = 0; i < requestIDArray.length ; i++){
		message = "'Your request has been selected by "+session.getAttribute("loginName")+
				" click Accept to secure a spot "+
				"<br><form action=\"matchRider.jsp\" method=\"post\">"+
				"<input type=\"hidden\" name=\"offerID\" value="+offerID+"/>"+
				"<input type=\"hidden\" name=\"requestID\" value="+requestIDArray[i]+"/>"+
				"<input type=\"submit\" class=\"w3-button w3-white w3-hover-black\" value=\"Accept\"/></form>'";
		out.print("<br>ruid: "+ruidArray[i]+" requestID: "+requestIDArray[i]);
		String query = "INSERT INTO finalproject.messages (fromRUID, toRUID, message, time) VALUES ("+myruid+", "+Integer.parseInt(ruidArray[i])+", "+message+", CURRENT_TIMESTAMP)";
		PreparedStatement ps = conn.prepareStatement(query);
		ps.executeUpdate();
		ps.close();
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