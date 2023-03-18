/*
 * Proiect MedSoft - by Alexandru-Gabriel Lefterache
 */
package db;

import java.sql.*;
import java.util.*;
import java.text.SimpleDateFormat;

public class JavaBean {

	String error;
	Connection con;

	public JavaBean() {
	}

	public void connect() throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medsoftdb?useSSL=false", "MedSoftUser", "af@345SDE456$$%%dgt");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect()

	public void connect(String bd) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + bd, "MedSoftUser", "jimisql");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect(String bd)

	public void connect(String bd, String ip) throws ClassNotFoundException, SQLException, Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://" + ip + ":3306/" + bd, "MedSoftUser", "jimisql");
		} catch (ClassNotFoundException cnfe) {
			error = "ClassNotFoundException: Nu s-a gasit driverul bazei de date.";
			throw new ClassNotFoundException(error);
		} catch (SQLException cnfe) {
			error = "SQLException: Nu se poate conecta la baza de date.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "Exception: A aparut o exceptie neprevazuta in timp ce se stabilea legatura la baza de date.";
			throw new Exception(error);
		}
	} // connect(String bd, String ip)

	public void disconnect() throws SQLException {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException sqle) {
			error = ("SQLException: Nu se poate inchide conexiunea la baza de date.");
			throw new SQLException(error);
		}
	} // disconnect()

	public void adaugaClient(String nume, String nume_Reprezentant, String prenume_reprezentant,
			String tara, String regiune, String oras, String adresa, String telefon)
			throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into Clienti(nume, nume_Reprezentant, prenume_reprezentant,"
						+ "tara, regiune, oras, adresa, telefon) values('" + nume + "'  , '" + nume_Reprezentant + 
						"', '" + prenume_reprezentant + "', '" + tara + "', '" + regiune + "', '" + oras + "',"
								+ "'" + adresa + "', '" + telefon + "'  );");

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of adaugaClient()

	public void adaugaProiect(String idProiect, String nume, String tip, String descriere, String data_finalizare,
			String data_actualizare, String versiune)
			throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into Proiecte(idProiect, nume, tip, descriere, data_finalizare, data_actualizare,"
						+ "versiune) values('" + idProiect + "'  , '" + nume + "', '" + tip + "',  '" + descriere + "',"
								+ " '" + data_finalizare + "',  '" + data_actualizare + "', '" + versiune + "');");

			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of adaugaProiect()

	public void adaugaAchizitie(int idclient, String idproiect, String dataAchizitie, double pret, String moneda)
			throws SQLException, Exception {
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = sdf1.parse(dataAchizitie);
		java.sql.Date sqlDate = new java.sql.Date(date.getTime());
		
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("insert into Achizitii(idclient, idproiect, data_achizitie, pret, moneda) values('" + idclient + "'  , '" + idproiect + "', '" + sqlDate + "', '" + pret + "', '" + moneda + "');");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of adaugaAchizitie()

	public ResultSet vedeTabela(String tabel) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select * from `medsoftdb`.`" + tabel + "`;");
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeTabela()

	public ResultSet vedeAchizitie() throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select a.nume Nume, a.nume_reprezentant NumeReprezentant, a.prenume_reprezentant PrenumeReprezentant, a.tara Tara,"
					+ " a.regiune Regiune, a.oras Oras, a.adresa Adresa, a.telefon Telefon, b.idproiect IdProiect, b.nume NumeProiect, b.descriere Descriere,"
					+ " b.data_finalizare DataFinalizare, b.data_actualizare DataActualizare, b.versiune Versiune, c.idachizitie, c.idproiect IdProiect, c.idclient IdClient,"
					+ " c.data_achizitie, c.pret, c.moneda from clienti a, proiecte b, achizitii c where a.idclient = c.idclient and b.idproiect = c.idproiect order by c.idachizitie asc;");
			Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
			rs = stmt.executeQuery(queryString);
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // vedeAchizitie()

	public void stergeDateTabela(String[] primaryKeys, String tabela, String dupaID) throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				PreparedStatement delete;
				delete = con.prepareStatement("DELETE FROM " + tabela + " WHERE " + dupaID + "=?;");
				for (int i = 0; i < primaryKeys.length; i++) {
					if (tabela != "proiecte")
					{
						var aux = java.lang.Long.parseLong(primaryKeys[i]);
						delete.setLong(1, aux);
					}
					else
					{
						delete.setString(1, primaryKeys[i]);
					}
					delete.execute();
				}
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			} catch (Exception e) {
				error = "A aparut o exceptie in timp ce erau sterse inregistrarile.";
				throw new Exception(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of stergeDateTabela()

	public void stergeTabela(String tabela) throws SQLException, Exception {
		if (con != null) {
			try {
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate("delete from " + tabela + ";");
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Stergere nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of stergeTabela()

	public void modificaTabela(String tabela, String IDTabela, String ID, String[] campuri, String[] valori) throws SQLException, Exception {
		String update = "update " + tabela + " set ";
		String temp = "";
		if (con != null) {
			try {
				for (int i = 0; i < campuri.length; i++) {
					if (i != (campuri.length - 1)) {
						temp = temp + campuri[i] + "='" + valori[i] + "', ";
					} else {
						temp = temp + campuri[i] + "='" + valori[i] + "' where " + IDTabela + " = '" + ID + "';";
					}
				}
				update = update + temp;
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate(update);
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of modificaTabela()

	public ResultSet intoarceLinie(String tabela, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where idClient=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinie()

	public ResultSet intoarceLinieDupaId(String tabela, String denumireId, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where " + denumireId + "=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinieDupaId()

	public ResultSet intoarceAchizitieId(int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			String queryString = ("select a.nume Nume, a.nume_reprezentant NumeReprezentant, a.prenume_reprezentant PrenumeReprezentant, a.telefon Telefon, b.idproiect IdProiect,"
					+ " b.nume NumeProiect, c.idachizitie, c.data_achizitie, c.pret, c.moneda from clienti a, proiecte b, achizitii c where a.idclient = c.idclient"
					+ " and b.idproiect = c.idproiect and idachizitie = '" + ID + "' order by c.idachizitie asc;");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinieDupaId()

	public ResultSet intoarceCautare(String tabela, String info) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Get column names
			String queryString = ("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '" + tabela +"';");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString);
			String columnNames = "";
			boolean first = true;
			
			while (rs.next()) {
				if (!first)
				{
					columnNames += ", ";
				}
				columnNames += "CAST(" + rs.getString("COLUMN_NAME") + " AS CHAR)";
				first = false;
			}
			
			// Escaping "info" (if needed)
			info = escapeStringForMySQL(info);
					
			// Execute query
			queryString = ("SELECT * FROM " + tabela + " where " + "'" + info + "'" + " in " + "(" + String.join(",", columnNames) + ");");
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); 
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceCautare()
	
	public Integer[] intoarceCautareIds(String info) throws SQLException, Exception {
		ResultSet achizitii = null;
		Integer[] indexArray;
		try {
			// Get columns
			String queryString = ("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'achizitii'"
					+ "AND COLUMN_NAME != 'idclient';");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			achizitii = stmt.executeQuery(queryString);
			String columnNames = "";
			boolean first = true;
			
			while (achizitii.next()) {
				if (achizitii.getString("COLUMN_NAME").trim() == "idclient")
					continue;
				
				if (!first)
				{
					columnNames += ", ";
				}
				columnNames += "CAST(" + achizitii.getString("COLUMN_NAME") + " AS CHAR)";
				first = false;
			}
			
			// Escaping "info" (if needed)
			info = escapeStringForMySQL(info);
					
			// Execute query
			queryString = ("SELECT * FROM achizitii WHERE " + "'" + info + "'" + " in " + "(" + String.join(",", columnNames) + ");");
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			achizitii = stmt.executeQuery(queryString); 
			List<Integer> indexes = new ArrayList<>();
			
			while (achizitii.next())
			{
				indexes.add(achizitii.getInt("idachizitie"));
			}
			
			indexArray = indexes.toArray(new Integer[0]);
			
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		
		return indexArray;
	} // end of intoarceCautareIds()
	
	// Method to escape a string if needed for a query.
	private String escapeStringForMySQL(String s) {
        return s.replaceAll("\\\\", "\\\\\\\\")
                .replaceAll("\b","\\b")
                .replaceAll("\n","\\n")
                .replaceAll("\r", "\\r")
                .replaceAll("\t", "\\t")
                .replaceAll("\\x1A", "\\Z")
                .replaceAll("\\x00", "\\0")
                .replaceAll("'", "\\'")
                .replaceAll("\"", "\\\"");
    }
}