package com.ats.taskmgmtadmin.common;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.http.client.support.BasicAuthorizationInterceptor;
import org.springframework.web.client.RestTemplate;

public class Constants {

	public static String statusIds = "0,8,9";
	
	// Web Api Path url
	public static final String url = "http://localhost:8095/";
	//public static final String url = "http://132.148.143.124:8080/CATaskMngtApi/";
	public static RestTemplate rest = new RestTemplate();
	public static final String imageSaveUrl = "/home/lenovo/Downloads/"; public
	  static String[] values = { "jpg", "jpeg", "gif", "png" };
	 public static RestTemplate getRestTemplate() {
			rest=new RestTemplate();
			rest.getInterceptors().add(new BasicAuthorizationInterceptor("aaryatech", "Aaryatech@1cr"));
			return rest;

			} 
	String imageViewUrl="http://132.148.143.124:8080/uploads/ujwal/UjjwalImg/";
	public static String getCurDateTime() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		String curDateTime = dateFormat.format(cal.getTime());
		return curDateTime;

	}
}
