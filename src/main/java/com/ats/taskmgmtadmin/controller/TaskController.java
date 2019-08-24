package com.ats.taskmgmtadmin.controller;

import java.text.DateFormat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.EmployeeFreeBsyList;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.task.model.GetTaskList;

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
	public String assignTask(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "task/assigntask";

		GetTaskList[] holListArray = Constants.getRestTemplate().getForObject(Constants.url + "/getAllTaskList",
				GetTaskList[].class);

		List<GetTaskList> taskList = new ArrayList<>(Arrays.asList(holListArray));

		for (int i = 0; i < taskList.size(); i++) {

			taskList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(taskList.get(i).getTaskId())));
		}
		model.addAttribute("taskList", taskList);
		EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
				EmployeeMaster[].class);
		List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
		model.addAttribute("epmList", epmList);

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
			String workDate=null;
			try {
				  workDate = request.getParameter("workDate");
			} catch (Exception e) {
				e.printStackTrace();
				workDate="NA";
			}
			System.out.println("work date**" + workDate);

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
			System.err.println("emp id are " + locId2);
			for (int j = 0; j < locId2.length; j++) {
				sbEmp = sbEmp.append(locId2[j] + ",");

			}
			String items1 = sbEmp.toString();
			items1 = items1.substring(0, items1.length() - 1);
			System.err.println("emp id are :::" + items1);

			map.add("taskIdList", items);
			map.add("empIdList", items1);
			map.add("userId", userId);
			map.add("curDateTime", Constants.getCurDateTime());
			map.add("workDate", workDate);

			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/taskAssignmentUpdate", map,
					Info.class);

			if (info.isError() == false) {

				for (int i = 0; i < TaskId.length; i++) {
					FormValidation.updateTaskLog(Constants.taskTex2, userId, Integer.parseInt(TaskId[i]));
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

}
