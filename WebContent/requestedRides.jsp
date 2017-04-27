<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>
<title>Requests</title>														<!-- SET TITLE -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">

<body class="w3-light-grey w3-content" style="max-width:1600px">
<%
try {
	/* Instance RUID */
	int myruid = Integer.parseInt(session.getAttribute("ruid").toString());
	/* Setup SQL connection */
	String url="jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	String username="alexarminjacek";
	String password="alexarminjacek";
	Connection conn=DriverManager.getConnection(url, username, password);
	Statement stmt = conn.createStatement();
	Statement delstmt = conn.createStatement();
	Statement delstmt1 = conn.createStatement();
	
	/* Queries and variables */
	String query;
	
	query = "SELECT * FROM finalproject.requestedRides WHERE departureTime <= DATE_ADD(current_timestamp,INTERVAL -4 HOUR) AND recurring = 1";
	PreparedStatement ps5 = conn.prepareStatement(query);
	ResultSet result5 = ps5.executeQuery(query);
	while(result5.next()){
		query = "INSERT INTO finalproject.requestedRides " +
				"(RUID, "+
				"fromLocation, "+
				"toLocation, "+
				"departureTime, "+
				"arrivalTime, "+
				"recurring, "+
				"earlyDeparture, "+
				"parkinglot)"+
				
				"VALUES"+
				"("+result5.getInt("RUID")+", "+
				"'"+result5.getString("fromLocation")+"', "+
				"'"+result5.getString("toLocation")+"', "+
				"DATE_ADD('"+result5.getString("departureTime")+"' ,INTERVAL 7 DAY), "+
				"DATE_ADD('"+result5.getString("arrivalTime")+"' ,INTERVAL 7 DAY), "+
				"1, "+
				"DATE_ADD('"+result5.getString("earlyDeparture")+"' ,INTERVAL 7 DAY), "+
				"'"+result5.getString("parkinglot")+"')";
		PreparedStatement ps8 = conn.prepareStatement(query);
		ps8.executeUpdate();
		ps8.close();
	}
	result5.close();
	ps5.close();
	
	query = "DELETE FROM finalproject.requestedRides WHERE departureTime <= DATE_ADD(current_timestamp,INTERVAL -4 HOUR)";
	delstmt.executeUpdate(query);
	delstmt.close();
	
	query = "SELECT * FROM finalproject.requestedRides WHERE RUID="+myruid;
	
	ResultSet rides = stmt.executeQuery(query);
	
	
%>
	
<!-- Top Title -->
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Profile : <%out.print(session.getAttribute("loginName"));%></div>
</header>


<!-- Logout -->
<div style="float:right;margin-right:50px">
  <p> </p>
  <form action="logout.jsp" method="post">
    <input type="submit" value="Logout" />
  </form>
</div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:50px">

  <!-- Keep room for the navigation menu  -->
  <div class="" style="margin-top:83px"></div> 

  <!-- Navigation -->
  <header>
  <div class="w3-padding-32" style="center">
    <div class="w3-bar">
      <a href="profilePage.jsp" class="w3-bar-item w3-hoover-black w3-button">Profile</a>
      <a href="myRides.jsp" class="w3-bar-item w3-button w3-hover-black">Offered Rides</a>
      <a href="requestedRides.jsp" class="w3-bar-item w3-button w3-black">Requested Rides</a>
      <a href="messenger.jsp" class="w3-bar-item w3-button w3-hover-black">Messaging</a>
      <a href="editProfile.jsp" class="w3-bar-item w3-button w3-hover-black">Edit Profile</a>
      <div class="w3-right"  style="width:30%"><form action="profileViewable.jsp" method="get">
      <input type="search" name="searchName" class="w3-input" value="" placeholder="Search by: User Name" 
      size=3 maxlength=20/>
      <input type="submit" value="Submit" class="w3-button w3-hover-black"
      class="w3-bar-item w3-button w3-hover-black">
      </form></div>
    </div>
  </div>
  </header>
  
  <!--TABLE-->
  <div class="w3-container w3-grey w3-padding-32 w3-padding-large" id="requests">
    <div class="w3-content" style="max-width:600px">
	<h4 class="w3-center"><b>Requests</b></h4>
    <div class="w3-content w3-center">
    <form action="deleteRequest.jsp" method="post">
      <table style="width:100%" border="2">
	    <tr>
	    	<th>Delete</th>
			<th>Early Departure Time</th>
			<th>Departure Time</th>
			<th>Arrival Time</th>
			<th>From</th>
			<th>To</th>
		</tr>
<%
	while(rides.next()) {
%>
		<tr>
			<td><input type="hidden" name="deleteID" value="<%= rides.getInt("requestID") %>" />
    		<input id="button" type="submit" value="Delete" ></td>
			<td><%out.print(rides.getString("earlyDeparture"));%></td>
			<td><%out.print(rides.getString("departureTime"));%></td>
			<td><%out.print(rides.getString("arrivalTime"));%></td>
			<td><%out.print(rides.getString("fromLocation"));%></td>
			<td><%out.print(rides.getString("toLocation"));%></td>
		</tr>	
		<%
		}
		rides.close();
		stmt.close();
		conn.close();
		%>
		<tr>
			<td align=center colspan=6>
				<input type="submit" value="Delete Selected" class="w3-bar-item w3-button w3-hover-black">
			</td>
		</tr>
	  </table>
	  </form>
    </div>
    </div>
  </div>
  
  <div class="w3-black w3-center w3-padding-24">Made by Alex Marek, Jacek Zarski & Armin Grossrieder</div>
  <%

  }
	catch(Exception e)
	{
		out.print(e.getMessage());
	}
%>
<!-- End page content -->
</div>
</body>
</html>