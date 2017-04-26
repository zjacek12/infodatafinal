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
	
	String query = "select adID, product, description from ads where numShown = (select MIN(numShown) from ads)";
	PreparedStatement ps = con.prepareStatement(query);
	ResultSet result = ps.executeQuery(query);
	
	if(result.next()){
		out.print(result.getString("description"));
		%>
		<br>
		<img src="<%out.print(result.getString("product")); %>" style="width:width;height:height;"><br>
		<div style="float:left;margin-left:50px">
  		<p> </p>
  		<form action="profilePage.jsp" method="get">
    	<input type="submit" value="Skip Ad" />
  </form></div>
	<% 	
	    
		String query1 = "update ads set numShown=numShown+1 where adID="+result.getInt("adID");
		PreparedStatement ps1 = con.prepareStatement(query1);
		int valid = ps.executeUpdate(query1);
	    
		if(valid==1){
			con.close();
		}else{
			out.print("Failed.");
			con.close();
		}
	}else{
		out.print("Failed.");
		con.close();
	}
  	
}catch(Exception e){
	
	out.print(e.getMessage());
}

%>
</body>
</html>