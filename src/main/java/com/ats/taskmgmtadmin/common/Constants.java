package com.ats.taskmgmtadmin.common;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Constants {
 
	//Web Api Path url
	public static final String url = "http://localhost:8095/";
	


public static String getCurDateTime()
{
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	String curDateTime = dateFormat.format(cal.getTime());
	return curDateTime;

}
}
