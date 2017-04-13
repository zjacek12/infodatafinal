<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<!-- Jacek Zarski, Alex Marek, Armin Grossrieder -->
<%
try {

	
	
	String url = "jdbc:mysql://infodataprojectdb.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/finalproject";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");

	Statement stmt = con.createStatement();
	String str = "SELECT COUNT(*) as cnt FROM accounts";
	ResultSet result = stmt.executeQuery(str);
	result.next();	
	int countAcc = result.getInt("cnt");
	boolean validated = true;
	String loginName = request.getParameter("loginName");
  	String password1 = request.getParameter("password1");
  	String password2 = request.getParameter("password2");
  	String ruid = request.getParameter("ruid");
  	String firstName = request.getParameter("firstName");
  	String lastName = request.getParameter("lastName");
  	String email = request.getParameter("email");
	String phoneNumber = request.getParameter("phoneNumber");
	String address = request.getParameter("address");
	
	if(loginName.equals("") || lastName.equals("") || password1.equals("") || password2.equals("") || ruid.equals("") || firstName.equals("")
			|| email.equals("") || !(password1.equals(password2))) {
		validated = false;
	}
	try {
		Integer.parseInt(ruid);
	} catch (Exception e) {
		out.print("Make sure RUID is a number");
	}
	if (validated) {
		//String insert = "INSERT INTO accounts(loginName, password) "
		//		+ "VALUES ('"+loginName+"', '"+password+"')";
		String insert = "INSERT INTO finalproject.accounts" +
				"(RUID, "+
				"loginName, "+
				"password, "+
				"firstName, "+
				"lastName, "+
				"email, "+
				"phone, "+
				"address, "+
				"numRides)"+
				"VALUES"+
				"('"+ruid+"', "+
				"'"+loginName+"', "+
				"'"+password1+"', "+
				"'"+firstName+"', "+
				"'"+lastName+"', "+
				"'"+email+"', "+
				"'"+phoneNumber+"', "+
				"'"+address+"', "+
				"'"+"0"+"')";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.executeUpdate();
		
		str = "SELECT COUNT(*) as cnt FROM accounts";
		result = stmt.executeQuery(str);
		result.next();
		System.out.println("Here");
		int countAccN = result.getInt("cnt");
		
		con.close();
	
		 
		int updateAcc = (countAcc != countAccN) ? 1 : 0;
		;
		System.out.println(updateAcc);
		if (updateAcc > 0) {
			
			out.print("New Account Name: " + loginName + "<br> Password: " + password1);
		} else {
			out.print("<br>Account already exists.");
		}
	
		out.print("<br>insert succeeded");
	} else {
		out.print("<br> Go back and check your credentials");
	}
} catch (Exception ex) {
	out.print("Account already exists!" + "<br>");
	out.print("maybe something went wrong");
	out.print("<br>" +"this may be why" +ex.getMessage());
}
%>

</body>
</html>