<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question submission</title>
<link rel="stylesheet" href="home.css">
</head>
<body>
	<div>
		<% 
		
		try{
			System.out.println("Testing Session");
			session.getAttribute("username").equals("");
			}catch(Exception e){ 
				System.out.println("Invalid Session");
				System.out.println(e);
			%>	
				<div class="errorMessage">
					Your session has expired, please <a href="employeeLogin.jsp">login</a> again. 
				</div>
			<% 	
				return;
			}
		%>
		
	</div>
	
	
	<h1 class="title">
		Train Reservation System
	</h1>


	<%
	String questionss = (String) request.getParameter("question");
	System.out.println(questionss);
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String insert = "insert into Question values (?, ?);";
		PreparedStatement insertUser = con.prepareStatement(insert);
		insertUser.setString(1, questionss);
		insertUser.setString(2, "");
		try{
			insertUser.executeUpdate();
		}catch(Exception e){
			System.out.println("Failed to insert " + questionss);
			System.out.println(e);
		}
		
		System.out.println("Disconnecting from database");
		insertUser.close();
		con.close();
	}catch(Exception e){
		out.println("<div class=\"errorMessage\"> Could not connect to the database </div>");
		System.out.println(e);
	}%>
	<div>
		<h2>
			Successfully submitted a question! Please go back to <a href="home.jsp">home</a>.
		</h2>
	</div>
</body>
</html>
