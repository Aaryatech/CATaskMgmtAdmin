package com.ats.taskmgmtadmin.controller;

import java.text.Collator;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ats.taskmgmtadmin.common.Constants;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.ActivityMaster;
import com.ats.taskmgmtadmin.model.ActivityPeriodDetails;
import com.ats.taskmgmtadmin.model.CustmrActivityMap;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.CustomerGroupMaster;
import com.ats.taskmgmtadmin.model.CustomerHeaderMaster;
import com.ats.taskmgmtadmin.model.DevPeriodicityMaster;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.FirmType;
import com.ats.taskmgmtadmin.model.GetActivityPeriodicity;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.model.ShowCustActiMapped;
import com.ats.taskmgmtadmin.model.TaskPeriodicityMaster;

@Controller
public class MasterMVCController {

	private static final Logger logger = LoggerFactory.getLogger(MasterMVCController.class);
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	String curDateTime = dateFormat.format(cal.getTime());
		
	MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
	HttpSession session = null;

	/**********************Service Master**********************/
	@RequestMapping(value = "/serviceList", method = RequestMethod.GET)
	public ModelAndView serviceListForm(Locale locale, Model model) {
		
		ModelAndView mav = new ModelAndView("master/serviceList");
		try {
			
		ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllServices", ServiceMaster[].class);
		List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));		
		mav.addObject("serviceList", srvcMstrList);
		
		//logger.info("Service List"+srvcMstrList);
		
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
			 session = request.getSession(); 
			
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
			int userId = emp.getEmpId();
			
			ServiceMaster service = new ServiceMaster();
			int servcId = 0;
			
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
			service.setUpdateUsername(userId);
			service.setExInt1(0);
			service.setExInt2(0);
			service.setExInt1(0);
			service.setExVar1("NA");
			service.setExVar2("NA");
			
