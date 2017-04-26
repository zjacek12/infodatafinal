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
	
	/* Vehicle Information */
	query="SELECT * FROM finalproject.car WHERE ruid=" + myruid;
	ResultSet vi = stmt.executeQuery(query);

	
	/* Leader Board */
	query="SELECT * FROM finalproject.accounts ORDER BY rankScore DESC";
	Statement stmt1=conn.createStatement();
	ResultSet lb = stmt1.executeQuery(query);
	
	/* Login Name */
	query="SELECT loginName FROM finalproject.accounts WHERE ruid=" + myruid;
	Statement stmt2=conn.createStatement();
	ResultSet lN = stmt2.executeQuery(query);
	lN.next();
	
	/* Contact Information */
	query="SELECT * FROM finalproject.accounts WHERE ruid=" + myruid;
	Statement stmt3=conn.createStatement();
	ResultSet ci = stmt3.executeQuery(query);
	ci.next();
	
	
	/* Comments */
	query="SELECT * FROM finalproject.ratings WHERE toRUID=" + myruid;
	Statement stmt4=conn.createStatement();
	ResultSet pc = stmt4.executeQuery(query);
	pc.next();
	pc.close();
	
	/* Rating Calculations */
	query="SELECT SUM(rating) as sum FROM finalproject.ratings WHERE toRUID=" + myruid;
	Statement stmt5=conn.createStatement();
	ResultSet pr = stmt5.executeQuery(query);
	pr.next();
	double sumR = pr.getDouble("sum");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.ratings WHERE toRUID=" + myruid;
	pr = stmt5.executeQuery(query);
	pr.next();
	double numR = pr.getInt("cnt");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role='Driver' AND RUID=" + myruid + " AND departureTime > DATE_ADD(DATE_ADD(current_timestamp,INTERVAL -1 MONTH), INTERVAL -4 HOUR)";
	pr = stmt5.executeQuery(query);
	pr.next(); 
	int numGivenMonth = pr.getInt("cnt");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role='Driver' AND RUID=" + myruid + " AND departureTime >  DATE_ADD(DATE_ADD(current_timestamp,INTERVAL -3 MONTH), INTERVAL -4 HOUR)";
	pr = stmt5.executeQuery(query);
	pr.next(); 
	int numGivenSemester = pr.getInt("cnt");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role='Passenger' AND RUID=" + myruid + " AND departureTime >  DATE_ADD(DATE_ADD(current_timestamp,INTERVAL -1 MONTH), INTERVAL -4 HOUR)";
	pr = stmt5.executeQuery(query);
	pr.next();
	int numTakenMonth = pr.getInt("cnt");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role='Passenger' AND RUID=" + myruid + " AND departureTime >  DATE_ADD(DATE_ADD(current_timestamp,INTERVAL -3 MONTH), INTERVAL -4 HOUR)";
	pr = stmt5.executeQuery(query);
	pr.next();
	int numTakenSemester = pr.getInt("cnt");
	pr.close();
	stmt5.close();
	
	/* Rating Calculation */
	double avgR = sumR/numR;
	double avgP = (avgR/5) * 100;
%>
	
<!-- Top Title -->
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Profile : <%out.print(lN.getString("loginName"));%></div>
</header>

<%
	lN.close();
%>

<!-- Logout -->
<div style="float:right;margin-right:50px">
  <p> </p>
  <form action="logout.jsp" method="post">
    <input type="submit" value="Logout" />
  </form></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:50px;margin-right:50px">

  <!-- Keep room for the navigation menu  -->
  <div class="" style="margin-top:83px"></div> 

  <!-- Navigation -->
  <header>
  <div class="w3-padding-32" style="center">
    <div class="w3-bar">
      <a href="profilePage.jsp" class="w3-bar-item w3-black w3-button">Profile</a>
      <a href="myRides.jsp" class="w3-bar-item w3-button w3-hover-black">Offered Rides</a>
      <a href="requestedRides.jsp" class="w3-bar-item w3-button w3-hover-black">Requested Rides</a>
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

  <!-- About Section -->
  <div class="w3-container w3-dark-grey w3-center w3-text-light-grey w3-padding-32" id="about">
	  
	  <!-- User Rating --> <!-- *ADD COMMENTS VIEWABLE?* -->
      <h4 class="w3-padding-16">User Rating</h4>
      <div class="w3-white">
        <div class="w3-container w3-padding-small w3-center w3-green" style="width:${avgP}%>"><%out.print(avgP);%>%</div>
      </div>
	 
	  <div style="width:100%">
	    <div class="w3-half">
		  <h4>Rides Given This Month</h4>
		  <p><%out.print(numGivenMonth);%></p>
		</div>
		<div class="w3-half">
		  <h4>Rides Taken This Month</h4>
		  <p><%out.print(numTakenMonth);%></p>
		</div>
	  </div>
	  <div style="clear:both"></div>
	  
	  <div style="width:100%">
	    <div class="w3-half">
		  <h4>Rides Given This Semester</h4>
		  <p><%out.print(numGivenSemester);%></p>
		</div>
		<div class="w3-half">
		  <h4>Rides Taken This Semester</h4>
		  <p><%out.print(numTakenSemester);%></p>
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
        <label><b>Name</b></label>
        <p><%out.print(ci.getString("firstName")); out.print(" " +ci.getString("lastName"));%></p>
      </div>
      <div class="w3-section">
        <label><b>Phone</b></label>
        <p><%out.print(ci.getString("phone"));%></p>
      </div>
      <div class="w3-section">
        <label><b>Email</b></label>
        <p><%out.print(ci.getString("email"));%></p>
      </div>
    </div>
  </div>
<%
	ci.close();
%>
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
	i++;
	}
	lb.close();
%>
	</table>
    </div>
    </div>
  </div>
  
  <div class="w3-black w3-center w3-padding-24">Made by Alex Marek, Jacek Zarski & Armin Grossrieder</div>
  <%
	/* Close stmt and conn */
	stmt.close();
 	stmt1.close();
 	stmt2.close();
	stmt3.close();
	stmt4.close();
	conn.close();
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
