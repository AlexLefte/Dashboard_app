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
					<a href="tabela_Proiecte.jsp">
						<span class="las la-clipboard-list"></span>
						<span>Proiecte</span>
					</a>
				</li>
				<li>
					<a class="active" href="tabela_Achizitii.jsp">
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
				Achiziții
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
					<form action="cauta_Achizitie.jsp" method="post">
						<div class="search-wrapper">
							<span class="las la-search"></span>
							<input type="search" placeholder="Cauta.." name="info" />
						</div>
					</form>
					<div class="actions">
						<button class="modify" onclick="on('modify_proj'); fillAcquisitionDetails();" disabled> Modifică </button>
						<button class="add_new" onclick="on('add')"> Adaugă </button>
						<label class="delete_label" for="submit-form" tabindex="0"> <span> Șterge </span></label>
					</div>
				</div>
				<form action="sterge_Achizitie.jsp" method="post">
				<div class="table_section">
					<table id="data_table">
						<thead>
							<tr>
								<th></th>
								<th> ID </th>
								<th> Client </th>
								<th> Prenume Repr. </th>
								<th> Nume Repr. </th>
								<th> Telefon </th>
								<th> Id Proiect </th>
								<th> Proiect </th>
								<th> Dată achiziție </th>
								<th> Preț </th>
								<th> Monedă </th>
							</tr>
						</thead>
						<tbody>
							<%
							try
							{
			                    jb.connect();
			                    ResultSet achizitii = jb.vedeAchizitie();
								// ResultSet clienti = jb.vedeTabela("clienti");
								// ResultSet proiecte = jb.vedeTabela("proiecte");
			                    long x;
			                    while (achizitii.next()) {
			                        x = achizitii.getInt("idachizitie");
			                %>
							<tr id="input_row">
								<td><input type="checkbox" class="checkLine" onchange="checkedFunc()" name="primarykey" value="<%= x%>"/></td>
								<td> <%= x%> </td>
								<td> <%= achizitii.getString("Nume")%> </td>
								<td> <%= achizitii.getString("PrenumeReprezentant")%> </td>
								<td> <%= achizitii.getString("NumeReprezentant")%>  </td>
								<td> <%= achizitii.getString("Telefon")%> </td>
								<td> <%= achizitii.getString("IdProiect")%> </td>
								<td> <%= achizitii.getString("NumeProiect")%> </td>
								<td> <%= achizitii.getString("data_achizitie")%> </td>
								<td> <%= achizitii.getString("pret")%> </td>
								<td> <%= achizitii.getString("moneda")%> </td>
							<%
                        		}
                    		%>
							</tr>
						</tbody>
					</table>
				</div>
					<input type="submit" id="submit-form" style="display:none" />
				</form>
			</div>
			<!-- </form> -->
			<div class="overlay_screen" id="add">
		    	<div class="overlay_content">
		        	<span class="close" onclick="off('add')">&times;</span>
						        <div class="form_section">
						        	<h1><span>Adăugare Achiziție</span></h1>
							        <form action="adauga_Achizitie.jsp" method="post">
							            <div class="user_details">
							            	<div class="input_box">
							            		<span class="details">Client:</span>
							            		<select name="idclient" required>
								            		<option disabled selected> -- selectează un client -- </option>
								            		<%	
								            			String Nume, PrenumeRepr, NumeRepr; 
								            			int idClient, idClientSelected;
								            			ResultSet clienti = jb.vedeTabela("clienti");
								            			while(clienti.next())
								            			{
								            				idClient = clienti.getInt("idclient");
								            				Nume = clienti.getString("nume");
								            				PrenumeRepr = clienti.getString("prenume_reprezentant");
								            				NumeRepr = clienti.getString("nume_reprezentant");
								            		%>
													    <option value="<%=idClient%>"><%=idClient%>, <%=Nume%>, <%=PrenumeRepr%>, <%=NumeRepr%></option>
						                            <%	       	
						                            	}
								            			String clientList =""; 
						                            %>
												</select>			
							            	</div>
							            	<div class="input_box">
							            		<span class="details">Proiect:</span>
							            		<select name="idproiect" required>
								            		<option disabled selected> -- selectează un proiect -- </option>
								            		<%	
								            			String idProiect, numeProiect; 
								            			ResultSet proiecte = jb.vedeTabela("proiecte");
								            			while(proiecte.next())
								            			{
								            				idProiect = proiecte.getString("idproiect");
								            				numeProiect = proiecte.getString("nume");								            			
								            		%>
													    <option value="<%=idProiect%>"><%=idProiect%>, <%=numeProiect%></option>
						                            <%				              
						                            	}
								            			String projectList =""; 
						                            %>						                            
												</select>			
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Dată achiziție:</span>
							            		<input type="text" name="data_achizitie" placeholder="YYYY-MM-DD" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Preț:</span>
							            		<input type="text" name="pret" placeholder="#.##" pattern="^\d+(\.)\d{2}$" required>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Tip:</span>
							            		<select name="moneda" id="tipuri" required>
							            			<option disabled selected> -- selectează moneda -- </option>
													<option value="RON">RON</option>
													<option value="EUR">EUR</option>
													<option value="USD">USD</option>
												</select>	
							            	</div>	
							            </div>
							            <div class="submit_button">
							            	<input type="submit" value="Adaugă achiziție" />
							            </div>
							        </form>
						        </div>
		    	</div>
			</div>
			<div class="overlay_screen" id="modify_proj">
		    	<div class="overlay_content">
		        	<span class="close" onclick="off('modify_proj')">&times;</span>
						        <div class="form_section">
						        	<h1><span>Modificare Achiziție</span></h1>
							        <form action="modifica_Achizitie.jsp" method="post" id="modify_form">
							            <div class="user_details">
							            	<div class="input_box modify_box">
							            		<span class="details">Id achizitie:</span>
							            		<input class="fill_value" type="text" name="idachizitie" readonly>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Client:</span>
							            		<select name="idclient" required>
								            		<option disabled selected> -- selectează un client -- </option>
								            		<%	
								            			clienti = jb.vedeTabela("clienti");
								            			while(clienti.next())
								            			{
								            				idClient = clienti.getInt("idclient");
								            				Nume = clienti.getString("nume");
								            				PrenumeRepr = clienti.getString("prenume_reprezentant");
								            				NumeRepr = clienti.getString("nume_reprezentant");
								            		%>
													    <option value="<%=idClient%>"><%=idClient%>, <%=Nume%>, <%=PrenumeRepr%>, <%=NumeRepr%></option>
						                            <%	       	
						                            	}
						                            %>
												</select>			
							            	</div>
							            	<div class="input_box">
							            		<span class="details">Proiect:</span>
							            		<select name="idproiect" required>
								            		<option disabled selected> -- selectează un proiect -- </option>
								            		<%	
								            			proiecte = jb.vedeTabela("proiecte");
								            			while(proiecte.next())
								            			{
								            				idProiect = proiecte.getString("idproiect");
								            				numeProiect = proiecte.getString("nume");								            			
								            		%>
													    <option value="<%=idProiect%>"><%=idProiect%>, <%=numeProiect%></option>
						                            <%				              
						                            	}
						                            %>
												</select>			
							            	</div>	
							            	<%
												jb.disconnect();
												}		
												catch(SQLException sqle)
									            {
										        		%>
											        	<div style="padding: 1rem 1rem 1rem 1rem">
											        	<p class="p1" style="font-size: 1.5rem">Datele nu au putut fi extrase.</p>
											        	<br/>
											        	<a href="index.jsp"><button class="button1"><b>Înapoi</b></button></a>
											        	<br/>
											        	</div>
										          		<%   
									          	}
											%>
							            	<div class="input_box">
							            		<span class="details">Dată achiziție:</span>
							            		<input class="fill_value" type="text" name="data_achizitie" placeholder="YYYY-MM-DD" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" required>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Preț:</span>
							            		<input class="fill_value" type="text" name="pret" placeholder="#.##" pattern="^\d+(\.)\d{2}$" required>		
							            	</div>	
							            	<div class="input_box">
							            		<span class="details">Tip:</span>
							            		<select class="fill_value" name="moneda" id="tipuri" required>
							            			<option disabled selected> -- selectează moneda -- </option>
													<option value="RON">RON</option>
													<option value="EUR">EUR</option>
													<option value="USD">USD</option>
												</select>	
							            	</div>	
							            </div>
							            <div class="submit_button modify_box">
							            	<input class="fill_value" type="submit" value="Salvează achiziție" />
							            </div>
							        </form>
						        </div>
		    	</div>
			</div>
			<% jb.disconnect(); %>
		</main>
	</div>
	<script src="app.js" defer></script>
</body>
</html>