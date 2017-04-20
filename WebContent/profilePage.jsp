<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>
<title>Profile Page</title>
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
	Statement stmt=conn.createStatement();
	
	/* Queries and variables */
	String query;
	query="SELECT * FROM finalproject.car WHERE ruid=" + myruid;
	ResultSet vi = stmt.executeQuery(query);
	query="SELECT * FROM finalproject.accounts ORDER BY rankScore";
	ResultSet lb = stmt.executeQuery(query);
	query="SELECT loginName FROM finalproject.accounts WHERE ruid=" + myruid;
	ResultSet lN = stmt.executeQuery(query);
	
	/* Close stmt and conn */
	stmt.close();
	conn.close();

%>
<!-- Top Title -->
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Profile : <%out.print(lN.getString("loginName"));%></div>
</header>

<%lN.close();%>

<!-- Logout -->
<div style="float:right">
  <p> </p>
  <a href="index.html" onClick="alert('You have successfuly logged out.')">Logout</a>
</div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:50px">

  <!-- Keep room for the navigation menu  -->
  <div class="" style="margin-top:83px"></div> 

  <!-- Navigation -->
  <header>
  <div class="w3-padding-32" style="center">
    <div class="w3-bar">
      <a href="profilePage.jsp" class="w3-bar-item w3-black w3-button">Profile</a>
      <a href="offeredRides.jsp" class="w3-bar-item w3-button w3-hover-black">Offered Rides</a>
      <a href="requestedRides.jsp" class="w3-bar-item w3-button w3-hover-black">Requested Rides</a>
      <a href="messages.jsp" class="w3-bar-item w3-button w3-hover-black">Messaging</a>
    </div>
  </div>
  </header>

  <!-- About Section -->
  <div class="w3-container w3-dark-grey w3-center w3-text-light-grey w3-padding-32" id="about">
	  
	  <!-- User Rating -->
      <h4 class="w3-padding-16">User Rating</h4>
      <div class="w3-white">
        <div class="w3-container w3-padding-small w3-center w3-green" style="width:85%">85%</div>
      </div>
	  <div style="width:100%">
	    <div style="width:20%; float:left">
		  <h4>Rides Given</h4>
		  <p>Some Number</p>
		</div>
		<div style="width:80%; float:right">
		  <h4>Rides Received</h4>
		  <p>Some Number</p>
		</div>
	  </div>
	  <div style="clear:both"></div>
      
      <hr class="w3-opacity">
	  
	  <!-- Select Offer or Request Ride -->
      <h4 class="w3-padding-16 w3-center">Which would you like to do?</h4>
      <div class="w3-row-padding" style="margin:0 -16px">
        <div class="w3-half w3-margin-bottom">
          <ul class="w3-ul w3-white w3-center w3-opacity w3-hover-opacity-off">
            <li class="w3-black w3-xlarge w3-padding-32">Offer A Ride</li>
            <li class="w3-light-grey w3-padding-24">
              <a href="offerRide.jsp" class="w3-button w3-white w3-padding-large">Enter</a>
            </li>
          </ul>
        </div>
        
        <div class="w3-half">
          <ul class="w3-ul w3-white w3-center w3-opacity w3-hover-opacity-off">
            <li class="w3-black w3-xlarge w3-padding-32">Request A Ride</li>
            <li class="w3-light-grey w3-padding-24">
              <a href="requestRide.jsp" class="w3-button w3-white w3-padding-large">Enter</a>
            </li>
          </ul>
        </div>
      </div>
  </div>
  
  <!-- Vehicle Information -->
  <div class="w3-container w3-light-grey w3-padding-32 w3-padding-large" id="contact">
    <div class="w3-content" style="max-width:600px">
      <h4 class="w3-center"><b>Vehicle Information</b></h4>
      <table style="width:100%" border="2">
	    <tr>
		  <th>License Plate</th>
		  <th>Make</th>
		  <th>Color</th>
		  <th>Max Seating</th>
		</tr>
<%
	while(vi.next()) {
%>
		<tr>
			<td><%out.print(vi.getString("plate"));%></td>
			<td><%out.print(vi.getString("make"));%></td>
			<td><%out.print(vi.getString("color"));%></td>
			<td><%out.print(vi.getString("numSeats"));%></td>
		</tr>
<%
	}
	vi.close();
%>		
	</table>
    </div>
  </div>

  <!-- Contact section -->
  <div class="w3-container w3-light-grey w3-padding-32 w3-padding-large" id="contact">
    <div class="w3-content" style="max-width:600px">
      <h4 class="w3-center"><b>Contact Information</b></h4>
      <div class="w3-section">
        <label>Name</label>
        <p>Enter Name Here</p>
      </div>
      <div class="w3-section">
        <label>Phone</label>
        <p>Enter Phone Here</p>
      </div>
      <div class="w3-section">
        <label>Email</label>
        <p>Enter Email Here</p>
      </div>
    </div>
  </div>

  <!-- Leaderboard -->
  <div class="w3-container w3-grey w3-padding-32 w3-padding-large" id="leaderboard">
    <div class="w3-content" style="max-width:600px">
	<h4 class="w3-center"><b>Leaderboard</b></h4>
    <div class="w3-content w3-center">
      <table style="width:100%" border="2">
	    <tr>
			<th>Rank</th>
			<th>Username</th>
			<th>Rating Score</th>
		</tr>
<%
	int i = 1;
	while(i < 11 && lb.next()) {
%>
		<tr>
			<td><%out.print(i);%></td>
			<td><%out.print(lb.getString("loginName"));%></td>
			<td><%out.print(lb.getString("rankScore"));%></td>
		</tr>	
<%
	}
	lb.close();
%>
	</table>
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