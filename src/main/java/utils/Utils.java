package utils;

import java.util.*;
import java.sql.*;
import java.text.DecimalFormat;

public class Utils 
{	
	//region Constructors
	public Utils()
	{
		
	}
	//endregion Constructors
	
	
	//region Properties
	public static String baseCurrency = "EUR";
	public static Map<String, String> ConvertionRatesToEUR = new HashMap<String, String>()
	{
		private static final long serialVersionUID = 1L;
		{
			put("RON", "0.2");
			put("EUR", "1");
			put("USD", "0.94");
		}
	};
	// endregion Properties
	
	
	//region Methods
	// Method to compute number of rows inside a ResultSet
	public static int GetRowsNo(ResultSet rs) throws SQLException 
	{
		int rows = 0;
		while (rs.next())
			rows++;

		return rows;
	}
	
	// Method to convert initial income to EUR
	public static Double ConvertToEUR(String currency, double income)
	{
		income *= Double.parseDouble(ConvertionRatesToEUR.get(currency));
		return income;
	}
	

	// Method to return income converted to the desired currency 
	public static String[] GetIncome(ResultSet rs) throws SQLException
	{
		double income = 0, rows = 0;
		while(rs.next())
		{
			rows++;
			income += ConvertToEUR(rs.getString("moneda"), rs.getDouble("pret"));
		}
		
		// Storing the income and the number of rows
		String ans[] = new String[2];
		ans[0] = String.valueOf(rows);
		ans[1] = new DecimalFormat("#.##").format(income);
		
		return ans;
	}
	//endregion Methods
}
