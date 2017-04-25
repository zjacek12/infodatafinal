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
	
	Statement stmt = con.createStatement();
	String str = "SELECT COUNT(*) as cnt FROM offeredRides WHERE RUID='"+ruid+"'";
	ResultSet result = stmt.executeQuery(str);
	result.next();	
	int numRequests = result.getInt("cnt");
	boolean validated = true;
	
  	String fromLocation = request.getParameter("fromLocation");
  	String toLocation = request.getParameter("toLocation");
  	String plate = request.getParameter("car");
  	int amtPPL = Integer.parseInt(request.getParameter("amtPPL"));
  	//get the parameter convert it to a data type Date.

  	 //Display the date
  	String departureTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(request.getParameter("departureTime")));
  	String arrivalTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(request.getParameter("arrivalTime")));
  	
  	String parkinglot = request.getParameter("parkinglot");
  	
  	out.print("departure: " +departureTime.toString()+"<br>arrival: " +arrivalTime.toString());
	if(fromLocation == "" || toLocation == "" || departureTime == "") {
		validated = false;
	}
	
	if (validated) {
		/* String insert = "INSERT INTO accounts(loginName, password) "
				+ "VALUES ('"+loginName+"', '"+password+"')"; */
		 String insert = "INSERT INTO offeredRides" +
				"(RUID, "+
				"fromLocation, "+
				"toLocation, "+
				"departureTime, "+
				"arrivalTime, "+
				"numSeats, "+
				"parkinglot, "+
				"plate) "+
				
				"VALUES"+
				"('"+ruid+"', "+
				"'"+fromLocation+"', "+
				"'"+toLocation+"', "+
				"'"+departureTime+"', "+
				"'"+arrivalTime+"', "+
				"'"+amtPPL+"', "+
				"'"+parkinglot+"', "+
				"'"+plate+"')";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.executeUpdate();
		

		str = "SELECT COUNT(*) as cnt FROM requestedRides WHERE RUID='"+ruid+"'";
		result = stmt.executeQuery(str);
		result.next();
		int numRequestsN = result.getInt("cnt");
		
		con.close();
	
		 
		int updateAcc = (numRequests != numRequestsN) ? 1 : 0;
		if (updateAcc > 0) {
			out.print("Request Submitted");
		} else {
			out.print("<br>Request already exists.");
		}
		
		response.sendRedirect("profilePage.jsp");
	} else {
		out.print("<br> Go back and check your input");
	}
} catch (Exception ex) {
	out.print("Something went wrong.");
	/* out.print("Account already exists!" + "<br>");
	out.print("maybe something went wrong"); */
	out.print("<br>" +"this may be why : " +ex.getMessage());
	ex.printStackTrace();
}
%>


</body>
</html>