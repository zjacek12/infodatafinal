<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,javax.swing.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
</head>
<body class="w3-light-grey w3-content" style="max-width:1600px">
<div style="float:right;margin-right:50px">
  <p> </p>
  <form action="logout.jsp" method="post">
    <input type="submit" value="Logout" />
  </form>
</div>
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Request a ride!</div>
</header>


<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<%
try {

	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");
	String loginName, password, query;
	Integer ruid;

	loginName = session.getAttribute("loginName").toString();
	password = session.getAttribute("password").toString();
	ruid = Integer.parseInt(session.getAttribute("ruid").toString());
	query = "SELECT * FROM accounts WHERE loginName ='"+loginName+"' AND password ='"+password+"'";
	PreparedStatement ps = con.prepareStatement(query);
	ResultSet result = ps.executeQuery(query);
	
	if(result.next()){
		%>
		<!-- !PAGE CONTENT! -->
	  <div class="w3-main" style="margin-left:50px; margin-right:50px">
		
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
	  		<form action="profile.jsp" method="get">
			<table class="w3-table-all">
				<th bgcolor="#CCCCFF" colspan=2>
					<font size=5>RIDER INFO</font>
				</th>
				<tr bgcolor="#c8d8f8">
					<td valign=top colspan=2>
						<b>Login: <%out.print(loginName);%></b><br>
						<b>Name: <%out.print(result.getString("firstName")+ " " +result.getString("lastName"));%></b><br>
						<b>RUID: <%out.print(ruid); %></b>
					</td>
				</tr>
				<tr bgcolor="#c8d8f8">
					<td valign=top>
						<b>Driver Rating: <%out.print(result.getDouble("userRating")); %></b>
						<br>
						<b>Number of rides offered: <%out.print(result.getInt("numRides"));%></b>
					</td>
				</tr>
			</table>
	</form>
			
		<form action="submitRequest.jsp" method="post">
				<table cellpadding=4 cellspacing=2 border=0 class="w3-table-all">
					<th bgcolor="#CCCCFF" colspan=2>
						<font size=5>REQUEST INFO</font>
					</th>
					<tr bgcolor="#c8d8f8">
						<td>
							<b>From Campus</b><br>
							<select name="fromLocation">
								<option value="College Ave"> College Ave </option>
								<option value="Livingston"> Livingston </option>
								<option value="Busch"> Busch </option>
								<option value="Cook/Douglass"> Cook/Douglass </option>
							</select>
						</td>
						<td>
							<b>To Campus</b><br>
							<select name="toLocation">
								<option value="College Ave"> College Ave </option>
								<option value="Livingston"> Livingston </option>
								<option value="Busch"> Busch </option>
								<option value="Cook/Douglass"> Cook/Douglass </option>
							</select>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td colspan=2>
							<b>Parking Lot</b><br>
							<input type="text" name="parkinglot" value="" />
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td>
							<b>How early can you leave?</b><br>
							
							<input type="datetime-local" name="earlyDeparture" />
							<br>
						</td>
						<td>
							<b>How late can you leave?</b><br>
							
							<input type="datetime-local" name="departureTime"/>
							<br>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td colspan=2>
						 	<b>When do you want to arrive by:</b>
							
							<input type="datetime-local" name="arrivalTime"/>
							<br>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td>
							<label for="yesrecurring">Every Week</label>
							<input type="radio" name="recurring" id="yesrecurring" value="1">
							<label for="norecurring">Only Once</label>
							<input type="radio" name="recurring" id="norecurring" value="0" checked="checked">
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td align=center colspan=2>
							<input type="submit" value="Submit Request" class="w3-bar-item w3-button w3-hover-black">
						</td>
					</tr>
				</table>
		</form>
		<%
		con.close();
		// out.print("Account Name: " + loginName + "<br> Password: " + password);
		
	} else {
		con.close();
		out.print("Please go back and log in again");
	}

	
} catch (Exception ex) {
	out.print("something failed failed" + "<br>");
	out.println("this is why");
	ex.printStackTrace();
}
%>
</div>
</body>
</html>