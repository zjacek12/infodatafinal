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
	
	boolean update = false;
	boolean first = true;
	String editLogin, editPass, editFirst, editLast, editEmail, editNum, editAddress;
	
	String loginName = request.getParameter("loginName");
  	String password1 = request.getParameter("password1");
  	String password2 = request.getParameter("password2");
  	String firstName = request.getParameter("firstName");
  	String lastName = request.getParameter("lastName");
  	String email = request.getParameter("email");
	String phoneNumber = request.getParameter("phoneNumber");
	String address = request.getParameter("address");
	
	StringBuilder sb = new StringBuilder();
	
	sb.append("UPDATE finalproject.accounts SET ");
	
	if(!loginName.equals("")){
		update = true;
		if(first) {
			first = false;
		} else {
			sb.append(", ");
		}
		sb.append("loginName='"+loginName+"'");
		/* editLogin = "UPDATE finalproject.accounts SET loginName='"+loginName+"' WHERE RUID="+myruid; */
	}
	if(!password1.equals("") && (password2.equals(password1))){
		update = true;
		if(first) {
			first = false;
		} else {
			sb.append(", ");
		}
		sb.append("password='"+password1+"'");
		/* editPass = "UPDATE finalproject.accounts SET password='"+password1+"' WHERE RUID="+myruid; */
	}
	if(!firstName.equals("")){
		update = true;
		if(first) {
			first = false;
		} else {
			sb.append(", ");
		}
		sb.append("firstName='"+firstName+"'");
/* 		editFirst = "UPDATE finalproject.accounts SET firstName='"+firstName+"' WHERE RUID="+myruid;
 */	}
	if(!lastName.equals("")){
		update = true;
		if(first) {
			first = false;
		} else {
			sb.append(", ");
		}
		sb.append("lastName='"+lastName+"'");
		/* editLast = "UPDATE finalproject.accounts SET lastName='"+lastName+"' WHERE RUID="+myruid; */
	}
	if(!email.equals("")){
		update = true;
		if(first) {
			first = false;
		} else {
			sb.append(", ");
		}
		sb.append("email='"+email+"'");
		/* editEmail = "UPDATE finalproject.accounts SET email='"+email+"' WHERE RUID="+myruid; */
	}
	if(!phoneNumber.equals("")){
		update = true;
		if(first) {
			first = false;
		} else {
			sb.append(", ");
		}
		sb.append("phone="+phoneNumber+"");
		/* editNum = "UPDATE finalproject.accounts SET phone='"+phoneNumber+"' WHERE RUID="+myruid; */
	}
	if(!address.equals("")){
		update = true;
		if(first) {
			first = false;
		} else {
			sb.append(", ");
		}
		sb.append("address='"+address+"'");
		/* editAddress = "UPDATE finalproject.accounts SET address='"+address+"' WHERE RUID="+myruid; */
	}
	sb.append(" WHERE RUID="+myruid);
	
	if(update) {
		String edit = sb.toString();
		PreparedStatement ps = con.prepareStatement(edit);
		ps.executeUpdate();
		ps.close();
		response.sendRedirect("profilePage.jsp");
	} else {
		out.print("There was nothing to edit...");
	}
	
	con.close();
} catch (Exception ex) {
	out.print("maybe something went wrong");
	out.print("<br>" +"this may be why <br>" +ex.getMessage());
}
%>

</body>
</html>