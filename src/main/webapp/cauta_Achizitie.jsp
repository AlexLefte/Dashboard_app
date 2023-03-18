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
					<form action="cauta_Achizitie.jsp" method="post" style="display:none">
						<div class="search-wrapper">
							<span class="las la-search"></span>
							<input type="search" placeholder="Cauta.."/>
						</div>
					</form>
					<div class="actions">
						<button class="modify" onclick="on('modify_proj'); fillAcquisitionDetails();" disabled> Modifică </button>
						<button class="add_new" onclick="on('add')" style="display:none"> Adaugă </button>
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
			                    Integer[] ids = jb.intoarceCautareIds(request.getParameter("info"));
			                    String x;
			                    System.out.print(ids);
			                    ResultSet rs = null;
			                    for (int i = 0; i < ids.length; i++)
			                    {
			                    	rs = jb.intoarceAchizitieId(ids[i]);
			                    	rs.next();
			                    	x = rs.getString("idachizitie");
			                %>
							<tr id="input_row">
								<td><input type="checkbox" class="checkLine" onchange="checkedFunc()" name="primarykey" value="<%= x%>"/></td>
								<td style="width:100px"> <%= x%> </td>
								<td style="width:200px"> <%= rs.getString("Nume")%> </td>
								<td> <%= rs.getString("PrenumeReprezentant")%> </td>
								<td style="width:300px"> <%= rs.getString("NumeReprezentant")%>  </td>
								<td> <%= rs.getString("Telefon")%> </td>
								<td> <%= rs.getString("IdProiect")%> </td>
								<td> <%= rs.getString("NumeProiect")%> </td>
								<td> <%= rs.getString("data_achizitie")%> </td>
								<td> <%= rs.getString("pret")%> </td>
								<td> <%= rs.getString("moneda")%> </td>
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
			<div class="overlay_screen" id="modify_proj">
		    	<div class="overlay_content">
		        	<span class="close" onclick="off('modify_proj')">&times;</span>
						        <div class="form_section">
						        	<h1><span>Modificare Client</span></h1>
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
								            			ResultSet clienti = jb.vedeTabela("clienti");
								            			while(clienti.next())
								            			{
								            				int idClient = clienti.getInt("idclient");
								            				String Nume = clienti.getString("nume");
								            				String PrenumeRepr = clienti.getString("prenume_reprezentant");
								            				String NumeRepr = clienti.getString("nume_reprezentant");
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
								            			ResultSet proiecte = jb.vedeTabela("proiecte");
								            			while(proiecte.next())
								            			{
								            				String idProiect = proiecte.getString("idproiect");
								            				String numeProiect = proiecte.getString("nume");								            			
								            		%>
													    <option value="<%=idProiect%>"><%=idProiect%>, <%=numeProiect%></option>
						                            <%				              
									                    }												
										         %>
												</select>
												<%
													jb.disconnect();
												}										
												catch(SQLException sqle)
									               {
										        		%>
											        	<div style="padding: 1rem 1rem 1rem 1rem">
											        	<p class="p1" style="font-size: 1.5rem">Cautarea datelor a eșuat.</p>
											        	<br/>
											        	<a href="tabela_Achizitii.jsp"><button class="button1"><b>Înapoi</b></button></a>
											        	<br/>
											        	</div>
										          		
										         		<%   
										        	} 
										    %>			
							            	</div>	
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
							            	<input class="fill_value" type="submit" value="Salvează client" />
							            </div>
							        </form>
						        </div>
		    	</div>
			</div>
		</main>
		<div style="padding: 1rem 1rem 1rem 1rem">
        	<br/>
        	<a href="tabela_Achizitii.jsp"><button class="button1"><b>Înapoi</b></button></a>
        	<br/>
        </div>
	</div>
	<script src="app.js" defer></script>
</body>
</html>