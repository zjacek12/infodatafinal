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

	int cid = Integer.parseInt(request.getParameter("company"));
	String prod = request.getParameter("linktoimage");
	String doc = request.getParameter("description");
	
	String b = "select count(*) from ads where companyID="+cid;
	PreparedStatement befSt = con.prepareStatement(b);
	ResultSet before = befSt.executeQuery(b);
	before.next();
    int amtbef = before.getInt(1);
	
	String query = "insert into ads(companyID, numShown, product, description) values("+cid+", 0, '"+prod+"', '"+doc+"')";
	PreparedStatement ps = con.prepareStatement(query);
	ps.executeUpdate(query);
	
	String a = "select count(*) from ads where companyID="+cid;
	PreparedStatement afSt = con.prepareStatement(b);
	ResultSet after = afSt.executeQuery(a);
	after.next();
    int amtaft = after.getInt(1);
    
    if(amtaft>amtbef){
    	out.print("Success!");
    	%>
    	<button onclick="history.back()">Ok</button><%
		// redirect here!! get rid of ^
		// response.sendRedirect("");
    	con.close();
    }else{
    	out.print("Failed!");
    	%><button onclick="history.back()">Ok</button><%
		// redirect here!! get rid of ^
		// response.sendRedirect("");
    	con.close();
    }
	
	
	
}catch(Exception e){}


%>

</body>
</html>