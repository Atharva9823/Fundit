<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="style.css">
<title>Successful registration</title>
</head>
<body>

	<% int cid = (Integer)request.getAttribute("c_id"); %>
	
	<h3 style="text-align: center;">Congratulations</h3><br><br>
	<p style="text-align: center;">Your company has been registered Successfully </p><br><br>
	<p style="text-align: center;">Company ID : <b><%= cid %></b></p><br><br>
	<div class="backHome"><a href="index.jsp">Get Started</a></div>
	
</body>
</html>