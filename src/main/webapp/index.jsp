<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java"
	import="java.lang.*,java.math.*,db.*,utils.*,java.sql.*, java.io.*, java.util.*"%>
	
<!DOCTYPE HTML>
<html lang = "ro">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
	<title>MedSoft DataBase</title>
	
	<link rel="icon" type="image/jpg" href="resources/side_bar_icon.jpg">
	
	<link rel="stylesheet" href="style.css">
	<link rel ="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
</head>

<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />

<body>
	<input type="checkbox" id="nav-toggle">
	<div class="sidebar">
		<div class="sidebar-brand">
			<h2><span class="img-icon"></span><span>MedSoft</span></h2>
		</div>
		<div class="sidebar-menu">
			<ul>
				<li>
					<a class="active" href="index.jsp"><span class="las la-igloo"></span>
					<span>Acasă</span></a>
				</li>
				<li>
					<a href="tabela_Clienti.jsp">
						<span class="las la-users"></span>
						<span>Clienți</span>
					</a>
				</li>
				<li>
					<a href="tabela_Proiecte.jsp">
						<span class="las la-clipboard-list"></span>
						<span>Proiecte</span>
					</a>
				</li>
				<li>
					<a href="tabela_Achizitii.jsp">
						<span class="las la-shopping-bag"></span>
						<span>Achiziții</span>
					</a>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="main-content">
		<header>
			<h2>
				<label for="nav-toggle">
					<span class="las la-bars"></span>
				</label>
				Acasă
			</h2>
			
			<!-- <div class="search-wrapper">
				<span class="las la-search"></span>
				<input type="search" placeholder="Cauta.."/>
			</div> -->
			
			<div class="user-wrapper">
				<img src="resources/side_bar_icon.jpg" width="30" height="30" alt="">
				<div>
					<h4>User</h4>
					<small>Admin</small>
				</div>
			</div>
		</header>
		
		<main>
			<%
                    jb.connect();
                    ResultSet clienti = jb.vedeTabela("clienti");
					ResultSet proiecte = jb.vedeTabela("proiecte");
					ResultSet achizitii = jb.vedeTabela("achizitii");
					int nrClienti, nrProiecte;
					String nrAchizitii, venituri;
                    
                    nrClienti = Utils.GetRowsNo(clienti);
                    nrProiecte = Utils.GetRowsNo(proiecte);
                    String[] a = Utils.GetIncome(achizitii);
                    nrAchizitii = a[0];
                    venituri = a[1];
            %>
			<div class="cards">
				<div class="card-single">
					<div>
						<h1><%= nrClienti%></h1>
						<span>Clienți</span>
					</div>
					<div>
						<span class="las la-users"></span>
					</div>
				</div>
				<div class="card-single">
					<div>
						<h1><%= nrProiecte%></h1>
						<span>Proiecte</span>
					</div>
					<div>
						<span class="las la-clipboard-list"></span>
					</div>
				</div>
				<div class="card-single">
					<div>
						<h1><%= nrAchizitii%></h1>
						<span>Achiziții</span>
					</div>
					<div>
						<span class="las la-shopping-bag"></span>
					</div>
				</div>
				<div class="card-single">
					<div>
						<h1><%= venituri%> €</h1>
						<span>Venituri</span>
					</div>
					<div>
						<span class="las la-wallet"></span>
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
</html>