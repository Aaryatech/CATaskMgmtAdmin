package com.ats.taskmgmtadmin.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.client.RestTemplate; 
 
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.model.CalenderYear;
import com.ats.taskmgmtadmin.model.GetHoliday;
import com.ats.taskmgmtadmin.model.GetWeeklyOff;
import com.ats.taskmgmtadmin.model.Holiday;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.WeeklyOff;

@Controller
@Scope("session")
public class HolidayAndWicklyoffController {

	RestTemplate rest = new RestTemplate();
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String curDate = dateFormat.format(new Date());
	String dateTime = dateFormat.format(now);
	Holiday editHoliday = new Holiday();
	WeeklyOff editWeeklyOff = new WeeklyOff();

	@RequestMapping(value = "/showHolidayList", method = RequestMethod.GET)
	public String showHolidayList(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/holiday_list";
		HttpSession session = request.getSession();

		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("companyId", 0);

			GetHoliday[] holListArray = rest.postForObject(Constants.url + "/getHolidayList", map, GetHoliday[].class);

			List<GetHoliday> holList = new ArrayList<>(Arrays.asList(holListArray));

			for (int i = 0; i < holList.size(); i++) {

				holList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(holList.get(i).getHolidayId())));
			}
			model.addAttribute("holList", holList);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/holidayAdd", method = RequestMethod.GET)
	public String holidayAdd(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/holiday";

		try {

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitInsertHoliday", method = RequestMethod.POST)
	public String submitInsertHoliday(HttpServletRequest request, HttpServletResponse response) {

		try {
			HttpSession session = request.getSession();

			CalenderYear calculateYear = rest.getForObject(Constants.url + "/getCalculateYearListIsCurrent",
					CalenderYear.class);

			String dateRange = request.getParameter("dateRange");
			String[] arrOfStr = dateRange.split("to", 2);

			String holidayRemark = request.getParameter("holidayRemark");
			String holidayTitle = request.getParameter("holidayTitle");

			StringBuilder sb = new StringBuilder();

			int holidayId = 0;
			try {
				holidayId = Integer.parseInt(request.getParameter("holidayId"));
			} catch (Exception e) {
				holidayId = 0;
			}

			Boolean ret = false;

			if (FormValidation.Validaton(dateRange, "") == true) {

				ret = true;

			}

			if (FormValidation.Validaton(holidayRemark, "") == true) {

				ret = true;

			}

			if (ret == false) {

				Holiday holiday = new Holiday();

				holiday.setCalYrId(calculateYear.getCalYrId());
				holiday.setCompanyId(0);
				holiday.setDelStatus(1);

				holiday.setExVar1("NA");
				holiday.setExVar2(holidayTitle);
				holiday.setExVar3("NA");
				holiday.setHolidayFromdt(DateConvertor.convertToYMD(arrOfStr[0].toString().trim()));
				holiday.setHolidayTodt(DateConvertor.convertToYMD(arrOfStr[1].toString().trim()));

				holiday.setHolidayRemark(holidayRemark);
				holiday.setIsActive(1);
				holiday.setMakerEnterDatetime(dateTime);
				holiday.setMakerUserId(1);

				Holiday res = rest.postForObject(Constants.url + "/saveHoliday", holiday, Holiday.class);

				if (res.isError() == false) {
					session.setAttribute("successMsg", "Record Inserted Successfully");
				} else {
					session.setAttribute("errorMsg", "Failed to Insert Record");
				}

			} else {
				session.setAttribute("errorMsg", "Failed to Insert Record");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/showHolidayList";
	}

	@RequestMapping(value = "/editHoliday", method = RequestMethod.GET)
	public String editHoliday(HttpServletRequest request, HttpServletResponse response, Model model) {

		String mav = "leave/holiday_edit";

		try {

			String base64encodedString = request.getParameter("holidayId");
			String holidayId = FormValidation.DecodeKey(base64encodedString);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("holidayId", holidayId);
			editHoliday = rest.postForObject(Constants.url + "/getHolidayById", map, Holiday.class);
			model.addAttribute("editHoliday", editHoliday);
			editHoliday.setHolidayFromdt(DateConvertor.convertToDMY(editHoliday.getHolidayFromdt()));
			editHoliday.setHolidayTodt(DateConvertor.convertToDMY(editHoliday.getHolidayTodt()));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitEditHoliday", method = RequestMethod.POST)
	public String submitEditHoliday(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		try {

			String dateRange = request.getParameter("dateRange");
			String[] arrOfStr = dateRange.split("to", 2);

			String holidayRemark = request.getParameter("holidayRemark");
			String holidayTitle = request.getParameter("holidayTitle");

			Boolean ret = false;

			if (FormValidation.Validaton(dateRange, "") == true) {

				ret = true;

			}

			if (FormValidation.Validaton(holidayTitle, "") == true) {

				ret = true;

			}

			if (ret == false) {

				editHoliday.setHolidayFromdt(DateConvertor.convertToYMD(arrOfStr[0].toString().trim()));
				editHoliday.setHolidayTodt(DateConvertor.convertToYMD(arrOfStr[1].toString().trim()));
				editHoliday.setHolidayRemark(holidayRemark);
				editHoliday.setExVar2(holidayTitle);
				Holiday res = rest.postForObject(Constants.url + "/saveHoliday", editHoliday, Holiday.class);

				if (res.isError() == false) {
					session.setAttribute("successMsg", "Record Updated Successfully");
				} else {
					session.setAttribute("errorMsg", "Failed to Update Record");
				}

			} else {
				session.setAttribute("errorMsg", "Failed to Update Record");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Update Record");
		}

		return "redirect:/showHolidayList";
	}

	@RequestMapping(value = "/deleteHoliday", method = RequestMethod.GET)
	public String deleteHoliday(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		try {

			String base64encodedString = request.getParameter("holidayId");
			String holidayId = FormValidation.DecodeKey(base64encodedString);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("holidayId", holidayId);
			Info info = rest.postForObject(Constants.url + "/deleteHoliday", map, Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Deleted Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Delete");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Delete");
		}
		return "redirect:/showHolidayList";
	}

	@RequestMapping(value = "/showWeeklyOffList", method = RequestMethod.GET)
	public String showWeeklyOffList(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();

		String mav = "master/weekly_off_list";

		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("companyId", 0);
			map.add("locIdList", 0);

			GetWeeklyOff[] holListArray = rest.postForObject(Constants.url + "/getWeeklyOffList", map,
					GetWeeklyOff[].class);

			List<GetWeeklyOff> weekOffList = new ArrayList<>(Arrays.asList(holListArray));

			for (int i = 0; i < weekOffList.size(); i++) {

				weekOffList.get(i).setExVar1(FormValidation.Encrypt(String.valueOf(weekOffList.get(i).getWoId())));
			}

			model.addAttribute("weekOffList", weekOffList);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/addWeeklyOff", method = RequestMethod.GET)
	public String addWeeklyOff(HttpServletRequest request, HttpServletResponse response) {

		String mav = "master/weekly_off_add";
		try {

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitInsertWeeklyOff", method = RequestMethod.POST)
	public String submitInsertWeeklyOff(HttpServletRequest request, HttpServletResponse response) {

		try {
			HttpSession session = request.getSession();

			String woDay = request.getParameter("woDay");
			String woPresently = request.getParameter("woPresently");
			String woRemarks = null;
			woRemarks = request.getParameter("woRemarks");
			String woType = request.getParameter("woType");

			Boolean ret = false;

			if (FormValidation.Validaton(woDay, "") == true) {

				ret = true;
			}

			if (FormValidation.Validaton(woPresently, "") == true) {

				ret = true;
			}

			if (ret == false) {

				WeeklyOff save = new WeeklyOff();
				save.setDelStatus(1);
				save.setIsActive(1);
				save.setWoType(woType);
				save.setWoRemarks(woRemarks);
				save.setWoIsUsed(1);
				save.setWoDay(woDay);
				save.setWoPresently(woPresently);
				save.setMakerEnterDatetime(dateTime);

				WeeklyOff res = rest.postForObject(Constants.url + "/saveWeeklyOff", save, WeeklyOff.class);

				if (res != null) {
					session.setAttribute("successMsg", "Record Inserted Successfully");
				} else {
					session.setAttribute("errorMsg", "Failed to Insert Record");
				}

			} else {
				session.setAttribute("errorMsg", "Failed to Insert Record");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/showWeeklyOffList";
	}

	@RequestMapping(value = "/editWeeklyOff", method = RequestMethod.GET)
	public String editWeeklyOff(HttpServletRequest request, HttpServletResponse response, Model model) {

		HttpSession session = request.getSession();
		String mav = "master/weekly_off_edit";

		try {

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			String base64encodedString = request.getParameter("woId");
			String woId = FormValidation.DecodeKey(base64encodedString);

			map = new LinkedMultiValueMap<>();
			map.add("woId", woId);
			editWeeklyOff = rest.postForObject(Constants.url + "/getWeeklyOffById", map, WeeklyOff.class);
			model.addAttribute("editWeeklyOff", editWeeklyOff);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping(value = "/submitEditInsertWeeklyOff", method = RequestMethod.POST)
	public String submitEditInsertWeeklyOff(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		try {

			String woDay = request.getParameter("woDay");
			String woPresently = request.getParameter("woPresently");
			String woRemarks = request.getParameter("woRemarks");
			
			String woType = request.getParameter("woType");

			Boolean ret = false;

			if (FormValidation.Validaton(woDay, "") == true) {

				ret = true;
			}

			if (FormValidation.Validaton(woPresently, "") == true) {

				ret = true;
			}

			if (ret == false) {

				editWeeklyOff.setWoDay(woDay);
				editWeeklyOff.setWoPresently(woPresently);
				editWeeklyOff.setWoRemarks(woRemarks);
				editWeeklyOff.setWoType(woType);

				WeeklyOff res = rest.postForObject(Constants.url + "/saveWeeklyOff", editWeeklyOff, WeeklyOff.class);

				if (res != null) {
					session.setAttribute("successMsg", "Record Updated Successfully");
				} else {
					session.setAttribute("errorMsg", "Failed to Update Record");
				}

			} else {
				session.setAttribute("errorMsg", "Failed to Update Record");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Update Record");
		}

		return "redirect:/showWeeklyOffList";
	}

	@RequestMapping(value = "/deleteWeeklyOff", method = RequestMethod.GET)
	public String deleteWeeklyOff(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		  
		try {

			String base64encodedString = request.getParameter("woId");
			String woId = FormValidation.DecodeKey(base64encodedString);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
			map.add("woId", woId);
			Info info = rest.postForObject(Constants.url + "/deleteWeeklyOff", map, Info.class);

			if (info.isError() == false) {
				session.setAttribute("successMsg", "Deleted Successfully");
			} else {
				session.setAttribute("errorMsg", "Failed to Delete");
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Failed to Delete");
		}
		return "redirect:/showWeeklyOffList";
	}

}