			ServiceMaster saveSrvc = Constants.getRestTemplate().postForObject(Constants.url+"/saveService", service, ServiceMaster.class);
			
		}catch (Exception e) {
			System.err.println("Exce in addService " + e.getMessage());
			e.printStackTrace();
		}
		return "redirect:/serviceList";
	}
	
	
	@RequestMapping(value = "/editService", method = RequestMethod.GET)
	public ModelAndView editService(HttpServletRequest request, HttpServletResponse response) {
	
		ModelAndView mav=null;
		try {
			 mav = new ModelAndView("master/serviceAdd");
			 
			int serviceId = Integer.parseInt(request.getParameter("serviceId"));
						
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			map.add("serviceId", serviceId);			
			ServiceMaster service = Constants.getRestTemplate().postForObject(Constants.url+"/getServiceById", map, ServiceMaster.class); 
			
			mav.addObject("service", service);
			
		}catch (Exception e) {
			System.err.println("Exce in editService " + e.getMessage());
			e.printStackTrace();
		}
		
		
		return mav;
		
	}
	
	@RequestMapping(value = "/deleteService", method = RequestMethod.GET)
	public String deleteService(HttpServletRequest request, HttpServletResponse response) {
		try {
			session = request.getSession(); 
			
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
			int userId = emp.getEmpId();
			
			int serviceId = Integer.parseInt(request.getParameter("serviceId"));
			
		System.out.println("Delete:"+serviceId);
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("userId", userId);
		map.add("serviceId", serviceId);
		
		Info info = Constants.getRestTemplate().postForObject(Constants.url+"/deleteService", map, Info.class);
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
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllServices", ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				
			mav.addObject("serviceList", srvcMstrList);
		}catch (Exception e) {
			System.err.println("Exce in activity " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	
	@RequestMapping(value = "/activityAdd", method = RequestMethod.POST)
	public ModelAndView activityAddForm(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {
			mav = new ModelAndView("master/activityAdd");
			ActivityMaster activity = new ActivityMaster();
			mav.addObject("activity", activity);
			MultiValueMap<String, Object> map = null;
				
			int serviceId = Integer.parseInt(request.getParameter("map_service_id"));
			System.out.println("Mapping Service Id = "+serviceId);
			
			map = new LinkedMultiValueMap<>();			
			map.add("serviceId", serviceId);
			
			ServiceMaster servicemMap = Constants.getRestTemplate().postForObject(Constants.url+"/getServiceById", map, ServiceMaster.class);
			
			mav.addObject("service", servicemMap);	
			
			map = new LinkedMultiValueMap<>();
			map.add("serviceId", serviceId);
			
			ActivityPeriodDetails[] activityArr = Constants.getRestTemplate().postForObject(Constants.url+"/getActivityDetails", map, ActivityPeriodDetails[].class);
			List<ActivityPeriodDetails> activityList = new ArrayList<>(Arrays.asList(activityArr));
			System.out.println("Act List:"+activityList);
			mav.addObject("actList", activityList);	
			
			DevPeriodicityMaster[] priodArr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllPeriodicityDurations", DevPeriodicityMaster[].class);
			List<DevPeriodicityMaster> periodList = new ArrayList<DevPeriodicityMaster>(Arrays.asList(priodArr));
			mav.addObject("periodList", periodList);	
			
		}catch (Exception e) {
			System.err.println("Exce in activityAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/addNewActivity", method = RequestMethod.POST)
	public String addServcActvtMaping(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			session = request.getSession(); 
			
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
			int userId = emp.getEmpId();
			
			ActivityMaster activity = new ActivityMaster();
			
			int actId = 0;
			try {
				actId = Integer.parseInt(request.getParameter("activity_id"));
			}catch(Exception e) {
				actId = 0;
				e.getMessage();
			}
			
			activity.setActiId(actId);
			activity.setActiName(request.getParameter("activityName"));
			activity.setPeriodicityId(Integer.parseInt(request.getParameter("periodicity")));
			activity.setActiDesc(request.getParameter("activityDesc"));
			activity.setServId(Integer.parseInt(request.getParameter("service_id")));
			activity.setDelStatus(1);
			activity.setUpdateDatetime(curDateTime);
			activity.setUpdateUsername(userId);
			activity.setExInt1(0);
			activity.setExInt2(0);
			activity.setExVar1("NA");
			activity.setExVar2("NA");
			
			ActivityMaster actMastr = Constants.getRestTemplate().postForObject(Constants.url+"/saveActivity", activity, ActivityMaster.class);
		}catch (Exception e) {
			System.err.println("Exce in addNewActivity " + e.getMessage());
			e.printStackTrace();
		}
		
		return "redirect:/activity";
		
	}
	
	
	@RequestMapping(value = "/editActivity", method = RequestMethod.GET)
	public ModelAndView editActivity(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {
					mav = new ModelAndView("master/activityAdd");
					
					MultiValueMap<String, Object> map = null;
					
					int activityId = Integer.parseInt(request.getParameter("actiId"));
						System.err.println("In Activity Edit--------"+activityId);
					
					map = new LinkedMultiValueMap<>();
					map.add("activityId", activityId);
					
					ActivityMaster activity = Constants.getRestTemplate().postForObject(Constants.url+"/getActivityById", map, ActivityMaster.class);
					System.out.println("Ativity="+activity);					
					mav.addObject("activity", activity);
					
					map = new LinkedMultiValueMap<>();			
					map.add("serviceId", activity.getServId());
					
					ServiceMaster servicemMap = Constants.getRestTemplate().postForObject(Constants.url+"/getServiceById", map, ServiceMaster.class);			
					System.out.println("Service="+servicemMap);
					mav.addObject("service", servicemMap);		
					
					map = new LinkedMultiValueMap<>();
					map.add("serviceId", activity.getServId());
					
					ActivityPeriodDetails[] activityArr = Constants.getRestTemplate().postForObject(Constants.url+"/getActivityDetails", map, ActivityPeriodDetails[].class);
					List<ActivityPeriodDetails> activityList = new ArrayList<>(Arrays.asList(activityArr));
					System.out.println("Act List:"+activityList);
					mav.addObject("actList", activityList);	
					
					DevPeriodicityMaster[] priodArr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllPeriodicityDurations", DevPeriodicityMaster[].class);
					List<DevPeriodicityMaster> periodList = new ArrayList<DevPeriodicityMaster>(Arrays.asList(priodArr));
					System.out.println("Periodicit-------------"+periodList);
					mav.addObject("periodList", periodList);
			
			
		}catch (Exception e) {
					System.err.println("Exce in editActivity " + e.getMessage());
					e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/deleteActivity/{activityId}", method = RequestMethod.GET)
	public String deleteActivity(HttpServletRequest request, HttpServletResponse response, 
			@PathVariable int activityId) {
				
				int serviceId = 0;
		try {
					MultiValueMap<String, Object> map = null;
					session = request.getSession(); 
					
					EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
					int userId = emp.getEmpId();
					
					System.out.println("Delete:"+activityId);
					
					map = new LinkedMultiValueMap<>();				
					map.add("activityId", activityId);
					
					ActivityMaster activity = Constants.getRestTemplate().postForObject(Constants.url+"/getActivityById", map, ActivityMaster.class);
					
					serviceId = activity.getServId();
					//System.out.println("In Act Del="+activity+"  "+serviceId);
					
					map = new LinkedMultiValueMap<>();
					map.add("userId", userId);
					map.add("activityId", activityId);
					
					Info info = Constants.getRestTemplate().postForObject(Constants.url+"/deleteActivity", map, Info.class);
		}catch (Exception e) {
					System.err.println("Exce in deleteActivity " + e.getMessage());
					e.printStackTrace();
		}
		return "redirect:/activity";		
	}
	
	@RequestMapping(value = "/activityAdd/{serviceId}", method = RequestMethod.GET)
	public ModelAndView activityAddForm(HttpServletRequest request, HttpServletResponse response, @PathVariable int serviceId) {
		ModelAndView mav = null;
		try {
			mav = new ModelAndView("master/activityAdd");
			ActivityMaster activity = new ActivityMaster();
			mav.addObject("activity", activity);
			MultiValueMap<String, Object> map = null;
				
			System.out.println("Mapping Service Id = "+serviceId);
			
			map = new LinkedMultiValueMap<>();			
			map.add("serviceId", serviceId);
			
			ServiceMaster servicemMap = Constants.getRestTemplate().postForObject(Constants.url+"/getServiceById", map, ServiceMaster.class);			
			mav.addObject("service", servicemMap);	
			
			map = new LinkedMultiValueMap<>();
			map.add("serviceId", serviceId);
			
			ActivityMaster[] activityArr = Constants.getRestTemplate().postForObject(Constants.url+"/getAllActivitesByServiceId", map, ActivityMaster[].class);
			List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));
			System.out.println("Act List:"+activityList);
			mav.addObject("actList", activityList);				
					
		}catch (Exception e) {
			System.err.println("Exce in activityAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	
	/***********************Employee Master*************************/
	
	@RequestMapping(value = "/employeeList", method = RequestMethod.GET)
	public ModelAndView employeeListForm(Locale locale, Model model) {

		ModelAndView mav = null;
		try {
				mav = new ModelAndView("master/employeeList");
				
				EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url+"/getAllEmployees", EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				mav.addObject("epmList", epmList);
				
				for (int i = 0; i < epmList.size(); i++) {

					epmList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(epmList.get(i).getEmpId())));
				}
			
		}catch (Exception e) {
			System.err.println("Exce in employeeList " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/employeeAdd", method = RequestMethod.GET)
	public ModelAndView employeeAddForm(Locale locale, Model model) {

		ModelAndView mav = null;
		try {
				mav = new ModelAndView("master/employeeAdd");
				
				EmployeeMaster employee  = new EmployeeMaster();
				mav.addObject("employee", employee);				
				
				ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllServices", ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				
				mav.addObject("serviceList", srvcMstrList);
		}catch (Exception e) {
			System.err.println("Exce in employeeAdd " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/addNewEmployee", method=RequestMethod.POST)
	public String  addNwEmployee(HttpServletRequest request, HttpServletResponse response) {
		try {
			session = request.getSession(); 
			
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
			int userId = emp.getEmpId();
			
			
				EmployeeMaster employee = new EmployeeMaster();
				
				int empId = 0;
				try {
					empId = Integer.parseInt(request.getParameter("employee_id"));
				}catch(Exception e) {
					e.getMessage();
				}
				String servicesList=null;
				try {
				String[] services = request.getParameterValues("empService");
				
				StringBuilder sb = new StringBuilder();

				for (int i = 0; i < services.length; i++) {
					sb = sb.append(services[i] + ",");

				}
				 servicesList = sb.toString();
				System.out.println("Serviceas:"+servicesList);
				}catch(Exception e) {
					
					servicesList="NA";
					System.out.println("Serviceas:"+servicesList);
				}
				
							
				employee.setEmpId(empId);
				employee.setEmpType(Integer.parseInt(request.getParameter("empType")));
				employee.setEmpName(request.getParameter("empName"));
				employee.setEmpNickname(request.getParameter("empNickname"));
				employee.setEmpDob(request.getParameter("dob"));
				employee.setEmpRoleId(1);
				employee.setEmpMob(request.getParameter("phone"));
				employee.setEmpEmail(request.getParameter("email"));
				employee.setEmpPass(request.getParameter("pwd"));
				employee.setEmpDesc(servicesList);
				employee.setEmpPic("NA");
				employee.setEmpSalary(request.getParameter("empSal"));
				employee.setDelStatus(1);
				employee.setUpdateDatetime(curDateTime);
				employee.setUpdateUsername(userId);
				employee.setExInt1(0);
				employee.setExInt2(0);
				employee.setExVar1("NA");
				employee.setExVar2("NA");
				employee.setIsActive(1);
				
				EmployeeMaster empl = Constants.getRestTemplate().postForObject(Constants.url+"/saveNewEmployee", employee, EmployeeMaster.class);
		}catch (Exception e) {
			System.err.println("Exce in addNwEmployee " + e.getMessage());
			e.printStackTrace();
		}
		return "redirect:/employeeList";
	}
	
	@RequestMapping(value = "/editEmployee", method=RequestMethod.GET)
	public ModelAndView editEmployee(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		MultiValueMap<String, Object> map = null;
		try {
			
			List empEditSrvcs=new ArrayList();
			
			mav = new ModelAndView("master/employeeAdd");
			
			int empId = Integer.parseInt(request.getParameter("empId"));
			System.out.println("Emp Id:"+empId);
			
			map = new LinkedMultiValueMap<>();
			
			map.add("empId", empId);
			EmployeeMaster employee = Constants.getRestTemplate().postForObject(Constants.url+"/getEmployeeById", map, EmployeeMaster.class);			
			System.err.println("EmpSrvcList-------"+employee.getEmpDesc());
			mav.addObject("employee", employee);
			
			
			List<Integer> empSrvc =Stream.of(employee.getEmpDesc().split(",")).map(Integer::parseInt).collect(Collectors.toList());
			
			
			System.out.println("Res------------"+empSrvc);
			
			mav.addObject("empSrvcIds", empSrvc);
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllServices", ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));			
			System.out.println("srvcMstrList------------"+srvcMstrList);
			mav.addObject("serviceList", srvcMstrList);
			
			/*
			 * for (int i = 0; i < empSrvc.size(); i++) {
			 * 
			 * for (int j = 0; j < srvcMstrList.size(); j++) {
			 * 
			 * if(Integer.parseInt(empSrvc.get(i))==srvcMstrList.get(j).getServId()) {
			 * System.out.println("List Found-------------"+empSrvc.get(i));
			 * 
			 * empEditSrvcs.add(empSrvc.get(i)); }
			 * 
			 * }
			 * 
			 * }
			 */
			
			///mav.addObject("empServcId", empEditSrvcs);
			
			
		}catch (Exception e) {
			System.err.println("Exce in editEmployee " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	
	
	@RequestMapping(value = "/deleteEmployee", method = RequestMethod.GET)
	public String deleteEmployee(HttpServletRequest request, HttpServletResponse response 
			) {
		
		String base64encodedString = request.getParameter("empId");
		String employeeId = FormValidation.DecodeKey(base64encodedString);
				
				int serviceId = 0;
		try {
					MultiValueMap<String, Object> map = null;
					session = request.getSession(); 
					
					EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
					int userId = emp.getEmpId();
					
					System.out.println("Delete:"+employeeId);
					
					map = new LinkedMultiValueMap<>();				
					map.add("employeeId", employeeId);
										
					map = new LinkedMultiValueMap<>();
					map.add("userId", userId);
					map.add("empId", employeeId);
					
					Info info = Constants.getRestTemplate().postForObject(Constants.url+"/deleteEmployee", map, Info.class);
		}catch (Exception e) {
					System.err.println("Exce in deleteEmployee " + e.getMessage());
					e.printStackTrace();
		}
		return "redirect:/employeeList";
	}
	
	
	@RequestMapping(value = "/updateIsActive", method = RequestMethod.GET)
	public String updateIsActive(HttpServletRequest request, HttpServletResponse response
		) {
		
		String base64encodedString = request.getParameter("empId");
		String empId = FormValidation.DecodeKey(base64encodedString);
			
		try {
					MultiValueMap<String, Object> map = null;
					session = request.getSession(); 
					
					EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
					int userId = emp.getEmpId();
					
					System.out.println("Delete:"+empId);
					
					map = new LinkedMultiValueMap<>();				
					map.add("employeeId", empId);
										
					map = new LinkedMultiValueMap<>();
					map.add("userId", userId);
					map.add("empId", empId);
					
					Info info = Constants.getRestTemplate().postForObject(Constants.url+"/updateEmployeeActiveness", map, Info.class);
		}catch (Exception e) {
					System.err.println("Exce in deleteEmployee " + e.getMessage());
					e.printStackTrace();
		}
		return "redirect:/employeeList";
	}
	
	/**********************Customer Group Master**************************/
	
	@RequestMapping(value = "/customerGroupList", method = RequestMethod.GET)
	public ModelAndView customerGroupListForm(Locale locale, Model model) {
		ModelAndView mav = null;
		try {
			mav = new ModelAndView("master/customerGroupList");
			
			CustomerGroupMaster[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllCustomerGroups", CustomerGroupMaster[].class);
			List<CustomerGroupMaster> custGrpList = new ArrayList<CustomerGroupMaster>(Arrays.asList(custGrpArr));
			
			mav.addObject("custGrpList", custGrpList);
		return mav;
		}catch (Exception e) {
			System.err.println("Exce in customerGroupList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/customerGroupAdd", method = RequestMethod.GET)
	public ModelAndView customerGroupAddForm(Locale locale, Model model) {

		ModelAndView mav = null;
		try {
				mav = new ModelAndView("master/customerGroupAdd");
				
				CustomerGroupMaster cust = new CustomerGroupMaster();				
				mav.addObject("cust", cust);
				
				
				
		}catch (Exception e) {
			
			System.err.println("Exce in customerGroupAdd " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/newCustomerGroup", method = RequestMethod.POST)
	public String  newCustomerGroup(HttpServletRequest request, HttpServletResponse response) {
		try{
			
			session = request.getSession(); 
			
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
			int userId = emp.getEmpId();
			
			
			CustomerGroupMaster cust = new CustomerGroupMaster();
			
			int cusrGrpId = 0;
			try {
				cusrGrpId = Integer.parseInt(request.getParameter("cust_group_id"));
			}catch (Exception e) {
				e.getMessage();
				cusrGrpId=0;
			}
			
			cust.setCustGroupId(cusrGrpId);
			cust.setCustGroupName(request.getParameter("grpName"));
			cust.setCustGroupRemark(request.getParameter("remark"));
			cust.setDelStatus(1);
			cust.setUpdateDatetime(curDateTime);
			cust.setUpdateUsername(userId);
			cust.setExInt1(0);
			cust.setExInt2(0);
			cust.setExVar1("NA");
			cust.setExVar2("NA");
			
			CustomerGroupMaster custGrp = Constants.getRestTemplate().postForObject(Constants.url+"/saveNewCustomerGroup", cust, CustomerGroupMaster.class);
			
		}catch (Exception e) {
			System.err.println("Exce in newCustomerGroup " + e.getMessage());
			e.printStackTrace();
		}
		
		return "redirect:/customerGroupList";
		
	}
	
	@RequestMapping(value = "/editCustGrp", method=RequestMethod.GET)
	public ModelAndView editCustGrp(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		try {
			int custGrpId = Integer.parseInt(request.getParameter("custGrpId"));
			
				mav = new ModelAndView("master/customerGroupAdd");
				
				CustomerGroupMaster cust = new CustomerGroupMaster();				
				mav.addObject("cust", cust);
				
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("custGrpId", custGrpId);
				CustomerGroupMaster custGrp = Constants.getRestTemplate().postForObject(Constants.url+"/getCustomerGroupById", map, CustomerGroupMaster.class);
				
				mav.addObject("cust", custGrp);
		}catch (Exception e) {
			
			System.err.println("Exce in customerGroupAdd " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/deleteCustGrp", method = RequestMethod.GET)
	public String deleteCustGrp(HttpServletRequest request, HttpServletResponse response) {
				
		try {
					MultiValueMap<String, Object> map = null;
					
					int custGrpId = Integer.parseInt(request.getParameter("custGrpId"));
					System.out.println("ID:"+custGrpId);
					
					session = request.getSession(); 
					
					EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
					int userId = emp.getEmpId();		
										
					map = new LinkedMultiValueMap<>();
					map.add("userId", userId);
					map.add("custGrpId", custGrpId);
					
					Info info = Constants.getRestTemplate().postForObject(Constants.url+"/deleteCustomerGroup", map, Info.class);
		}catch (Exception e) {
					System.err.println("Exce in deleteCustGrp " + e.getMessage());
					e.printStackTrace();
		}
		return "redirect:/customerGroupList";
	}
	
	/********************Customer Header Master*************************/
	
	@RequestMapping(value = "/customerAdd", method = RequestMethod.GET)
	public ModelAndView clientForm(Locale locale, Model model) {
		ModelAndView mav = null;
		try {
			
				mav = new ModelAndView("master/customerAdd");
				
				CustomerHeaderMaster custHead = new CustomerHeaderMaster();
				mav.addObject("custHead", custHead);
				
			 
				
				CustomerGroupMaster[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllCustomerGroups", CustomerGroupMaster[].class);
				List<CustomerGroupMaster> custGrpList = new ArrayList<CustomerGroupMaster>(Arrays.asList(custGrpArr));
				mav.addObject("custGrpList", custGrpList);
				
				EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url+"/getAllEmployees", EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				mav.addObject("epmList", epmList);
				
				
		}catch (Exception e) {
			System.err.println("Exce in customerAdd " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/customerList", method = RequestMethod.GET)
	public ModelAndView clientListForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/customerList");
		try {
			
				CustomerDetails[] custHeadArr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllCustomerInfo", CustomerDetails[].class);
				List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));
				mav.addObject("custHeadList", custHeadList);
				
		}catch (Exception e) {
			System.err.println("Exce in customerList " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/addCustomerHeader", method=RequestMethod.POST)
	public String addCustomerHeader(HttpServletRequest request, HttpServletResponse response) {
		try {
			session = request.getSession(); 
			
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
			int userId = emp.getEmpId();
			
				CustomerHeaderMaster cust = new CustomerHeaderMaster();
				int custHeadId = 0; 
				try {
						custHeadId = Integer.parseInt(request.getParameter("cust_head_id"));
				}catch (Exception e) {
					e.getMessage();
				}
				
				int custType = Integer.parseInt(request.getParameter("custType"));
				
				cust.setCustId(custHeadId);
				cust.setOwnerEmpId(Integer.parseInt(request.getParameter("ownerPartner")));
				
				 
				cust.setCustType(custType);
				if(custType==1) {
					cust.setCustGroupId(Integer.parseInt(request.getParameter("clientGrp")));	
					cust.setCustFirmName("NA");
				}else {
					cust.setCustGroupId(0);
					cust.setCustFirmName(request.getParameter("firmName"));
				}
				cust.setCustAssesseeTypeId(Integer.parseInt(request.getParameter("assesseeType")));
				cust.setCustAssesseeName(request.getParameter("assesseeName"));
				cust.setCustPanNo(request.getParameter("panNo"));
				cust.setCustEmailId(request.getParameter("emailId"));
				cust.setCustPhoneNo(request.getParameter("phone"));
				cust.setCustAddr1(request.getParameter("address1"));
				cust.setCustAddr2(request.getParameter("address2"));
				cust.setCustCity(request.getParameter("city"));
				cust.setCustPinCode(Integer.parseInt(request.getParameter("pincode")));
				cust.setCustBusinNatute(request.getParameter("business"));
				cust.setCustIsDscAvail(Integer.parseInt(request.getParameter("dsc")));
				cust.setCustFolderId(request.getParameter("filePath"));
				cust.setCustFileNo(request.getParameter("fileNo"));		
				
				try {
				cust.setCustAadhar(request.getParameter("aadhar"));
				}catch (Exception e) {
					e.getMessage();
					cust.setCustAadhar(request.getParameter("-"));
				}
				
				
				
				cust.setCustDob(request.getParameter("dob"));
				cust.setDelStatus(1);
				cust.setIsActive(1);
				cust.setUpdateDatetime(curDateTime);
				cust.setUpdateUsername(userId);
				cust.setExInt1(0);
				cust.setExInt2(0);
				cust.setExVar1("NA");
				cust.setExVar2("NA");
				System.out.println("Customer:"+cust);
		 CustomerHeaderMaster  custHead = Constants.getRestTemplate().postForObject(Constants.url+"/saveNewCustomerHeader", cust, CustomerHeaderMaster.class);
				
		}catch (Exception e) {
			System.err.println("Exce in addCustomerHeader " + e.getMessage());
			e.printStackTrace();
		}
		return "redirect:/customerList";
	}
	
		
	@RequestMapping(value="/editCust" , method = RequestMethod.GET)
	public ModelAndView editCust(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		try {
			MultiValueMap<String, Object> map = null;
			mav = new ModelAndView("master/customerAdd");
			
			int custId = Integer.parseInt(request.getParameter("custId"));
			
			map = new LinkedMultiValueMap<>();
			map.add("custHeadId", custId);
			
			CustomerHeaderMaster custHead = Constants.getRestTemplate().postForObject(Constants.url+"/getCustomerHeadById", map, CustomerHeaderMaster.class);
			mav.addObject("custHead", custHead);
			
			FirmType[] firmArr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllFirms", FirmType[].class);
			List<FirmType> firmList = new ArrayList<FirmType>(Arrays.asList(firmArr));
			mav.addObject("firmList", firmList);
			
			EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url+"/getAllEmployees", EmployeeMaster[].class);
			List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
			mav.addObject("epmList", epmList);
			
			CustomerGroupMaster[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllCustomerGroups", CustomerGroupMaster[].class);
			List<CustomerGroupMaster> custGrpList = new ArrayList<CustomerGroupMaster>(Arrays.asList(custGrpArr));
			mav.addObject("custGrpList", custGrpList);
			
			
		}catch (Exception e) {
			System.err.println("Exce in editCust " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value = "/deletCust", method = RequestMethod.GET)
	public String deletCustcustId(HttpServletRequest request, HttpServletResponse response) {
				
		try {
					MultiValueMap<String, Object> map = null;
					
					session = request.getSession(); 
					
					EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");				
					int userId = emp.getEmpId();
					
					int custId = Integer.parseInt(request.getParameter("custId"));						
										
					map = new LinkedMultiValueMap<>();
					map.add("userId", userId);
					map.add("custHeadId", custId);
					
					Info info = Constants.getRestTemplate().postForObject(Constants.url+"/deleteCustomerHeader", map, Info.class);
		}catch (Exception e) {
					System.err.println("Exce in deletCust " + e.getMessage());
					e.printStackTrace();
		}
		return "redirect:/customerList";
	}
	
	/*****************Customer Activity Mapping Master****************/
	
	@RequestMapping(value = "/customerActivityAddMap", method = RequestMethod.GET)
	public ModelAndView customerActivityAddMapForm(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		MultiValueMap<String, Object> map = null;
		try {			
			mav = new ModelAndView("master/customerActivityAddMap");
			
			
			int custId = Integer.parseInt(request.getParameter("custId"));
			
			map = new LinkedMultiValueMap<>();
			map.add("custId", custId);
			
			CustomerDetails cust = Constants.getRestTemplate().postForObject(Constants.url+"/getcustById", map, CustomerDetails.class);
			mav.addObject("cust", cust);
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url+"/getAllServices", ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));			
			mav.addObject("serviceList", srvcMstrList);
			
			map = new LinkedMultiValueMap<>();
			map.add("serviceId", srvcMstrList.get(0).getServId());
			
			ActivityMaster[] activityArr = Constants.getRestTemplate().postForObject(Constants.url+"/getAllActivitesByServiceId", map, ActivityMaster[].class);
			List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));			
			mav.addObject("actList", activityList);	
			
		}catch (Exception e) {
			System.err.println("Exce in customerActivityAddMap " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/addCustomerActMap", method = RequestMethod.POST)
	public String addCustomerActMap(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession(); 
			
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			
			int userId = emp.getEmpId();
						
			CustmrActivityMap activityMap = new CustmrActivityMap();
			
			activityMap.setMappingId(0);
			activityMap.setActvBillingAmt(Integer.parseInt(request.getParameter("billAmt")));
			activityMap.setActvEmpBudgHr(Integer.parseInt(request.getParameter("empBudgetHr")));
			activityMap.setActvStartDate(request.getParameter("startDate"));
			activityMap.setActvEndDate(request.getParameter("endDate"));
			activityMap.setActvManBudgHr(Integer.parseInt(request.getParameter("mgBudgetHr")));
			activityMap.setActvStatutoryDays(Integer.parseInt(request.getParameter("statutary_endDays")));
			activityMap.setCustId(Integer.parseInt(request.getParameter("custId")));
			activityMap.setDelStatus(1);
			activityMap.setExInt1(0);
			activityMap.setExInt2(0);
			activityMap.setExVar1("NA");
			activityMap.setExVar2("NA");			
			activityMap.setPeriodicityId(Integer.parseInt(request.getParameter("periodicityId")));
			activityMap.setUpdateDatetime(curDateTime);
			activityMap.setUpdateUsername(userId);
			activityMap.setActvId(Integer.parseInt(request.getParameter("activity")));
			
			System.out.println("Activity Map---------"+activityMap.toString());
			CustmrActivityMap map = Constants.getRestTemplate().postForObject(Constants.url+"/saveTask1", activityMap, CustmrActivityMap.class);
			
		}catch (Exception e) {
			System.err.println("Exce in addCustomerActMap " + e.getMessage());
			e.printStackTrace();
		}
		
		return "redirect:/customerList";
		
	}
	
	
	
	@RequestMapping(value = "/showCustomerActivityMap", method = RequestMethod.GET)
	public ModelAndView showCustomerActivityMap(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("master/customerActiMapList");
		MultiValueMap<String, Object> map = null;
		try {			
			
			int custId = Integer.parseInt(request.getParameter("custId"));
			
			map = new LinkedMultiValueMap<>();
			map.add("custId", custId);
			
			ShowCustActiMapped[] custHeadArr = Constants.getRestTemplate().postForObject(Constants.url+"/getAllCustActivityMapped",map, ShowCustActiMapped[].class);
				List<ShowCustActiMapped> custActMapList = new ArrayList<ShowCustActiMapped>(Arrays.asList(custHeadArr));
				mav.addObject("custActMapList", custActMapList);
				
		}catch (Exception e) {
			System.err.println("Exce in showCustomerActivityMap " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	
	/**********************************************************************/
	
	@RequestMapping(value = "/getPeridicityByActivity", method = RequestMethod.GET)
	public @ResponseBody GetActivityPeriodicity getPeridicityByActivity(HttpServletRequest request, HttpServletResponse response){
		GetActivityPeriodicity period = null;
		try {
				 
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			
			int activityId = Integer.parseInt(request.getParameter("actvityId"));
			System.err.println("Id Found--------------"+activityId);
			
			map = new LinkedMultiValueMap<>();
			map.add("activityId", activityId);
			
			 period = Constants.getRestTemplate().postForObject(Constants.url+"/getPeriodicityByActivityId", map, GetActivityPeriodicity.class);
			System.out.println("Periodicity-------------"+period);
			
		}catch (Exception e) {
			System.err.println("Exce in customerActivityAddMap " + e.getMessage());
			e.printStackTrace();
		}
		return period;
		
		
	}
}

/*SELECT 
        t_tasks.task_id,
        t_tasks.task_text,
        t_tasks.task_start_date,
        t_tasks.task_end_date,
        t_tasks.task_statutory_due_date,
        t_tasks.mngr_bud_hr,
        t_tasks.emp_bud_hr,
        t_tasks.task_emp_ids,
        m_emp.emp_name,
        m_services.serv_name,
        m_activities.acti_name,
        dm_periodicity.periodicity_name,
        m_cust_group.cust_group_name,
        dm_fin_year.fin_year_name
       

FROM 	
        t_tasks,
        m_emp,
        m_services,
        m_activities,
        dm_periodicity,
        m_cust_group,
        m_cust_header,
        dm_fin_year
       
WHERE 
        t_tasks.del_status=1 AND
        m_emp.emp_id=2 AND
		t_tasks.task_emp_ids=m_emp.emp_id AND
        t_tasks.actv_id=m_activities.acti_id AND
        m_activities.serv_id=m_services.serv_id AND
        m_activities.periodicity_id=dm_periodicity.periodicity_id AND
        t_tasks.cust_id=m_cust_header.cust_id AND
        m_cust_header.cust_group_id=m_cust_group.cust_group_id AND
        dm_fin_year.fin_year_id=t_tasks.task_fy_id*/


