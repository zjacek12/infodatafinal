<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>
<title>System Support</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<body class="w3-light-grey w3-content" style="max-width:1600px">

<%
try{
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");

	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");

	String loginName = request.getParameter("sysuname");
	String password = request.getParameter("syspw");
	
	out.print(loginName+password);

	String query = "SELECT * FROM staffAccounts WHERE username='"+loginName+"' AND password='"+password+"'";
	PreparedStatement ps = con.prepareStatement(query);
	ResultSet result = ps.executeQuery(query);
	
	if(result.next()){
		%>
		<!-- Top Title -->
	<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
	  <div class="w3-left w3-padding">Welcome, System Supporter <%out.print(result.getString("firstName")); out.print(" "+result.getString("lastName"));%>!</div>
	</header>
	
	<!-- Logout -->

	
	<div class="w3-center w3-container w3-white w3-padding-16" style="margin-top:83px"></div> 

	<div class="w3-main" style="margin-left:50px; margin-right:50px">
	
	<div style="float:right;margin-right:50px">
  		<p> </p>
  		<form action="logout.jsp" method="post">
    	<input type="submit" value="Logout" />
  </form></div>
	  
	  <div class="w3-half w3-center w3-container w3-white w3-padding-16">
	  	<h4><b>Reset Password</b></h4>
	  	<form action="resetPW.jsp" method="post">
	  		<table class="w3-table-all">
				<tr bgcolor="#c8d8f8">
					<td valign=top colspan=2>
						<b>username:<sup></sup></b>
						<br>
						<input type="text" name="uname" size=30 value=""  maxlength=20>
					</td>
				</tr>
				<tr bgcolor="#c8d8f8">
					<td valign=top colspan=2>
						<b>new password:<sup></sup></b>
						<br>
						<input type="text" name="newPW" size=30 value=""  maxlength=20>
					</td>
				</tr>
				<tr bgcolor="#c8d8f8">
					<td valign=top colspan=2>
						<b>confirm password:</b>
						<br>
						<input type="text" name="confirmPW" size=30 value=""  maxlength=20>
					</td>
				</tr>
				<tr bgcolor="#c8d8f8">
					<td  align=center colspan=2>
						<input type="submit"  value="Reset">
					</td>
				</tr>
			</table>
	  	</form>
	  </div>
	  
	  <div class="w3-half w3-center w3-container w3-white w3-padding-16">
	  	<h4><b>Lock In/Out</b></h4>
	  	<form action="lockOut.jsp" method="post">
	  		<table class="w3-table-all">
				<tr bgcolor="#c8d8f8">
					<td valign=top colspan=2>
						<b>username:<sup></sup></b>
						<br>
						<input type="text" name="uname" size=30 value=""  maxlength=20>
					</td>
				</tr>
		  		<tr bgcolor="#c8d8f8">
					<td  align=center colspan=2>
						<input type="submit" value="Lock Out">
					</td>
				</tr>
	  		</table>
	  	</form>
	  </div>
	  
	  <div class="w3-half w3-center w3-container w3-white w3-padding-16">
	  	<form action="undolockOut.jsp" method="post">
	  		<table class="w3-table-all">
				<tr bgcolor="#c8d8f8">
					<td valign=top colspan=2>
						<b>username:<sup></sup></b>
						<br>
						<input type="text" name="uname" size=30 value=""  maxlength=20>
					</td>
				</tr>
		  		<tr bgcolor="#c8d8f8">
					<td  align=center colspan=2>
						<input type="submit" value="Allow In">
					</td>
				</tr>
	  		</table>
	  	</form>
	  </div>
	 </div>
	  
	  <div class="w3-center w3-container w3-white w3-padding-16" style="margin-top:83px"></div> 
	  
	  <div class="w3-main" style="margin-left:50px; margin-right:50px">
		  
		  <div class="w3-half w3-center w3-container w3-white w3-padding-16">
		  	<h4><b>Add Ad</b></h4>
		  	<form action="insertAd.jsp" method="post">
		  		<table class="w3-table-all">
					<tr bgcolor="#c8d8f8">
						<td>
							<b>Company</b><br>
							<select name="company">
							<%
							Statement stmt11 = con.createStatement();
							String nquery = "select companyID, name from finalproject.company"; 
							ResultSet result11 = stmt11.executeQuery(nquery); 
							while(result11.next()){
							%>
								<option value="<%out.print(result11.getInt("companyID"));%>"> <%out.print(""+result11.getString("name"));%> </option>
							<%} %>
							</select>
						</td>
						<td>
							<b>Link to Image:</b>
								<br>
							<input type="text" name="linktoimage" size=30 value="" maxlength=200>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td colspan=2>
							<b>Description:</b>
							<br>
							<input type="text" name="description" size=30 value="" maxlength=200>
						</td>
					</tr>
		  			<tr bgcolor="#c8d8f8" colspan=2>
						<td  align=center colspan=2>
							<input type="submit" value="Add">
						</td>
					</tr>
				</table>
		  	</form>
		  </div>
		  
		  <div class="w3-half w3-center w3-container w3-white w3-padding-16"> 
		  	<h4><b>View Ad-Stats</b></h4>
		  	<form action="showAdStats.jsp" method="post">
		  		<table class="w3-table-all">
				<tr bgcolor="#c8d8f8">
					<td>
						<b>Company</b><br>
						<select name="company">
						<%
						Statement stmt12 = con.createStatement();
						String mquery = "select companyID, name from finalproject.company"; 
						ResultSet result12 = stmt12.executeQuery(mquery); 
						while(result12.next()){
						%>
							<option value="<%= result12.getInt("companyID") %>"> <%out.print(""+result12.getString("name"));%> </option>
						<%} %>
						</select>
					</td>
				</tr>
				<tr bgcolor="#c8d8f8">
					<td  align=center colspan=2>
						<input type="submit" value="Show">
					</td>
				</tr>
				</table>
		  	</form>
	 	</div>
	  </div>
	  
		
		<% 
		con.close();
	} else {
		con.close();
		out.print("failed.");
		// response.sendRedirect("");
	}
	
}catch(Exception e){}
%>	

  </body>
  </html>
  	
  
  
  
  
  
  
  
  
  
  
  
  