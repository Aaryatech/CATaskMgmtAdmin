package com.ats.taskmgmtadmin.controller;

import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.model.report.TlTaskCompletReport;

@Controller
@Scope("session")
public class TlCompletedGTaskReportMVCCntrl {

	@RequestMapping(value = "/getTeamLeadReport", method = RequestMethod.GET)
	public ModelAndView dashboard(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Model model) {

		ModelAndView mav = new ModelAndView("report/tlreport");
		try {
			
		}catch(Exception e) {
			System.err.println("Exception in getTeamLeadReport:"+e.getMessage());
			e.printStackTrace();
		}
		return mav;
	}
	
	/*
	 * @RequestMapping(value="/getTeamLeadCompletTaskReport",
	 * method=RequestMethod.GET) public@ResponseBody List<TlTaskCompletReport>
	 * getTeamLeadCompletTaskReport(HttpServletRequest request, HttpServletResponse
	 * response){ List<TlTaskCompletReport> ttlList = new
	 * ArrayList<TlTaskCompletReport>(); try { MultiValueMap<String, Object> map =
	 * new LinkedMultiValueMap<>(); String date = request.getParameter("fromDate");
	 * String[] dates = date.split(" to ");
	 * 
	 * 
	 * System.out.println("Dates----------"+dates[0]+" "+dates[1]);
	 * map.add("fromDate", DateConvertor.convertToYMD(dates[0])); map.add("toDate",
	 * DateConvertor.convertToYMD(dates[1]));
	 * 
	 * TlTaskCompletReport[] ttlArr = Constants.getRestTemplate()
	 * .postForObject(Constants.url + "/getTlCompletedTeskRepot", map,
	 * TlTaskCompletReport[].class); ttlList = new
	 * ArrayList<TlTaskCompletReport>(Arrays.asList(ttlArr));
	 * System.out.println("List---------------"+ttlList); }catch (Exception e) {
	 * System.err.println("Exception in getTeamLeadCompletTaskReport : "+e.
	 * getMessage()); e.printStackTrace(); } return ttlList;
	 * 
	 * }
	 */
}
