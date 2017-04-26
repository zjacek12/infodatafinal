<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
	
	int myruid = Integer.parseInt(session.getAttribute("ruid").toString());

	Statement stmt = con.createStatement();
	String str = "SELECT COUNT(*) as cnt FROM car WHERE RUID="+myruid;
	ResultSet result = stmt.executeQuery(str);
	result.next();	
	int countAcc = result.getInt("cnt");
	boolean validated = true;
	
	String make = request.getParameter("make");
  	String model = request.getParameter("model");
  	String plate = request.getParameter("plate");
  	String color = request.getParameter("color");
  	String numSeats = request.getParameter("numSeats");
	
	if(make.equals("") || model.equals("") || plate.equals("") || color.equals("") || numSeats.equals("")) {
		validated = false;
	}
	try {
		Integer.parseInt(numSeats);
	} catch (Exception e) {
		out.print("Put the number of seats in please!");
	}
	if (validated) {
		//String insert = "INSERT INTO accounts(loginName, password) "
		//		+ "VALUES ('"+loginName+"', '"+password+"')";
		String insert = "INSERT INTO finalproject.car" +
				"(plate, "+
				"RUID, "+
				"make, "+
				"model, "+
				"color, "+
				"numSeats)"+
				"VALUES"+
				"('"+plate+"', "+
				"'"+myruid+"', "+
				"'"+make+"', "+
				"'"+model+"', "+
				"'"+color+"', "+
				numSeats+")";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.executeUpdate();
		ps.close();
		str = "SELECT COUNT(*) as cnt FROM car WHERE RUID="+myruid;
		result = stmt.executeQuery(str);
		result.next();
		int countAccN = result.getInt("cnt");
		result.close();
		stmt.close();
		con.close();
	
		 
		int updateAcc = (countAcc != countAccN) ? 1 : 0;
		
		if (updateAcc > 0) {
			response.sendRedirect("profilePage.jsp");
		} else {
			out.print("<br>Car already exists.");
		}
	} else {
		out.print("<br> You are missing some fields!");
	}
} catch (Exception ex) {
	out.print("Account already exists!" + "<br>");
	out.print("maybe something went wrong");
	out.print("<br>" +"this may be why" +ex.getMessage());
}
%>

</body>
</html>