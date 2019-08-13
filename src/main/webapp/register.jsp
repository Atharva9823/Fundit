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
			var z = document.f.pan.value;

			var y = document.f.cname.value;
			var letters = /^[A-Za-z ]+$/;
			   if(!y.match(letters))
			     {	
				   alert("Please enter valid name");
				   return false;
			     }
			   
			   if(z.length!=5)
				{
					alert("Please enter valid 5-digit PAN");
					return false;	
				}
			var p = document.f.psswrd.value;
			var cp = document.f.cpsswrd.value;
			
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
			<td id="logo"><img src="it2.png">&nbsp;&nbsp;fund<b>IT</b></td>
			<td style="border-bottom: 3px solid transparent"><a href="index.jsp">Home</a></td>
			<td style="border-bottom: 3px solid transparent"><a href="companies.jsp">Startups</a></td>
			<td style="border-bottom: 3px solid transparent"><a>Support</a></td>
			<td style="border-bottom: 3px solid transparent"><a>About</a></td>   
			<td style="border-bottom: 3px solid #189AD3"><a href="login.jsp">Login</a></td> 
		</tr>
    </table>
    
    <div  class="login_form">
        <form action="insertCompany" method="post" onsubmit="return validate_form()" name="f">
            <h2>Register as Startup</h2>
            <br>
            <br>
            Company Name<br>
            <input class="textinp" type="text" name="cname" required>
            <br>
            <br>
           	PAN<br>
            <input class="textinp" type="text" name="pan" required>
            <br>
            <br>
            City<br>
            <input class="textinp" type="text" name="city" required>
            <br>
            <br>
            Date of founding<br>
            <input class="textinp" type="date" value="" name="founding" required>
            <br>
            <br>
            Description<br>
            <input class="textinp" type="text" value="" name="desc" required>
            <br>
            <br>
            Category<br>
            <select name="categ">
            <option value="category" selected>Select one</option>
		    <option value="technology">Technology</option>
		    <option value="entetainment">Entertainment</option>
		    <option value="e-commerce">E-commerce</option>
		    <option value="others">Others</option>
		  	</select>
            <br>
            <br>
            Password<br>
            <input class="textinp" type="password" name="psswrd" required>
            <br>
            <br>
            Confirm Password<br>
            <input class="textinp" type="password" name="cpsswrd" required>
            <br>
            <br>
            <p><a href="clogin.jsp">Already have an account ?</a> </p>
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
