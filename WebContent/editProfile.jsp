<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>
<title>Edit Profile</title>														<!-- SET TITLE -->
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
	
	/* Login Name */
	query="SELECT loginName FROM finalproject.accounts WHERE ruid=" + myruid;
	Statement stmt2=conn.createStatement();
	ResultSet lN = stmt2.executeQuery(query);
	lN.next();
%>
	
<!-- Top Title -->
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Editing Profile : <%out.print(lN.getString("loginName"));%></div>
</header>

<%
	lN.close();
%>

<!-- Logout -->
<div style="float:right;margin-right:50px">
  <p> </p>
  <a href="index.html" onClick="alert('You have successfuly logged out.')">Logout</a>
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
      <a href="offeredRides.jsp" class="w3-bar-item w3-button w3-hover-black">Offered Rides</a>
      <a href="requestedRides.jsp" class="w3-bar-item w3-button w3-hover-black">Requested Rides</a>
      <a href="messages.jsp" class="w3-bar-item w3-button w3-hover-black">Messaging</a>
      <a href="editProfile.jsp" class="w3-bar-item w3-button w3-black">Edit Profile</a>
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
  <div class="w3-container w3-dark-grey w3-center w3-text-light-grey w3-padding-32" id="editContainer">
	<h4 class="w3-padding-16">Edit Credentials</h4>
	  <div style="clear:both"></div>
      
      <hr class="w3-opacity">
      
     <div class="w3-container w3-grey w3-padding-32 w3-padding-large" id="editProfile">
   		 <div class="w3-content" >
  			 <div class="w3-content w3-center">
    			 <form action="submitEdit.jsp" method="post">
					<table class="w3-table-all">
						<th bgcolor="#CCCCFF" colspan=2>
							<font size=5>Edit Profile</font>
						</th>
						<tr>
							<td valign=top> 
								<b>First Name<sup>*</sup></b> 
								<br>
							<input type="text" name="firstName" value="" size=15 maxlength=20></td>
							<td  valign=top>
								<b>Last Name<sup>*</sup></b>
								<br>
							<input type="text" name="lastName" value="" size=15 maxlength=20></td>
						</tr>
						<tr >
							<td valign=top colspan=2>
								<b>E-Mail<sup>*</sup></b> 
								<br>
								<input type="email" name="email" value="" size=25  maxlength=125>
							<br></td>
						</tr>
						<tr >
							<td valign=top colspan=2>
								<b>User Name<sup>*</sup></b>
								<br>
								<input type="text" name="loginName" size=10 value=""  maxlength=10>
							</td>
						</tr>
						<tr >
							<td valign=top>
								<b>Password<sup>*</sup></b> 
								<br>
								<input type="password" name="password1" size=10 value=""  
							maxlength=10></td>
							<td  valign=top>
								<b>Confirm Password<sup>*</sup></b>
								<br>
								<input type="password" name="password2" size=10 value=""  
							maxlength=10></td>
						</tr>
						<tr >
							<td  valign=top colspan=2>
								<b>Phone Number</b>
								<br>
								<input type="text" name="phoneNumber" size=20 value=""  
							maxlength=20></td>
						</tr>
						<tr >
							<td valign=top colspan=2>
								<b>Address</b> 
								<br>
								<input type="text" name="address" value="" size=25  maxlength=125>
							<br></td>
						</tr>
						<tr >
							<td  align=center colspan=2>
								<input type="submit" value="Submit"> <input type="reset"  
								value="Reset">
							</td>
						</tr>
					</table>
				</form>
    		</div>
       </div>
  </div>
   <div class="w3-container w3-grey w3-padding-32 w3-padding-large" id="addCar">
   		<div class="w3-content" >
  			 <div class="w3-content w3-center">
    			 <form action="addCar.jsp" method="post">
					<table class="w3-table-all">
						<th bgcolor="#CCCCFF" colspan=2>
							<font size=5>Add Car</font>
						</th>
						<tr>
							<td valign=top> 
								<b>Make<sup>*</sup></b> 
								<br>
								<input type="text" name="make" value="" size=15 maxlength=20></td>
							<td  valign=top>
								<b>Model<sup>*</sup></b>
								<br>
							<input type="text" name="model" value="" size=15 maxlength=20></td>
						</tr>
						<tr >
							<td valign=top colspan=2>
								<b>Plate<sup>*</sup></b> 
								<br>
								<input type="text" name="plate" value="" size=10  maxlength=15>
							<br></td>
						</tr>
						<tr >
							<td valign=top colspan=2>
								<b>Color<sup>*</sup></b>
								<br>
								<input type="text" name="color" size=15 value=""  maxlength=20>
							</td>
						</tr>
						<tr >
							<td valign=top colspan=2>
								<b>Number of Seats<sup>*</sup></b> 
								<br>
								<input type="text" name="numSeats" size=2 value=""  maxlength=2></td>
						</tr>
						<tr >
							<td  align=center colspan=2>
								<input type="submit" value="Submit"> <input type="reset"  
								value="Reset">
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