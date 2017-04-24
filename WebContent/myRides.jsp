<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">

<body class="w3-light-grey w3-content" style="max-width:1600px">
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<%
try {
	String query;
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");
	int ruid = Integer.parseInt(session.getAttribute("ruid").toString());
	
	Statement delstmt = con.createStatement();
	query = "DELETE FROM finalproject.offeredRides WHERE departureTime <= NOW()";
	delstmt.executeUpdate(query);
	delstmt.close();
	
  	Statement stmt = con.createStatement();
  	query = "SELECT * FROM offeredRides WHERE RUID='"+ruid+"'";
  	ResultSet result = stmt.executeQuery(query);
  %>	
<!-- Top Title -->
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Profile : <%out.print(session.getAttribute("loginName"));%></div>
</header>


<!-- Logout -->
<div style="float:right;margin-right:50px">
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
      <a href="profilePage.jsp" class="w3-bar-item w3-hoover-black w3-button">Profile</a>
      <a href="myRides.jsp" class="w3-bar-item w3-button w3-black">Offered Rides</a>
      <a href="requestedRides.jsp" class="w3-bar-item w3-button w3-hoover-black">Requested Rides</a>
      <a href="messenger.jsp" class="w3-bar-item w3-button w3-hover-black">Messaging</a>
    </div>
  </div>
  </header>
  
	<div class="w3-container w3-light-grey w3-padding-32 w3-padding-large" id="contact">
		<div class="w3-content" style="max-width:900px">
  			
  <%
  while(result.next()){
	%>
<%-- 	<%out.print(result.getString("fromLocation")); %> to <%out.print(result.getString("toLocation")); %> 
	      on <%out.print(result.getString("departureTime").substring(0, 10)); %>
	      at <%out.print(result.getString("departureTime").substring(11)); %> --%>
	<form action="acceptRequests.jsp" method="post">
		<table style="width:100%" class="w3-table-all">
			<tr>
				<td><b>Ride: </b></td>
			  	<td><b><%out.print(ruid); %></b></td>
			  	<td><b><%out.print(result.getString("fromLocation")); %></b></td>
			  	<td><b><%out.print(result.getString("toLocation")); %></b></td>
			  	<td><b><%out.print(result.getString("departureTime").substring(0, 10)); %></b></td>
			  	<td><b><%out.print(result.getString("departureTime").substring(11)); %></b></td>
			</tr>
  			<tr bgcolor="#CCCCFF" colspan=2>
  				<td><b>Matching Requests </b></td>
			  	<td>RUID</td>
			  	<td>From</td>
			  	<td>To</td>
			  	<td>On</td>
			  	<td>At</td>
			</tr>
			
			<%
			Statement stmt11 = con.createStatement();
			String nquery = "select * from finalproject.requestedRides "+
					"where fromLocation='"+result.getString("fromLocation")+"' and toLocation='"+result.getString("toLocation")+"'";
			// TODO: AND DEPARTURE TIMES MATCH UP ='"+loginName+"'
			ResultSet result11 = stmt11.executeQuery(nquery); 
			while(result11.next()){
			%>
			<tr>
				<td><input type="checkbox" name="selected" value="<% out.print(result11.getString("RUID"));%>"></td>
				<td><% out.print(result11.getString("RUID"));%></td>
		  		<td><% out.print(result11.getString("fromLocation"));%></td>
		  		<td><% out.print(result11.getString("toLocation"));%></td>
		  		<td><%out.print(result.getString("departureTime").substring(0, 10)); %></td>
		  		<td><%out.print(result.getString("departureTime").substring(11)); %></td>
			</tr>

			
			<% } %>
			<tr>
				<td>
					<input type="submit" value="Submit Request" class="w3-bar-item w3-button w3-hover-black">
				</td>
			</tr>
		</table>
	</form>
  <%}%>
  		
		
		<!-- </form> -->
		
		</div>
		</div>
		<%
  

  } catch (Exception ex) {
    out.print("Something went wrong.");
    /* out.print("Account already exists!" + "<br>");
    out.print("maybe something went wrong"); */
    out.print("<br>" +"this may be why : ");
    ex.printStackTrace();
  }

	
  
%>

</div>
</body>
</html>
