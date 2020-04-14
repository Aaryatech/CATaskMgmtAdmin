package com.ats.taskmgmtadmin.controller;

import java.text.DateFormat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.HomeController;
import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.AccessControll;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.DateValues;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.common.HoursConversion;
import com.ats.taskmgmtadmin.common.PeriodicityDates;
import com.ats.taskmgmtadmin.common.TaskText;
import com.ats.taskmgmtadmin.model.ActivityMaster;
import com.ats.taskmgmtadmin.model.CustNameId;
import com.ats.taskmgmtadmin.model.CustmrActivityMap;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.CustomerHeaderMaster;
import com.ats.taskmgmtadmin.model.DailyWorkLog;
import com.ats.taskmgmtadmin.model.DevPeriodicityMaster;
import com.ats.taskmgmtadmin.model.EmpWorkLogHrs;
import com.ats.taskmgmtadmin.model.EmployeeFreeBsyList;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.FinancialYear;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.model.ShowCustActiMapped;
import com.ats.taskmgmtadmin.model.TaskListHome;
import com.ats.taskmgmtadmin.task.model.GetTaskList;
import com.ats.taskmgmtadmin.task.model.Task;
import com.ats.taskmgmtadmin.task.model.TempForTaskEdit;
import com.ats.taskmgmtadmin.task.model.TempTaskSave;

@Controller
@Scope("session")
public class TaskController {
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	List<EmployeeMaster> empList = new ArrayList<EmployeeMaster>();
	EmployeeFreeBsyList empListTot = new EmployeeFreeBsyList();
	List<EmployeeMaster> empListNew = new ArrayList<EmployeeMaster>();
	Date now = new Date();
	String curDate = dateFormat.format(new Date());
	String dateTime = dateFormat.format(now);

	String curDateTime = dateFormat.format(cal.getTime());
	String redirect;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/assignTask", method = RequestMethod.GET)
	public ModelAndView assignTask(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("assignTask", "assignTask", "1", "0", "0", "0", newModuleList);
		
		 List<ServiceMaster> srvcMstrList = new ArrayList<>();
		try {

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("task/assigntask");

				/*
				 * ServiceMaster[] srvsMstr = Constants.getRestTemplate()
				 * .getForObject(Constants.url + "/getAllEnrolledServices",
				 * ServiceMaster[].class); List<ServiceMaster> srvcMstrList = new
				 * ArrayList<>(Arrays.asList(srvsMstr)); mav.addObject("serviceList",
				 * srvcMstrList);
				 */
				/*
				 * CustomerDetails[] custHeadArr = Constants.getRestTemplate()
				 * .getForObject(Constants.url + "/getAllCustomerInfo",
				 * CustomerDetails[].class); List<CustomerDetails> custHeadList = new
				 * ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));
				 * 
				 * mav.addObject("custList", custHeadList);
				 */

				String custId = "0";
				String servId = "0";
				int periodicityId = 0;
				if (request.getParameter("customer") != "" && request.getParameter("customer") != null) {
					custId = request.getParameter("customer");
					try {
						periodicityId = Integer.parseInt(request.getParameter("periodicityId"));
					} catch (Exception e) {
						periodicityId = 0;
					}
				} else {
					custId = "0";
				}
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("periodId", periodicityId);

				CustomerDetails[] custHeadArr = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getCustByPeriodcityId",map, CustomerDetails[].class);
				List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

				mav.addObject("custList", custHeadList);
				
				//if (periodicityId != 0) {
					  map = new LinkedMultiValueMap<>();
					map.add("periodcityId", periodicityId);
					ServiceMaster[] srvsMstr = Constants.getRestTemplate().postForObject(Constants.url + "/getServicesByPeriodId",
							map,ServiceMaster[].class);
					srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
					mav.addObject("serviceList", srvcMstrList);
				//}

				if (request.getParameter("service") != "" && request.getParameter("service") != null) {
					servId = request.getParameter("service");
				} else {
					servId = "0";
				}
				mav.addObject("servId", servId);
				mav.addObject("custId", custId);
				mav.addObject("perdId", periodicityId);

			map = new LinkedMultiValueMap<>();
				map.add("stat", 0);
				map.add("servId", Integer.parseInt(servId));
				map.add("custId", Integer.parseInt(custId));
				map.add("periodicityId", periodicityId);
				GetTaskList[] holListArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllTaskList", map, GetTaskList[].class);

				List<GetTaskList> taskList = new ArrayList<>(Arrays.asList(holListArray));

				for (int i = 0; i < taskList.size(); i++) {

					taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
				}
				mav.addObject("taskList", taskList);
				EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
						EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				mav.addObject("epmList", epmList);

				DevPeriodicityMaster[] priodArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllPeriodicityDurations", DevPeriodicityMaster[].class);
				List<DevPeriodicityMaster> periodList = new ArrayList<DevPeriodicityMaster>(Arrays.asList(priodArr));
				mav.addObject("periodList", periodList);
			}
		} catch (Exception e) {

			e.printStackTrace();

		}

