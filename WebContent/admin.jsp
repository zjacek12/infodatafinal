<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>
<title>Admin</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">

<head>
<style>
</style>
</head>
<body class="w3-light-grey w3-content" style="max-width:1600px">
	
<!-- Top Title -->
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Welcome Administrator!</div>
</header>

<!-- Logout -->
<div style="float:right; margin-right:50px">
  <p> </p>
  <a href="index.html" onClick="alert('You have successfuly logged out.')">Logout</a>
</div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:50px; margin-right:50px">

  <!-- Keep room for the navigation menu  -->
  <div class="" style="margin-top:83px"></div> 

  <!-- Navigation -->
  <header>
  <div class="w3-padding-32" style="center">
    
  </div>
  </header>

  <!-- Lookup by time, user, origin, or destination -->
  <div class="w3-center w3-container w3-white w3-padding-16">
  	  <h4>View Total Rides By:</h4>
	  <div style="clear:both"></div>
	  <form action="adminQuery.jsp" method="get">
			<table border="1px solid black">
				<tr class="w3-white">
					<td>
						<b>From Campus</b><br>
						<select name="fromLocaction">
							<option value="formNull"> --Insert Here-- </option>
							<option value="formCA"> College Ave </option>
							<option value="fromL"> Livingston </option>
							<option value="fromB"> Busch </option>
							<option value="formCD"> Cook/Douglass </option>
						</select>
					</td>
					<td>
						<b>To Campus</b><br>
						<select name="toLocation">
							<option value="formNull"> --Insert Here-- </option>
							<option value="toC"> College Ave </option>
							<option value="toL"> Livingston </option>
							<option value="toB"> Busch </option>
							<option value="toCD"> Cook/Douglass </option>
						</select>
					</td>
				</tr>
				<tr class="w3-white">
<%-- 				<fmt:formatDate var='formattedDate' value='${date}' pattern="EEE, d MMM hh:mm aaa" type='both' timeStyle='medium'/> --%>						<td>
						<b>Rides made from (start time/date):</b><br>
							
						<input type="datetime-local" name="startTime" <%-- value="${formattedDate}" --%>/>
						<br>
					</td>
					<td>
						<b>Rides made until (end time/date):</b><br>
							
						<input type="datetime-local" name="endTime" <%-- value="${formattedDate}" --%>/>
						<br>
					</td>
				</tr>
				<tr class="w3-white">
					<td>
					 	<b>Search by userName:</b>
							
						<input type="text" name="userName">
						<br>
					</td>
				</tr>
				<tr class="w3-white">
					<td align=center colspan=2>
						<input type="submit" value="Submit Request" class="w3-bar-item w3-button w3-hover-black">
					</td>
				</tr>
			</table>
      </form> 
  </div>       
  
  <hr class="w3-opacity">
  
  <!-- Create SysSupport -->
  <div class="w3-container w3-dark-grey w3-text-light-grey w3-padding-32" id="about">
	  <div style="clear:both"></div>
    <div class="w3-container w3-padding w3-center w3-dark-grey">
      <h2>Create System Support Account</h2>
    </div>
    <form action="createSysSupport.jsp" method="post">
    <div class="w3-panel">
      <label>First Name</label>
      <input class="w3-input w3-border w3-margin-bottom" type="text" name="firstName">
      <label>Last Name</label>
      <input class="w3-input w3-border w3-margin-bottom" type="text" name="lastName">
      <label>Password</label>
      <input class="w3-input w3-border w3-margin-bottom" type="password" name="password">
      <label>Phone #</label>
      <input class="w3-input w3-border w3-margin-bottom" type="text" name="phone">
      <label>Email</label>
      <input class="w3-input w3-border w3-margin-bottom" type="text" name="email">
      <label>Address</label>
      <input class="w3-input w3-border w3-margin-bottom" type="text" name="address">
      <div class="w3-section">
        <input class="w3-button w3-red" type="reset" value="Reset">
        <input class="w3-button w3-light-grey w3-right" type="submit" value="Submit"> 
      </div>    
    </div>
    </form>
      
  </div>

  <div class="w3-black w3-center w3-padding-24">Made by Alex Marek, Jacek Zarski & Armin Grossrieder</div>

<!-- End page content -->
</div>
</body>
</html>