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
	
	int offerID = Integer.parseInt(request.getParameter("offerID"));
	int requestID = Integer.parseInt(request.getParameter("requestID"));
	
	StringBuilder msb = new StringBuilder();
	
	boolean noSeats = false;
	
	String query = "SELECT numSeats FROM finalproject.offeredRides WHERE offerID="+offerID;
	Statement stmt = con.createStatement();
	ResultSet num = stmt.executeQuery(query);
	if(num.next()){
		if(num.getInt("numSeats") <= 0){
			noSeats = true;
			msb.append("Sorry Not enough seats..");
			// SEND MSG
			response.sendRedirect("messages.jsp");
		}
	}
	
	String update = "UPDATE finalproject.requestedRides SET offerID="+offerID+" WHERE requestID="+requestID;
	PreparedStatement ps = con.prepareStatement(update);
	ps.executeUpdate();
	ps.close();
	
	update = "UPDATE finalproject.offeredRides SET numSeats= numSeats -1 WHERE offerID="+offerID+" AND numSeats > 0";
	PreparedStatement ps1 = con.prepareStatement(update);
	ps1.executeUpdate();
	
	query = "SELECT * FROM finalproject.offeredRides WHERE offerID="+offerID;
	PreparedStatement ps2 = con.prepareStatement(query);
	ResultSet offerResult = ps2.executeQuery(query);
	if (offerResult.next()){
		
	}
  	
  	response.sendRedirect("messages.jsp");
  
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