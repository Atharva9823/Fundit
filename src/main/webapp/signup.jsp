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
		<script>
	
		function validate_form()
		{
			var x = document.f.EMAIL.value;
			var atpos = x.indexOf("@");
			var dotpos = x.lastIndexOf(".");
			var p = document.f.PASSWORD.value;
			var cp = document.f.CPASSWORD.value;
		
			
			if(atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
			{
				alert("Please enter valid e-mail");
				return false;
			}

			
			var y = document.f.FIRSTNAME.value;
			var letters = /^[A-Za-z ]+$/;
			   if(!y.match(letters))
			     {	
				   alert("Please enter valid name");
				   return false;
			     }
			
			var z = document.f.AADHAR.value;

			if(z.length!=6)
			{
				alert("Please enter valid 6-digit aadhar");
				return false;	
			}
		
			if(!(p.match(cp)))
			{
				alert("Paswswords do not match");
				return false;
			}
			
			return true;
		}
		
		
	
	</script>
</head>
<body style="background-image: url(loginback.png); background-size: 100% 100%; ">

	<table class="navbar">
		<tr>
			<td id="logo"><img src="it2.png">&nbsp;&nbsp;infin<b>IT</b>e</td>
			<td style="border-bottom: 3px solid transparent"><a href="index.jsp">Home</a></td>
			<td style="border-bottom: 3px solid transparent"><a href="companies.jsp">Startups</a></td>
			<td style="border-bottom: 3px solid transparent"><a>Support</a></td>
			<td style="border-bottom: 3px solid transparent"><a>About</a></td>   
			<td style="border-bottom: 3px solid #189AD3"><a href="login.jsp">Login</a></td> 
		</tr>
    </table>
    
    <div  class="login_form">
        <form name="f" action="insertInvestor" method="post" onsubmit="return validate_form()">
            <h2>Register as Investor</h2>
            <br>
            Name<br>
            <input class="textinp" type="text" name="FIRSTNAME">
            <br>
            <br>
            Email<br>
            <input class="textinp" type="email" name="EMAIL">
            <br>
            <br>
            Date of birth<br>
            <input class="textinp" type="date" name="DOB" max="2000-01-01">
            <br>
            <br>
            Aadhar Card no.<br>
            <input class="textinp" type="text" name="AADHAR">
            <br>
            Capital<br>
            <input class="textinp" type="text" name="ICAPITAL">
            <br>
            <br>
            Password<br>
            <input class="textinp" type="password" name="PASSWORD">
            <br>
            <br>
            Confirm Password<br>
            <input class="textinp" type="password" name="CPASSWORD">
            <br>
            <br>
            <p><a href="login.jsp">Already have an account ?</a> </p>
            <input class="sbutton" type="submit" value="Create">&nbsp;<input class="cbutton" type="reset" value="Clear">
            <br><br>
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
                <li>Contridbuer 1</li>
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