package com.ats.taskmgmtadmin.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.ExceUtil;
import com.ats.taskmgmtadmin.common.ExportToExcel;
import com.ats.taskmgmtadmin.model.CapacityDetailByEmp;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.report.ComplTaskVarienceRep;
import com.ats.taskmgmtadmin.model.report.CompletedTaskReport;
import com.ats.taskmgmtadmin.model.report.InactiveTaskReport;

@Controller
@Scope("session")
public class ReportV2 {

	List<CapacityDetailByEmp> empCapList;

	@RequestMapping(value = "/getAllEmployeeCapacityDetail", method = RequestMethod.GET)
	public String showCompTaskReportFormanager(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		String mav = new String();
		try {

			mav = "report/v2/empCapDetails"; // copy of compTaskForManager.jsp
			String yearrange = request.getParameter("monthyear");
			if (yearrange != null) {

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");

				String[] fromDate = yearrange.split(" to ");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("fromDate", DateConvertor.convertToYMD(fromDate[0]));
				map.add("toDate", DateConvertor.convertToYMD(fromDate[1]));
				CapacityDetailByEmp[] resArray = Constants.getRestTemplate().postForObject(
						Constants.url + "getAllEmployeeCapacityDetail", map, CapacityDetailByEmp[].class);
				empCapList = new ArrayList<>(Arrays.asList(resArray));

				model.addAttribute("empCapList", empCapList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);
				session.setAttribute("fromDate", fromDate[0]);
				session.setAttribute("toDate", fromDate[1]);

			} else {
				String dateFrTd = DateConvertor.getFromToDate();
				model.addAttribute("fromDate", dateFrTd.split(" to ")[0]);
				model.addAttribute("toDate", dateFrTd.split(" to ")[1]);
				model.addAttribute("yearrange", DateConvertor.getFromToDate());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/getAllEmployeeCapacityDetailExcel", method = RequestMethod.GET)
	public void getAllEmployeeCapacityDetailExcel(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Performance-Total Capacity Utilization";

		HttpSession session = request.getSession();
		EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
		int userId = emp.getEmpId();

		try {

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Employee Name");
			rowData.add("Budgeted Capacity");
			rowData.add("Alloted Capacity");
			rowData.add("Utilized Capacity");
			rowData.add("Budgeted vs Alloted");
			rowData.add("Budgeted vs Utilized");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < empCapList.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + empCapList.get(i).getEmpName());
				rowData.add("" + empCapList.get(i).getBugetedCap());
				rowData.add("" + empCapList.get(i).getAllWork());
				rowData.add("" + empCapList.get(i).getActWork());
				rowData.add(""
						+ roundUp((empCapList.get(i).getBugetedCap() - Float.valueOf(empCapList.get(i).getAllWork()))));
				rowData.add("" + roundUp(
						(Float) empCapList.get(i).getBugetedCap() - Float.valueOf(empCapList.get(i).getActWork())));

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			XSSFWorkbook wb = null;
			try {
				String fromDate = (String) session.getAttribute("fromDate");
				String toDate = (String) session.getAttribute("toDate");

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						" From Date:" + fromDate + "   To Date:" + toDate + "", "", 'G');

				ExceUtil.autoSizeColumns(wb, 3);
				response.setContentType("application/vnd.ms-excel");
				String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
				response.setHeader("Content-disposition", "attachment; filename=" + reportName + "-" + date + ".xlsx");
				wb.write(response.getOutputStream());

			} catch (IOException ioe) {
				throw new RuntimeException("Error writing spreadsheet to output stream");
			} finally {
				if (wb != null) {
					wb.close();
				}
			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	public String roundUp(float value) {

		BigDecimal bd = new BigDecimal(value).setScale(2, RoundingMode.HALF_UP);

		return bd.toPlainString();

	}

	// Completed task Due date And Hours Variance
	List<ComplTaskVarienceRep> taskReportList;
	@RequestMapping(value = "/getCompTaskVariation/{reportType}", method = RequestMethod.GET)
	public String showCompTaskReportFormanager(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model, @PathVariable int reportType) {
		String reportTitle=null;

		String mav = new String();
		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			map = new LinkedMultiValueMap<String, Object>();
			map.add("empId", userId);
			EmployeeMaster[] employee = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllEmployeesByIds", map, EmployeeMaster[].class);
			List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));

			model.addAttribute("epmList", epmList);
			
			System.err.println("report type= " + reportType);
			mav = "report/v2/compTaskVariationRep"; // copy of empMngrPerfmncReprt.jsp
			
			if (reportType == 1) {
				reportTitle="Due Date Variance";

			} else {
				 reportTitle= "Hours Variance";
			}
			String yearrange = request.getParameter("monthyear");
			if (yearrange != null) {

				map = new LinkedMultiValueMap<String, Object>();
				map.add("empId", Integer.parseInt(request.getParameter("empId")));
				EmployeeMaster empData = Constants.getRestTemplate().postForObject(Constants.url + "/getEmployeeById",
						map, EmployeeMaster.class);

				String[] fromDate = yearrange.split(" to ");
				map = new LinkedMultiValueMap<String, Object>();

				if (reportType == 1) {
					map.add("reportType", reportType);

				} else {
					map.add("reportType", empData.getEmpType());
				}
				
				map.add("fromDate",  fromDate[0]);
				map.add("toDate", fromDate[1]);
				map.add("empIds", Integer.parseInt(request.getParameter("empId")));

				ComplTaskVarienceRep[] resArray = Constants.getRestTemplate().postForObject(
						Constants.url + "getComplTaskVarienceReport", map, ComplTaskVarienceRep[].class);
				taskReportList = new ArrayList<>(Arrays.asList(resArray));

				model.addAttribute("taskReportList", taskReportList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);

				model.addAttribute("empData", empData);
				model.addAttribute("reportType", reportType);
				model.addAttribute("reportTitle", reportTitle);
				model.addAttribute("empId", Integer.parseInt(request.getParameter("empId")));

				session.setAttribute("fromDateR2", fromDate[0]);
				session.setAttribute("toDateR2", fromDate[1]);

			} else {
				String dateFrTd = DateConvertor.getFromToDate();
				model.addAttribute("fromDate", dateFrTd.split(" to ")[0]);
				model.addAttribute("toDate", dateFrTd.split(" to ")[1]);
				model.addAttribute("yearrange", DateConvertor.getFromToDate());
				model.addAttribute("reportType", reportType);
				model.addAttribute("reportTitle", reportTitle);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

}
