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
					<a href="index.jsp"><span class="las la-igloo"></span>
					<span>Acasă</span></a>
				</li>
				<li>
					<a href="tabela_Clienti.jsp">
						<span class="las la-users"></span>
						<span>Clienți</span>
					</a>
				</li>
				<li>
					<a class="active" href="tabela_Proiecte.jsp">
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
				Proiecte
			</h2>			
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
			String id = request.getParameter("idproiect").trim();
            String nume = request.getParameter("nume").trim();
			String tip = request.getParameter("tip").trim();
			String descriere = request.getParameter("descriere").trim();
			String dataFinalizare = request.getParameter("data_finalizare").trim();
			String dataActualizare = request.getParameter("data_actualizare").trim();
			String versiune = request.getParameter("versiune").trim();
            if (nume != null) {
            	try
            	{
	            	jb.connect();
	                String[] valori = {id, nume, tip, descriere, dataFinalizare, dataActualizare, versiune};
	                String[] campuri = {"idproiect", "nume", "tip", "descriere", "data_finalizare", 
	                		"data_actualizare", "versiune"};
	                jb.modificaTabela("proiecte", "idproiect", id, campuri, valori);
	                jb.disconnect();
        	%>
	        <div style="padding: 1rem 1rem 1rem 1rem">
	        	<p class="p1" style="font-size: 1.5rem">Datele au fost modificate cu succes!</p>
	        	<br/>
	        	<a href="tabela_Proiecte.jsp"><button class="button1"><b>Înapoi</b></button></a>
	        	<br/>
	        </div>
        		<%
        		}
        		catch (SQLException sqle)
            	{
            		%>
		        	<div style="padding: 1rem 1rem 1rem 1rem">
		        	<p class="p1" style="font-size: 1.5rem">Modificarea datelor a eșuat. O posibilă cauză poate fi duplicarea numelui proiectului!</p>
		        	<br/>
		        	<a href="tabela_Proiecte.jsp"><button class="button1"><b>Înapoi</b></button></a>
		        	<br/>
		        	</div>
	          		<%   
            	}
        	} 
            else { 
        %>
        <div style="padding: 1rem 1rem 1rem 1rem">
        	<p class="p1" style="font-size: 1.5rem">Modificarea datelor a eșuat. Vă rugăm să încercați din nou!</p>
        	<br/>
        	<a href="tabela_Proiecte.jsp"><button class="button1"><b>Înapoi</b></button></a>
        	<br/>
        </div>
        <%
            }
        %>			
		</main>
	</div>
</body>
</html>