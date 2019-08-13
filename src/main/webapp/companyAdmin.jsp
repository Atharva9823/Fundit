<%@page import="fundit.Holdings"%>
<%@page import="fundit.InvestorDao"%>
<%@page import="fundit.CompanyDao"%>
<%@page import="fundit.Company"%>
<%@page import="fundit.NeedsDao"%>
<%@page import="fundit.Needs"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" type="text/css" href="companygrid.css">
    <title>
		mini project
	</title>
</head>

<body>
<%

List<Needs> nl = new ArrayList<Needs>();
NeedsDao n = new NeedsDao();

List<Holdings> hl = new ArrayList<Holdings>();
CompanyDao c = new CompanyDao();
HttpSession se = request.getSession();
String sessionLogin = (String)se.getAttribute("login_status");
//String em = (String)request.getAttribute("eMail");

Company comp = new Company();

Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fundit","root","mysqlpassword");


String query = "select * from company where c_id = "+ Integer.parseInt(sessionLogin);

Statement st = con.createStatement();
ResultSet rs = st.executeQuery(query);
rs.next();

comp.setC_id(rs.getInt("c_id"));
comp.setCapital(rs.getDouble("capital"));
comp.setC_name(rs.getString("c_name"));
comp.setCity(rs.getString("city"));
comp.setValuation(rs.getDouble("valuation"));
comp.setDate(rs.getString("founded"));
comp.setStake(rs.getDouble("stake"));
comp.setCategory(rs.getString("category"));

comp.setDescription(rs.getString("description"));
rs.close();

String query4 = "select * from needs where c_id = "+ comp.getC_id() + " and aadhar IS NULL";
Statement st4 = con.createStatement();
ResultSet rs4 = st4.executeQuery(query4);

while(rs4.next())
{
	Needs ne = new Needs();
	ne.setAadhar(rs4.getInt("aadhar"));
	ne.setC_id(rs4.getInt("c_id"));
	ne.setBuy(rs4.getBoolean("buy"));
	ne.setSell(rs4.getBoolean("sell"));
	ne.setOffer(rs4.getDouble("offer"));
	ne.setStake(rs4.getDouble("stake"));
	nl.add(ne);
}
rs4.close();

/////////////////////////////////////////////////////

String query3 = "select sum(stake) as sum_sell from needs where aadhar IS NULL and sell = 1 and c_id = " + comp.getC_id();
Statement st3 = con.createStatement();
ResultSet rs3 = st3.executeQuery(query3);
rs3.next();

double sum_sell = rs3.getDouble("sum_sell");
rs3.close();

String query5 = "select sum(stake) as sum_buy from needs where aadhar IS NULL and buy = 1 and c_id = " + comp.getC_id();
Statement st5 = con.createStatement();
ResultSet rs5 = st5.executeQuery(query5);
rs5.next();

double sum_buy = rs5.getDouble("sum_buy");
rs5.close();

///////////////////////////////////////////////////
c.connect();
hl = c.getHoldings(sessionLogin);
c.disconnect();

int c_id_temp = Integer.parseInt(sessionLogin);

