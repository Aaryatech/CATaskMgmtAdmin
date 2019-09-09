package com.ats.taskmgmtadmin;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.acsrights.Info;
import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.common.TaskText;
import com.ats.taskmgmtadmin.model.CustNameId;
import com.ats.taskmgmtadmin.model.CustomerGroupMaster;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.model.StatusMaster;
import com.ats.taskmgmtadmin.model.TaskListHome;
import com.ats.taskmgmtadmin.model.custdetail.GetCustSignatory;
import com.ats.taskmgmtadmin.task.model.Task;
/**
 * Handles requests for the application home page.
 * @param <Task>
 */

//for session
/*
 * In servlet context.xml add this
 * xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" after beans
 * <mvc:interceptors><beans:bean
 * class="com.ats.taskmgmtadmin.CheckUserInterceptor"/></mvc:interceptors>
 * 
 * 
 * in web.xml <filter> <filter-name>noBrowserCacheFilter</filter-name>
 * <filter-class>com.ats.taskmgmtadmin.NoBrowserCacheFilter</filter-class>
 * </filter> <filter-mapping> <filter-name>noBrowserCacheFilter</filter-name>
 * <url-pattern>/*</url-pattern> </filter-mapping>
 */

@Controller
public class HomeController<Task> {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/*
	 * @RequestMapping(value = "/", method = RequestMethod.GET) public String
	 * home(Locale locale, Model model) {
	 * logger.info("Welcome home! The client locale is {}.", locale);
	 * 
	 * Date date = new Date(); DateFormat dateFormat =
	 * DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
	 * 
	 * String formattedDate = dateFormat.format(date);
	 * 
	 * model.addAttribute("serverTime", formattedDate );
	 * 
	 * return "home"; }
	 */

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public ModelAndView dashboard(Locale locale, Model model) {

		// ModelAndView mav = new ModelAndView("login");

		ModelAndView mav = new ModelAndView("dashboard");

		return mav;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) {

		// ModelAndView mav = new ModelAndView("login");

		ModelAndView mav = new ModelAndView("loginDemo");

		return mav;
	}

	/*
	 * @RequestMapping(value = "/customerAdd", method = RequestMethod.GET) public
	 * ModelAndView clientForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerAdd");
	 * 
	 * return mav; }
	 * 
	 * @RequestMapping(value = "/customerList", method = RequestMethod.GET) public
	 * ModelAndView clientListForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerList");
	 * 
	 * return mav; }
	 */

	@RequestMapping(value = "/customerSignAdd", method = RequestMethod.GET)
	public ModelAndView clientSignAddForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("master/customerSignAdd");

