package com.ats.taskmgmtadmin.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.CalenderYear;
import com.ats.taskmgmtadmin.model.EmpListWithDateList;
import com.ats.taskmgmtadmin.model.EmpListWithDateWiseDetail;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.LeaveApply;
import com.ats.taskmgmtadmin.model.LeaveCount;
import com.ats.taskmgmtadmin.model.LeaveDetail;
import com.ats.taskmgmtadmin.model.LeaveDetailWithFreeHours;

@Controller
@Scope("session")
public class LeaveController {

	@RequestMapping(value = "/showEmpListForLeave", method = RequestMethod.GET)
	public String showEmpListForLeave(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/showEmpListForLeave";

		try {

			EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
					EmployeeMaster[].class);
			List<EmployeeMaster> empList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));

			for (int i = 0; i < empList.size(); i++) {
				empList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(empList.get(i).getEmpId())));
			}

			model.addAttribute("empList", empList);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/leaveApply", method = RequestMethod.GET)
	public String leaveApply(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/leaveApplication";

		try {

			String empIds = request.getParameter("empId");
			// int empId = Integer.parseInt(request.getParameter("empId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", FormValidation.DecodeKey(empIds));
			EmployeeMaster employee = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
					EmployeeMaster.class);

			model.addAttribute("employee", employee);
			model.addAttribute("empId", Integer.parseInt(FormValidation.DecodeKey(empIds)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/calholidayWebservice", method = RequestMethod.GET)
	public @ResponseBody LeaveCount calholidayWebservice(HttpServletRequest request, HttpServletResponse response) {

		LeaveCount leaveCount = new LeaveCount();

		try {
			// String empId = request.getParameter("empId");
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", 0);
			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			System.out.println(map);
			leaveCount = Constants.getRestTemplate().postForObject(Constants.url + "/calculateHolidayBetweenDate", map,
					LeaveCount.class);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return leaveCount;
	}

	@RequestMapping(value = { "/calculateHolidayBetweenDate" }, method = RequestMethod.GET)
	public @ResponseBody String calculateHolidayBetweenDate(@RequestParam("fromDate") String fromDate,
			@RequestParam("toDate") String toDate) {

		int totalcount = 0;
		int diff = difffun(fromDate, toDate);

		try {

			SimpleDateFormat yydate = new SimpleDateFormat("dd-MM-yyyy");

			for (Date j = yydate.parse(fromDate); j.compareTo(yydate.parse(toDate)) <= 0;) {

				Calendar c = Calendar.getInstance();
				c.setTime(j);
				int dayOfWeek = c.get(Calendar.DAY_OF_WEEK) - 1;

				if (dayOfWeek == 0) {

					totalcount++;
				}
				j.setTime(j.getTime() + 1000 * 60 * 60 * 24);

			}

			diff = diff - totalcount;

		} catch (Exception e) {

			e.printStackTrace();
		}

		return String.valueOf(diff);

	}

	public int difffun(String date1, String date2) {

		SimpleDateFormat myFormat = new SimpleDateFormat("dd-MM-yyy");

		int result = 0;

		try {
			Date date3 = myFormat.parse(date1);
			Date date4 = myFormat.parse(date2);
			long diff = date4.getTime() - date3.getTime();
			result = (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
		} catch (Exception e) {

		}

		return result + 1;
	}

	@RequestMapping(value = "/insertLeave", method = RequestMethod.POST)
	public String insertLeave(HttpServletRequest request, HttpServletResponse response) {
		String empId1 = request.getParameter("empId");
		try {
			HttpSession session = request.getSession();
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			// String compName = request.getParameter("1");
			String leaveDateRange = request.getParameter("leaveDateRange");
			String dayTypeName = request.getParameter("dayTypeName");
			float noOfDays = Float.parseFloat(request.getParameter("noOfDays"));
			// int leaveTypeId = Integer.parseInt(request.getParameter("leaveTypeId"));

			int empId = Integer.parseInt(request.getParameter("empId"));

			String remark = new String();

			String[] arrOfStr = leaveDateRange.split("to", 2);

			System.out.println("dayType" + dayTypeName);

			try {
				remark = request.getParameter("leaveRemark");
			} catch (Exception e) {
				remark = "NA";
			}

			Boolean ret = false;

			if (FormValidation.Validaton(leaveDateRange, "") == true) {

				ret = true;
				System.out.println("leaveDateRange" + ret);
			}
			if (FormValidation.Validaton(request.getParameter("noOfDays"), "") == true) {

				ret = true;
				System.out.println("noOfDays" + ret);
			}

			CalenderYear cal = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getCalculateYearListIsCurrent", CalenderYear.class);

			if (ret == false) {

				LeaveApply leaveSummary = new LeaveApply();

				leaveSummary.setCalYrId(cal.getCalYrId());
				leaveSummary.setEmpId(empId);
				leaveSummary.setLeaveNumDays(noOfDays);
				leaveSummary.setLeaveDuration(dayTypeName);
				leaveSummary.setLeaveEmpReason(remark);
				leaveSummary.setLeaveFromdt(DateConvertor.convertToYMD(arrOfStr[0].toString().trim()));
				leaveSummary.setLeaveTodt(DateConvertor.convertToYMD(arrOfStr[1].toString().trim()));
				leaveSummary.setIsActive(1);
				leaveSummary.setDelStatus(1);
				leaveSummary.setMakerEnterDatetime(sf.format(date));

				LeaveApply res = Constants.getRestTemplate().postForObject(Constants.url + "/saveLeaveApply",
						leaveSummary, LeaveApply.class);
				
				if(res!=null) {
					session.setAttribute("successMsg", Constants.Sucessmsg);
				}else {
					session.setAttribute("errorMsg", Constants.Failmsg);
				}
				
			} else {
				session.setAttribute("errorMsg", "Failed to Insert Record");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		// return "redirect:/showApplyForLeave";
		return "redirect:/leaveApply?empId=" + FormValidation.Encrypt(empId1);

	}

	@RequestMapping(value = "/showLeaveHistList", method = RequestMethod.GET)
	public String showLeaveHistList(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/showLeaveHistList";

		try {
			String empId1 = request.getParameter("empId");
			int empId = Integer.parseInt(FormValidation.DecodeKey(empId1));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("empId", empId);
			LeaveDetail[] res = Constants.getRestTemplate().postForObject(Constants.url + "/getLeaveListByEmp", map,
					LeaveDetail[].class);
			List<LeaveDetail> list = new ArrayList<>(Arrays.asList(res));

			EmployeeMaster employee = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById", map,
					EmployeeMaster.class);
			model.addAttribute("employee", employee);
			model.addAttribute("list", list);
			model.addAttribute("empId1", empId1);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/deleteLeave", method = RequestMethod.GET)
	public String deleteLeave(HttpServletRequest request, HttpServletResponse response, Model model) {

		String empId1 = request.getParameter("emp");
		try {

			int leaveId = Integer.parseInt(request.getParameter("leaveId"));
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("leaveId", leaveId);
			Info res = Constants.getRestTemplate().postForObject(Constants.url + "/deleteLeaveApply", map, Info.class);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/showLeaveHistList?empId=" + empId1;
	}

	@RequestMapping(value = "/showLeaveHistListBetweenDate", method = RequestMethod.GET)
	public String showLeaveHistListBetweenDate(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/showLeaveHistListBetweenDate";

		try {

			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");

			if (fromDate != null && toDate != null) {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("fromDate", DateConvertor.convertToYMD(fromDate));
				map.add("toDate", DateConvertor.convertToYMD(toDate));
				LeaveDetailWithFreeHours leaveDetailWithFreeHours = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getTotalAvailableHours", map, LeaveDetailWithFreeHours.class);
				model.addAttribute("leaveDetailWithFreeHours", leaveDetailWithFreeHours);
				model.addAttribute("fromDate", fromDate);
				model.addAttribute("toDate", toDate);

			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/empListwithDaywiseLeaveStatus", method = RequestMethod.GET)
	public String empListwithDaywiseLeaveStatus(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/empListwithDaywiseLeaveStatus";

		try {

			String fromDate = request.getParameter("fromDate");
			//String toDate = request.getParameter("toDate");

			String[] dates = fromDate.split(" to ");
			
			if (fromDate != null) {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				map.add("fromDate", dates[0]);
				map.add("toDate", dates[1]);
				EmpListWithDateList empListWithDateList = Constants.getRestTemplate()
						.postForObject(Constants.url + "/daywiseLeaveHistoryofEmployee", map, EmpListWithDateList.class);
				model.addAttribute("empListWithDateList", empListWithDateList);
				model.addAttribute("fromDate", fromDate); 

			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return mav;
	}
}
