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
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");
	int ruid = Integer.parseInt(session.getAttribute("ruid").toString());
  Statement stmt = con.createStatement();
  String str = "SELECT * FROM offeredRides WHERE RUID='"+ruid+"'";
  ResultSet result = stmt.executeQuery(str);

  %>
  <form action="finalizeRide.jsp" method="post">
		<center>
			<table cellpadding=4 cellspacing=2 border=0>
        <th bgcolor="#CCCCFF" colspan=2>
          <font size=5>My Rides</font>
        </th> <%
        while(result.next()){
          %> <tr class='clickable-row' data-href='/finalizeRide.jsp' valign=top colspan=2>
          <td>
              <b>Date: <%out.print(result.getString("departureTime")); %></b><br>
              <b>To: <%out.print(result.getString("toLocation")); %></b>
              // this is what gets passed to finalizeRide.jsp :
              int rideid = Integer.parseInt(result.getString("offerID"));
            </td>
          </tr> <%
        }
				%><tr bgcolor="#c8d8f8">
					<td align=center colspan=2>
						<input type="submit" value="Finalize">
					</td>
				</tr>
			</table>
		</center>
	</form>

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
