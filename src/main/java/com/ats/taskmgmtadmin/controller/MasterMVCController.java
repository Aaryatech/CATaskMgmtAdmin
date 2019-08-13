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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.model.Info;
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
	
	@RequestMapping(value = "/service", method = RequestMethod.GET)
	public ModelAndView serviceForm(Locale locale, Model model) {

		ModelAndView mav = null;
		try {
			mav = new ModelAndView("master/serviceAdd");
			ServiceMaster service = new ServiceMaster();
			mav.addObject("service", service);
		}catch (Exception e) {
			System.err.println("Exce in service " + e.getMessage());
			e.printStackTrace();
		}
		

		return mav;
	}
	
	@RequestMapping(value = "/addService", method = RequestMethod.GET)
	public String addService(HttpServletRequest request, HttpServletResponse response) {
		try {
			
			ServiceMaster service = new ServiceMaster();
			int servcId = 0;
			int user = 111;
			try {
				servcId = Integer.parseInt(request.getParameter("service_id"));
			}catch(Exception e){
				e.getMessage();
				servcId = 0;
			}
			
			
			service.setServId(servcId);
			service.setServName(request.getParameter("serviceName"));
			service.setServDesc(request.getParameter("serviceDesc"));
			service.setDelStatus(1);
			service.setUpdateDatetime(curDateTime);
			service.setUpdateUsername(user);
			service.setExInt1(0);
			service.setExInt2(0);
			service.setExInt1(0);
			service.setExVar1("NA");
			service.setExVar2("NA");
			
			ServiceMaster saveSrvc = rest.postForObject(Constants.url+"/saveService", service, ServiceMaster.class);
			
		}catch (Exception e) {
			System.err.println("Exce in addService " + e.getMessage());
			e.printStackTrace();
		}
		return "redirect:/serviceList";
	}
	
	
	@RequestMapping(value = "/editService", method = RequestMethod.POST)
	public ModelAndView editService(HttpServletRequest request, HttpServletResponse response) {
	
		ModelAndView mav=null;
		try {
			 mav = new ModelAndView("master/serviceAdd");
			 
			int serviceId = Integer.parseInt(request.getParameter("edit_service_id"));
						
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			map.add("serviceId", serviceId);			
			ServiceMaster service = rest.postForObject(Constants.url+"/getServiceById", map, ServiceMaster.class); 
			
			mav.addObject("service", service);
			
		}catch (Exception e) {
			System.err.println("Exce in editService " + e.getMessage());
			e.printStackTrace();
		}
		
		
		return mav;
		
	}
	
	@RequestMapping(value = "/deleteService/{serviceId}", method = RequestMethod.GET)
	public String deleteService(HttpServletRequest request, HttpServletResponse response, 
			@PathVariable int serviceId) {
		try {
		int userId = 222;
		System.out.println("Delete:"+serviceId);
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("userId", userId);
		map.add("serviceId", serviceId);
		
		Info info = rest.postForObject(Constants.url+"/deleteService", map, Info.class);
		}catch (Exception e) {
			System.err.println("Exce in deleteService " + e.getMessage());
			e.printStackTrace();
		}
		return "redirect:/serviceList";		
	}
	
	/****************************Activity Controller****************************/
	
	@RequestMapping(value = "/activity", method = RequestMethod.GET)
	public ModelAndView activityForm(Locale locale, Model model) {

		ModelAndView mav = null;
		try {
		
			mav = new ModelAndView("master/activityList");
			
			ServiceMaster[] srvsMstr = rest.getForObject(Constants.url+"/getAllServices", ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				
			mav.addObject("serviceList", srvcMstrList);
		}catch (Exception e) {
			System.err.println("Exce in activity " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	
	@RequestMapping(value = "/activityAdd", method = RequestMethod.GET)
	public ModelAndView activityAddForm(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {
			int serviceId = Integer.parseInt(request.getParameter("map_service_id"));
			System.out.println("Mapping Service Id = "+serviceId);
				mav = new ModelAndView("master/activityAdd");
			
					
		}catch (Exception e) {
			System.err.println("Exce in activityAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
}
