package com.ats.taskmgmtadmin.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.EmployeeFreeBsyList;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.FinancialYear;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.task.model.EmpSalary;
import com.ats.taskmgmtadmin.task.model.SalaryHis;
import com.ats.taskmgmtadmin.task.model.TempSalList;

@Controller
public class EmpSalaryController {

	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Calendar cal = Calendar.getInstance();

	RestTemplate rest = new RestTemplate();
	Date now = new Date();
	String curDate = dateFormat.format(new Date());
	String dateTime = dateFormat.format(now);
	String items = null;
	String curDateTime = dateFormat.format(cal.getTime());

	// Harsha 21 Aug 2019
	List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>();
	List<EmpSalary> epmSalList = new ArrayList<EmpSalary>();
	@RequestMapping(value = "/employeeListForSalaryUpdate", method = RequestMethod.GET)
	public ModelAndView employeeListForm(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;
		
		
		List<ModuleJson> newModuleList = (List<ModuleJson>) session.getAttribute("newModuleList");
		Info view = AccessControll.checkAccess("employeeListForSalaryUpdate", "employeeListForSalaryUpdate", "1", "0", "0", "0", newModuleList);
		try {

			if (view.isError() == true) {

				mav = new ModelAndView("accessDenied");

			} else {
	 
			mav = new ModelAndView("Salary/empSalaryUpdate");

			EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
					EmployeeMaster[].class);
			epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));

			for (int i = 0; i < epmList.size(); i++) {

				epmList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(epmList.get(i).getEmpId())));
			}

			FinancialYear[] fin = Constants.getRestTemplate().getForObject(Constants.url + "/getAllFinYear",
					FinancialYear[].class);
			List<FinancialYear> fyList = new ArrayList<FinancialYear>(Arrays.asList(fin));
			mav.addObject("fyList", fyList);

			for (int i = 0; i < epmList.size(); i++) {

				epmList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(epmList.get(i).getEmpId())));
			}
			mav.addObject("epmList", epmList);
			}
		} catch (Exception e) {
			System.err.println("Exce in employeeList " + e.getMessage());
			e.printStackTrace();
		}

		return mav;
	}

	// Harsha 22 Aug 2019

	@RequestMapping(value = "/updateEmpsalary", method = RequestMethod.GET)
	public String selectEmployeeToAssigTask(HttpServletRequest request, HttpServletResponse response
			) {
		HttpSession session = request.getSession();
		EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

	 
		
		try {
		int month = Integer.parseInt(request.getParameter("month"));
		int finYear = Integer.parseInt(request.getParameter("finYear"));
		int userId = emp.getEmpId();
		System.out.println("inside "+month+finYear);

		String newsal = null;
		int empId = 0;

		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			List<TempSalList> salList = new ArrayList<TempSalList>();

			for (int i = 0; i < epmList.size(); i++) {
				System.out.println("salList in for "+i);
				TempSalList temp=new TempSalList();
				newsal = request.getParameter("currSal" + epmList.get(i).getEmpId());
				empId = epmList.get(i).getEmpId();

				temp.setCurDateTime(Constants.getCurDateTime());
				temp.setEmpId(empId);
				try {
					temp.setEmpSalary(Float.parseFloat(newsal));
				}catch (Exception e) {

					temp.setEmpSalary(0);
				}

				
				temp.setFinYear(finYear);
				temp.setMonth(month);
				temp.setUserId(userId);
				salList.add(temp);
				//System.out.println("salList in for "+salList.toString());
			}
			  
			Info info = Constants.getRestTemplate().postForObject(Constants.url + "/updateSalRecord", salList,
					Info.class);

		} catch (Exception e) {

			e.printStackTrace();
		}

		return "redirect:/employeeListForSalaryUpdate";
	}
	
	
	
	@RequestMapping(value = "/getPrevSalList", method = RequestMethod.GET)
	public @ResponseBody SalaryHis getFreeEmployeeList(HttpServletRequest request,
			HttpServletResponse response) {
		SalaryHis empListTot = new SalaryHis();

		try {

			 
			int year = Integer.parseInt(request.getParameter("finYear"));
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			 
			map.add("year", year);
			
			EmpSalary[] holListArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getEmpSalByYear", map, EmpSalary[].class);

			epmSalList = new ArrayList<>(Arrays.asList(holListArray));
		System.out.println("data in ajax **"+epmSalList.toString());
			empListTot.setEmpList(epmList);;
			empListTot.setEmpSalList(epmSalList);
			
			
			
		} catch (Exception e) {

			e.printStackTrace();
		}

		return empListTot;
	}

}
