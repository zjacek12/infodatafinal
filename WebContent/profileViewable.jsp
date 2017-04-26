<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>

<% 
/* Instance userName */
String searchName = request.getParameter("searchName");
%>

<title><%out.print(searchName + "'s Profile");%></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">

<body class="w3-light-grey w3-content" style="max-width:1600px">

<%
try {	
	/* Setup SQL connection */
	String url="jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	String username="alexarminjacek";
	String password="alexarminjacek";
	Connection conn=DriverManager.getConnection(url, username, password);
	Statement stmt=conn.createStatement();
	
	
	/* Queries and variables */
	String query;
	
	/* Match Username to RUID */
	query="SELECT ruid FROM finalproject.accounts WHERE loginName='" + searchName+"'";
	Statement stmt6 = conn.createStatement();
	ResultSet id = stmt6.executeQuery(query);
	id.next();
	int thisruid = id.getInt("ruid");
	id.close();
	stmt6.close();
	
	/* Vehicle Information */
	query="SELECT * FROM finalproject.car WHERE ruid=" + thisruid;
	ResultSet vi = stmt.executeQuery(query);
	
	/* Leader Board */
	query="SELECT * FROM finalproject.accounts ORDER BY rankScore DESC";
	Statement stmt1=conn.createStatement();
	ResultSet lb = stmt1.executeQuery(query);
	
	/* Contact Information */
	query="SELECT * FROM finalproject.accounts WHERE ruid=" + thisruid;
	Statement stmt3=conn.createStatement();
	ResultSet ci = stmt3.executeQuery(query);
	ci.next();
	
	/* Comments */
	query="SELECT * FROM finalproject.ratings WHERE toRUID=" + thisruid;
	Statement stmt4=conn.createStatement();
	ResultSet pc = stmt4.executeQuery(query);
	pc.next();
	pc.close();
	
	/* Rating Calculations */
	query="SELECT SUM(rating) as sum FROM finalproject.ratings WHERE toRUID=" + thisruid;
	Statement stmt5=conn.createStatement();
	ResultSet pr = stmt5.executeQuery(query);
	pr.next();
	double sumR = pr.getDouble("sum");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.ratings WHERE toRUID=" + thisruid;
	pr = stmt5.executeQuery(query);
	pr.next();
	double numR = pr.getInt("cnt");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role='Driver' AND RUID=" + thisruid + " AND departureTime > DATE_ADD(DATE_ADD(current_timestamp,INTERVAL -1 MONTH), INTERVAL -4 HOUR)";
	pr = stmt5.executeQuery(query);
	pr.next(); 
	int numGivenMonth = pr.getInt("cnt");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role='Driver' AND RUID=" + thisruid + " AND departureTime> DATE_ADD(DATE_ADD(current_timestamp,INTERVAL -3 MONTH), INTERVAL -4 HOUR)";
	pr = stmt5.executeQuery(query);
	pr.next(); 
	int numGivenSemester = pr.getInt("cnt");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role='Passenger' AND RUID=" + thisruid + " AND departureTime> DATE_ADD(DATE_ADD(current_timestamp,INTERVAL -1 MONTH), INTERVAL -4 HOUR)";
	pr = stmt5.executeQuery(query);
	pr.next();
	int numTakenMonth = pr.getInt("cnt");
	pr.close();
	
	query="SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role='Passenger' AND RUID=" + thisruid + " AND departureTime> DATE_ADD(DATE_ADD(current_timestamp,INTERVAL -3 MONTH), INTERVAL -4 HOUR)";
	pr = stmt5.executeQuery(query);
	pr.next();
	int numTakenSemester = pr.getInt("cnt");
	pr.close();
	stmt5.close();
	
	/* Rating Calculation */
	double avgR = sumR/numR;
	double avgP = (avgR/5) * 100;
	
	/* Comments */
	query="SELECT * FROM finalproject.ratings WHERE toRUID=" + thisruid;
	Statement stmt7 = conn.createStatement();
	ResultSet com = stmt7.executeQuery(query);
%>
	
<!-- Top Title -->
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Profile : <%out.print(searchName);%></div>
</header>

<!-- Logout -->
<div style="float:right;margin-right:50px">
  <p> </p>
  <form action="logout.jsp" method="post">
    <input type="submit" value="Logout" />
  </form>
</div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:50px;margin-right:50px">

  <!-- Keep room for the navigation menu  -->
  <div class="" style="margin-top:83px"></div> 

  <!-- Navigation -->
  <header>
  <div class="w3-padding-32" style="center">
    <div class="w3-bar">
      <a href="profilePage.jsp" class="w3-bar-item w3-hover-black w3-button">Return to My Profile</a>
      <a href="messenger.jsp" class="w3-bar-item w3-button w3-hover-black">Messaging</a>
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
	    
  	  <!-- User Comments -->
	  <div align=center style="width:100%">
	    <h4><b>User Comments</b></h4>
	  	<table style="width:80%" border="1">
	  		<col width=20%>
	  		<col width=75% align=center>
	  		<col width=5%>
	  		<tr>
	  			<th><%out.print(searchName);%>'s Role</th>
	  			<th>Comment</th>
	  			<th>Rating</th>
	  		</tr>
<%
	while(com.next()) {
		if(com.getString("role").equals("Driver")) {
%>
			<tr>
				<td>Passenger</td>
				<td><%out.print(com.getString("thecomment"));%></td>
				<td><%out.print(com.getInt("rating"));%></td>
			</tr>
<%
		} else {
%>
			<tr>
				<td>Driver</td>
				<td><%out.print(com.getString("thecomment"));%></td>
				<td><%out.print(com.getInt("rating"));%></td>
			</tr>
<%
		}
	}
%>
	  	</table>
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
	com.close();
	stmt.close();
 	stmt1.close();
	stmt3.close();
	stmt4.close();
	stmt7.close();
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
