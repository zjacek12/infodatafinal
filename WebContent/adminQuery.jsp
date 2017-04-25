<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->

<!DOCTYPE html>

<html>
<title>Admin</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<body class="w3-light-grey w3-content" style="max-width:1600px">

<%
try {
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Connection conn = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");
	
	String fromLocation = request.getParameter("fromLocation");
	String toLocation = request.getParameter("toLocation");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	String userName = request.getParameter("userName");
			
	Statement stmt = conn.createStatement();
	String query;
	
	if(fromLocation.equals("formNull")) {
	}
	if(toLocation.equals("formNull")) {
	}
	if(startTime.equals("")) {
	}
	if(endTime.equals("")) {
	}
	if(userName.equals("")) {
	}
	
	// All are null								#1
	if(fromLocation.equals("formNull") && toLocation.equals("formNull") && startTime.equals("") && endTime.equals("") && userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\"";
	
	// fromLocation or toLocation are set		#2
	} else if(!(fromLocation.equals("formNull") && toLocation.equals("formNull")) && startTime.equals("") && endTime.equals("") && userName.equals("")) {
		if(fromLocation.equals("formNull")) {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND toLocation=\"" + toLocation + "\"";
		} else if(toLocation.equals("formNull")) {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND fromLocation=\"" + fromLocation + "\"";
		} else {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND toLocation=\"" + toLocation + "\" AND fromLocation=\"" + fromLocation + "\"";
		}
	// startTime or endTime are set			#3
	} else if(fromLocation.equals("formNull") && toLocation.equals("formNull") && !(startTime.equals("") && endTime.equals("")) && userName.equals("")) {
		if(startTime.equals("")) {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND arrivalTime<" + endTime;
		} else if(endTime.equals("")) {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND arrivalTime>" + startTime;
		} else {
			query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\" AND arrivalTime<" + endTime + " AND arrivalTime>" + startTime;
		}
	// userName is set							#4
	} else if(fromLocation.equals("formNull") && toLocation.equals("formNull") && startTime.equals("") && endTime.equals("") && !userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog r JOIN finalproject.accounts a ON a.ruid=r.ruid WHERE r.role=\"Driver\" AND a.loginName=\"" + userName + "\"";
	// 2 and 3 are set
	} else if(!(fromLocation.equals("formNull") && toLocation.equals("formNull")) && !(startTime.equals("") && endTime.equals("")) && userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog WHERE role=\"Driver\"";
		if(!fromLocation.equals("formNull")) {
			query += " AND fromLocation=\"" + fromLocation + "\"";
		}
		if(!toLocation.equals("formNull")) {
			query += " AND toLocation=\"" + toLocation + "\"";
		}
		if(startTime.equals("")) {
			query += " AND arrivalTime<" + endTime;
		} else if(endTime.equals("")) {
			query += " AND arrivalTime>" + startTime;
		} else {
			query += " AND arrivalTime<" + endTime + " AND arrivalTime>" + startTime;
		}
	// 2 and 4 are set
	} else if(!(fromLocation.equals("formNull") && toLocation.equals("formNull")) && startTime.equals("") && endTime.equals("") && !userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog r JOIN finalproject.accounts a ON a.ruid=r.ruid WHERE r.role=\"Driver\" AND a.loginName=\"" + userName + "\"";
		if(!fromLocation.equals("formNull")) {
			query += " AND r.fromLocation=\"" + fromLocation + "\"";
		}
		if(!toLocation.equals("formNull")) {
			query += " AND r.toLocation=\"" + toLocation + "\"";
		}
	// 3 and 4 are set	
	} else if(fromLocation.equals("formNull") && toLocation.equals("formNull") && !(startTime.equals("") && endTime.equals("")) && !userName.equals("")) {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog r JOIN finalproject.accounts a ON a.ruid=r.ruid WHERE r.role=\"Driver\" AND a.loginName=\"" + userName + "\"";
		if(startTime.equals("")) {
			query += " AND r.arrivalTime<" + endTime;
		} else if(endTime.equals("")) {
			query += " AND r.arrivalTime>" + startTime;
		} else {
			query += " AND r.arrivalTime<" + endTime + " AND r.arrivalTime>" + startTime;
		}
	// all are set
	} else {
		query = "SELECT COUNT(*) as cnt FROM finalproject.rideLog r JOIN finalproject.accounts a ON a.ruid=r.ruid WHERE r.role=\"Driver\" AND a.loginName=\"" + userName + "\"";
		if(!fromLocation.equals("formNull")) {
			query += " AND r.fromLocation=\"" + fromLocation + "\"";
		}
		if(!toLocation.equals("formNull")) {
			query += " AND r.toLocation=\"" + toLocation + "\"";
		}
		if(startTime.equals("")) {
			query += " AND r.arrivalTime<" + endTime;
		} else if(endTime.equals("")) {
			query += " AND r.arrivalTime>" + startTime;
		} else {
			query += " AND r.arrivalTime<" + endTime + " AND r.arrivalTime>" + startTime;
		}
	}
	
	ResultSet rs = stmt.executeQuery(query);
	rs.next();
%>

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
  	  <h4><b>View Total Rides By:</b></h4>
	  <form action="adminQuery.jsp" method="get">
				<table cellpadding=4 cellspacing=2 border=0 class="w3-table-all">
					<tr bgcolor="#c8d8f8">
<%
	if(fromLocation.equals("formNull")) {
%>
						<td>
							<b>From Campus</b><br>
							<select name="fromLocation">
								<option value="formNull"> --Insert Here-- </option>
								<option value="College Ave"> College Ave </option>
								<option value="Livingston"> Livingston </option>
								<option value="Busch"> Busch </option>
								<option value="Cook/Douglass"> Cook/Douglass </option>
							</select>
						</td>
<% 
	} else {
%>
						<td>
							<b>From Campus</b><br>
							<select name="fromLocation">
								<option value="<%out.print(fromLocation);%>"> <%out.print(fromLocation);%> </option>
								<option value="formNull"> --Insert Here-- </option>
								<option value="College Ave"> College Ave </option>
								<option value="Livingston"> Livingston </option>
								<option value="Busch"> Busch </option>
								<option value="Cook/Douglass"> Cook/Douglass </option>
							</select>
						</td>
<%
	}

	if(toLocation.equals("formNull")) {
%>
						<td>
							<b>To Campus</b><br>
							<select name="toLocation">
								<option value="formNull"> --Insert Here-- </option>
								<option value="College Ave"> College Ave </option>
								<option value="Livingston"> Livingston </option>
								<option value="Busch"> Busch </option>
								<option value="Cook/Douglass"> Cook/Douglass </option>
							</select>
						</td>
<%
	} else {
%>
						<td>
							<b>To Campus</b><br>
							<select name="toLocation">
								<option value="<%out.print(toLocation);%>"> <%out.print(toLocation);%> </option>
								<option value="formNull"> --Insert Here-- </option>
								<option value="College Ave"> College Ave </option>
								<option value="Livingston"> Livingston </option>
								<option value="Busch"> Busch </option>
								<option value="Cook/Douglass"> Cook/Douglass </option>
							</select>
						</td>
<%
	}
%>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td>
							<b>Start Date</b><br>
							
							<input type="datetime-local" name="startTime" placeholder="<%out.print(startTime);%>"/>
							<br>
						</td>
						<td>
							<b>End Date</b><br>
							
							<input type="datetime-local" name="endTime" placeholder="<%out.print(endTime);%>"/>
							<br>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td align=center>
						 	<b>Search by userName</b>
							
							<input type="text" name="userName" placeholder="<%out.print(userName);%>"/>
							<br>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td align=center colspan=2>
							<input type="submit" value="Submit Request" class="w3-bar-item w3-button w3-hover-black">
						</td>
					</tr>
				</table>
		</form>
		
		<h4>Number of Rides Given:</h4>
		<p><b><%out.println(rs.getInt("cnt"));%></b></p>
		<p>The execute query used is as follows:</p>
		<p><%out.println(query);%></p>
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

<%
	rs.close();
	stmt.close();
	conn.close();
	
} catch (Exception ex) {
		out.println("Oops!");
		out.println("Something went wrong!");
		out.println(ex.getMessage());
}
%>

</body>
</html>