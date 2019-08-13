package com.ats.taskmgmtadmin.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.model.ServiceMaster;

@Controller
public class MasterMVCController {

	private static final Logger logger = LoggerFactory.getLogger(MasterMVCController.class);
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	String curDateTime = dateFormat.format(cal.getTime());
	
	RestTemplate rest = new RestTemplate();
	
	MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
	
	/**********************Service Master**********************/
	@RequestMapping(value = "/serviceList", method = RequestMethod.GET)
	public ModelAndView serviceListForm(Locale locale, Model model) {
		
		ModelAndView mav = new ModelAndView("master/serviceList");
		try {
			
		ServiceMaster[] srvsMstr = rest.getForObject(Constants.url+"/getAllServices", ServiceMaster[].class);
		List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
		
		mav.addObject("serviceList", srvcMstrList);
		logger.info("Service List"+srvcMstrList);
		}catch (Exception e) {
			System.err.println("Exce in serviceList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/editService", method = RequestMethod.POST)
	public String editService(HttpServletRequest request, HttpServletResponse response) {
		try {
			
			int serviceId = Integer.parseInt(request.getParameter("servcId"));
			System.out.println("Service Id = "+serviceId);
			
		}catch (Exception e) {
			System.err.println("Exce in editService " + e.getMessage());
			e.printStackTrace();
		}
		
		
		return "redirect:/serviceList";
		
	}
}