		return mav;
	}

	/*
	 * @RequestMapping(value = "/service", method = RequestMethod.GET) public
	 * ModelAndView serviceForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/serviceAdd");
	 * 
	 * return mav; }
	 */

	/*
	 * @RequestMapping(value = "/serviceList", method = RequestMethod.GET) public
	 * ModelAndView serviceListForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/serviceList");
	 * 
	 * return mav; }
	 */

	/*
	 * @RequestMapping(value = "/activity", method = RequestMethod.GET) public
	 * ModelAndView activityForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/activityList");
	 * 
	 * return mav; }
	 */

	/*
	 * @RequestMapping(value = "/activityAdd", method = RequestMethod.GET) public
	 * ModelAndView activityAddForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/activityAdd");
	 * 
	 * return mav; }
	 */

	@RequestMapping(value = "/taskPeriodicityList", method = RequestMethod.GET)
	public ModelAndView taskPeriodicityListForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("task/taskPeriodicityList");

		return mav;
	}

	@RequestMapping(value = "/taskPeriodicityAdd", method = RequestMethod.GET)
	public ModelAndView taskPeriodicityAddForm(Locale locale, Model model) {

		ModelAndView mav = new ModelAndView("task/taskPeriodicityAdd");

		return mav;
	}

	@RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
	public String loginProcess(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String mav = null;
		try {

			RestTemplate restTemplate = new RestTemplate();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map = new LinkedMultiValueMap<>();
			map.add("userName", request.getParameter("username"));
			map.add("password", request.getParameter("password"));

			EmployeeMaster empLogin = Constants.getRestTemplate().postForObject(Constants.url + "/loginCheck", map,
					EmployeeMaster.class);

			if (empLogin == null) {
				mav = "loginDemo";
				System.err.println("Login failed");
				 
				model.addAttribute("errorPassMsg", "Invalid Login Credentials");
			} else {
				System.err.println("Successful Login******"+empLogin.getExInt1());

				
				if(empLogin.getExInt1()!=0) {
					System.err.println("already login ");
				mav = "redirect:/dashboard";
			
				session = request.getSession();

				session.setAttribute("empLogin", empLogin);
				
				session.setAttribute("imageUrl", Constants.imageViewUrl+empLogin.getEmpPic());
				map = new LinkedMultiValueMap<String, Object>();
				map.add("roleId", empLogin.getEmpRoleId());
		
				try {
					ParameterizedTypeReference<List<ModuleJson>> typeRef = new ParameterizedTypeReference<List<ModuleJson>>() {
					};
					ResponseEntity<List<ModuleJson>> responseEntity = Constants.getRestTemplate().exchange(
							Constants.url + "getRoleJsonByRoleId", HttpMethod.POST, new HttpEntity<>(map),
							typeRef);

					List<ModuleJson> newModuleList = responseEntity.getBody();

					session.setAttribute("newModuleList", newModuleList);
					
			}catch (Exception e) {
				System.err.println("Access Right get Exception  " +e.getMessage());
			}

				}
				else {
					System.err.println("1st login ");
					//mav="changePassword";
					session.setAttribute("userId", empLogin.getEmpId());
					mav = "redirect:/chngPassword";
					
					
				}
			}
		} catch (Exception e) {
			mav = "loginDemo";
			System.err.println("Exception in Login Process  " + e.getMessage());
			e.printStackTrace();

		}

		return mav;
	}
	

	@RequestMapping(value = "/chngPassword", method = RequestMethod.GET)
	public ModelAndView chngPassword(Locale locale, Model model) {

		// ModelAndView mav = new ModelAndView("login");

		ModelAndView mav = new ModelAndView("changePassword");

		return mav;
	}
	
	@RequestMapping(value = "/chngNewPassword", method = RequestMethod.POST)
	public String changePassForm(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Got me");
		
 
		try {
			HttpSession session = request.getSession();
			String password = request.getParameter("newPasssword");
			int userId = (int) session.getAttribute("userId");
			System.out.println("Password Found"+password+"  "+userId);
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("password", password);
			map.add("userId", userId);

			Info errMsg = Constants.getRestTemplate().postForObject(Constants.url + "/changePass", map, Info.class);
		
			session.invalidate();

		} catch (Exception e) {

			System.err.println("exception In chngNewPassword at Home Contr" + e.getMessage());
			
			e.printStackTrace();
			HttpSession session = request.getSession();
			session.invalidate();
		}

		return "redirect:/";

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Locale locale, Model model, HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}

	@RequestMapping(value = "/sessionTimeOut", method = RequestMethod.GET)
	public String sessionTimeOut(Locale locale, Model model, HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}

	/*
	 * @RequestMapping(value = "/employeeList", method = RequestMethod.GET) public
	 * ModelAndView employeeListForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/employeeList");
	 * 
	 * return mav; }
	 */

	/*
	 * @RequestMapping(value = "/employeeAdd", method = RequestMethod.GET) public
	 * ModelAndView employeeAddForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/employeeAdd");
	 * 
	 * return mav; }
	 */

	/*
	 * @RequestMapping(value = "/customerGroupList", method = RequestMethod.GET)
	 * public ModelAndView customerGroupListForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerGroupList");
	 * 
	 * return mav; }
	 */

	/*
	 * @RequestMapping(value = "/customerGroupAdd", method = RequestMethod.GET)
	 * public ModelAndView customerGroupAddForm(Locale locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerGroupAdd");
	 * 
	 * return mav; }
	 */

	/*
	 * @RequestMapping(value = "/customerActivityAddMap", method =
	 * RequestMethod.GET) public ModelAndView customerActivityAddMapForm(Locale
	 * locale, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("master/customerActivityAddMap");
	 * 
	 * return mav; }
	 */

	


	@RequestMapping(value = "/taskListForEmp", method = RequestMethod.GET)
	public ModelAndView taskListForEmpForm(HttpServletRequest request,
			HttpServletResponse response,HttpSession session) {

		ModelAndView mav = new ModelAndView("task/homeTaskList");
		try {
					
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			map.add("empId", empSes.getEmpId());
			map.add("statusIds", Constants.statusIds);
			
			TaskListHome[] taskArr = Constants.getRestTemplate().postForObject(Constants.url+"/getTaskListByEmpId",map, TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			
			for (int i = 0; i < taskList.size(); i++) {

				taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
				taskList.get(i).setExVar2(FormValidation.Encrypt(String.valueOf(empSes.getEmpId())));
				}
			
			mav.addObject("taskList", taskList);
			System.err.println("taskList-----"+taskList.toString());
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			
			CustNameId[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCustNames", CustNameId[].class);
			List<CustNameId> custGrpList = new ArrayList<CustNameId>(Arrays.asList(custGrpArr));
		//	System.err.println("custGrpList-----"+custGrpList.toString());
			mav.addObject("custGrpList", custGrpList);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", empSes.getEmpId());
			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);
			
		}catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/fliterTaskList", method = RequestMethod.POST)
	public ModelAndView fliterTaskList(HttpServletRequest request,
			HttpServletResponse response,HttpSession session) {

		ModelAndView mav = new ModelAndView("task/homeTaskList");
		try {
			
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			
			
			String[] dates = fromDate.split("to");
			System.err.println("Data---------"+dates[0]+"   "+dates[1]);
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			map.add("empId", empSes.getEmpId());
			map.add("fromDate", DateConvertor.convertToYMD(dates[0]));
			map.add("toDate", DateConvertor.convertToYMD(dates[1]));
			map.add("service", Integer.parseInt(request.getParameter("service")));
			map.add("activity", Integer.parseInt(request.getParameter("activity")));
			map.add("custId", Integer.parseInt(request.getParameter("custId")));
			map.add("statusIds", Constants.statusIds);
			
			TaskListHome[] taskArr = Constants.getRestTemplate().postForObject(Constants.url+"/getTaskListByFilters",map, TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			System.out.println("taskList-----------"+taskList);
			mav.addObject("taskList", taskList);
			
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			
			CustNameId[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCustNames", CustNameId[].class);
			List<CustNameId> custGrpList = new ArrayList<CustNameId>(Arrays.asList(custGrpArr));
			mav.addObject("custGrpList", custGrpList);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", empSes.getEmpId());
			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);
			
		}catch (Exception e) {
			System.err.println("Exce in fliterTaskList  " + e.getMessage());
		}

		return mav;
	}
	
	@RequestMapping(value = "/setSubModId", method = RequestMethod.GET)
	public @ResponseBody void setSubModId(HttpServletRequest request, HttpServletResponse response) {
		int subModId = Integer.parseInt(request.getParameter("subModId"));
		int modId = Integer.parseInt(request.getParameter("modId"));
		/*
		 * System.out.println("subModId " + subModId); System.out.println("modId " +
		 * modId);
		 */
		HttpSession session = request.getSession();
		session.setAttribute("sessionModuleId", modId);
		session.setAttribute("sessionSubModuleId", subModId);
		session.removeAttribute("exportExcelList");
	}

	@RequestMapping(value = "/getTaskById", method=RequestMethod.GET)
	public @ResponseBody TaskListHome getTaskById(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			
		}catch (Exception e) {
			System.err.println("Exception in getTaskById : "+e.getMessage());
		}
		return null;
		
	}
	
	@RequestMapping(value = "/updateTaskStatusByTaskId", method=RequestMethod.GET)
	public @ResponseBody Info updateTaskStatusByTaskId(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		Info info = new Info();
		List<TaskListHome> taskList = null;
		HttpSession session1 = request.getSession();

		EmployeeMaster emp = (EmployeeMaster) session1.getAttribute("empLogin");
		int userId = emp.getEmpId();
		try {
			int statusId = Integer.parseInt(request.getParameter("statusId"));
			int taskId = Integer.parseInt(request.getParameter("taskId"));
			System.out.println("status-------------"+statusId+" "+taskId);
			MultiValueMap<String, Object> map = null;
			
			map = new LinkedMultiValueMap<>();
			map.add("taskId", taskId);
			map.add("statusVal", statusId);
 			map.add("userId", userId);
			map.add("curDateTime", Constants.getCurDateTime());

			
			info = Constants.getRestTemplate().postForObject(Constants.url+"/updateStatusByTaskId",map, Info.class);			
			System.err.println(info.toString());
			if(info!=null) {
				FormValidation.updateTaskLog(TaskText.taskTex3, userId, taskId);

			}
			
			
			
			
			
			//EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			
			//map = new LinkedMultiValueMap<>();
			//map.add("empId", empSes.getEmpId());
			//map.add("statusIds", Constants.statusIds);
			
			//TaskListHome[] taskArr = Constants.getRestTemplate().postForObject(Constants.url+"/getTaskListByEmpId",map, TaskListHome[].class);
			//taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			
		}catch (Exception e) {
			System.err.println("Exception in updateTaskStatusByTaskId : "+e.getMessage());
		}
		
		return info;
		
	}
	
	/*********************************System Generated Status**********************************/
	
	@RequestMapping(value = "/unallotedTask", method = RequestMethod.GET)
	public ModelAndView unallotedTask(HttpServletRequest request,
			HttpServletResponse response,HttpSession session) {

		ModelAndView mav = new ModelAndView("task/taskAlloted");
		try {
					
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			TaskListHome[] taskArr = Constants.getRestTemplate().getForObject(Constants.url+"/getTaskAlloted", TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			
			/*
			 * for (int i = 0; i < taskList.size(); i++) {
			 * 
			 * taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(
			 * i).getTaskId())));
			 * taskList.get(i).setExVar2(FormValidation.Encrypt(String.valueOf(empSes.
			 * getEmpId()))); }
			 */
			
			mav.addObject("taskList", taskList);
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			
			CustNameId[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCustNames", CustNameId[].class);
			List<CustNameId> custGrpList = new ArrayList<CustNameId>(Arrays.asList(custGrpArr));
		//	System.err.println("custGrpList-----"+custGrpList.toString());
			mav.addObject("custGrpList", custGrpList);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", empSes.getEmpId());
			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);
			
			mav.addObject("sysState", 1);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/fliterUnAllotedTaskList", method = RequestMethod.POST)
	public ModelAndView unallotedFilterTask(HttpServletRequest request,
			HttpServletResponse response,HttpSession session) {

		ModelAndView mav = new ModelAndView("task/taskAlloted");
		try {
					
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());			
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			map.add("service", Integer.parseInt(request.getParameter("service")));
			map.add("activity", Integer.parseInt(request.getParameter("activity")));
			map.add("custId", Integer.parseInt(request.getParameter("custId")));
			
			TaskListHome[] taskArr = Constants.getRestTemplate().postForObject(Constants.url+"/getFilteredTaskUnalloted",map, TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			
			/*
			 * for (int i = 0; i < taskList.size(); i++) {
			 * 
			 * taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(
			 * i).getTaskId())));
			 * taskList.get(i).setExVar2(FormValidation.Encrypt(String.valueOf(empSes.
			 * getEmpId()))); }
			 */
			
			mav.addObject("taskList", taskList);
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			
			CustNameId[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCustNames", CustNameId[].class);
			List<CustNameId> custGrpList = new ArrayList<CustNameId>(Arrays.asList(custGrpArr));
		//	System.err.println("custGrpList-----"+custGrpList.toString());
			mav.addObject("custGrpList", custGrpList);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", empSes.getEmpId());
			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);
			
			mav.addObject("sysState", 1);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/critical", method = RequestMethod.GET)
	public ModelAndView critical(HttpServletRequest request, HttpServletResponse response,HttpSession session) {

		ModelAndView mav = new ModelAndView("task/taskAlloted");
		try {
					
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			TaskListHome[] taskArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCriticalTask", TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			
			mav.addObject("taskList", taskList);
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			
			CustNameId[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCustNames", CustNameId[].class);
			List<CustNameId> custGrpList = new ArrayList<CustNameId>(Arrays.asList(custGrpArr));
		//	System.err.println("custGrpList-----"+custGrpList.toString());
			mav.addObject("custGrpList", custGrpList);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", empSes.getEmpId());
			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);
			
			mav.addObject("sysState", 2);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/fliterCriticalTaskList", method = RequestMethod.POST)
	public ModelAndView fliterCriticalTaskList(HttpServletRequest request,
			HttpServletResponse response,HttpSession session) {

		ModelAndView mav = new ModelAndView("task/taskAlloted");
		try {
					
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());			
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			map.add("service", Integer.parseInt(request.getParameter("service")));
			map.add("activity", Integer.parseInt(request.getParameter("activity")));
			map.add("custId", Integer.parseInt(request.getParameter("custId")));
			
			TaskListHome[] taskArr = Constants.getRestTemplate().postForObject(Constants.url+"/getFilteredCriticalTask",map, TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			
			mav.addObject("taskList", taskList);
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			
			CustNameId[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCustNames", CustNameId[].class);
			List<CustNameId> custGrpList = new ArrayList<CustNameId>(Arrays.asList(custGrpArr));
		//	System.err.println("custGrpList-----"+custGrpList.toString());
			mav.addObject("custGrpList", custGrpList);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", empSes.getEmpId());
			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);
			
			mav.addObject("sysState", 2);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	
	@RequestMapping(value = "/overdue", method = RequestMethod.GET)
	public ModelAndView overdue(HttpServletRequest request, HttpServletResponse response,HttpSession session) {

		ModelAndView mav = new ModelAndView("task/taskAlloted");
		try {
					
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			TaskListHome[] taskArr = Constants.getRestTemplate().getForObject(Constants.url+"/getOverdueTask", TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			
			mav.addObject("taskList", taskList);
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			
			CustNameId[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCustNames", CustNameId[].class);
			List<CustNameId> custGrpList = new ArrayList<CustNameId>(Arrays.asList(custGrpArr));
		//	System.err.println("custGrpList-----"+custGrpList.toString());
			mav.addObject("custGrpList", custGrpList);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", empSes.getEmpId());
			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);
			
			mav.addObject("sysState", 3);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	@RequestMapping(value = "/fliterOverdueTaskList", method = RequestMethod.POST)
	public ModelAndView fliterOverdueTaskList(HttpServletRequest request,
			HttpServletResponse response,HttpSession session) {

		ModelAndView mav = new ModelAndView("task/taskAlloted");
		try {
					
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());			
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			
			map.add("service", Integer.parseInt(request.getParameter("service")));
			map.add("activity", Integer.parseInt(request.getParameter("activity")));
			map.add("custId", Integer.parseInt(request.getParameter("custId")));
			
			TaskListHome[] taskArr = Constants.getRestTemplate().postForObject(Constants.url+"/getFilteredOverdueTask",map, TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));
			
			mav.addObject("taskList", taskList);
			
			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			
			CustNameId[] custGrpArr = Constants.getRestTemplate().getForObject(Constants.url+"/getCustNames", CustNameId[].class);
			List<CustNameId> custGrpList = new ArrayList<CustNameId>(Arrays.asList(custGrpArr));
		//	System.err.println("custGrpList-----"+custGrpList.toString());
			mav.addObject("custGrpList", custGrpList);
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", empSes.getEmpId());
			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);
			
			mav.addObject("sysState", 3);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
}
