<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html>
<html>
<body>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<%
try {
	String query;
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");
	int ruid = Integer.parseInt(session.getAttribute("ruid").toString());
  Statement stmt = con.createStatement();
  query = "SELECT * FROM offeredRides WHERE RUID='"+ruid+"'";
  ResultSet result = stmt.executeQuery(query);
  
  
  while(result.next()){
	  %>
	  <div class="w3-container w3-light-grey w3-padding-32 w3-padding-large" id="contact">
	    <div class="w3-content" style="max-width:600px">
	      <h4 class="w3-center"><b><%out.print(result.getString("fromLocation")); %> to <%out.print(result.getString("toLocation")); %> 
	      on <%out.print(result.getString("departureTime").substring(0, 10)); %>
	      at <%out.print(result.getString("departureTime").substring(11)); %></b></h4>
  			<table style="width:100%" border="2">
  			<tr >
  				<th>Select</th>
			  	<th>RUID</th>
			  	<th>From</th>
			  	<th>To</th>
			  	<th>At</th>
			</tr>
			<%
			Statement stmt11 = con.createStatement();
			String nquery = "select RUID, fromLocation, toLocation, departureTime from finalproject.requestedRides req "+
					"where req.fromLocation='"+result.getString("fromLocation")+"' and req.toLocation='"+result.getString("toLocation")+"'";
			// TODO: AND DEPARTURE TIMES MATCH UP ='"+loginName+"'
			ResultSet result11 = stmt11.executeQuery(nquery); 
			%><form action="sendOffers.jsp" method="post">
			<%while(result11.next()){
			%>
			
			<tr>
				<th> <input type="checkbox" name="selected" value="<% out.print(result11.getString("RUID"));%>"></th>
				<th><% out.print(result11.getString("RUID"));%></th>
		  		<th><% out.print(result11.getString("fromLocation"));%></th>
		  		<th><% out.print(result11.getString("toLocation"));%></th>
		  		<th><% out.print(result11.getString("departureTime"));%></th>
			</tr>
			<% } %>
			<td><input type="submit" name="selected" value="Notify" ></td>
		</table>
		</form>
		
		</div>
		</div>
			
  <%}
  

  } catch (Exception ex) {
    out.print("Something went wrong.");
    /* out.print("Account already exists!" + "<br>");
    out.print("maybe something went wrong"); */
    out.print("<br>" +"this may be why : ");
    ex.printStackTrace();
  }

	
  
%>


</body>
</html>