//hl = (List<Holdings>)request.getAttribute("holdings");
%>
	<table class="navbar">
		<tr>
			<td id="logo"><img src="it2.png">&nbsp;&nbsp;fund<b>IT</b></td>
			<td style="border-bottom: 3px solid transparent"><a href="index.jsp">Home</a></td>
			<td style="border-bottom: 3px solid transparent"><a href="companies.jsp">Startups</a></td>
			<td style="border-bottom: 3px solid transparent"><a>Support</a></td>
			<td style="border-bottom: 3px solid transparent"><a>About</a></td>
			<td style="border-bottom: 3px solid #189AD3"><a href="login.jsp">Logout</a></td> 
		</tr>
    </table>
	
	<div class="companyDetails">
	<div class="companyName">
		<img src="profile_pic.png" style="width:90%;margin-left:12px;margin-top:10px;">
		<br>
		
	</div>
	<div class="companyInfo">
		<h1><%= comp.getC_name()%></h1>
		<ul>
			<li>Company ID: <%= comp.getC_id()%></li><br>
			<li>Company Capital: <%= comp.getCapital()%></li><br>
			<li>Valuation: <%= comp.getValuation()%></li><br>
			<li>Stake: <%= comp.getStake()%></li><br>
			<li>Category: <%= comp.getCategory()%></li><br>
			<li><%= comp.getDescription()%></li><br>
			
			
		</ul>
		
		<div class="companyfundedbar"><div style="width:<%= 100-comp.getStake() %>%;"></div></div>
		<%= 100-comp.getStake() %>% Owned.

		<br>
		<br><b><h3 style="margin-top: 30px">Your Current Holders</h3></b>
		<br>
		
		<table class="stakeTable" style="margin-bottom: 30px">
			<tr> 
				<th>Company ID</th>
				<th>Aadhar</th>
				<th>Bond Date</th>
				<th>Bond Value</th>
				<th>Stake</th>
				<th>Offer</th>
			</tr>
			
			<%for(Holdings h : hl) {%>
			<tr> 
				<td><%=h.getC_id() %></td>
				<td><%=h.getAadhar() %></td>
				<td><%=h.getDate() %></td>
				<td><%=h.getBond_val() %></td>
				<td><%=h.getStake() %></td>
				<td><%=h.getOffer() %></td>
			<%} %>
		</table>
		
		
		<br>
		
		<br>
		<br><b><h3>Your Needs Posted</h3></b>
		<br>
		
		
		<table class="stakeTable" style="margin-bottom: 30px">
			<tr>
				<th>Company ID</th>
				<th>Name</th>
				<th>Buy</th>
				<th>Sell</th>
				<th>Stake</th>
				<th>Offer</th>
				
			</tr>
			
			<%for(Needs ne : nl) {
			
			String query2 = "select * from company where c_id = "+ ne.getC_id();
			Statement st2 = con.createStatement();
			ResultSet rs2 = st2.executeQuery(query2);
			rs2.next();
			
			

			Company c1 = new Company();
			c1.setC_id(rs2.getInt("c_id"));
			c1.setC_name(rs2.getString("c_name"));
			c1.setCategory(rs2.getString("category"));
			rs2.close();
			
			%>
			
			<tr> 
				<td><%=ne.getC_id() %></td>
				<td><%=c1.getC_name() %></td>
				<td><%=ne.isBuy() %></td>
				<td><%=ne.isSell() %></td>
				<td><%=ne.getStake() %></td>
				<td><%=ne.getOffer() %></td>
				
			</tr>
			<%} %>
		</table>
		
		
		
		
		
		<br><br>	
		<button  type="button" class="stakeBuyButton" onclick="openForm()">Buy/Sell</button><br><br>
		<!--<button type="button" class="investorLogout" onclick="location.href='login.jsp'">Logout</button>-->

	<div class="form-popup" id="myform">
	<form action="NeedsCompany" class="form-container" method="post">
		<h1>Buy/Sell Stake</h1>
	Buy
	<input type="radio" name="buysell" value="buy" id="buy" onclick="buyorsell(1)" ><br>
	Sell
	<input type="radio" name="buysell" value="sell" id="sell" onclick="buyorsell(2)"><br>
	<br>Stake<br>
	<input type="hidden" name="c_id" value="<%=c_id_temp %>" required>
	<% //if(buysell = "buy") {%>
    	<input type="hidden" placeholder="Enter Stake s" class="buysellInput" name="sstake" id="sstake" min="1" max="<%=comp.getStake() - sum_sell %>" required><br>
    <% //}else {%>
      	<input type="hidden" placeholder="Enter Stake b" class="buysellInput" name="bstake" id="bstake" min="1" max="<%=comp.getStake() - sum_buy %>"required><br>
    <%//} %>
    
    <br>Offer<br>
    <input type="number" placeholder="Enter Offer per %" class="buysellInput" name="offer" required><br><br>
    <button type="submit" id="BSbutton">Buy/Sell</button>
    <button type="button" id="CloseButton"  onclick="closeForm()">Close</button>
	</form>
		</div>
	</div>
	</div>
	
	<script>
	
	var buysell;
	
	function openForm() {
	    document.getElementById("myform").style.display = "block";
	}
	
	function closeForm() {
	    document.getElementById("myform").style.display = "none";
	}
	
	function buyorsell(k) {
		
		if(k == 1)
		{
			document.getElementById("sstake").setAttribute("type","hidden");
			document.getElementById("bstake").setAttribute("type","number");
		}
		else if(k == 2)
		{
			document.getElementById("sstake").setAttribute("type","number");
			document.getElementById("bstake").setAttribute("type","hidden");
		}
		
	}
	/*
		function buyorsell(k) {
		if(k == 1)
		{
			buysell = 1;
			
		}
		else if(k == 2)
		{
			buysell = 2;
		}
		
		
		function checkBuySell()
		{
			if(buysell == 1)
				return "number";
			else
				return "hidden";
		}
	}
	*/
	</script>
	
	
</body>
</html>