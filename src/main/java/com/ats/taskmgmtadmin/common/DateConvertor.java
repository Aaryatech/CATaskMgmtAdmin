package com.ats.taskmgmtadmin.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateConvertor {

	public static String convertToYMD(String date) {

		String convertedDate = null;
		try {
			SimpleDateFormat ymdSDF = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat dmySDF = new SimpleDateFormat("dd-MM-yyyy");
			Date dmyDate = dmySDF.parse(date);

			convertedDate = ymdSDF.format(dmyDate);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return convertedDate;

	}

	public static String convertToDMY(String utildate) {

		String convertedDate = null;
		try {
			SimpleDateFormat ymdSDF = new SimpleDateFormat("yyyy-mm-dd");
			SimpleDateFormat ymdSDF2 = new SimpleDateFormat("yyyy-mm-dd");

			SimpleDateFormat dmySDF = new SimpleDateFormat("dd-mm-yyyy");

			Date ymdDate = ymdSDF2.parse(utildate);

			convertedDate = dmySDF.format(ymdDate);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return convertedDate;

	}

	public static java.sql.Date convertToSqlDate(String date) {

		java.sql.Date convertedDate = null;
		try {
			SimpleDateFormat ymdSDF = new SimpleDateFormat("yyyy-mm-dd");
			SimpleDateFormat dmySDF = new SimpleDateFormat("dd-MM-yyyy");

			Date dmyDate = dmySDF.parse(date);

			System.out.println("converted util date commons " + dmyDate);

			convertedDate = new java.sql.Date(dmyDate.getTime());
			System.out.println("converted sql date commons " + convertedDate);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return convertedDate;

	}

	public static Calendar getTimePlusSpecMin(int interval) {

		SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm");
		Calendar cal30 = Calendar.getInstance();

		System.out.println("Time " + String.valueOf(df.format(cal30.getTime())));

		cal30.add(Calendar.MINUTE, interval);
		// return String.valueOf(df.format(cal30.getTime()));
		return cal30;
	}

	public static Calendar getCurTime() {

		int interval = 0;
		SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm");
		Calendar curCal = Calendar.getInstance();

		System.out.println("Time " + String.valueOf(df.format(curCal.getTime())));

		curCal.add(Calendar.MINUTE, interval);
		// return String.valueOf(df.format(curCal.getTime()));
		return curCal;

	}

	// Get From to Date with months first day to current day
	public static String getFromToDate() {
		String leaveDateRange = null;
		String fromDate = null;
		String toDate = null;
		Calendar c = Calendar.getInstance(); // this takes current date

		// System.out.println(c.getTime());
		//c.set(Calendar.DAY_OF_MONTH, 1);
		Date toDate1 = c.getTime();

		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

		toDate = sdf.format(toDate1);

		c.set(Calendar.DAY_OF_MONTH, 1);
		Date fromDate1 = c.getTime();

		fromDate = sdf.format(fromDate1);

		leaveDateRange = fromDate.concat(" to ").concat(toDate);
		return leaveDateRange;
	}

	public static String getMonthsStartEnd() {
		String leaveDateRange = null;
		String fromDate = null;
		String toDate = null;
		Calendar c = Calendar.getInstance(); // this takes current date

		// System.out.println(c.getTime());

		 c.add(Calendar.MONTH, 1);  
	        c.set(Calendar.DAY_OF_MONTH, 1);  
	        c.add(Calendar.DATE, -1);  
		Date toDate1 = c.getTime();
//System.err.println("to date "+toDate1);
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

		toDate = sdf.format(toDate1);
		c = Calendar.getInstance(); 
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date fromDate1 = c.getTime();
		
		

		fromDate = sdf.format(fromDate1);

		leaveDateRange = fromDate.concat(" to ").concat(toDate);
		return leaveDateRange;
	}
}
