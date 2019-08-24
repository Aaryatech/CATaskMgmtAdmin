package com.ats.taskmgmtadmin.common;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.ats.task.mgmtadmin.communication.model.Communication;
import com.ats.taskmgmtadmin.acsrights.Info;

public class FormValidation {

	public static Boolean Validaton(String str, String type) {

		try {
			if (str != null && !str.trim().isEmpty()) {

				if (type.equals("email")) {

					String ePattern = "^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$";
					java.util.regex.Pattern p = java.util.regex.Pattern.compile(ePattern);
					java.util.regex.Matcher m = p.matcher(str);

					if (m.matches()) {
						return false;
					} else {
						return true;
					}

				}
				if (type.equals("mobile")) {

					String ePattern = "^[1-9]{1}[0-9]{9}$";
					java.util.regex.Pattern p = java.util.regex.Pattern.compile(ePattern);
					java.util.regex.Matcher m = p.matcher(str);
					if (m.matches()) {
						return false;
					} else {
						return true;
					}
				}

				return false;
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return true;

	}

	public static String DecodeKey(String str) {

		String decrypt = new String();
		try {

			Decoder theDecoder = Base64.getDecoder();
			byte[] byteArray = theDecoder.decode(str);
			decrypt = new String(byteArray, StandardCharsets.UTF_8); 

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return decrypt;

	}
	
	

	public static String Encrypt(String str) {

		String encrypt = new String();
		try {

			Encoder theEncoder = Base64.getEncoder();
			byte[] theArray = str.getBytes(StandardCharsets.UTF_8);
			encrypt = theEncoder.encodeToString(theArray);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return encrypt;

	}
	
	
	
	public static Info updateTaskLog(String text,int userId,int taskId) {
		
		
		Info res=new Info();
		 try {
 				Communication comcat=new Communication();
				comcat.setCommunText(text);
				comcat.setDelStatus(1);
				comcat.setEmpId(userId);
				comcat.setExInt1(1);
				comcat.setExInt2(1);
				comcat.setExVar1("NA");
				comcat.setExVar2("NA");
				comcat.setTypeId(2);
				comcat.setRemark("NA");
				comcat.setTaskId(taskId);
				comcat.setUpdateDatetime(Constants.getCurDateTime());
				comcat.setUpdateUser(userId);
				

				Communication custHead = Constants.getRestTemplate().postForObject(Constants.url + "/saveCommunication",
						comcat, Communication.class);
				

				if(custHead!=null) {
					res.setError(false);
					res.setMessage("success");
					
				}else {
					res.setError(true);
					res.setMessage("failed");
				}
	 
				
		 }catch (Exception e) {
				System.err.println("Exce in Saving Cust Login Detail " + e.getMessage());
				e.printStackTrace();
			}
 
		
		
		return res;
		
	}

}