		return mav;
	}

	// Sachin 31-03-2020 get Service and Cust  List by PeriodId
	@RequestMapping(value = "/getServicesandCustByPeriodId", method = RequestMethod.GET)
	public @ResponseBody DataTransfrerClass getServicesByPeriodId(HttpServletRequest request,
			HttpServletResponse response) {
		DataTransfrerClass dtc=new DataTransfrerClass();
		
		int periodicityId = Integer.parseInt(request.getParameter("periodcityId"));
		List<ServiceMaster> serviceList = new ArrayList<ServiceMaster>();

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("periodcityId", periodicityId);
		ServiceMaster[] holListArray = Constants.getRestTemplate()
				.postForObject(Constants.url + "/getServicesByPeriodId", map, ServiceMaster[].class);
		serviceList = new ArrayList<>(Arrays.asList(holListArray));
		map = new LinkedMultiValueMap<>();
		map.add("periodId", periodicityId);

		CustomerDetails[] custHeadArr = Constants.getRestTemplate()
				.postForObject(Constants.url + "/getCustByPeriodcityId",map, CustomerDetails[].class);
		List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

		dtc.setCustList(custHeadList);
		dtc.setServList(serviceList);
		return dtc;
	}

	/*
	 * @RequestMapping(value = "/selectEmployeeToAssigTask", method =
	 * RequestMethod.GET) public ModelAndView
	 * selectEmployeeToAssigTask(HttpServletRequest request, HttpServletResponse
	 * response, Model model) {
	 * 
	 * ModelAndView mav = new ModelAndView("task/showEmpListForAssignTask"); try {
	 * empList = new ArrayList<EmployeeMaster>(); empListTot = new
	 * EmployeeFreeBsyList(); empListNew = new ArrayList<EmployeeMaster>(); workDate
	 * = request.getParameter("workDate"); System.out.println("work date**" +
	 * workDate);
	 * 
	 * TaskId = request.getParameterValues("TaskId");
	 * 
	 * StringBuilder sb = new StringBuilder();
	 * 
	 * for (int i = 0; i < TaskId.length; i++) { sb = sb.append(TaskId[i] + ",");
	 * 
	 * // System.out.println("task id are**" + TaskId[i]);
	 * 
	 * } items = sb.toString();
	 * 
	 * items = items.substring(0, items.length() - 1);
	 * 
	 * 
	 * StringBuilder sb1 = new StringBuilder(); String[] locId2 =
	 * request.getParameterValues("empId2"); for (int i = 0; i < locId2.length; i++)
	 * { sb1 = sb1.append(locId2[i] + ",");
	 * 
	 * } String items1 = sb.toString(); items1 = items1.substring(0, items1.length()
	 * - 1); System.err.println("emp loc are :::" + items1);
	 * 
	 * 
	 * 
	 * } catch (Exception e) {
	 * 
	 * e.printStackTrace(); }
	 * 
	 * return mav; }
	 */
	@RequestMapping(value = "/getFreeEmployeeList", method = RequestMethod.GET)
	public @ResponseBody List<EmployeeMaster> getFreeEmployeeList(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			empList = new ArrayList<EmployeeMaster>();
			int catId = Integer.parseInt(request.getParameter("catId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("roleId", catId);
			EmployeeMaster[] holListArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpByEmpTypeId", map, EmployeeMaster[].class);

			empList = new ArrayList<>(Arrays.asList(holListArray));
			for (int j = 0; j < empList.size(); j++) {

				for (int i = 0; i < empListNew.size(); i++) {

					if (empList.get(j).getEmpId() == empListNew.get(i).getEmpId()) {
						empList.remove(j);
						break;
					}
				}
			}

			/// System.out.println("emp list by type" + empList.toString());
		} catch (Exception e) {

			e.printStackTrace();
		}

		return empList;
	}

	@RequestMapping(value = "/moveEmp", method = RequestMethod.GET)
	public @ResponseBody EmployeeFreeBsyList moveEmp(HttpServletRequest request, HttpServletResponse response) {

		try {
			// System.out.println("Hii in moveEmp");

			String empIds = request.getParameter("empId");
			String[] empId = empIds.split(",");
			// System.out.println(Arrays.asList(empId));
			for (int i = 1; i < empId.length; i++) {
				for (int j = 0; j < empList.size(); j++) {

					if (empList.get(j).getEmpId() == Integer.parseInt(empId[i])) {
						empListNew.add(empList.get(j));
						empList.remove(j);

						break;

					}
				}
			}

			// System.out.println("Complete emp 1** " + empList.toString());
			// System.out.println("Complete emp 2** " + empListNew.toString());
			empListTot.setBsyList(empList);
			empListTot.setFreeList(empListNew);
			// System.out.println("Complete emp list is** " + empListTot.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return empListTot;
	}

	@RequestMapping(value = "/deleteEmp", method = RequestMethod.GET)
	public @ResponseBody EmployeeFreeBsyList deleteEmp(HttpServletRequest request, HttpServletResponse response) {

		try {
			int empId = Integer.parseInt(request.getParameter("empId"));
			// System.out.println("empId** " + empId);

			for (int i = 0; i < empListTot.getFreeList().size(); i++) {
				if (empListTot.getFreeList().get(i).getEmpId() == empId) {
					// System.out.println("matchd** " + i);
					empListTot.getFreeList().remove(i);
					break;

				}
			}

			empListTot.setBsyList(empList);
			empListTot.setFreeList(empListNew);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return empListTot;
	}

	@RequestMapping(value = "/submitTaskAssignment", method = RequestMethod.POST)
	public String addCustLoginDetail(HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		try {

			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			String workDate = null;
			try {
				workDate = request.getParameter("workDate");
			} catch (Exception e) {
				e.printStackTrace();
				workDate = " ";
			}
			// System.out.println("work date**" + workDate);

			String[] TaskId = request.getParameterValues("TaskId");

			StringBuilder sb = new StringBuilder();

			for (int i = 0; i < TaskId.length; i++) {
				sb = sb.append(TaskId[i] + ",");

				System.out.println("task id are**" + TaskId[i]);

			}

			String items = sb.toString();

			items = items.substring(0, items.length() - 1);

			StringBuilder sbEmp = new StringBuilder();
			String[] locId2 = request.getParameterValues("empId2");
			// System.err.println("emp id are " + locId2);
			for (int j = 0; j < locId2.length; j++) {
				sbEmp = sbEmp.append(locId2[j] + ",");

			}
			String items1 = sbEmp.toString();
			items1 = items1.substring(0, items1.length() - 1);
			/// System.err.println("emp id are :::" + items1);

			map.add("taskIdList", items);
			map.add("empIdList", items1);
			map.add("userId", userId);
			map.add("curDateTime", Constants.getCurDateTime());
			map.add("workDate", workDate);

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/taskAssignmentUpdate", map,
					Info.class);

			if (info.isError()) {
				session.setAttribute("errorMsg", "Unable to Assign Task");

			} else {
				session.setAttribute("successMsg", "Task Assigned Successfully");

			}

			if (info.isError() == false) {

				for (int i = 0; i < TaskId.length; i++) {
					FormValidation.updateTaskLog(TaskText.taskTex2, userId, Integer.parseInt(TaskId[i]));
				}
			}

		} catch (Exception e) {
			System.err.println("Exce in Saving Cust Login Detail " + e.getMessage());
			e.printStackTrace();
		}

		return "redirect:/assignTask";
	}

	@RequestMapping(value = "/showDailyWorkLog", method = RequestMethod.GET)
	public String showDailyWorkLog(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "task/showDailyWorkLog";

		return mav;
	}

	// *******************Inactive Task******************************************

	@RequestMapping(value = "/inactiveTaskList", method = RequestMethod.GET)
	public ModelAndView inactiveTaskList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		ModelAndView mav = null;

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("inactiveTaskList", "inactiveTaskList", "1", "0", "0", "0",
				newModuleList);

		if (view.isError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {

			mav = new ModelAndView("task/inactiveTaskList");
			List<Integer> actIntList = null;
			List<Integer> custIntList = null;
			int servId = 0;
			StringBuilder sbCust = new StringBuilder();
			String[] custList = null;

			StringBuilder sbAct = new StringBuilder();
			String[] actList = null;
			String itemsCust = null;
			String itemsAct = null;

			ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
					ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);

			CustomerDetails[] custHeadArr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllCustomerInfoActiveInactive", CustomerDetails[].class);
			List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

			mav.addObject("custList", custHeadList);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			try {
				servId = Integer.parseInt(request.getParameter("service"));
			} catch (Exception e) {

				servId = 0;

			}

			map = new LinkedMultiValueMap<>();
			map.add("serviceId", servId);

			ActivityMaster[] activityArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllActivitesByServiceId", map, ActivityMaster[].class);
			List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));
			mav.addObject("activityList", activityList);

			try {
				sbAct = new StringBuilder();
				actList = request.getParameterValues("activity");
				// System.err.println("emp id are " + locId2);
				for (int j = 0; j < actList.length; j++) {
					sbAct = sbAct.append(actList[j] + ",");
				}
				itemsAct = sbAct.toString();
				itemsAct = itemsAct.substring(0, itemsAct.length() - 1);
			} catch (Exception e) {

				itemsAct = "0";
			}
			actIntList = Stream.of(itemsAct.split(",")).map(Integer::parseInt).collect(Collectors.toList());
			mav.addObject("actIntList", actIntList);
			try {
				sbCust = new StringBuilder();
				custList = request.getParameterValues("customer");

				for (int j = 0; j < custList.length; j++) {
					sbCust = sbCust.append(custList[j] + ",");

				}
				itemsCust = sbCust.toString();
				itemsCust = sbCust.substring(0, itemsCust.length() - 1);

			} catch (Exception e) {

				itemsCust = "0";

			}

			custIntList = Stream.of(itemsCust.split(",")).map(Integer::parseInt).collect(Collectors.toList());

			// Prev
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			// for dropdown
			mav.addObject("actIntList", actIntList);
			mav.addObject("custIdList", custIntList);
			mav.addObject("servId", servId);
			session.setAttribute("inactivePage", 1);
//
			try {

				map = new LinkedMultiValueMap<>();
				map.add("empId", userId);
				map.add("itemsAct", itemsAct);
				map.add("itemsCust", itemsCust);
				map.add("servId", servId);

				GetTaskList[] holListArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllInactiveTaskList", map, GetTaskList[].class);

				List<GetTaskList> taskList = new ArrayList<>(Arrays.asList(holListArray));

				for (int i = 0; i < taskList.size(); i++) {

					taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
				}
				mav.addObject("taskList", taskList);
				// System.out.println("ManualTakList***" + taskList.toString());
				Info edit = AccessControll.checkAccess("inactiveTaskList", "inactiveTaskList", "0", "0", "1", "0",
						newModuleList);

				if (edit.isError() == false) {
					// //System.out.println(" edit Accessable ");
					mav.addObject("editAccess", 0);
				}

			} catch (Exception e) {
				System.err.println("Exce in addCustomerActMap " + e.getMessage());
				e.printStackTrace();
			}

		}
		return mav;

	}

	// **************************Manual Task
	// ******************************************************************

	@RequestMapping(value = "/manualTaskAdd", method = RequestMethod.GET)
	public ModelAndView manualTaskAddForm(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		HttpSession session = request.getSession();
		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("manualTaskAdd", "manualTaskAdd", "1", "0", "0", "0", newModuleList);

		if (view.isError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {

			try {

				mav = new ModelAndView("task/manualTaskAdd");
				mav.addObject("title", " Add Manual Task");
				mav.addObject("taskType", 1);
				mav.addObject("isEdit", 0);
				CustomerDetails[] custHeadArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerInfo", CustomerDetails[].class);
				List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

				// System.out.println("cust is " + custHeadList.toString());
				mav.addObject("custList", custHeadList);

				ServiceMaster[] srvsMstr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllEnrolledServices", ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				mav.addObject("serviceList", srvcMstrList);
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map = new LinkedMultiValueMap<>();
				map.add("serviceId", srvcMstrList.get(0).getServId());

				FinancialYear[] fin = Constants.getRestTemplate().getForObject(Constants.url + "/getAllFinYear",
						FinancialYear[].class);
				List<FinancialYear> fyList = new ArrayList<FinancialYear>(Arrays.asList(fin));
				mav.addObject("fyList", fyList);
				EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
						EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				mav.addObject("epmList", epmList);
				Task task = new Task();
				mav.addObject("task", task);

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int empType = emp.getEmpType();
				mav.addObject("empType", empType);

			} catch (Exception e) {
				System.err.println("Exce in addCustomerActMap " + e.getMessage());
				e.printStackTrace();
			}

		}

		return mav;
	}

	@RequestMapping(value = "/editTask", method = RequestMethod.GET)
	public ModelAndView taskEdit(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		int flag = Integer.parseInt(request.getParameter("flag"));
		HttpSession session = request.getSession();

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info info = new Info();
		if (flag == 1) {
			info = AccessControll.checkAccess("editTask", "manualTaskList", "0", "0", "1", "0", newModuleList);

		} else {
			info = AccessControll.checkAccess("editTask", "inactiveTaskList", "0", "0", "1", "0", newModuleList);

		}

		if (info.isError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {

			try {
				mav = new ModelAndView("task/manualTaskAdd");

				mav.addObject("title", " Edit Task");

				String base64encodedString = request.getParameter("taskId");
				int taskId = Integer.parseInt(FormValidation.DecodeKey(base64encodedString));

				// System.out.println("flag is" + flag);
				mav.addObject("taskType", flag);
				mav.addObject("isEdit", 1);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
				map.add("taskId", taskId);
				Task task = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskByTaskIdForEdit1", map,
						Task.class);
				task.setTaskStatutoryDueDate(DateConvertor.convertToDMY(task.getTaskStatutoryDueDate()));
				task.setTaskStartDate(DateConvertor.convertToDMY(task.getTaskStartDate()));
				try {
					task.setTaskEndDate(DateConvertor.convertToDMY(task.getTaskEndDate()));
				} catch (Exception e) {
					task.setTaskEndDate("");
				}

				task.setEmpBudHr(HoursConversion.convertMinToHours(task.getEmpBudHr()));
				task.setMngrBudHr(HoursConversion.convertMinToHours(task.getMngrBudHr()));

				List<Integer> empIntList = Stream.of(task.getTaskEmpIds().split(",")).map(Integer::parseInt)
						.collect(Collectors.toList());

				mav.addObject("task", task);
				mav.addObject("empIntList", empIntList);

				CustomerDetails[] custHeadArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerInfoActiveInactive", CustomerDetails[].class);
				List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

				// System.out.println("cust is " + custHeadList.toString());
				mav.addObject("custList", custHeadList);

				ServiceMaster[] srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getAllServices",
						ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				mav.addObject("serviceList", srvcMstrList);
				map = new LinkedMultiValueMap<>();
				map = new LinkedMultiValueMap<>();
				map.add("serviceId", srvcMstrList.get(0).getServId());

				FinancialYear[] fin = Constants.getRestTemplate().getForObject(Constants.url + "/getAllFinYear",
						FinancialYear[].class);
				List<FinancialYear> fyList = new ArrayList<FinancialYear>(Arrays.asList(fin));
				mav.addObject("fyList", fyList);
				EmployeeMaster[] employee = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllEmployeesActiveInactive", EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				mav.addObject("epmList", epmList);
				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int empType = emp.getEmpType();
				mav.addObject("empType", empType);

			} catch (Exception e) {
				System.err.println("Exce in addCustomerActMap " + e.getMessage());
				e.printStackTrace();
			}
		}

		return mav;
	}

	@RequestMapping(value = "/manualTaskList", method = RequestMethod.GET)
	public ModelAndView manualTaskList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		ModelAndView mav = null;

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("manualTaskList", "manualTaskList", "1", "0", "0", "0", newModuleList);

		if (view.isError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {
			mav = new ModelAndView("task/manualTaskList");
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			// System.out.println("empType is "+emp.getEmpType());
			if (emp.getEmpType() == 3) {

				try {
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("stat", -1);
					map.add("empId", userId);
					GetTaskList[] holListArray = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getAllManualTaskList", map, GetTaskList[].class);

					List<GetTaskList> taskList = new ArrayList<>(Arrays.asList(holListArray));

					for (int i = 0; i < taskList.size(); i++) {

						taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
					}
					mav.addObject("taskList", taskList);
					// System.out.println("ManualTakList***"+taskList.toString());
					Info edit = AccessControll.checkAccess("manualTaskList", "manualTaskList", "0", "0", "1", "0",
							newModuleList);

					if (edit.isError() == false) {
						// //System.out.println(" edit Accessable ");
						mav.addObject("editAccess", 0);
					}
				} catch (Exception e) {
					System.err.println("Exce in addCustomerActMap " + e.getMessage());
					e.printStackTrace();
				}
			}
		}
		return mav;

	}

	@RequestMapping(value = "/updateManualTaskStatus", method = RequestMethod.GET)
	public String updateManualTaskStatus(HttpServletRequest request, HttpServletResponse response) {
		String redirect = null;
		try {

			String base64encodedString = request.getParameter("taskId");
			int taskId = Integer.parseInt(FormValidation.DecodeKey(base64encodedString));
			int stat = Integer.parseInt(request.getParameter("stat"));

			HttpSession session1 = request.getSession();
			int inactivePage = 0;
			try {
				inactivePage = (int) session1.getAttribute("inactivePage");
			} catch (Exception e) {
				inactivePage = 0;
			}
			EmployeeMaster emp = (EmployeeMaster) session1.getAttribute("empLogin");
			int userId = emp.getEmpId();

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("taskId", taskId);
			map.add("statusVal", stat);
			map.add("userId", userId);
			map.add("curDateTime", Constants.getCurDateTime());

			Task task = Constants.getRestTemplate().postForObject(Constants.url + "/updateManualTaskByTaskId", map,
					Task.class);
			if (task != null) {

				if (stat == 1) {
					FormValidation.updateTaskLog(TaskText.taskTex6, userId, taskId);
				} else if (stat == 0) {
					FormValidation.updateTaskLog(TaskText.taskTex5, userId, taskId);
				} else if (stat == 2) {
					FormValidation.updateTaskLog(TaskText.taskTex7, userId, taskId);
				}

			}

			redirect = "redirect:/manualTaskList";
			// "redirect:/communication?taskId=" + taskId;
			if (inactivePage == 1) {
				redirect = "redirect:/inactiveTaskList";
			}
		} catch (Exception e) {
			System.err.println("Exce in updateTaskStatus " + e.getMessage());
			e.printStackTrace();
		}

		return redirect;
	}

	/*
	 * @RequestMapping(value = "/addManualTask", method = RequestMethod.POST) public
	 * String submitUpdatedTask(Model model, HttpServletRequest request,
	 * HttpServletResponse response) { String a = null; try { HttpSession session =
	 * request.getSession();
	 * 
	 * EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
	 * String mnghr = request.getParameter("mgBudgetHr"); String emphr =
	 * request.getParameter("empBudgetHr"); String mnghr1=null; try { mnghr1 =
	 * HoursConversion.convertHoursToMin(mnghr); }catch (Exception e) {
	 * 
	 * } String emphr1 = HoursConversion.convertHoursToMin(emphr); //
	 * System.out.println("mnghr1" + mnghr1); // System.out.println("emphr1" +
	 * emphr1); int userId = emp.getEmpId(); int userType=emp.getEmpType(); int
	 * taskType = Integer.parseInt(request.getParameter("taskType"));
	 * CustmrActivityMap activityMapanual = new CustmrActivityMap(); StringBuilder
	 * sbEmp = new StringBuilder(); String[] locId2 =
	 * request.getParameterValues("empId2"); // System.err.println("emp id are " +
	 * locId2); for (int j = 0; j < locId2.length; j++) { sbEmp =
	 * sbEmp.append(locId2[j] + ",");
	 * 
	 * } String items1 = sbEmp.toString(); items1 = items1.substring(0,
	 * items1.length() - 1); int taskId = 0;
	 * 
	 * taskId = Integer.parseInt(request.getParameter("taskId"));
	 * 
	 * if (taskId != 0) { try { System.out.println("in task edit");
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
	 * Object>();
	 * 
	 * map.add("taskId", taskId); map.add("items1", items1); map.add("empBudgetHr",
	 * Integer.parseInt(emphr1)); map.add("mgBudgetHr", Integer.parseInt(mnghr1));
	 * map.add("startDate", request.getParameter("statDate")); map.add("customer",
	 * Integer.parseInt(request.getParameter("customer"))); map.add("service",
	 * Integer.parseInt(request.getParameter("service"))); map.add("periodicityId",
	 * Integer.parseInt(request.getParameter("periodicityId"))); map.add("activity",
	 * Integer.parseInt(request.getParameter("activity"))); map.add("userId",
	 * userId); map.add("curDateTime", Constants.getCurDateTime());
	 * map.add("statDate", request.getParameter("statDate")); map.add("billAmt",
	 * request.getParameter("billAmt"));
	 * 
	 * Info temp = Constants.getRestTemplate().postForObject(Constants.url +
	 * "/submitEditMannualTask", map, Info.class);
	 * 
	 * if (taskType == 1) { if(userType!=5) a = "redirect:/manualTaskList"; else
	 * a="redirect:/manualTaskAdd"; if (temp != null) {
	 * System.out.println("successMsg"); session.setAttribute("successMsg",
	 * "Manual Task Updated Successfully"); } else { System.out.println("errorMsg");
	 * session.setAttribute("errorMsg", "Failed to Update Manual Task"); }
	 * 
	 * } else { if(userType!=5) a = "redirect:/inactiveTaskList"; else { a =
	 * "redirect:/taskListForEmp"; } } } catch (Exception e) {
	 * System.err.println("Exce in addCustomerActMap " + e.getMessage());
	 * e.printStackTrace(); }
	 * 
	 * } else { try { if(userType!=5) a = "redirect:/manualTaskList"; else { a =
	 * "redirect:/taskListForEmp"; } System.out.println("in task add");
	 * activityMapanual.setMappingId(0);
	 * activityMapanual.setActvEmpBudgHr(Integer.parseInt(emphr1));
	 * activityMapanual.setActvStartDate(request.getParameter("statDate"));
	 * activityMapanual.setActvEndDate(request.getParameter("endDate"));
	 * 
	 * //activityMapanual.setActvManBudgHr(Integer.parseInt(mnghr1));
	 * activityMapanual.setActvStatutoryDays(Integer.parseInt(request.getParameter(
	 * "statutary_endDays")));
	 * activityMapanual.setCustId(Integer.parseInt(request.getParameter("customer"))
	 * ); activityMapanual.setDelStatus(1);
	 * activityMapanual.setExInt1(Integer.parseInt(request.getParameter("service")))
	 * ; activityMapanual.setExInt2(0); activityMapanual.setExVar1(items1);
	 * activityMapanual.setExVar2("NA");
	 * activityMapanual.setPeriodicityId(Integer.parseInt(request.getParameter(
	 * "periodicityId")));
	 * activityMapanual.setUpdateDatetime(Constants.getCurDateTime());
	 * activityMapanual.setUpdateUsername(userId);
	 * activityMapanual.setActvId(Integer.parseInt(request.getParameter("activity"))
	 * ); try {
	 * activityMapanual.setActvBillingAmt(Integer.parseInt(request.getParameter(
	 * "billAmt"))); }catch (Exception e) { activityMapanual.setActvBillingAmt(0); }
	 * 
	 * try { activityMapanual.setActvManBudgHr(Integer.parseInt(mnghr1)); }catch
	 * (Exception e) { activityMapanual.setActvManBudgHr(0); }
	 * 
	 * // System.out.println("Activity Map---------" + activityMapanual.toString());
	 * Info map = Constants.getRestTemplate().postForObject(Constants.url +
	 * "/saveMannualTask", activityMapanual, Info.class);
	 * 
	 * if (map.isError()==false) { session.setAttribute("successMsg",
	 * "Manual Task Added Successfully"); } else { session.setAttribute("errorMsg",
	 * "Failed to Add Manual Task"); }
	 * 
	 * } catch (Exception e) { System.err.println("Exce in addCustomerActMap " +
	 * e.getMessage()); e.printStackTrace(); }
	 * 
	 * }
	 * 
	 * } catch (Exception e) { System.err.println("Exce in addCustomerActMap " +
	 * e.getMessage()); e.printStackTrace(); }
	 * 
	 * return a;
	 * 
	 * }
	 */

	// Sachin 29-12-2019

	@RequestMapping(value = "/addManualTask", method = RequestMethod.POST)
	public String submitUpdatedTask(Model model, HttpServletRequest request, HttpServletResponse response) {
		String a = null;
		try {
			HttpSession session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			String mnghr = request.getParameter("mgBudgetHr");
			String emphr = request.getParameter("empBudgetHr");
			String mnghr1 = null;
			try {
				mnghr1 = HoursConversion.convertHoursToMin(mnghr);
			} catch (Exception e) {
				mnghr1 = "0";
			}
			String emphr1 = HoursConversion.convertHoursToMin(emphr);
			// System.out.println("mnghr1" + mnghr1);
			// System.out.println("emphr1" + emphr1);
			int userId = emp.getEmpId();
			int userType = emp.getEmpType();
			int taskType = Integer.parseInt(request.getParameter("taskType"));
			CustmrActivityMap activityMapanual = new CustmrActivityMap();
			StringBuilder sbEmp = new StringBuilder();
			String[] locId2 = request.getParameterValues("empId2");
			// System.err.println("emp id are " + locId2);
			for (int j = 0; j < locId2.length; j++) {
				sbEmp = sbEmp.append(locId2[j] + ",");

			}
			String items1 = sbEmp.toString();
			items1 = items1.substring(0, items1.length() - 1);
			int taskId = 0;

			taskId = Integer.parseInt(request.getParameter("taskId"));
String taskComment=request.getParameter("task_comment");
			if (taskId != 0) {
				try {
					System.out.println("in task edit");
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

					map.add("taskId", taskId);
					map.add("items1", items1);
					map.add("empBudgetHr", Integer.parseInt(emphr1));
					map.add("mgBudgetHr", Integer.parseInt(mnghr1));
					map.add("startDate", request.getParameter("endDate"));
					map.add("customer", Integer.parseInt(request.getParameter("customer")));
					map.add("service", Integer.parseInt(request.getParameter("service")));
					map.add("periodicityId", Integer.parseInt(request.getParameter("periodicityId")));
					map.add("activity", Integer.parseInt(request.getParameter("activity")));
					map.add("userId", userId);
					map.add("curDateTime", Constants.getCurDateTime());
					map.add("statDate", request.getParameter("statDate"));
					map.add("billAmt", request.getParameter("billAmt"));
					
					map.add("taskComment", taskComment.trim());
					Info temp = Constants.getRestTemplate().postForObject(Constants.url + "/submitEditMannualTask", map,
							Info.class);

					if (taskType == 1) {
						if (userType != 5)
							a = "redirect:/manualTaskList";
						else
							a = "redirect:/manualTaskAdd";
						if (temp != null) {
							System.out.println("successMsg");
							session.setAttribute("successMsg", "Manual Task Updated Successfully");
						} else {
							System.out.println("errorMsg");
							session.setAttribute("errorMsg", "Failed to Update Manual Task");
						}

					} else {
						if (userType != 5)
							a = "redirect:/inactiveTaskList";
						else {
							a = "redirect:/taskListForEmp";
						}
					}
				} catch (Exception e) {
					System.err.println("Exce in addCustomerActMap " + e.getMessage());
					e.printStackTrace();
				}

			} else {
				try {
					if (userType != 5)
						a = "redirect:/manualTaskList";
					else {
						a = "redirect:/taskListForEmp";
					}
					System.out.println("in task add");

					/*
					 * Task task=new Task();
					 * task.setActvId(Integer.parseInt(request.getParameter("activity")));
					 * 
					 * task.setBillingAmt(request.getParameter("billAmt"));
					 * task.setCustId(Integer.parseInt(request.getParameter("customer")));
					 * task.setDelStatus(1); task.setEmpBudHr(emphr1); task.setExInt1(1);
					 * task.setExInt2(1); task.setExVar1("NA"); task.setIsActive(1);
					 * task.setMappingId(18); task.setMngrBudHr(mnghr);
					 * task.setPeriodicityId(Integer.parseInt(request.getParameter("periodicityId"))
					 * ); task.setServId(servId); task.setTaskCode(taskCode);
					 * task.setTaskCompletionDate(taskCompletionDate); task.setTaskEmpIds(items1);
					 * task.setTaskEndDate(taskEndDate); task.setTaskFyId(taskFyId);
					 * task.setTaskId(0); task.setTaskStartDate(taskStartDate);
					 * task.setTaskStatus(taskStatus);
					 * task.setTaskStatutoryDueDate(taskStatutoryDueDate);
					 * task.setTaskSubline("na"); task.setTaskText(taskText);
					 * task.setUpdateDatetime(updateDatetime);
					 * 
					 * task.setUpdateUsername();
					 */

					activityMapanual.setMappingId(0);
					activityMapanual.setActvEmpBudgHr(Integer.parseInt(emphr1));
					activityMapanual.setActvStartDate(request.getParameter("statDate"));
					activityMapanual.setActvEndDate(request.getParameter("endDate"));

					// activityMapanual.setActvManBudgHr(Integer.parseInt(mnghr1));
					activityMapanual.setActvStatutoryDays(Integer.parseInt(request.getParameter("statutary_endDays")));
					activityMapanual.setCustId(Integer.parseInt(request.getParameter("customer")));
					activityMapanual.setDelStatus(1);
					activityMapanual.setExInt1(Integer.parseInt(request.getParameter("service")));
					activityMapanual.setExInt2(0);
					activityMapanual.setExVar1(items1);
					activityMapanual.setExVar2(taskComment.trim());
					activityMapanual.setPeriodicityId(Integer.parseInt(request.getParameter("periodicityId")));
					activityMapanual.setUpdateDatetime(Constants.getCurDateTime());
					activityMapanual.setUpdateUsername(userId);
					activityMapanual.setActvId(Integer.parseInt(request.getParameter("activity")));
					try {
						activityMapanual.setActvBillingAmt(Integer.parseInt(request.getParameter("billAmt")));
					} catch (Exception e) {
						activityMapanual.setActvBillingAmt(0);
					}

					try {
						activityMapanual.setActvManBudgHr(Integer.parseInt(mnghr1));
					} catch (Exception e) {
						activityMapanual.setActvManBudgHr(0);
					}

					// System.out.println("Activity Map---------" + activityMapanual.toString());
					Info map = Constants.getRestTemplate().postForObject(Constants.url + "/saveMannualTask",
							activityMapanual, Info.class);

					if (map.isError() == false) {
						session.setAttribute("successMsg", "Manual Task Added Successfully");
					} else {
						session.setAttribute("errorMsg", "Failed to Add Manual Task");
					}

				} catch (Exception e) {
					System.err.println("Exce in addCustomerActMap " + e.getMessage());
					e.printStackTrace();
				}

			}

		} catch (Exception e) {
			System.err.println("Exce in addCustomerActMap " + e.getMessage());
			e.printStackTrace();
		}

		return a;

	}

	// ******************Home task list task edit*********************************

	@RequestMapping(value = "/getTaskByTaskIdForEdit", method = RequestMethod.GET)
	public @ResponseBody TempForTaskEdit getTaskByTaskIdForEdit(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		TempForTaskEdit logList = new TempForTaskEdit();

		try {
			int taskId = Integer.parseInt(request.getParameter("taskId"));
			// System.out.println("getDailyWorkLogByEmpId ----- Service Called " + taskId);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);
			Task task = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskByTaskIdForEdit1", map,
					Task.class);
			task.setEmpBudHr(HoursConversion.convertMinToHours(task.getEmpBudHr()));
			task.setMngrBudHr(HoursConversion.convertMinToHours(task.getMngrBudHr()));

			task.setTaskStatutoryDueDate(DateConvertor.convertToDMY(task.getTaskStatutoryDueDate()));
			try {
				task.setTaskEndDate(DateConvertor.convertToDMY(task.getTaskEndDate()));
			} catch (Exception e) {
				// task.setTaskEndDate(DateConvertor.convertToDMY(""));
				task.setTaskEndDate("");
			}

			logList.setTask(task);
			// System.out.println(" task----------"+task.toString());
			EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
					EmployeeMaster[].class);
			List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));

			logList.setTask(task);
			logList.setEmpList(epmList);
			List<Integer> actIntList = new ArrayList<Integer>();
			String[] result = (task.getTaskEmpIds().split(","));
			for (int j = 0; j < result.length; j++) {

				actIntList.add(Integer.parseInt(result[j]));

			}
			logList.setEmpId(actIntList);

			// System.out.println(" actIntList----------"+actIntList.toString());

		} catch (Exception e) {
			System.err.println("Exce in workLogList " + e.getMessage());
			e.printStackTrace();
		}
		return logList;
	}

	@RequestMapping(value = "/submitUpdatedTask", method = RequestMethod.POST)
	public @ResponseBody Info addManualTask(HttpServletRequest request, HttpServletResponse response) {
		System.err.println("Hello sachin");
		Info res = new Info();
		try {

			HttpSession session = request.getSession();
			System.err.println("emp hii");
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

			int userId = emp.getEmpId();

			CustmrActivityMap activityMapanual = new CustmrActivityMap();
			StringBuilder sbEmp = new StringBuilder();
			// System.err.println("emp id are " + locId2);

			String emp1 = request.getParameter("emp");
			System.err.println("emp id are " + emp1);

			emp1 = emp1.substring(1, emp1.length() - 1);
			emp1 = emp1.replaceAll("\"", "");
			String items1 = emp1;
			System.err.println("emp items1 are " + items1);
			String empHr = request.getParameter("empBudHr");
			String mngHr = request.getParameter("manBudHr");
			String mnghr1 = new String();
			String emphr1 = new String();

			mnghr1 = HoursConversion.convertHoursToMin(mngHr);
			emphr1 = HoursConversion.convertHoursToMin(empHr);

			String dueDate = request.getParameter("dueDate");
			String workDate = request.getParameter("workDate");
			System.err.println("date " + workDate);
			String bilAmt = request.getParameter("bilAmt");

			String taskId = request.getParameter("taskId1");
			if (workDate != null && workDate != "") {
				System.err.println("In if ");

				workDate = DateConvertor.convertToYMD(workDate);
			} else {
				System.err.println("In else ");
				workDate = "null";
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);
			map.add("empHr", emphr1);
			map.add("mngHr", mnghr1);
			map.add("dueDate", DateConvertor.convertToYMD(dueDate));
			map.add("workDate", workDate);
			map.add("empId", items1);
			map.add("updateUserName", userId);
			map.add("updateDateTime", Constants.getCurDateTime());

			map.add("bilAmt", bilAmt);

			res = Constants.getRestTemplate().postForObject(Constants.url + "/updateEditTsk", map, Info.class);

		} catch (Exception e) {
			System.err.println("Exce in addCustomerActMap " + e.getMessage());
			e.printStackTrace();
		}

		return res;

	}

	
	
	//Sachin 11-04-2020
	@RequestMapping(value = "/updateTaskAssignPage", method = RequestMethod.POST)
	public @ResponseBody Info updateTaskAssignPage(HttpServletRequest request, HttpServletResponse response) {
		System.err.println("Hello sachin updateTaskAssignPage");
		Info res = new Info();
		try {

			HttpSession session = request.getSession();
			System.err.println("emp hii");
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

			int userId = emp.getEmpId();


			String empHr = request.getParameter("empBudHr");
			String mngHr = request.getParameter("manBudHr");
			String mnghr1 = new String();
			String emphr1 = new String();

			mnghr1 = HoursConversion.convertHoursToMin(mngHr);
			emphr1 = HoursConversion.convertHoursToMin(empHr);

			String dueDate = request.getParameter("dueDate");
			String workDate = request.getParameter("workDate");
			String bilAmt = request.getParameter("bilAmt");

			String taskId = request.getParameter("taskId1");
			if (workDate != null && workDate != "") {
				System.err.println("In if ");

				workDate = DateConvertor.convertToYMD(workDate);
			} else {
				System.err.println("In else ");
				workDate = "null";
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);
			map.add("empHr", emphr1);
			map.add("mngHr", mnghr1);
			map.add("dueDate", DateConvertor.convertToYMD(dueDate));
			map.add("workDate", workDate);
			map.add("updateUserName", userId);
			map.add("updateDateTime", Constants.getCurDateTime());

			map.add("bilAmt", bilAmt);

			res = Constants.getRestTemplate().postForObject(Constants.url + "/editTaskOnAssignPage", map, Info.class);

		} catch (Exception e) {
			System.err.println("Exce in addCustomerActMap " + e.getMessage());
			e.printStackTrace();
		}

		return res;

	}

	
	// *************************Forgot
	// Pass***********************************************

	@RequestMapping(value = "/showForgotPass", method = RequestMethod.GET)
	public ModelAndView showForgotPassForm(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		try {

			model = new ModelAndView("forgetPassword");

		} catch (Exception e) {

			System.err.println("exception In showCMSForm at home Contr" + e.getMessage());

			e.printStackTrace();

		}

		return model;

	}

	@RequestMapping(value = "/checkUserPassword", method = RequestMethod.POST)
	public String checkUserPassword(HttpServletRequest request, HttpServletResponse response) {
		String c = null;
		System.err.println("Hiii  checkValue  ");
		Info info = new Info();
		ModelAndView model = new ModelAndView();
		HttpSession session = request.getSession();
		try {
			// model = new ModelAndView("forgotPassword");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			String inputValue = request.getParameter("username");
			System.err.println("Info inputValue  " + inputValue);

			map.add("inputValue", inputValue);
			info = Constants.getRestTemplate().postForObject(Constants.url + "checkUserName", map, Info.class);
			System.err.println("get GetUserData" + info.toString());

			if (info.isError() == true) {
				// model = new ModelAndView("forgotPassword");
				c = "redirect:/showForgotPass";
				// model.addObject("msg", "Invalid User Name");
				session.setAttribute("errorPassMsg", "Invalid User Name or Contact Number");

			} else {
				// model = new ModelAndView("login");
				c = "redirect:/";
				session.setAttribute("errorPassMsg", "Password has been sent to your Email.");
				// model.addObject("msg", "Password has been sent to your email");

			}

		} catch (Exception e) {
			System.err.println("Exce in checkUniqueField  " + e.getMessage());
			e.printStackTrace();
		}

		return c;

	}

	// *******************************************Cmpleted
	// Task*************************************

	@RequestMapping(value = "/completedTaskList", method = RequestMethod.GET)
	public ModelAndView completedTaskList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		ModelAndView mav = null;

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("completedTaskList", "completedTaskList", "1", "0", "0", "0",
				newModuleList);

		if (view.isError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {
			mav = new ModelAndView("task/completedTaskList");
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			// System.out.println("empType is "+emp.getEmpType());

			try {

				ServiceMaster[] srvsMstr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllEnrolledServices", ServiceMaster[].class);
				List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
				mav.addObject("serviceList", srvcMstrList);

				CustomerDetails[] custHeadArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerInfo", CustomerDetails[].class);
				List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

				mav.addObject("custList", custHeadList);

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				StringBuilder sbCust = new StringBuilder();
				String[] custList = null;
				int servId = 0;
				StringBuilder sbAct = new StringBuilder();
				String[] actList = null;
				String itemsCust = null;
				String itemsAct = null;

				try {
					servId = Integer.parseInt(request.getParameter("service"));
				} catch (Exception e) {

					servId = 0;

				}

				map = new LinkedMultiValueMap<>();
				map.add("serviceId", servId);

				ActivityMaster[] activityArr = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllActivitesByServiceId", map, ActivityMaster[].class);
				List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));
				mav.addObject("activityList", activityList);

				try {
					sbAct = new StringBuilder();
					actList = request.getParameterValues("activity");
					// System.err.println("emp id are " + locId2);
					for (int j = 0; j < actList.length; j++) {
						sbAct = sbAct.append(actList[j] + ",");
					}
					itemsAct = sbAct.toString();
					itemsAct = itemsAct.substring(0, itemsAct.length() - 1);
				} catch (Exception e) {

					itemsAct = "0";
				}
				List<Integer> actIntList = Stream.of(itemsAct.split(",")).map(Integer::parseInt)
						.collect(Collectors.toList());
				mav.addObject("actIntList", actIntList);
				try {
					sbCust = new StringBuilder();
					custList = request.getParameterValues("customer");

					for (int j = 0; j < custList.length; j++) {
						sbCust = sbCust.append(custList[j] + ",");

					}
					itemsCust = sbCust.toString();
					itemsCust = sbCust.substring(0, itemsCust.length() - 1);

				} catch (Exception e) {

					itemsCust = "0";

				}

				List<Integer> custIntList = Stream.of(itemsCust.split(",")).map(Integer::parseInt)
						.collect(Collectors.toList());

				// for dropdown
				mav.addObject("actIntList", actIntList);
				mav.addObject("custIdList", custIntList);
				mav.addObject("servId", servId);

				// Prev
				map = new LinkedMultiValueMap<>();
				map.add("stat", 9);
				map.add("empId", userId);
				map.add("itemsAct", itemsAct);
				map.add("custId", itemsCust);
				map.add("servId", servId);
				GetTaskList[] holListArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllCompletedTaskList", map, GetTaskList[].class);

				List<GetTaskList> taskList = new ArrayList<>(Arrays.asList(holListArray));

				for (int i = 0; i < taskList.size(); i++) {

					// taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
				}
				mav.addObject("taskList", taskList);
				System.out.println("CompletedTakList***Sac" + taskList.toString());
			} catch (Exception e) {
				System.err.println("Exce in CompletedTakList " + e.getMessage());
				e.printStackTrace();
			}

		}
		return mav;

	}

	@RequestMapping(value = "/reopenTaskStatus", method = RequestMethod.GET)
	public String reopenTaskStatus(HttpServletRequest request, HttpServletResponse response, Model model) {
		try {
			HttpSession session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

			int userId = emp.getEmpId();

			int taskId = Integer.parseInt(request.getParameter("taskId"));
			logger.info("TaskId----------------" + taskId);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);
			map.add("empId", userId);
			map.add("updateUserName", userId);
			map.add("updateDateTime", Constants.getCurDateTime());

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/reopenTaskByTaskId", map,
					Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Task Reopened Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Reopened Task");
			}
		} catch (Exception e) {
			System.err.println("Exce in reopenTaskStatus " + e.getMessage());
			e.printStackTrace();
		}

		return "redirect:/completedTaskList";

	}

	@RequestMapping(value = "/updateCompletedTaskStatus", method = RequestMethod.GET)
	public String activeDeactiveService(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "task/updateCompTaskStatus";

		try {
			String base64encodedString = request.getParameter("taskId");
			int taskId = Integer.parseInt(FormValidation.DecodeKey(base64encodedString));

			model.addAttribute("taskId", taskId);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);
			Task task = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskByTaskIdForEdit1", map,
					Task.class);
			task.setEmpBudHr(HoursConversion.convertMinToHours(task.getEmpBudHr()));
			task.setMngrBudHr(HoursConversion.convertMinToHours(task.getMngrBudHr()));
			model.addAttribute("task", task);

		} catch (Exception e) {
			e.getMessage();
		}

		return mav;
	}

	@RequestMapping(value = "/updateCompletdStatus", method = RequestMethod.POST)
	public String updateActivityIsActiveStatus(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session1 = request.getSession();

		EmployeeMaster emp = (EmployeeMaster) session1.getAttribute("empLogin");
		int userId = emp.getEmpId();

		try {
			int isStatus = Integer.parseInt(request.getParameter("isStatus"));
			int taskId = Integer.parseInt(request.getParameter("taskId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("taskId", taskId);
			map.add("statusVal", isStatus);
			map.add("curDateTime", Constants.getCurDateTime());
			map.add("userId", userId);

			Info updateIsActiveStatus = Constants.getRestTemplate()
					.postForObject(Constants.url + "/updateCompletedTaskByTaskId", map, Info.class);

			if (updateIsActiveStatus != null) {
				FormValidation.updateTaskLog(TaskText.taskTex8, userId, taskId);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/completedTaskList";
	}

	@RequestMapping(value = "/submitUpdateCompletedTask", method = RequestMethod.POST)
	public String submitUpdateCompletedTask(HttpServletRequest request, HttpServletResponse response) {

		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		try {

			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			String stat = null;
			try {
				stat = request.getParameter("isStatus");
			} catch (Exception e) {
				e.printStackTrace();
				stat = " ";
			}
			// System.out.println("work date**" + workDate);

			String[] TaskId = request.getParameterValues("TaskId");

			StringBuilder sb = new StringBuilder();

			for (int i = 0; i < TaskId.length; i++) {
				sb = sb.append(TaskId[i] + ",");

				// System.out.println("task id are**" + TaskId[i]);

			}

			String items = sb.toString();

			items = items.substring(0, items.length() - 1);

			map.add("taskId", items);
			map.add("stat", stat);
			map.add("curDateTime", Constants.getCurDateTime());
			map.add("userId", userId);

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateCompletedTask", map,
					Info.class);

			if (info.isError() == false) {

				for (int i = 0; i < TaskId.length; i++) {
					FormValidation.updateTaskLog(TaskText.taskTex8, userId, Integer.parseInt(TaskId[i]));
				}
				session.setAttribute("successMsg", Constants.Sucessmsg);
			} else {

				session.setAttribute("errorMsg", Constants.Failmsg);
			}

		} catch (Exception e) {
			System.err.println("Exce in Saving Cust Login Detail " + e.getMessage());
			e.printStackTrace();
		}

		return "redirect:/completedTaskList";
	}

	@RequestMapping(value = "/taskListForEmpFromDash", method = RequestMethod.GET)
	public ModelAndView taskListForEmpForm(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		ModelAndView mav = new ModelAndView("task/homeTaskList");
		try {

			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
			mav.addObject("empType", empSes.getEmpType());

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map.add("empId", empSes.getEmpId());
			map.add("stat", 1);

			TaskListHome[] taskArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getTaskListByEmpIdAndDashCountOverDue", map, TaskListHome[].class);
			List<TaskListHome> taskList = new ArrayList<TaskListHome>(Arrays.asList(taskArr));

			for (int i = 0; i < taskList.size(); i++) {

				taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
				taskList.get(i).setExVar2(FormValidation.Encrypt(String.valueOf(empSes.getEmpId())));
			}

			mav.addObject("taskList", taskList);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/managerTask", method = RequestMethod.GET)
	public ModelAndView managerTask(Locale locale, Model model) {

		// ModelAndView mav = new ModelAndView("login");

		ModelAndView mav = new ModelAndView("managerTask");

		return mav;
	}

	@RequestMapping(value = "/employeeTask", method = RequestMethod.GET)
	public ModelAndView employeeTask(Locale locale, Model model) {

		// ModelAndView mav = new ModelAndView("login");

		ModelAndView mav = new ModelAndView("employeeTask");

		return mav;
	}

	/******************** Add Emp Hours 1 **************************/
	List<GetTaskList> taskList = null;

	/*
	 * @RequestMapping(value = "/addEmpHrs", method = RequestMethod.GET) public
	 * String addEmpHrs(HttpServletRequest request, HttpServletResponse response,
	 * Model model) { //String mav = "task/addEmpHrs"; String mav =
	 * "task/addEmpWorkLog"; try {
	 * 
	 * ServiceMaster[] srvsMstr = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getAllEnrolledServices",
	 * ServiceMaster[].class); List<ServiceMaster> srvcMstrList = new
	 * ArrayList<>(Arrays.asList(srvsMstr)); model.addAttribute("serviceList",
	 * srvcMstrList);
	 * 
	 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
	 * map.add("serviceId", srvcMstrList.get(0).getServId());
	 * 
	 * ActivityMaster[] activityArr = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getAllEnrolledActivitesByServiceId", map,
	 * ActivityMaster[].class); List<ActivityMaster> activityList = new
	 * ArrayList<>(Arrays.asList(activityArr)); model.addAttribute("actList",
	 * activityList);
	 * 
	 * CustomerDetails[] custHeadArr = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getAllCustomerInfoActiveInactive",
	 * CustomerDetails[].class); List<CustomerDetails> custHeadList = new
	 * ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));
	 * model.addAttribute("custHeadList", custHeadList);
	 * 
	 * EmployeeMaster[] employee = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getAllEmployeesActiveInactive",
	 * EmployeeMaster[].class); List<EmployeeMaster> epmList = new
	 * ArrayList<EmployeeMaster>(Arrays.asList(employee));
	 * model.addAttribute("epmList", epmList);
	 * 
	 * } catch (Exception e) { System.err.println("Exception in addEmpHrs" +
	 * e.getMessage()); }
	 * 
	 * return mav; }
	 */

	@RequestMapping(value = "/getEmpWorkLogs", method = RequestMethod.GET)
	public @ResponseBody List<GetTaskList> getEmpWorkLogs(HttpServletRequest request) {
		int emp = Integer.parseInt(request.getParameter("emp"));
		// int service = Integer.parseInt(request.getParameter("service"));
		// int activity = Integer.parseInt(request.getParameter("activity"));
		// int customer = Integer.parseInt(request.getParameter("customer"));

		// System.out.println("Vals---------"+emp+" "+service+" "+" "+activity+"
		// "+customer);

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		map.add("stat", 9);
		map.add("emp", emp);
		// map.add("service", service);
		// map.add("activity", activity);
		// map.add("customer", customer);

		GetTaskList[] holListArray = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskListForWorkLog",
				map, GetTaskList[].class);

		taskList = new ArrayList<>(Arrays.asList(holListArray));

		// System.out.println("List Work log-----------" + taskList);
		return taskList;

	}

	/************* Save Emp Hrs ***************/
	@RequestMapping(value = "/addEmpWorkHrs", method = RequestMethod.POST)
	public String addEmpWorkHrs(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		try {
			session = request.getSession();
			EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");

			int logId = 0;
			try {
				logId = Integer.parseInt(request.getParameter("logId"));
			} catch (Exception e) {
				e.getMessage();
			}

			DailyWorkLog workLog = new DailyWorkLog();
			String hrs = request.getParameter("workHour");
			String mnghr1 = HoursConversion.convertHoursToMin(hrs);

			workLog.setDelStatus(1);
			workLog.setEmpId(Integer.parseInt(request.getParameter("empId")));
			workLog.setExInt1(0);
			workLog.setExInt2(0);
			workLog.setExVar1("NA");
			workLog.setExVar2("NA");
			workLog.setTaskId(Integer.parseInt(request.getParameter("taskId")));
			workLog.setUpdateDatetime(curDateTime);
			workLog.setUpdateUsername(empSes.getEmpId());
			workLog.setWorkDate(request.getParameter("workDate"));
			workLog.setWorkHours(mnghr1);
			workLog.setWorkLogId(logId);
			workLog.setWorkRemark(request.getParameter("remark"));
			// System.out.println("Logssss------"+workLog);
			DailyWorkLog logData = Constants.getRestTemplate().postForObject(Constants.url + "/addNewWorkLog", workLog,
					DailyWorkLog.class);

		} catch (Exception e) {
			System.err.println("Exce in newWorkLog " + e.getMessage());
			e.printStackTrace();
		}

		return "redirect:/addEmpHrs";

	}

	/********************** Add Emp Hours2 **********************************/

	@RequestMapping(value = "/addEmpHrs", method = RequestMethod.GET)
	public String addEmpHrs(HttpServletRequest request, HttpServletResponse response, Model model,
			HttpSession session) {
		String mav = null;

		session = request.getSession();
		EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");

		if (empSes.getEmpType() == 1 || empSes.getEmpType() == 2) {
			mav = "task/addEmpWorkLog";
		} else {
			mav = "accessDenied";
		}
		try {

			ServiceMaster[] srvsMstr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllEnrolledServices", ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			model.addAttribute("serviceList", srvcMstrList);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("serviceId", srvcMstrList.get(0).getServId());

			ActivityMaster[] activityArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllEnrolledActivitesByServiceId", map, ActivityMaster[].class);
			List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));
			model.addAttribute("actList", activityList);

			CustomerDetails[] custHeadArr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllCustomerInfoActiveInactive", CustomerDetails[].class);
			List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));
			model.addAttribute("custHeadList", custHeadList);

			EmployeeMaster[] employee = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllEmployeesActiveInactive", EmployeeMaster[].class);
			List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
			model.addAttribute("epmList", epmList);

		} catch (Exception e) {
			System.err.println("Exception in addEmpHrs" + e.getMessage());
		}

		return mav;
	}

	@RequestMapping(value = "/getEmpWorkHoursLogs", method = RequestMethod.GET)
	public @ResponseBody List<EmpWorkLogHrs> getEmpWorkHoursLogs(HttpServletRequest request) {
		List<EmpWorkLogHrs> empWrkLogList = null;
		try {

			int activity = 0;

			int emp = Integer.parseInt(request.getParameter("emp"));
			int service = Integer.parseInt(request.getParameter("service"));

			try {
				activity = Integer.parseInt(request.getParameter("activity"));
			} catch (Exception e) {
				e.getMessage();
			}

			int customer = Integer.parseInt(request.getParameter("customer"));
			String fromDate = request.getParameter("fromDate");

			// System.out.println("Hi---------"+emp+" "+fromDate+" "+service+" "+"
			// "+activity+" "+customer);

			String[] dates = fromDate.split("to");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("stat", 9);
			map.add("fromDate", DateConvertor.convertToYMD(dates[0]));
			map.add("toDate", DateConvertor.convertToYMD(dates[1]));
			map.add("emp", emp);
			map.add("service", service);
			map.add("activity", activity);
			map.add("customer", customer);

			EmpWorkLogHrs[] empWrkLogArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getTaskDailyWorkLog", map, EmpWorkLogHrs[].class);

			empWrkLogList = new ArrayList<>(Arrays.asList(empWrkLogArr));

			System.out.println("List Work log-----------" + empWrkLogList);
		} catch (Exception e) {
			System.err.println("Exception in  getEmpWorkHoursLogs : " + e.getMessage());
			e.printStackTrace();

		}
		return empWrkLogList;

	}

	/*
	 * @RequestMapping(value = "/editworkLog", method = RequestMethod.GET)
	 * public @ResponseBody ModelAndView getDailyWorkLogByEmpId(HttpServletRequest
	 * request, HttpServletResponse response, HttpSession session, Model model) {
	 * DailyWorkLog hrLog = null;
	 * 
	 * ModelAndView mav = new ModelAndView("task/addEmpWorkLog"); try { int logId =
	 * Integer.parseInt(request.getParameter("logId"));
	 * System.out.println("editworkLog ----- Service Called "+ logId);
	 * MultiValueMap<String, Object> map = null;
	 * 
	 * session = request.getSession();
	 * 
	 * EmployeeMaster empSes = (EmployeeMaster) session.getAttribute("empLogin");
	 * map = new LinkedMultiValueMap<>(); map.add("logId", logId);
	 * 
	 * hrLog = Constants.getRestTemplate().postForObject(Constants.url +
	 * "/getWorkLogById", map, DailyWorkLog.class);
	 * 
	 * 
	 * System.out.println("Log List----------"+hrLog.toString());
	 * mav.addObject("isEdit", 1); mav.addObject("logList", hrLog);
	 * 
	 * ServiceMaster[] srvsMstr = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getAllEnrolledServices",
	 * ServiceMaster[].class); List<ServiceMaster> srvcMstrList = new
	 * ArrayList<>(Arrays.asList(srvsMstr)); mav.addObject("serviceList",
	 * srvcMstrList);
	 * 
	 * map = new LinkedMultiValueMap<>(); map.add("serviceId",
	 * srvcMstrList.get(0).getServId());
	 * 
	 * ActivityMaster[] activityArr = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getAllEnrolledActivitesByServiceId", map,
	 * ActivityMaster[].class); List<ActivityMaster> activityList = new
	 * ArrayList<>(Arrays.asList(activityArr)); mav.addObject("actList",
	 * activityList);
	 * 
	 * CustomerDetails[] custHeadArr = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getAllCustomerInfoActiveInactive",
	 * CustomerDetails[].class); List<CustomerDetails> custHeadList = new
	 * ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));
	 * mav.addObject("custHeadList", custHeadList);
	 * 
	 * EmployeeMaster[] employee = Constants.getRestTemplate()
	 * .getForObject(Constants.url + "/getAllEmployeesActiveInactive",
	 * EmployeeMaster[].class); List<EmployeeMaster> epmList = new
	 * ArrayList<EmployeeMaster>(Arrays.asList(employee)); mav.addObject("epmList",
	 * epmList);
	 * 
	 * } catch (Exception e) { System.err.println("Exce in editworkLog " +
	 * e.getMessage()); e.printStackTrace(); } return mav; }
	 */

	@RequestMapping(value = "/getDailyWorkLogById", method = RequestMethod.GET)
	public @ResponseBody DailyWorkLog getDailyWorkLogById(HttpServletRequest request, HttpServletResponse response) {
		DailyWorkLog hrLog = null;
		try {
			int logId = Integer.parseInt(request.getParameter("logId"));
			// System.out.println("editworkLog ----- Service Called "+ logId);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map.add("logId", logId);

			hrLog = Constants.getRestTemplate().postForObject(Constants.url + "/getWorkLogHrsById", map,
					DailyWorkLog.class);

		} catch (Exception e) {
			System.err.println("Exce in getDailyWorkLogById " + e.getMessage());
		}
		return hrLog;

	}

	/***************** Customer Activity Mapping Master ****************/

	@RequestMapping(value = "/customerActivityAddMap", method = RequestMethod.GET)
	public ModelAndView customerActivityAddMapForm(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = null;
		MultiValueMap<String, Object> map = null;
		try {
			mav = new ModelAndView("master/customerActivityAddMap");

			String base64encodedString = request.getParameter("custId");
			String custId = FormValidation.DecodeKey(base64encodedString);
			// int custId = Integer.parseInt(request.getParameter("custId"));

			map = new LinkedMultiValueMap<>();
			map.add("custId", custId);

			// CustomerDetails cust =
			// Constants.getRestTemplate().postForObject(Constants.url + "/getcustById",
			// map,
			// CustomerDetails.class);
			CustNameId cust = Constants.getRestTemplate().postForObject(Constants.url + "/getCustNameById", map,
					CustNameId.class);
			System.err.println("ActMap--------------" + cust.toString());
			mav.addObject("cust", cust);

			ServiceMaster[] srvsMstr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllEnrolledServices", ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);

			map = new LinkedMultiValueMap<>();
			map.add("serviceId", srvcMstrList.get(0).getServId());

			ActivityMaster[] activityArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllEnrolledActivitesByServiceId", map, ActivityMaster[].class);
			List<ActivityMaster> activityList = new ArrayList<>(Arrays.asList(activityArr));
			mav.addObject("actList", activityList);

		} catch (Exception e) {
			System.err.println("Exce in customerActivityAddMap " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}

	List<Task> taskTempList = new ArrayList<Task>();
	CustmrActivityMap activityMap = new CustmrActivityMap();

	@RequestMapping(value = "/addCustomerActMap", method = RequestMethod.POST)
	public ModelAndView addCustomerActMap(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = null;
		MultiValueMap<String, Object> map = null;
		taskTempList = new ArrayList<Task>();
		mav = new ModelAndView("task/taskGenList");
		List<Task> custActMapList = null;
		try {

			HttpSession session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

			int userId = emp.getEmpId();
			String edate = new String();
			String edate1 = new String();
			activityMap = new CustmrActivityMap();
			if (request.getParameter("endDate") != "" && request.getParameter("endDate") != null) {
				edate = DateConvertor.convertToYMD(request.getParameter("endDate"));
				edate1 = request.getParameter("endDate");
				activityMap.setActvEndDate(edate1);
			} else {
				FinancialYear srvsMstr = Constants.getRestTemplate().getForObject(Constants.url + "/getCurrentFinYear",
						FinancialYear.class);
				edate = srvsMstr.getFinEndDate();
				activityMap.setActvEndDate(DateConvertor.convertToDMY(edate));
			}

			activityMap.setMappingId(0);
			activityMap.setActvBillingAmt(Integer.parseInt(request.getParameter("billAmt")));
			activityMap.setActvEmpBudgHr(
					Integer.parseInt(HoursConversion.convertHoursToMin(request.getParameter("empBudgetHr"))));
			activityMap.setActvStartDate(request.getParameter("startDate"));

			activityMap.setActvManBudgHr(
					Integer.parseInt(HoursConversion.convertHoursToMin(request.getParameter("mgBudgetHr"))));
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

			// task generation work start
			int totdays = 0;
			//Sachin 10-04-2020
			map = new LinkedMultiValueMap<>();
			map.add("custHeadId", activityMap.getCustId());

			CustomerHeaderMaster custHead = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getCustomerHeadById", map, CustomerHeaderMaster.class);
			
			//10-04-2020
			Date date = Calendar.getInstance().getTime();
			
			DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

			int perId = Integer.parseInt(request.getParameter("periodicityId"));

			map = new LinkedMultiValueMap<>();
			map.add("activityId", Integer.parseInt(request.getParameter("activity")));

			ActivityMaster actv = Constants.getRestTemplate().postForObject(Constants.url + "/getActivityById", map,
					ActivityMaster.class);
			// System.out.println("Ativity=" + actv);
			mav.addObject("activity", actv);

			map = new LinkedMultiValueMap<>();
			map.add("periodicityId", perId);

			DevPeriodicityMaster period = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getDevPerodicityById", map, DevPeriodicityMaster.class);
			mav.addObject("per", period);

			String strDate = DateConvertor.convertToYMD((request.getParameter("startDate")));
			// System.out.println("Converted String str: " + strDate);
			String endDate = edate;
			// System.out.println("Converted String end: " + endDate);
			// System.out.println("perId: " + perId);
			List<DateValues> listDate = PeriodicityDates.getDates(strDate, endDate, perId);
			totdays = listDate.size();

			map = new LinkedMultiValueMap<>();

			map.add("serviceId", actv.getServId());
			ServiceMaster servc = Constants.getRestTemplate().postForObject(Constants.url + "/getServiceById", map,
					ServiceMaster.class);

			mav.addObject("service", servc);

			for (int i = 0; i < listDate.size(); i++) {

				Task task = new Task();
				task.setTaskId(i);
				Date date1 = listDate.get(i).getDate();

				// System.out.println("date bef stat**" + dateFormat.format(date1));
				task.setTaskStatutoryDueDate(PeriodicityDates.addDaysToGivenDate(dateFormat.format(date1),
						Integer.parseInt(request.getParameter("statutary_endDays"))));

				// System.out.println("stat date **" + task.getTaskStatutoryDueDate());

				FinancialYear fin = new FinancialYear();
				map = new LinkedMultiValueMap<>();

				map.add("statDate", String.valueOf(task.getTaskStatutoryDueDate()));
				fin = Constants.getRestTemplate().postForObject(Constants.url + "/getFinYearByStatdate", map,
						FinancialYear.class);

				task.setTaskStartDate(PeriodicityDates.addDaysToGivenDate(task.getTaskStatutoryDueDate(), -30));

				StringBuilder sb1 = new StringBuilder(servc.getServName());

				sb1.append("-").append(actv.getActiName()).append("-").append(listDate.get(i).getValue());
				// System.out.println("Fin task name" + sb1);
				task.setTaskId(i);
				task.setActvId(activityMap.getActvId());
				task.setCustId(activityMap.getCustId());
				task.setDelStatus(1);
				task.setEmpBudHr(HoursConversion.convertHoursToMin(request.getParameter("empBudgetHr")));
				task.setExInt1(0);
				task.setExInt2(0);
				task.setExVar1("NA");
				task.setExVar2("NA");
				task.setMappingId(0);
				task.setPeriodicityId(activityMap.getPeriodicityId());
				task.setIsActive(1);

				task.setMngrBudHr(HoursConversion.convertHoursToMin(request.getParameter("mgBudgetHr")));
				task.setServId(actv.getServId());
				task.setTaskCode("NA");
				task.setTaskEmpIds(custHead.getOwnerEmpId()+",");
				task.setTaskFyId(fin.getFinYearId());
				task.setTaskEndDate(task.getTaskStatutoryDueDate());
				task.setTaskStatus(0);
				task.setTaskSubline("NA");
				task.setTaskText(String.valueOf(sb1));
				task.setUpdateDatetime(Constants.getCurDateTime());
				task.setUpdateUsername(userId);
				task.setBillingAmt(request.getParameter("billAmt"));
				task.setExVar1(DateConvertor.convertToDMY(task.getTaskStatutoryDueDate()));
				taskTempList.add(task);

			}

			mav.addObject("taskList", taskTempList);
			mav.addObject("mHr", request.getParameter("mgBudgetHr"));
			mav.addObject("eHr", request.getParameter("empBudgetHr"));

			// System.out.println("taskTempList**" + taskTempList.toString());

			// task generation work end

			/*
			 * map = new LinkedMultiValueMap<>(); map.add("custHeadId",
			 * activityMap.getCustId());
			 * 
			 * CustomerHeaderMaster custHead = Constants.getRestTemplate()
			 * .postForObject(Constants.url + "/getCustomerHeadById", map,
			 * CustomerHeaderMaster.class);
			 */
			mav.addObject("custHead", custHead);
			mav.addObject("custName", request.getParameter("custName"));

		} catch (Exception e) {
			System.err.println("Exce in addCustomerActMap " + e.getMessage());
			e.printStackTrace();
		}

		return mav;

	}

	@RequestMapping(value = "/submitTaskResponse", method = RequestMethod.POST)
	public String submitTaskResponse(HttpServletRequest request, HttpServletResponse response) {

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		HttpSession session = request.getSession();
		EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
		String custId = null;
		String redirect = null;
		try {
			TempTaskSave tsk = new TempTaskSave();
			List<Task> taskFinalList = new ArrayList<Task>();
			String[] TaskId = request.getParameterValues("TaskId");

			StringBuilder sb = new StringBuilder();

			for (int i = 0; i < TaskId.length; i++) {

				for (int j = 0; j < taskTempList.size(); j++) {
					taskTempList.get(j).setExVar1("NA");

					if (Integer.parseInt(TaskId[i]) == taskTempList.get(j).getTaskId()) {

						taskFinalList.add(taskTempList.get(j));

						custId = String.valueOf(taskTempList.get(j).getCustId());

					}

				}

			}
			tsk.setCmpList(activityMap);
			tsk.setTskList(taskFinalList);

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/saveTaskRes", tsk, Info.class);

			if (info.isError()) {
				session.setAttribute("errorMsg", Constants.Failmsg);
				redirect = "redirect:/customerActivityAddMap?custId=" + FormValidation.Encrypt(custId);

			} else {
				session.setAttribute("successMsg", Constants.Sucessmsg);
				redirect = "redirect:/customerActivityAddMap?custId=" + FormValidation.Encrypt(custId);
			}

		} catch (Exception e) {
			System.err.println("Exce in Saving Cust Login Detail " + e.getMessage());
			e.printStackTrace();
		}
		return redirect;

	}

	@RequestMapping(value = "/showCustomerActivityMap", method = RequestMethod.GET)
	public ModelAndView showCustomerActivityMap(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mav = new ModelAndView("master/customerActiMapList");
		MultiValueMap<String, Object> map = null;
		try {

			String base64encodedString = request.getParameter("custId");
			String custId = FormValidation.DecodeKey(base64encodedString);
			// int custId = Integer.parseInt(request.getParameter("custId"));

			map = new LinkedMultiValueMap<>();
			map.add("custId", custId);

			ShowCustActiMapped[] custHeadArr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllCustActivityMapped", map, ShowCustActiMapped[].class);
			List<ShowCustActiMapped> custActMapList = new ArrayList<ShowCustActiMapped>(Arrays.asList(custHeadArr));
			mav.addObject("custActMapList", custActMapList);
			mav.addObject("custId", Integer.parseInt(custId));
		} catch (Exception e) {
			System.err.println("Exce in showCustomerActivityMap " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
//**************************************************************************

	@RequestMapping(value = "/deleteActMapByDate", method = RequestMethod.GET)
	public @ResponseBody Info deleteActMapByDate(HttpServletRequest request, HttpServletResponse response) {
		Info info = new Info();
		try {
			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			int custId = Integer.parseInt(request.getParameter("custId"));
			String spfDate = request.getParameter("date");
			System.out.println("Date---------" + spfDate + " - " + custId);

			System.out.println("Param-----------" + DateConvertor.convertToYMD(spfDate) + " - " + userId);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map.add("date", DateConvertor.convertToYMD(spfDate));
			map.add("userId", userId);
			map.add("custId", custId);

			info = Constants.getRestTemplate().postForObject(Constants.url + "/deleteAllActMappByDate", map,
					Info.class);
			System.out.println("res=" + info);

		} catch (Exception e) {
			System.err.println("Exce in deleteActMapByDate " + e.getMessage());
			e.printStackTrace();
		}

		return info;

	}

}