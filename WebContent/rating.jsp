<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>
<title>Rate a User</title>
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
	Statement stmt1=conn.createStatement();
	
	/* Retrieve rideID */
	String rideId = request.getParameter("rideId");
	
	/* Queries and variables */
	String query;
	
	/* Determine rider or driver */
	query="SELECT role FROM finalproject.rideLog WHERE rideID=" + rideId + " AND RUID=" + myruid;
	ResultSet rl = stmt.executeQuery(query);
	rl.next();
	
	if(rl.getString("role").equals("Driver")) {
		String query2 = "DELETE FROM finalproject.offeredRides WHERE offerID="+rideId;
		PreparedStatement ps2 = conn.prepareStatement(query2);
		ps2.executeUpdate();
		ps2.close();
	}
%>
	
<!-- Top Title -->
 <div class="w3-black w3-center w3-padding-24">NOTE: Ratings on already previously rated users will be re-written!!!</div>
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Rate a User!</div>
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
      <a href="profilePage.jsp" class="w3-bar-item w3-hover-black w3-button">Profile</a>
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
  
<%
	if(rl.getString("role").equals("Driver")) {
		query="SELECT a.loginName, a.firstName, a.lastName, a.RUID FROM finalproject.accounts a JOIN finalproject.rideLog r ON a.RUID=r.RUID WHERE r.rideID=" + rideId + " AND r.role='Passenger'";
		ResultSet nme=stmt1.executeQuery(query);
%>

  <!-- Rating Section -->
  <div class="w3-container w3-light-grey w3-padding-32 w3-padding-large" id="contact">
    <div class="w3-content" style="max-width:600px">
    
<%
		while(nme.next()) {
			String message = "'Your driver has concluded the ride! Please rate him once the ride finishes! <form action=\"rating.jsp\" method=\"post\"><input type=\"hidden\" name=\"rideId\" value=\""+rideId+"\"/><input type=\"submit\" class=\"w3-button w3-white w3-hover-black\" value=\"Rate Driver\"/></form>'";
			String query1 = "INSERT INTO finalproject.messages (fromRUID, toRUID, message, time) VALUES (1111, "+nme.getInt("RUID")+", "+message+", DATE_ADD(current_timestamp,INTERVAL -4 HOUR))";
			PreparedStatement ps = conn.prepareStatement(query1);
			ps.executeUpdate();
			ps.close();
%>

      <h4 class="w3-center"><b><%out.print(nme.getString("a.loginName"));%></b></h4>
      <p class="w3-center"><%out.print(nme.getString("a.firstName") + " " + nme.getString("a.lastName"));%></p>
      <form action="createRating.jsp" method="post">
      <div class="w3-section w3-center">
        <label>Rating (1-5)</label>
        <p>
        	<select name="score">
			<option value="1"> (1/5) </option>
			<option value="2"> (2/5) </option>
			<option value="3"> (3/5) </option>
			<option value="4"> (4/5) </option>
			<option value="5"> (5/5) </option>
			</select>
		</p>
		<p><input class="w3-input w3-border w3-margin-bottom" type="text" name="cmnt" value="" placeholder="Anything you'd like to mention about this driver?"></p>
		<input type="hidden" name="toRUID" value="<%out.print(nme.getInt("a.RUID"));%>">
		<input type="hidden" name="role" value="Driver">
		<input type="submit" value="Submit Rating">
      </div>
      </form>
    </div>
  </div>
  
<%
		}
		nme.close();
	} else {
		query="SELECT RUID FROM finalproject.rideLog WHERE rideID=" + rideId + " AND role='Driver'";
		ResultSet nme = stmt1.executeQuery(query);
		nme.next();
		
		int rateed = nme.getInt("RUID");
		
		query="SELECT loginName, firstName, lastName FROM finalproject.accounts WHERE RUID=" + rateed;
		nme=stmt1.executeQuery(query);
		nme.next();
%>

  <!-- Rating Section -->
  <div class="w3-container w3-light-grey w3-padding-32 w3-padding-large" id="contact">
    <div class="w3-content" style="max-width:600px">
      <h4 class="w3-center"><b><%out.print(nme.getString("loginName"));%></b></h4>
      <p class="w3-center"><%out.print(nme.getString("firstName") + " " + nme.getString("lastName"));%></p>
      <form action="createRating.jsp" method="post">
      <div class="w3-section w3-center">
        <label>Rating (1-5)</label>
        <p>
        	<select name="score">
			<option value="1"> (1/5) </option>
			<option value="2"> (2/5) </option>
			<option value="3"> (3/5) </option>
			<option value="4"> (4/5) </option>
			<option value="5"> (5/5) </option>
			</select>
		</p>
		<p><input class="w3-input w3-border w3-margin-bottom" type="text" name="cmnt" value="" placeholder="Anything you'd like to mention about this driver?"></p>
		<input type="hidden" name="toRUID" value="<%out.print(rateed);%>">
		<input type="hidden" name="role" value="Passenger">
		<input type="submit" value="Submit Rating">
      </div>
      </form>
    </div>
  </div>
  
<%
		nme.close();
	}
	rl.close();
%>
  
  <div class="w3-black w3-center w3-padding-24">Made by Alex Marek, Jacek Zarski & Armin Grossrieder</div>
  <%
	/* Close stmt and conn */
	stmt.close();
    stmt1.close();
	conn.close();
  }
	catch(Exception e)
	{
		response.sendRedirect("profilePage.jsp");
	}
%>
<!-- End page content -->
</div>
</body>
</html>