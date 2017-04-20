<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,javax.swing.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
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
		<form action="profile.jsp" method="get">
			<center>
				<table cellpadding=4 cellspacing=2 border=0>
					<th bgcolor="#CCCCFF" colspan=2>
						<font size=5>USER</font>
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
							<b>Rider Rating: <%out.print(result.getDouble("riderRating")); %></b> 
							<br>
						</td>
						<td>
							<b>Number of rides taken: <%out.print(result.getInt("numRides"));%></b>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td  align=center colspan=2>
							<input type="submit" value="View Profile">
						</td>
					</tr>
				</table>
			</center>
		</form>
		<form action="myRequests.jsp" method="get">
			<center>
				<table cellpadding=4 cellspacing=2 border=0>
					<tr bgcolor="#c8d8f8">
						<td align=center colspan=2>
							<input type="submit" value="My Requests">
						</td>
					</tr>
				</table>
			</center>
		</form>
		<form action="submitRequest.jsp" method="post">
			<center>
				<table cellpadding=4 cellspacing=2 border=0>
					<tr bgcolor="#c8d8f8">
						<td>
							<b>From Campus</b><br>
							<select name="fromLocaction">
								<option value="formCA"> College Ave </option>
								<option value="fromL"> Livingston </option>
								<option value="fromB"> Busch </option>
								<option value="formCD"> Cook/Douglass </option>
							</select>
						</td>
						<td>
							<b>To Campus</b><br>
							<select name="toLocation">
								<option value="toC"> College Ave </option>
								<option value="toL"> Livingston </option>
								<option value="toB"> Busch </option>
								<option value="toCD"> Cook/Douglass </option>
							</select>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
<%-- 					<fmt:formatDate var='formattedDate' value='${date}' pattern="EEE, d MMM hh:mm aaa" type='both' timeStyle='medium'/> --%>						<td>
							<b>How early can you leave?</b><br>
							
							<input type="datetime-local" name="earlyDeparture" <%-- value="${formattedDate}" --%>/>
							<br>
						</td>
						<td>
							<b>How late can you leave?</b><br>
							
							<input type="datetime-local" name="departureTime" <%-- value="${formattedDate}" --%>/>
							<br>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td>
						 	<b>When do you want to arrive by:</b>
							
							<input type="datetime-local" name="arrivalTime" <%-- value="${formattedDate}" --%>/>
							<br>
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td>
							<label for="yesrecurring">Every Week</label>
							<input type="radio" name="recurring" id="yesrecurring" value="true">
						</td>
						<td>
							<label for="norecurring">Only Once</label>
							<input type="radio" name="recurring" id="norecurring" value="false" checked="checked">
						</td>
					</tr>
					<tr bgcolor="#c8d8f8">
						<td align=center colspan=2>
							<input type="submit" value="Submit Request">
						</td>
					</tr>
				</table>
			</center>
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
</body>
</html>