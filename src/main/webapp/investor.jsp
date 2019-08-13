<%@page import="fundit.Holdings"%>
<%@page import="fundit.InvestorDao"%>
<%@page import="fundit.Investor"%>
<%@page import="fundit.Logs"%>
<%@page import="fundit.LogsDao"%>
<%@page import="fundit.Company"%>
<%@page import="fundit.NeedsDao"%>
<%@page import="fundit.Needs"%>


<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

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

List<Logs> ll = new ArrayList<Logs>();
LogsDao l = new LogsDao();

List<Needs> nl = new ArrayList<Needs>();
NeedsDao n = new NeedsDao();

List<Holdings> hl = new ArrayList<Holdings>();
InvestorDao i = new InvestorDao();

HttpSession se = request.getSession();
String k = (String)se.getAttribute("login_status");
int sessionLogin = Integer.parseInt(k);
//String em = (String)request.getAttribute("eMail");

Investor inv = new Investor();

Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fundit","root","mysqlpassword");

String query = "select * from investor where aadhar = "+ sessionLogin;

Statement st = con.createStatement();
ResultSet rs = st.executeQuery(query);
rs.next();

inv.setName(rs.getString("name"));
inv.setAadhar(rs.getInt("aadhar"));
inv.setEmail(rs.getString("email"));
inv.setIcapital(rs.getDouble("icapital"));
rs.close();

String query4 = "select * from needs where aadhar = "+ inv.getAadhar();
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

i.connect();
hl = i.getHoldings(sessionLogin);
i.disconnect();


l.connect();
ll = l.addLogs(inv.getAadhar());
l.disconnect();


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
		<h1><%= inv.getName() %></h1>
		<ul>
			<li>Aadhar: <%= inv.getAadhar()%></li><br>
			<li>Capital: <%= inv.getIcapital() %></li><br>
		</ul>
		
		<table class="stakeTable" style="margin-bottom: 30px">
			<tr> 
				<th>Company ID</th>
				<th>Name</th>
				<th>Category</th>
				<th>Bond Date</th>
				<th>Bond Value</th>
				<th>Stake</th>
				<th>Offer</th>
				<th>Sell Quantity</th>
				
			</tr>
			
			<%for(Holdings h : hl) {%>
			
			<%
			
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fundit","root","mysqlpassword");
			
			String query2 = "select * from company where c_id = "+ h.getC_id();

			//Company details
			Statement st2 = con.createStatement();
			ResultSet rs2 = st2.executeQuery(query2);
			rs2.next();

			Company c = new Company();
			c.setC_id(rs2.getInt("c_id"));
			c.setC_name(rs2.getString("c_name"));
			c.setCategory(rs2.getString("category"));
			rs2.close();
			
			String query3 = "select sum(stake) as sum from needs where aadhar = " + h.getAadhar() + " and sell = 1 and c_id = " + h.getC_id();
			Statement st3 = con.createStatement();
			ResultSet rs3 = st3.executeQuery(query3);
			rs3.next();
			
			double sum = rs3.getDouble("sum");
			rs3.close();
			
			
			%>
			<tr> 
				<td><%=h.getC_id() %></td>
				<td><%=c.getC_name() %></td>
				<td><%=c.getCategory() %></td>
				<td><%=h.getDate() %></td>
				<td><%=h.getBond_val() %></td>
				<td><%=h.getStake() %></td>
				<td><%=h.getOffer() %></td>
				<td><form action="NeedsInvestor" method="post">
					<input type="hidden" value=<%= h.getC_id() %> name="C_id">
					<input type="hidden" value=<%=inv.getAadhar() %> name="aadhar">
					<input type="hidden" value=<%=h.getOffer() %> name="Offer">
					<input type="number" name="stake" min="1" max="<%=h.getStake() - sum %>">
					<input type="submit" value="Sell">
					</form></td>
			</tr>
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

			Company c = new Company();
			c.setC_id(rs2.getInt("c_id"));
			c.setC_name(rs2.getString("c_name"));
			c.setCategory(rs2.getString("category"));
			rs2.close();
			
			%>
			
			<tr> 
				<td><%=ne.getC_id() %></td>
				<td><%=c.getC_name() %></td>
				<td><%=ne.isBuy() %></td>
				<td><%=ne.isSell() %></td>
				<td><%=ne.getStake() %></td>
				<td><%=ne.getOffer() %></td>
				
			</tr>
			<%} %>
		</table>
		
		
		
		
		
		
		
		
		<br>
		
		<br>
		<br><b><h3>Your Previous Transactions</h3></b>
		<br>
		
		<table style="margin-top: 5px" class="stakeTable">
			<tr> 
				<th>Company ID</th>
				<th>Name</th>
				<th>Category</th>
				<th>Stake</th>
				<th>Offer</th>
				<th>Txn Date</th>
				<th>Txn Time</th>
			</tr>
			
			<%for(Logs logs : ll) {%>
			<%
			
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fundit","root","mysqlpassword");
			
			String query3 = "select * from company where c_id = "+ logs.getC_id();

			//Company details
			Statement st3 = con.createStatement();
			ResultSet rs3 = st3.executeQuery(query3);
			rs3.next();

			Company c = new Company();
			c.setC_id(rs3.getInt("c_id"));
			c.setC_name(rs3.getString("c_name"));
			c.setCategory(rs3.getString("category"));
			rs3.close();
			
			%>
			
			<tr> 
				<td><%=logs.getC_id() %></td>
				<td><%=c.getC_name() %></td>
				<td><%=c.getCategory() %></td>
				<td><%=logs.getStake() %></td>
				<td><%=logs.getOffer() %></td>
				<td><%=logs.getT_date() %></td>
				<td><%=logs.getT_time() %></td>
			</tr>
			<%} %>
		</table>
		<br><br>
	</div>
	
	</div>
	
</body>
</html>