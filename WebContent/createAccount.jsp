<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<%
try {

	//Create a connection string
	//jdbc:mysql://cs336-2.crujdr9emkb3.us-east-1.rds.amazonaws.com:3306/BarBeerDrinkerSample
	String url = "jdbc:mysql://infodataproject.cp0hpiqr4mmx.us-east-2.rds.amazonaws.com:3306/infodataproject";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");

	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "alexarminjacek", "alexarminjacek");

	//Create a SQL statement
	Statement stmt = con.createStatement();

	//Populate SQL statement with an actual query. It returns a single number. The number of beers in the DB.
	String str = "SELECT COUNT(*) as cnt FROM `accounts`";

	//Run the query against the DB
	ResultSet result = stmt.executeQuery(str);

	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
	result.next();
	//Parse out the result of the query
	int countAcc = result.getInt("cnt");

	//Get parameters from the HTML form at the HelloWorld.jsp
	String loginName = request.getParameter("loginName");
  	String password = request.getParameter("password");

	//Make an insert statement for the Sells table:
	String insert = "INSERT INTO `accounts`(loginName, password)"
			+ "VALUES ('?', '?')";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setString(1, loginName);
	ps.setString(2, password);
	//Run the query against the DB
	ps.executeUpdate();

	//Check counts once again (the same as the above)
	str = "SELECT COUNT(*) as cnt FROM `accounts`";
	result = stmt.executeQuery(str);
	result.next();
	System.out.println("Here");
	int countAccN = result.getInt("cnt");
	System.out.println(countAccN);

	//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	con.close();

	//Compare counts of the beers and bars before INSERT on Sells and after to figure out whether there is a bar and a beer stub records inserted by a trigger. 
	int updateAcc = (countAcc != countAccN) ? 1 : 0;
	;
	System.out.println(updateAcc);
	if (updateAcc > 0) {
		//Create a dynamic HTML form for beer update if needed. The form is not going to show up if the beer specified at HelloWorld.jsp already exists in the database.
		out.print("New Account Name " + loginName + "<br> Password: " + password);
	} else {
		out.print("Account already exists.");
	}

	out.print("insert succeeded");
} catch (Exception ex) {
	out.print("insert failed" + "<br>");
	out.println("this is why");
	ex.printStackTrace();
}
%>

</body>
</html>