<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>

<html>
<title>Messenger</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">

<head>
<style>
</style>
</head>
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
	
	/* Your loginName */
	String query1="SELECT loginName FROM finalproject.accounts WHERE ruid=" + myruid;
	ResultSet lN = stmt.executeQuery(query1);
	lN.next();
	String userName = lN.getString("loginName");
	
	/* People you've messaged */
	String query2="SELECT DISTINCT loginName, ruid FROM finalproject.accounts a JOIN finalproject.messages m ON a.ruid=m.fromRUID WHERE m.toRUID=" + myruid + " ORDER BY m.time DESC";
	Statement stmt1=conn.createStatement();
	ResultSet rmf = stmt1.executeQuery(query2);
%>
	
<!-- Top Title -->
<header class="w3-container w3-top w3-white w3-xlarge w3-padding-16">
  <div class="w3-left w3-padding">Messages : <%out.print(lN.getString("loginName"));%></div>
</header>

<%
	lN.close();
%>

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
    <div class="w3-bar">
      <a href="profilePage.jsp" class="w3-bar-item w3-hover-black w3-button">Profile</a>
      <a href="myRides.jsp" class="w3-bar-item w3-button w3-hover-black">Offered Rides</a>
      <a href="requestedRides.jsp" class="w3-bar-item w3-button w3-hover-black">Requested Rides</a>
      <a href="messenger.jsp" class="w3-bar-item w3-button w3-black">Messaging</a>
    </div>
  </div>
  </header>

  <!-- Messenger Section -->
  <div class="w3-container w3-dark-grey w3-center w3-text-light-grey w3-padding-32" id="about">
	  
	  <!-- Messages -->
      <h4 class="w3-padding-16">Recent Messages</h4>
	  <div style="width:100%">
<% 
	Statement stmt2=conn.createStatement();
	ResultSet msg;
	while(rmf.next()) {
		String otherUser = rmf.getString("loginName");
		int otherRUID = rmf.getInt("ruid");
		String query3="SELECT * FROM finalproject.messages WHERE (fromRUID=" + otherRUID + " AND toRUID=" + myruid + ") OR (fromRUID=" + myruid + " AND toRUID=" + otherRUID + ") ORDER BY time ASC";
		msg = stmt2.executeQuery(query3);
%>
	    <h4><b><%out.print(otherUser);%></b></h4>
	    <table style="width:100%" border="2">	    	
<% 
		while(msg.next()) {
			if(msg.getInt("fromRuid") == myruid) { // Sent from you
%>
			<tr>
				<td>Sent</td>
				<td><%out.print(msg.getString("message"));%></td>
				<td><%out.print(msg.getInt("time"));%></td>
			</tr>
<%
			} else { // Received
%>
			<tr>
				<td>Received</td>
				<td><%out.print(msg.getString("message"));%></td>
				<td><%out.print(msg.getInt("time"));%></td>
			</tr>
<%
			}
		}
%>
	    </table>
<% 
	}
	rmf.close();
%>
	  </div>
	  <div style="clear:both"></div>
      
      <hr class="w3-opacity">
  </div>
  
  <!-- Send Message -->
  <div class="w3-container w3-light-grey w3-padding-32 w3-padding-large" id="contact">
	<a href="javascript:void(0)" style="margin-left:150px" class="w3-button w3-dark-grey w3-button w3-center w3-padding-16" onclick="document.getElementById('id01').style.display='block'">New Message</a>      
  </div>
  
<!-- Modal that pops up when you click on "New Message" -->
<div id="id01" class="w3-modal" style="z-index:4">
  <div class="w3-modal-content w3-animate-zoom">
    <div class="w3-container w3-padding w3-dark-grey">
      <h2>Send Mail</h2>
    </div>
    <form action="sendMessage.jsp" method="post">
    <div class="w3-panel">
      <label>To</label>
      <input class="w3-input w3-border w3-margin-bottom" type="text" name="toName">
      <label>From</label>
      <p class="w3-input w3-border w3-margin-bottom"><%out.print(userName);%></p>
      <label>Message:</label>
      <input class="w3-input w3-border w3-margin-bottom" style="height:150px" name="message" maxlength=245 placeholder="What's on your mind?">
      <div class="w3-section">
        <a class="w3-button w3-red" onclick="document.getElementById('id01').style.display='none'">Cancel  <i class="fa fa-remove"></i></a>
        <input class="w3-button w3-light-grey w3-right" type="submit" value="Send"> 
      </div>    
    </div>
    </form>
  </div>
</div>

  <div class="w3-black w3-center w3-padding-24">Made by Alex Marek, Jacek Zarski & Armin Grossrieder</div>
  <%
	/* Close stmt and conn */
	stmt.close();
    stmt1.close();
    stmt2.close();
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