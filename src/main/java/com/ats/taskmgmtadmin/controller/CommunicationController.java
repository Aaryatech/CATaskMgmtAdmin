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

import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.ats.task.mgmtadmin.communication.model.Communication;
import com.ats.task.mgmtadmin.communication.model.GetAllCommunicationByTaskId;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.CustomerHeaderMaster;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.StatusMaster;
import com.ats.taskmgmtadmin.model.TaskListHome;

@Controller
public class CommunicationController {
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();

	RestTemplate rest = new RestTemplate();
	Date now = new Date();
	String curDate = dateFormat.format(new Date());
	String dateTime = dateFormat.format(now);
	String items = null;
	String curDateTime = dateFormat.format(cal.getTime());
	HttpSession session =null ;

	
	
	@RequestMapping(value = "/communication", method = RequestMethod.GET)
	public ModelAndView communicationForm(HttpServletRequest request, HttpServletResponse response
			) {
		session = request.getSession();
		ModelAndView mav = new ModelAndView("task/communication");
		String base64encodedString = request.getParameter("taskId");
		String taskId = FormValidation.DecodeKey(base64encodedString);
		String base64encodedString1 = request.getParameter("empId");
		String empId = FormValidation.DecodeKey(base64encodedString1);
		EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
		int userId = emp.getEmpId();
		System.err.println("Id / Value--------------" + taskId + " / " + empId);
		
		try {

			mav.addObject("taskId", taskId);
			mav.addObject("empId", empId);
			MultiValueMap<String, Object> map = null;
		

			map = new LinkedMultiValueMap<String, Object>();
			map.add("taskId", taskId);

			GetAllCommunicationByTaskId[] communication = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getCommunicationByTaskId", map, GetAllCommunicationByTaskId[].class);
			List<GetAllCommunicationByTaskId> communicationList = new ArrayList<>(Arrays.asList(communication));
			mav.addObject("communicationList", communicationList);
			mav.addObject("loginUser", userId);
			System.err.println("communicationList--------------" + communicationList.toString());
			
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", userId);

			StatusMaster[] statusMstr = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getStatusByEmpTypeIds", map, StatusMaster[].class);
			List<StatusMaster> statusList = new ArrayList<>(Arrays.asList(statusMstr));
			mav.addObject("statusList", statusList);

			map = new LinkedMultiValueMap<String, Object>();
			map.add("empType", userId);
			map.add("taskId", taskId);

			TaskListHome task = Constants.getRestTemplate().postForObject(Constants.url + "/getTaskByTaskId", map,
					TaskListHome.class);
			mav.addObject("task", task);

		} catch (Exception e) {
			System.err.println("Exce in communication " + e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	
	@RequestMapping(value = "/insertNewMessage", method = RequestMethod.POST)
	public String insertNewMessage(HttpServletRequest request, HttpServletResponse response) {
		EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
		int userId = emp.getEmpId();
		String empId=request.getParameter("empId");
		String taskId=request.getParameter("taskId");
		try {
			session = request.getSession();
			
         Communication comcat=new Communication();
		 
         comcat.setCommunText(request.getParameter("msg"));
         comcat.setDelStatus(1);
         comcat.setEmpId(Integer.parseInt(request.getParameter("empId")));
         comcat.setExInt1(1);
         comcat.setExInt2(1);
         comcat.setExVar1("NA");
         comcat.setExVar2("NA");
         comcat.setTaskId(Integer.parseInt(request.getParameter("taskId")));
         comcat.setUpdateDatetime(Constants.getCurDateTime());
         comcat.setUpdateUser(userId);
        
			 
         Communication custHead = Constants.getRestTemplate()
					.postForObject(Constants.url + "/saveCommunication", comcat, Communication.class);

		} catch (Exception e) {
			System.err.println("Exce in saveCommunication " + e.getMessage());
			e.printStackTrace();
		}
 		return "redirect:/communication?taskId="+FormValidation.Encrypt(taskId)+"&empId="+FormValidation.Encrypt(empId);
	}



}
