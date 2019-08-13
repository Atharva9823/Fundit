<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="style.css">
	<title>
		mini project
	</title>

</head>


<body style="background-image: url(loginback.png);">
<% HttpSession se = request.getSession();
	String status = (String)se.getAttribute("login_status");
	se.setAttribute("login_status", "");
	
%>
	<table class="navbar">
		<tr>
			<td id="logo"><img src="it2.png">&nbsp;&nbsp;fund<b>IT</b></td>
			<td style="border-bottom: 3px solid transparent"><a href="index.jsp">Home</a></td>
			<td style="border-bottom: 3px solid transparent"><a href="companies.jsp">Startups</a></td>
			<td style="border-bottom: 3px solid transparent"><a>Support</a></td>
			<td style="border-bottom: 3px solid transparent"><a>About</a></td>
			<td style="border-bottom: 3px solid #189AD3"><a href="login.jsp">Login</a></td> 
		</tr>
    </table>
    
    <div class="login_form">
        <form action="checkLogin" method="post">
            <a class="selectedLogin">Investor</a><a class="unselectedLogin" href="clogin.jsp">Startup</a><br><br><br>
            Enter aadhar<br>
            <input class="textinp" type="number" name="EMAIL" min="100000" max="999999">
            <br>
            <br>
            Password<br>
            <input class="textinp" type="password" name="PASSWORD">
            <br>
            <br>
            <% if(status.equals("failed")) { %>
            <p style="text-align: center;color: red;"> Invalid login credentials </p><br>
            <% } %>
            <input class="sbutton" type="submit" value="Login">&nbsp;<input class="cbutton" type="reset" value="Clear">
            <br><br>
            <p>
            <a href="recoverpass.html">Forgot password</a><br><br>
            Don't have a account yet ? <a href="signup.jsp">Create One!</a><br>
            </p>
        </form>
    </div>
    <footer>
        <div class="foot">
            <ul>
                <li style="border: 2px solid transparent; border-bottom: 2px solid gray; ">ABOUT US</li>
                <br>
                <li><a href="#">Team</a></li>
                <li><a href="#">Project infinite</a></li>
            </ul>
    
            <ul>
                <li style="border: 2px solid transparent; border-bottom: 2px solid gray; ">CONTRIBUTIONS</li>
                <br>		
                <li>Contributer 1</li>
                <li>Other</li>
            </ul>
            
            <ul class="social_links">
                <li style="border: 2px solid transparent; border-bottom: 2px solid gray; ">FOLLOW US</li>
                <br>
                <li>
                    <img style="width: 32px;" src="facebook.png">
                    <img style="width: 32px;" src="twitter.png">
                    <img style="width: 32px;" src="insta.png">
                </li>
                
            </ul>
            
        </div>
    </footer>
    
</body>
</html>
    