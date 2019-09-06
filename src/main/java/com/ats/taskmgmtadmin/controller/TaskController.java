package com.ats.taskmgmtadmin.controller;

import java.text.DateFormat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.AccessControll;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.common.TaskText;
import com.ats.taskmgmtadmin.model.ActivityMaster;
import com.ats.taskmgmtadmin.model.ActivityPeriodDetails;
import com.ats.taskmgmtadmin.model.CustNameId;
import com.ats.taskmgmtadmin.model.CustmrActivityMap;
import com.ats.taskmgmtadmin.model.CustomerDetails;
import com.ats.taskmgmtadmin.model.DailyWorkLog;
import com.ats.taskmgmtadmin.model.EmployeeFreeBsyList;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.FinancialYear;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.ServiceMaster;
import com.ats.taskmgmtadmin.task.model.GetTaskList;
import com.ats.taskmgmtadmin.task.model.Task;
import com.ats.taskmgmtadmin.task.model.TempForTaskEdit;

@Controller
@Scope("session")
public class TaskController {
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	List<EmployeeMaster> empList = new ArrayList<EmployeeMaster>();
	EmployeeFreeBsyList empListTot = new EmployeeFreeBsyList();
	List<EmployeeMaster> empListNew = new ArrayList<EmployeeMaster>();
	RestTemplate rest = new RestTemplate();
	Date now = new Date();
	String curDate = dateFormat.format(new Date());
	String dateTime = dateFormat.format(now);

	String curDateTime = dateFormat.format(cal.getTime());

	@RequestMapping(value = "/assignTask", method = RequestMethod.GET)
	public ModelAndView assignTask(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("assignTask", "assignTask", "1", "0", "0", "0", newModuleList);
		try {

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
				mav = new ModelAndView("task/assigntask");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("stat", 0);
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

			}
		} catch (Exception e) {

			e.printStackTrace();

		}

		return mav;
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

		RestTemplate restTemplate = new RestTemplate();
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

			// Prev
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			// for dropdown
			mav.addObject("actIntList", actIntList);
			mav.addObject("custIdList", custIntList);
			mav.addObject("servId", servId);

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
				//System.out.println("ManualTakList***" + taskList.toString());
				Info edit = AccessControll.checkAccess("inactiveTaskList", "inactiveTaskList", "0", "0", "1", "0", newModuleList);
				 
				 
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

				CustomerDetails[] custHeadArr = Constants.getRestTemplate()
						.getForObject(Constants.url + "/getAllCustomerInfo", CustomerDetails[].class);
				List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

