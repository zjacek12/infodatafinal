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
	
	String loginName = session.getAttribute("loginName").toString();
	
	int offerID = Integer.parseInt(request.getParameter("offerID"));
	int requestID = Integer.parseInt(request.getParameter("requestID"));
	
	boolean noSeats = false;
	
	String query = "SELECT COUNT(*) as cnt FROM finalproject.offeredRides WHERE offerID="+offerID;
	Statement stmt = con.createStatement();
	ResultSet check = stmt.executeQuery(query);
	check.next();
	int cnt = check.getInt("cnt");
	check.close();
	if(cnt < 1){
		out.print("That ride is full or it has been closed... Sorry!");
		stmt.close();
	} else {
		stmt.close();
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE rideID="+offerID;
		Statement stmt2 = con.createStatement();
		ResultSet check2 = stmt2.executeQuery(query);
		check2.next();
		String insert = "";
		query = "SELECT * FROM finalproject.offeredRides WHERE offerID="+offerID;
		Statement stmt1 = con.createStatement();
		ResultSet rideInfo = stmt1.executeQuery(query);
		rideInfo.next();
		if(check2.getInt("cnt") < 1){
			if(rideInfo.getInt("recurring") == 1){
				insert = "INSERT INTO offeredRides" +
						"(RUID, "+
						"fromLocation, "+
						"toLocation, "+
						"departureTime, "+
						"arrivalTime, "+
						"numSeats, "+
						"parkinglot, "+
						"recurring, "+
						"plate) "+
							
						"VALUES"+
						"("+rideInfo.getInt("RUID")+", "+
						"'"+rideInfo.getString("fromLocation")+"', "+
						"'"+rideInfo.getString("toLocation")+"', "+
						"DATE_ADD('"+rideInfo.getString("departureTime")+"' ,INTERVAL +7 DAY), "+
						"DATE_ADD('"+rideInfo.getString("arrivalTime")+"' ,INTERVAL +7 DAY), "+
						""+rideInfo.getInt("numSeats")+", "+
						"'"+rideInfo.getString("parkinglot")+"', "+
						"1, "+
						"'"+rideInfo.getString("plate")+"')";
				
				PreparedStatement ps6 = con.prepareStatement(insert);
				ps6.executeUpdate();
				ps6.close();
			}
			insert = "INSERT INTO finalproject.rideLog " +
					"(RUID, "+
					"rideID, "+
					"role, "+
					"departureTime, "+
					"arrivalTime, "+
					"fromLocation, "+
					"toLocation, "+
					"plate, "+
					"parkinglot)"+				
					"VALUES"+
					"("+rideInfo.getInt("RUID")+", "+
					""+offerID+", "+
					"'Driver', "+
					"'"+rideInfo.getString("departureTime")+"', "+
					"'"+rideInfo.getString("arrivalTime")+"', "+
					"'"+rideInfo.getString("fromLocation")+"', "+
					"'"+rideInfo.getString("toLocation")+"', "+
					"'"+rideInfo.getString("plate")+"', "+
					"'"+rideInfo.getString("parkinglot")+"')";
			PreparedStatement ps1 = con.prepareStatement(insert);
			ps1.executeUpdate();
			ps1.close();
			
		}
		
		stmt2.close();
		check2.close();

		insert = "INSERT INTO finalproject.rideLog " +
				"(RUID, "+
				"rideID, "+
				"role, "+
				"departureTime, "+
				"arrivalTime, "+
				"fromLocation, "+
				"toLocation, "+
				"plate, "+
				"parkinglot)"+
				"VALUES"+
				"("+ruid+", "+	
				""+offerID+", "+
				"'Passenger', "+
				"'"+rideInfo.getString("departureTime")+"', "+
				"'"+rideInfo.getString("arrivalTime")+"', "+
				"'"+rideInfo.getString("fromLocation")+"', "+
				"'"+rideInfo.getString("toLocation")+"', "+
				"'"+rideInfo.getString("plate")+"', "+
				"'"+rideInfo.getString("parkinglot")+"')";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.executeUpdate();
		ps.close();
		
		String message = "'"+loginName+" has joined your ride! Your ride leaves at "+rideInfo.getString("departureTime")+" from "+rideInfo.getString("fromLocation")+" "+rideInfo.getString("parkinglot")+"'";
		query = "INSERT INTO finalproject.messages(fromRUID, toRUID, message, time) VALUES (1111, "+rideInfo.getInt("RUID")+", "+message+", DATE_ADD(current_timestamp,INTERVAL -4 HOUR))";
		PreparedStatement ps4 = con.prepareStatement(query);
		ps4.executeUpdate();
		ps4.close();
		
		message = "'Your ride leaves at "+rideInfo.getString("departureTime")+" from "+rideInfo.getString("fromLocation")+" "+rideInfo.getString("parkinglot")+"'";
		query = "INSERT INTO finalproject.messages(fromRUID, toRUID, message, time) VALUES (1111, "+ruid+", "+message+", DATE_ADD(current_timestamp,INTERVAL -4 HOUR))";
		PreparedStatement ps3 = con.prepareStatement(query);
		ps3.executeUpdate();
		ps3.close();
		stmt1.close();
		rideInfo.close();
		
		query = "SELECT * FROM finalproject.requestedRides WHERE requestID="+requestID+" AND recurring = 1";
		PreparedStatement ps7 = con.prepareStatement(query);
		ResultSet result7 = ps7.executeQuery(query);
		if(result7.next()){
			insert = "INSERT INTO finalproject.requestedRides " +
					"(RUID, "+
					"fromLocation, "+
					"toLocation, "+
					"departureTime, "+
					"arrivalTime, "+
					"recurring, "+
					"earlyDeparture, "+
					"parkinglot)"+
					
					"VALUES"+
					"("+result7.getInt("RUID")+", "+
					"'"+result7.getString("fromLocation")+"', "+
					"'"+result7.getString("toLocation")+"', "+
					"DATE_ADD('"+result7.getString("departureTime")+"' ,INTERVAL 7 DAY), "+
					"DATE_ADD('"+result7.getString("arrivalTime")+"' ,INTERVAL 7 DAY), "+
					"1, "+
					"DATE_ADD('"+result7.getString("earlyDeparture")+"' ,INTERVAL 7 DAY), "+
					"'"+result7.getString("parkinglot")+"')";
			PreparedStatement ps8 = con.prepareStatement(insert);
			ps8.executeUpdate();
			ps8.close();
		}
		result7.close();
		ps7.close();
		
		query = "DELETE FROM finalproject.requestedRides WHERE requestID="+requestID;
		PreparedStatement ps5 = con.prepareStatement(query);
		ps5.executeUpdate();
		ps5.close();
		
		con.close();
	  	
	  	response.sendRedirect("messenger.jsp");
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