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
			<div class="table">
				<div class="table_header">
					<form action="cauta_Proiect.jsp" method="post" style="display:none">
						<div class="search-wrapper">
							<span class="las la-search"></span>
							<input type="search" placeholder="Cauta.."/>
						</div>
					</form>
					<div class="actions">
						<button class="modify" onclick="on('modify')" disabled> Modifică </button>
						<button class="add_new" onclick="on('add')" style="display:none"> Adaugă </button>
						<label class="delete_label" for="submit-form" tabindex="0"> <span> Șterge </span></label>
					</div>
				</div>
				<form action="sterge_Proiect.jsp" method="post">
				<div class="table_section">
					<table id="data_table">
						<thead>
							<tr>
								<th></th>
								<th style="width:100px"> ID </th>
								<th style="width:200px"> Nume </th>
								<th> Tip </th>
								<th style="width:300px"> Descriere </th>
								<th> Dată finalizare </th>
								<th> Dată actualizare </th>
								<th> Versiune </th>
							</tr>
						</thead>
						<tbody>
							<%
							try
							{
			                    jb.connect();
			                    ResultSet rs = jb.intoarceCautare("proiecte", request.getParameter("info"));
			                    String x;
			                    while (rs.next()) {
			                        x = rs.getString("idproiect");
			                %>
							<tr id="input_row">
								<td><input type="checkbox" class="checkLine" onchange="checkedFunc()" name="primarykey" value="<%= x%>"/></td>
								<td style="width:100px"> <%= x%> </td>
								<td style="width:200px"> <%= rs.getString("nume")%> </td>
								<td> <%= rs.getString("tip")%> </td>
								<td style="width:300px"> <%= rs.getString("descriere")%>  </td>
								<td> <%= rs.getString("data_finalizare")%> </td>
								<td> <%= rs.getString("data_actualizare")%> </td>
								<td> <%= rs.getString("versiune")%> </td>
							<%
                        		}
                    		%>
							</tr>
						</tbody>
					</table>
					<%
								jb.disconnect();
							}
							catch(SQLException sqle)
				               {
					        		%>
						        	<div style="padding: 1rem 1rem 1rem 1rem">
						        	<p class="p1" style="font-size: 1.5rem">Cautarea a esuat.</p>
						        	<br/>
						        	<a href="tabela_Proiecte.jsp"><button class="button1"><b>Înapoi</b></button></a>
						        	<br/>
						        	</div>
					          		<%   
				          	   }
							%>
				</div>
					<input type="submit" id="submit-form" style="display:none" />
				</form>
			</div>
			<div class="overlay_screen" id="modify">
		    	<div class="overlay_content">
		        	<span class="close" onclick="off('modify')">&times;</span>
						        <div class="form_section">
						        	<h1><span>Modificare Proiect</span></h1>
							        <form action="modifica_Proiect.jsp" method="post" id="modify_form">
							            <div class="user_details">
							            	<div class="input_box">
							            		<span class="details">ID:</span>
							            		<input class="fill_value" type="text" name="idproiect" readonly>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Nume:</span>
							            		<input class="fill_value" type="text" name="nume" required>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Tip:</span>
							            		<select class="fill_value" name="tip" id="tipuri" required>
												  <option value="HW">HW</option>
												  <option value="SW">SW</option>
												  <option value="HW-SW">HW-SW</option>
												</select>	
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Descriere</span>
							            		<input class="fill_value" type="text" name="descriere" required>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Dată finalizare:</span>
							            		<input class="fill_value" type="text" name="data_finalizare" required>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Dată actualizare:</span>
							            		<input class="fill_value" type="text" name="data_actualizare" required>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Versiune:</span>
							            		<input class="fill_value" type="text" name="versiune" required>		
							            	</div>	
							            </div>
							            <div class="submit_button">
							            	<input type="submit" value="Salvează proiect" />
							            </div>
							        </form>
						        </div>
		    	</div>
			</div>
		</main>
		<div style="padding: 1rem 1rem 1rem 1rem">
        	<br/>
        	<a href="tabela_Proiecte.jsp"><button class="button1"><b>Înapoi</b></button></a>
        	<br/>
        </div>
	</div>
	<script src="app.js" defer></script>
</body>
</html>