				System.out.println("cust is " + custHeadList.toString());
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
				Task task=new Task();
				mav.addObject("task", task);
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
		Info info=new Info();
		if(flag==1) {
			  info = AccessControll.checkAccess("editTask", "manualTaskList", "0", "0", "1", "0", newModuleList);

		}else {
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
		
			System.out.println("flag is"+flag);
			mav.addObject("taskType", flag);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);
			Task task = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskByTaskIdForEdit1", map,
					Task.class);
			task.setTaskStatutoryDueDate(DateConvertor.convertToDMY(task.getTaskStatutoryDueDate()));
			task.setTaskStartDate(DateConvertor.convertToDMY(task.getTaskStartDate()));
			task.setTaskEndDate(DateConvertor.convertToDMY(task.getTaskEndDate()));
			List<Integer> empIntList = Stream.of(task.getTaskEmpIds().split(",")).map(Integer::parseInt)
					.collect(Collectors.toList());

			mav.addObject("task", task);
			mav.addObject("empIntList", empIntList);

			CustomerDetails[] custHeadArr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllCustomerInfo", CustomerDetails[].class);
			List<CustomerDetails> custHeadList = new ArrayList<CustomerDetails>(Arrays.asList(custHeadArr));

			System.out.println("cust is " + custHeadList.toString());
			mav.addObject("custList", custHeadList);

			ServiceMaster[] srvsMstr = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getAllEnrolledServices", ServiceMaster[].class);
			List<ServiceMaster> srvcMstrList = new ArrayList<>(Arrays.asList(srvsMstr));
			mav.addObject("serviceList", srvcMstrList);
			map = new LinkedMultiValueMap<>();
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
					Info edit = AccessControll.checkAccess("manualTaskList", "manualTaskList", "0", "0", "1", "0", newModuleList);
					 
					 
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

		} catch (Exception e) {
			System.err.println("Exce in updateTaskStatus " + e.getMessage());
			e.printStackTrace();
		}

		return redirect;
	}

	@RequestMapping(value = "/addManualTask", method = RequestMethod.POST)
	public String submitUpdatedTask(HttpServletRequest request, HttpServletResponse response) {
		String a = null;
		try {
			HttpSession session = request.getSession();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

			int userId = emp.getEmpId();
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
			try {
				taskId = Integer.parseInt(request.getParameter("taskId"));

				if (taskId != 0) {
					System.out.println("in task edit");
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

					map.add("taskId", taskId);
					map.add("items1", items1);
					map.add("empBudgetHr", Integer.parseInt(request.getParameter("empBudgetHr")));
					map.add("mgBudgetHr", Integer.parseInt(request.getParameter("mgBudgetHr")));
					map.add("startDate", request.getParameter("startDate"));
					map.add("endDate", request.getParameter("endDate"));
					map.add("customer", Integer.parseInt(request.getParameter("customer")));
					map.add("service", Integer.parseInt(request.getParameter("service")));
					map.add("periodicityId", Integer.parseInt(request.getParameter("periodicityId")));
					map.add("activity", Integer.parseInt(request.getParameter("activity")));
					map.add("userId", userId);
					map.add("curDateTime", Constants.getCurDateTime());

					Info temp = Constants.getRestTemplate().postForObject(Constants.url + "/submitEditMannualTask", map,
							Info.class);
					
					if(taskType==1) {
						a = "redirect:/manualTaskList";
					}else {
						a = "redirect:/inactiveTaskList";
					}
					
				}

			} catch (Exception e) {
				taskId = 0;
				e.getMessage();
			}

			if (taskId == 0) {
				a = "redirect:/manualTaskList";
				System.out.println("in task add");
				activityMapanual.setMappingId(0);
				activityMapanual.setActvEmpBudgHr(Integer.parseInt(request.getParameter("empBudgetHr")));
				activityMapanual.setActvStartDate(request.getParameter("startDate"));
				activityMapanual.setActvEndDate(request.getParameter("endDate"));
				activityMapanual.setActvManBudgHr(Integer.parseInt(request.getParameter("mgBudgetHr")));
				activityMapanual.setActvStatutoryDays(Integer.parseInt(request.getParameter("statutary_endDays")));
				activityMapanual.setCustId(Integer.parseInt(request.getParameter("customer")));
				activityMapanual.setDelStatus(1);
				activityMapanual.setExInt1(Integer.parseInt(request.getParameter("service")));
				activityMapanual.setExInt2(0);
				activityMapanual.setExVar1(items1);
				activityMapanual.setExVar2("NA");
				activityMapanual.setPeriodicityId(Integer.parseInt(request.getParameter("periodicityId")));
				activityMapanual.setUpdateDatetime( Constants.getCurDateTime());
				activityMapanual.setUpdateUsername(userId);
				activityMapanual.setActvId(Integer.parseInt(request.getParameter("activity")));

				System.out.println("Activity Map---------" + activityMapanual.toString());
				Info map = Constants.getRestTemplate().postForObject(Constants.url + "/saveMannualTask",
						activityMapanual, Info.class);
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
			System.out.println("getDailyWorkLogByEmpId ----- Service Called " + taskId);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);
			Task task = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskByTaskIdForEdit1", map,
					Task.class);
			task.setTaskStatutoryDueDate(DateConvertor.convertToDMY(task.getTaskStatutoryDueDate()));
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

			// System.out.println(" List----------"+actIntList.toString());

		} catch (Exception e) {
			System.err.println("Exce in workLogList " + e.getMessage());
			e.printStackTrace();
		}
		return logList;
	}

	@RequestMapping(value = "/submitUpdatedTask", method = RequestMethod.POST)
	public String addManualTask(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			System.err.println("emp hii");
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

			int userId = emp.getEmpId();

			CustmrActivityMap activityMapanual = new CustmrActivityMap();
			StringBuilder sbEmp = new StringBuilder();
			String[] locId2 = request.getParameterValues("emp");
			System.err.println("emp id are " + locId2);
			for (int j = 0; j < locId2.length; j++) {
				sbEmp = sbEmp.append(locId2[j] + ",");

			}
			String items1 = sbEmp.toString();
			items1 = items1.substring(0, items1.length() - 1);

			String empHr = request.getParameter("empBudHr");
			String mngHr = request.getParameter("manBudHr");
			String dueDate = request.getParameter("dueDate");
			String workDate = request.getParameter("workDate");
			String taskId = request.getParameter("taskId1");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);
			map.add("empHr", empHr);
			map.add("mngHr", mngHr);
			map.add("dueDate", dueDate);
			map.add("workDate", workDate);
			map.add("empId", items1);
			map.add("updateUserName", userId);
			map.add("updateDateTime", Constants.getCurDateTime());

			Info inf = Constants.getRestTemplate().postForObject(Constants.url + "/updateEditTsk", map, Info.class);

		} catch (Exception e) {
			System.err.println("Exce in addCustomerActMap " + e.getMessage());
			e.printStackTrace();
		}

		return "redirect:/taskListForEmp";

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
				session.setAttribute("errorPassMsg", "Password has been sent to your Email & Contact Number");
				// model.addObject("msg", "Password has been sent to your email");

			}

		} catch (Exception e) {
			System.err.println("Exce in checkUniqueField  " + e.getMessage());
			e.printStackTrace();
		}

		return c;

	}
	
	//*******************************************Cmpleted Task*************************************
	
	@RequestMapping(value = "/completedTaskList", method = RequestMethod.GET)
	public ModelAndView completedTaskList(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		ModelAndView mav = null;

		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("completedTaskList", "completedTaskList", "1", "0", "0", "0", newModuleList);

		if (view.isError() == true) {

			mav = new ModelAndView("accessDenied");

		} else {
			mav = new ModelAndView("task/completedTaskList");
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			// System.out.println("empType is "+emp.getEmpType());
			if (emp.getEmpType() == 3) {

				try {
					MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
					map.add("stat", 9);
					map.add("empId", userId);
					GetTaskList[] holListArray = Constants.getRestTemplate()
							.postForObject(Constants.url + "/getAllCompletedTaskList", map, GetTaskList[].class);

					List<GetTaskList> taskList = new ArrayList<>(Arrays.asList(holListArray));

					for (int i = 0; i < taskList.size(); i++) {

						taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
					}
					mav.addObject("taskList", taskList);
					System.out.println("CompletedTakList***"+taskList.toString());
				} catch (Exception e) {
					System.err.println("Exce in addCustomerActMap " + e.getMessage());
					e.printStackTrace();
				}
			}
		}
		return mav;

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
			
			if(updateIsActiveStatus!=null) {
				FormValidation.updateTaskLog(TaskText.taskTex8, userId, taskId);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/completedTaskList";
	}



}
