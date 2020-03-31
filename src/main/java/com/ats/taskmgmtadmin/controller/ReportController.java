package com.ats.taskmgmtadmin.controller;

import java.io.BufferedInputStream;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ats.taskmgmtadmin.acsrights.ModuleJson;
import com.ats.taskmgmtadmin.common.AccessControll;
import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.ExceUtil;
import com.ats.taskmgmtadmin.common.ExportToExcel;
import com.ats.taskmgmtadmin.common.FormValidation;
import com.ats.taskmgmtadmin.common.ReportCostants;
import com.ats.taskmgmtadmin.model.ClientGroupList;
import com.ats.taskmgmtadmin.model.EmpIdNameList;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.EmpwithPartnerList;
import com.ats.taskmgmtadmin.model.Info;
import com.ats.taskmgmtadmin.model.report.CompletedTaskReport;
import com.ats.taskmgmtadmin.model.report.EmpAndMangPerfRepDetail;
import com.ats.taskmgmtadmin.model.report.EmpAndMngPerformanceRep;
import com.ats.taskmgmtadmin.model.report.InactiveTaskReport;
import com.ats.taskmgmtadmin.model.report.TlTaskCompletReport;
import com.ats.taskmgmtadmin.task.model.GetTaskList;
import com.ats.taskmgmtadmin.util.ItextPageEvent;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
@Scope("session")
public class ReportController {
	/*
	 * <dependency> <groupId>com.itextpdf</groupId>
	 * <artifactId>itextpdf</artifactId> <version>5.5.13</version> </dependency>
	 * 
	 * <dependency> <groupId>org.apache.poi</groupId>
	 * <artifactId>poi-ooxml</artifactId> <version>3.13</version> </dependency>
	 */

	// harsha

	@RequestMapping(value = "/showReports", method = RequestMethod.GET)
	public ModelAndView showQueryBasedReports(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = null;
		try {
			model = new ModelAndView("report/repDash");
			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			model.addObject("userId", userId);

			int userType = emp.getEmpType();
			model.addObject("userType", userType);
			model.addObject("empName", emp.getEmpName());

			if (userType == 3) {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("empId", userId);
				EmployeeMaster[] employee = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllEmployeesByIds", map, EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				model.addObject("epmList", epmList);
			} else {
				EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
						EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
				model.addObject("epmList", epmList);
			}

			ClientGroupList[] clientGroup = Constants.getRestTemplate()
					.getForObject(Constants.url + "/getClientGroupList", ClientGroupList[].class);
			List<ClientGroupList> clientGroupList = new ArrayList<ClientGroupList>(Arrays.asList(clientGroup));
			model.addObject("clientGroupList", clientGroupList);

		} catch (Exception e) {

			System.err.println("Exce in showReports " + e.getMessage());
			e.printStackTrace();

		}

		return model;
	}

	@RequestMapping(value = "/showCompTaskReportForEmp", method = RequestMethod.GET)
	public String clientWiseReport(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Model model) {

		String mav = new String();
		try {

			mav = "report/Employee/compTaskReportForEmp";
			String yearrange = request.getParameter("monthyear");
			System.out.println("yearrange***" + yearrange);
			if (yearrange != null) {

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				String[] fromDate = yearrange.split(" to ");
				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("fromDate", DateConvertor.convertToYMD(fromDate[0]));
				map.add("toDate", DateConvertor.convertToYMD(fromDate[1]));
				map.add("empIds", String.valueOf(userId));
				CompletedTaskReport[] resArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "getCompletedTaskReport", map, CompletedTaskReport[].class);
				List<CompletedTaskReport> cmpTaskList = new ArrayList<>(Arrays.asList(resArray));
				//System.out.println("cmpTaskList***" + cmpTaskList.toString());
				for (int i = 0; i < cmpTaskList.size(); i++) {
					if (cmpTaskList.get(i).getTaskStatutoryDueDate() == " "
							&& cmpTaskList.get(i).getTaskStatutoryDueDate() == null) {
						cmpTaskList.get(i).setTaskStatutoryDueDate("-");

					}

					if (cmpTaskList.get(i).getTaskStartDate() == " " && cmpTaskList.get(i).getTaskStartDate() == null) {
						cmpTaskList.get(i).setTaskStartDate("-");
					}
				}

				model.addAttribute("cmpTaskList", cmpTaskList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	
	@RequestMapping(value = "/showCompletedTaskRep", method = RequestMethod.GET)
	public void showStudentParticipatedNssNccReport(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Task Completed For Employee";

		HttpSession session = request.getSession();
		EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
		int userId = emp.getEmpId();
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map.add("fromDate", DateConvertor.convertToYMD(fromDate));
		map.add("toDate", DateConvertor.convertToYMD(toDate));
		map.add("empIds", String.valueOf(userId));
		CompletedTaskReport[] resArray = Constants.getRestTemplate()
				.postForObject(Constants.url + "getCompletedTaskReport", map, CompletedTaskReport[].class);
		List<CompletedTaskReport> progList = new ArrayList<>(Arrays.asList(resArray));

		String header = "";
		String title = "                 ";

		DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
		String repDate = DF2.format(new Date());

		try {

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Task Text");
			rowData.add("Client Name");
			rowData.add("Service");
			rowData.add("Activity");
			rowData.add("Task/ Periodicity");
			rowData.add("Execution Partner");
			rowData.add("Manager Name");
			rowData.add("TL Name");
			rowData.add("Due Date");
			rowData.add("Completion Date");
			rowData.add("Employee Budgeted Hrs");
			rowData.add("Total Hrs Employee");
			rowData.add("Google Drive Link");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < progList.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + progList.get(i).getTaskText());
				rowData.add("" + progList.get(i).getCustFirmName());
				rowData.add("" + progList.get(i).getServName());
				rowData.add("" + progList.get(i).getActiName());
				rowData.add("" + progList.get(i).getPeriodicityName());
				rowData.add("" + progList.get(i).getPartner());
				rowData.add("" + progList.get(i).getManager());
				rowData.add("" + progList.get(i).getTeamLeader());
				// System.out.println("stat date" + progList.get(i).getTaskStatutoryDueDate());
				// System.out.println("end date" + progList.get(i).getTaskEndDate());
				if (progList.get(i).getTaskStatutoryDueDate() != " "
						&& progList.get(i).getTaskStatutoryDueDate() != null) {

					rowData.add("" + progList.get(i).getTaskStatutoryDueDate());
				} else {
					rowData.add("" + "-");
				}

				if (progList.get(i).getTaskEndDate() != " " && progList.get(i).getTaskEndDate() != null) {
					rowData.add("" + progList.get(i).getTaskEndDate());
				} else {
					rowData.add("" + "-");
				}

				rowData.add("" + progList.get(i).getEmpBudHr());
				rowData.add("" + progList.get(i).getWorkHours());
				rowData.add(progList.get(i).getExVar1());

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						"Emp Name:" + emp.getEmpName() + " From Date:" + fromDate + "   To Date:" + toDate + "", "",
						'M');

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

	@RequestMapping(value = "/showMangPerfHeadList", method = RequestMethod.GET)
	public ModelAndView mangPerfHeadList(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;
		System.err.println("Hello");

		try {
			List<EmployeeMaster> epmList=new ArrayList<EmployeeMaster>();
			mav = new ModelAndView("report/Manager/mangPerfHeadList");
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			String empIdList = new String();
			int empId = 0;
			try {
				empId = Integer.parseInt(request.getParameter("empId"));
			} catch (Exception e) {
				empId = 0;
			}
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("empId", userId);
			EmployeeMaster[] employee = Constants.getRestTemplate()
					.postForObject(Constants.url + "/getAllEmployeesByIds", map, EmployeeMaster[].class);
			 epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
			if (empId == 0) {

				// System.out.println("emp are**********" + epmList.toString());
				for (int i = 0; i < epmList.size(); i++) {
					empIdList = empIdList + "," + epmList.get(i).getEmpId();
				}
				

			} else {
				
				empIdList = String.valueOf(empId);
				
			}
			mav.addObject("epmList", epmList);
			mav.addObject("empId", empId);

			String yearrange = null;
			try {
				yearrange = request.getParameter("yearrange");
				mav.addObject("yearrange", yearrange);
			} catch (Exception e) {
				yearrange = null;
			}
			if (yearrange != null) {
				String[] fromDate = yearrange.split(" to ");
			map = new LinkedMultiValueMap<String, Object>();

				map.add("fromDate", DateConvertor.convertToYMD(fromDate[0]));
				map.add("toDate", DateConvertor.convertToYMD(fromDate[1]));
				map.add("empIdList", empIdList);
				EmpAndMngPerformanceRep[] resArray = Constants.getRestTemplate().postForObject(
						Constants.url + "getEmpAndMngPerformanceReportHead", map, EmpAndMngPerformanceRep[].class);
				List<EmpAndMngPerformanceRep> progList = new ArrayList<>(Arrays.asList(resArray));
				System.err.println("progList 1"+progList);
				mav.addObject("progList", progList);

				/*
				 * for (int i = 0; i < progList.size(); i++) { float a =
				 * Float.parseFloat(progList.get(i).getActWork()); float b =
				 * Float.parseFloat(progList.get(i).getBudgetedCap()); float c = b - a;
				 * 
				 * progList.get(i).setExVar1(String.valueOf(c));
				 * 
				 * }
				 */
				System.err.println("progList 2"+progList);

				mav.addObject("fromDate", fromDate[0]);
				mav.addObject("toDate", fromDate[1]);
				mav.addObject("emps", empId);
			}
		} catch (Exception e) {

			e.printStackTrace();

		}

		return mav;
	}

	@RequestMapping(value = "/showEmpAndMngPerformanceRep", method = RequestMethod.GET)
	public void showEmpAndMngPerformanceRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee And Manager Performance Report Header";
		try {

			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");

			String empIdList = new String();
			int empId = Integer.parseInt(request.getParameter("emps"));
			if (empId == 0) {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("empId", userId);
				EmployeeMaster[] employee = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllEmployeesByIds", map, EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));

				// System.out.println("emp are**********" + epmList.toString());
				for (int i = 0; i < epmList.size(); i++) {
					empIdList = empIdList + "," + epmList.get(i).getEmpId();
				}

			} else {
				empIdList = String.valueOf(empId);
			}

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("empIdList", empIdList);
			EmpAndMngPerformanceRep[] resArray = Constants.getRestTemplate().postForObject(
					Constants.url + "getEmpAndMngPerformanceReportHead", map, EmpAndMngPerformanceRep[].class);
			List<EmpAndMngPerformanceRep> progList = new ArrayList<>(Arrays.asList(resArray));
		

					List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

					ExportToExcel expoExcel = new ExportToExcel();
					List<String> rowData = new ArrayList<String>();

					rowData.add("Sr. No");
					rowData.add("Employee Name");
					rowData.add("No. of Tasks");
					rowData.add("Budgeted Time");
					rowData.add("Actual Time in Selected Period");
					rowData.add("Actual Till Date");
					rowData.add("Total Available Hrs");

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					int cnt = 1;
					for (int i = 0; i < progList.size(); i++) {
						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();
						cnt = cnt + i;

						rowData.add("" + (i + 1));
						rowData.add("" + progList.get(i).getEmpName());
						rowData.add("" + progList.get(i).getTaskCount());
						rowData.add("" + progList.get(i).getAllWork());
						rowData.add("" + progList.get(i).getActWork());
						rowData.add("" + progList.get(i).getExVar1());

						rowData.add("" + progList.get(i).getBudgetedCap());
				/*
				 * float a = Float.parseFloat(progList.get(i).getActWork()); float b =
				 * Float.parseFloat(progList.get(i).getBudgetedCap()); float c = b - a;
				 * rowData.add("" + c);
				 */

						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

					}

					XSSFWorkbook wb = null;
					try {

						wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
								"From Date:" + fromDate + "   To Date:" + toDate + "", "", 'G');

						ExceUtil.autoSizeColumns(wb, 3);
						response.setContentType("application/vnd.ms-excel");
						String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
						response.setHeader("Content-disposition",
								"attachment; filename=" + reportName + "-" + date + ".xlsx");
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

	
	
	@RequestMapping(value = "/showMangPerfHeadListDetailForm", method = RequestMethod.GET)
	public String showMangPerfHeadListDetailForm(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			Model model) {

		String mav = new String();
		try {

			mav = "report/Manager/mangPerfDetailList";
		
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");

			String empId = request.getParameter("empId");
			//System.out.println("prm are:::" + empId + fromDate + toDate);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("empId", empId);
			map.add("status", 9);
			EmpAndMangPerfRepDetail[] resArray = Constants.getRestTemplate().postForObject(
					Constants.url + "getEmpAndMngPerformanceReportDetail", map, EmpAndMangPerfRepDetail[].class);
			List<EmpAndMangPerfRepDetail> perfList = new ArrayList<>(Arrays.asList(resArray));
			
			//System.out.println("perfList task**"+perfList.size());
			System.out.println("perfList task**"+perfList.toString());
			model.addAttribute("perfList",perfList);
			model.addAttribute("fromDate", fromDate);
			model.addAttribute("toDate", toDate);
			model.addAttribute("empId", empId);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
 
	@RequestMapping(value = "/showMangPerfHeadListDetail", method = RequestMethod.GET)
	public void showMangPerfHeadListDetail(HttpServletRequest request, HttpServletResponse response) {
//
		String reportName = "Employee Manager Performance Detail Report ";

		try {
			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");

			String empId = request.getParameter("empId");
		// System.out.println("prm are:::" + empId + fromDate + toDate);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("fromDate", DateConvertor.convertToYMD(fromDate));
			map.add("toDate", DateConvertor.convertToYMD(toDate));
			map.add("empId", empId);
			map.add("status", 9);
			EmpAndMangPerfRepDetail[] resArray = Constants.getRestTemplate().postForObject(
					Constants.url + "getEmpAndMngPerformanceReportDetail", map, EmpAndMangPerfRepDetail[].class);
			List<EmpAndMangPerfRepDetail> progList = new ArrayList<>(Arrays.asList(resArray));
			//System.out.println("perfList task**"+progList.size());

			
					List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

					ExportToExcel expoExcel = new ExportToExcel();
					List<String> rowData = new ArrayList<String>();

					rowData.add("Sr. No");
					rowData.add("Task Text");
					rowData.add("Client Name");
					rowData.add("Service");
					rowData.add("Activity");
					rowData.add("Task/ Periodicity");
					rowData.add("Owner Partner");
					rowData.add("Execution Partner");
					rowData.add("Employee");
					rowData.add("TL Name");
					rowData.add("Due Date");
					rowData.add("Work Date");
					rowData.add("Status");
					rowData.add("Completion Date");
					rowData.add("Employee Budgeted Hrs");
					//rowData.add("Total Hrs Employee");
					//rowData.add("TL Total Hrs");
					//rowData.add("Manager Budgeted Hrs");
					//rowData.add("Manager Total Hrs");
					//rowData.add("Total manager hrs for selected period");
					rowData.add("Employee hrs for selected period");
					//rowData.add("Total TL hrs for selected period");
					rowData.add("Actual Till Date");
					rowData.add("Google drive Link");

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					int cnt = 1;
					for (int i = 0; i < progList.size(); i++) {
						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();
						cnt = cnt + i;

						rowData.add("" + (i + 1));
						rowData.add("" + progList.get(i).getTaskText());
						rowData.add("" + progList.get(i).getCustFirmName());
						rowData.add("" + progList.get(i).getServName());
						rowData.add("" + progList.get(i).getActiName());
						rowData.add("" + progList.get(i).getPeriodicityName());
						rowData.add("" + progList.get(i).getOwnerPartner());
						rowData.add("" + progList.get(i).getPartner());
						rowData.add("" + progList.get(i).getEmployee());
						rowData.add("" + progList.get(i).getTeamLeader());

						if (progList.get(i).getTaskStatutoryDueDate() != ""
								&& progList.get(i).getTaskStatutoryDueDate() != null) {
							//String[] splited1 = progList.get(i).getTaskStatutoryDueDate().split("T");
							rowData.add("" + progList.get(i).getTaskStatutoryDueDate() );
						} else {
							rowData.add("" + "-");
						}
						if (progList.get(i).getTaskEndDate() != "" && progList.get(i).getTaskEndDate() != null) {
							//String[] splited2 = progList.get(i).getTaskEndDate().split("T");
							rowData.add("" + progList.get(i).getTaskEndDate());
						} else {
							rowData.add("" + "-");
						}

						rowData.add("" + progList.get(i).getStatusText());
						
						if (progList.get(i).getTaskCompletionDate() != ""
								&& progList.get(i).getTaskCompletionDate() != null) {
							//String[] splited3 = progList.get(i).getTaskCompletionDate().split("T");
							rowData.add("" +progList.get(i).getTaskCompletionDate());
						} else {
							rowData.add("" + "-");
						}

						rowData.add("" + progList.get(i).getEmpBudHr());
						//rowData.add("" + progList.get(i).getTeamLeaderHrs());
						//rowData.add("" + progList.get(i).getMngrBudHr());
						//rowData.add("" + progList.get(i).getManagerHrs());
						//rowData.add("" + progList.get(i).getManagerBetHrs());
						rowData.add("" + progList.get(i).getEmpBetHrs());//act bet sel date 
						rowData.add("" + progList.get(i).getEmployeeHrs());//act till date

						//rowData.add("" + progList.get(i).getTlBetHrs());
						rowData.add("" + progList.get(i).getExVar1());

						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

					}

					XSSFWorkbook wb = null;
					try {

						wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
								"From Date:" + fromDate + "   To Date:" + toDate + "", "", 'W');

						ExceUtil.autoSizeColumns(wb, 3);
						response.setContentType("application/vnd.ms-excel");
						String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
						response.setHeader("Content-disposition",
								"attachment; filename=" + reportName + "-" + date + ".xlsx");
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

	//Declined task report Sachin 28-03-2020

	@RequestMapping(value = "/showInactiveTaskReportForManagerForm", method = RequestMethod.GET)
	public String showInactiveTaskReportForManagerForm(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		String mav = new String();
		try {

			mav = "report/Manager/inactiveTaskForManager";
			String yearrange = request.getParameter("monthyear");
			// System.out.println("yearrange***"+yearrange);
			if (yearrange != null) {

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				String[] fromDate = yearrange.split(" to ");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("fromDate1", DateConvertor.convertToYMD(fromDate[0]));
				map.add("toDate1", DateConvertor.convertToYMD(fromDate[1]));
				map.add("empIds", String.valueOf(userId));
				map.add("status", 7);
				InactiveTaskReport[] resArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "getInactiveTaskReport", map, InactiveTaskReport[].class);
				List<InactiveTaskReport> cmpTaskList = new ArrayList<>(Arrays.asList(resArray));
				for (int i = 0; i < cmpTaskList.size(); i++) {
					if (cmpTaskList.get(i).getTaskStatutoryDueDate() == " "
							&& cmpTaskList.get(i).getTaskStatutoryDueDate() == null) {
						cmpTaskList.get(i).setTaskStatutoryDueDate("-");

					}

					if (cmpTaskList.get(i).getTaskEndDate() == " " && cmpTaskList.get(i).getTaskEndDate() == null) {
						cmpTaskList.get(i).setTaskEndDate("-");
					}
				}

				model.addAttribute("cmpTaskList", cmpTaskList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	//Declined task report

	@RequestMapping(value = "/showInactiveTaskRepForManager", method = RequestMethod.GET)
	public void showInactiveTaskRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Declined Task";

		try {
			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("fromDate1", DateConvertor.convertToYMD(fromDate));
			map.add("toDate1", DateConvertor.convertToYMD(toDate));
			map.add("empIds", String.valueOf(userId));
			map.add("status", 7);
			InactiveTaskReport[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getInactiveTaskReport", map, InactiveTaskReport[].class);
			List<InactiveTaskReport> progList = new ArrayList<>(Arrays.asList(resArray));
			//System.err.println("getInactiveTaskReport**" + progList.toString());

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Task Text");
			rowData.add("Client Name");
			rowData.add("Service");
			rowData.add("Activity");
			rowData.add("Task/ Periodicity");
			rowData.add("Owner Partner");
			rowData.add("Execution Partner");
			rowData.add("Employee Name");
			rowData.add("TL Name");
			rowData.add("Due Date");
			rowData.add("Inactive Date");
			rowData.add("Employee Budgeted Hrs");
			rowData.add("Total Hrs Employee");
			rowData.add("TL Total Hrs");
			rowData.add("Manager Budgeted Hrs");
			rowData.add("Manager Total Hrs");
			rowData.add("Google Drive Link");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < progList.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + progList.get(i).getTaskText());
				rowData.add("" + progList.get(i).getCustFirmName());
				rowData.add("" + progList.get(i).getServName());
				rowData.add("" + progList.get(i).getActiName());
				rowData.add("" + progList.get(i).getPeriodicityName());
				rowData.add("" + progList.get(i).getOwnerPartner());
				rowData.add("" + progList.get(i).getPartner());
				rowData.add("" + progList.get(i).getEmployee());
				rowData.add("" + progList.get(i).getTeamLeader());
				//String[] splited = progList.get(i).getTaskStatutoryDueDate().split(" ");
				rowData.add("" + progList.get(i).getTaskStatutoryDueDate());
				if (progList.get(i).getTaskEndDate() != "" && progList.get(i).getTaskEndDate() != null) {
					//String[] splited1 = progList.get(i).getTaskEndDate().split(" ");
					rowData.add("" + progList.get(i).getTaskEndDate());
				} else {
					rowData.add("" + "-");
				}
				rowData.add("" + progList.get(i).getEmpBudHr());
				rowData.add("" + progList.get(i).getEmployeeHrs());
				rowData.add("" + progList.get(i).getTeamLeaderHrs());
				rowData.add("" + progList.get(i).getMngrBudHr());

				rowData.add("" + progList.get(i).getManagerHrs());
				rowData.add("" + progList.get(i).getExVar1());

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						"Manager Name:" + emp.getEmpName() + " From Date:" + fromDate + "   To Date:" + toDate + "", "",
						'R');

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

	@RequestMapping(value = "/showCompTaskReportFormanager", method = RequestMethod.GET)
	public String showCompTaskReportFormanager(HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Model model) {

		String mav = new String();
		try {

			mav = "report/Manager/compTaskForManager";
			String yearrange = request.getParameter("monthyear");
			System.out.println("yearrange***" + yearrange);
			if (yearrange != null) {

				EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
				int userId = emp.getEmpId();

				String[] fromDate = yearrange.split(" to ");

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("fromDate1", DateConvertor.convertToYMD(fromDate[0]));
				map.add("toDate1", DateConvertor.convertToYMD(fromDate[1]));
				map.add("empIds", String.valueOf(userId));
				map.add("status", 9);
				InactiveTaskReport[] resArray = Constants.getRestTemplate()
						.postForObject(Constants.url + "getInactiveTaskReport", map, InactiveTaskReport[].class);
				List<InactiveTaskReport> cmpTaskList = new ArrayList<>(Arrays.asList(resArray));
				for (int i = 0; i < cmpTaskList.size(); i++) {
					if (cmpTaskList.get(i).getTaskStatutoryDueDate() == " "
							&& cmpTaskList.get(i).getTaskStatutoryDueDate() == null) {
						cmpTaskList.get(i).setTaskStatutoryDueDate("-");

					}

					if (cmpTaskList.get(i).getTaskEndDate() == " " && cmpTaskList.get(i).getTaskEndDate() == null) {
						cmpTaskList.get(i).setTaskEndDate("-");
					}
				}

				model.addAttribute("cmpTaskList", cmpTaskList);
				model.addAttribute("fromDate", fromDate[0]);
				model.addAttribute("toDate", fromDate[1]);
				model.addAttribute("yearrange", yearrange);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	@RequestMapping(value = "/showCompletedTaskRepForManager", method = RequestMethod.GET)
	public void showCompletedTaskRepForManager(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Completed Task(Manager)";

		try {
			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();

			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			map.add("fromDate1", DateConvertor.convertToYMD(fromDate));
			map.add("toDate1", DateConvertor.convertToYMD(toDate));
			map.add("empIds", String.valueOf(userId));
			map.add("status", 9);
			InactiveTaskReport[] resArray = Constants.getRestTemplate()
					.postForObject(Constants.url + "getInactiveTaskReport", map, InactiveTaskReport[].class);
			List<InactiveTaskReport> progList = new ArrayList<>(Arrays.asList(resArray));
			//System.err.println("getInactiveTaskReport**" + progList.toString());

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No");
			rowData.add("Task Text");
			rowData.add("Client Name");
			rowData.add("Service");
			rowData.add("Activity");
			rowData.add("Task/ Periodicity");
			rowData.add("Owner Partner");
			rowData.add("Execution Partner");
			rowData.add("Employee Name");
			rowData.add("TL Name");
			rowData.add("Due Date");
			rowData.add("Completion Date");
			rowData.add("Employee Budgeted Hrs");
			rowData.add("Total Hrs Employee");
			rowData.add("TL Total Hrs");
			rowData.add("Manager Budgeted Hrs");
			rowData.add("Manager Total Hrs");
			rowData.add("Google Drive Link");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;
			for (int i = 0; i < progList.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + progList.get(i).getTaskText());
				rowData.add("" + progList.get(i).getCustFirmName());
				rowData.add("" + progList.get(i).getServName());
				rowData.add("" + progList.get(i).getActiName());
				rowData.add("" + progList.get(i).getPeriodicityName());
				rowData.add("" + progList.get(i).getOwnerPartner());
				rowData.add("" + progList.get(i).getPartner());
				rowData.add("" + progList.get(i).getEmployee());
				rowData.add("" + progList.get(i).getTeamLeader());
				//String[] splited = progList.get(i).getTaskStatutoryDueDate().split(" ");
				rowData.add("" +  progList.get(i).getTaskStatutoryDueDate());
				if (progList.get(i).getTaskStartDate() != "" && progList.get(i).getTaskStartDate() != null) {
					//String[] splited1 = progList.get(i).getTaskStartDate().split(" ");
					rowData.add("" + progList.get(i).getTaskStartDate());
				} else {
					rowData.add("" + "-");
				}
				rowData.add("" + progList.get(i).getEmpBudHr());
				rowData.add("" + progList.get(i).getEmployeeHrs());
				rowData.add("" + progList.get(i).getTeamLeaderHrs());
				rowData.add("" + progList.get(i).getMngrBudHr());

				rowData.add("" + progList.get(i).getManagerHrs());
				rowData.add("" + progList.get(i).getExVar1());

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						"Manager Name:" + emp.getEmpName() + " From Date:" + fromDate + "   To Date:" + toDate + "", "",
						'R');

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

	@RequestMapping(value = "/showEmployeePartnerGrid", method = RequestMethod.GET)
	public void showEmployeePartnerGrid(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee Partner Grid";

		try {
			List<EmployeeMaster> empList = new ArrayList<EmployeeMaster>();
			HttpSession session = request.getSession();
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			String part = null;

			int part1 = Integer.parseInt(request.getParameter("partner"));
			String yearrange = request.getParameter("fromDate");
			String[] fromDate = yearrange.split(" to ");

			if (part1 == 1) {
				part = "Owner Partner";
			} else {
				part = "Execution Partner";
			}
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<>();

			map.add("fromDate", DateConvertor.convertToYMD(fromDate[0]));
			map.add("toDate", DateConvertor.convertToYMD(fromDate[1]));
			map.add("partnerType", Integer.parseInt(request.getParameter("partner")));

			EmpwithPartnerList[] empwithPartnerList = Constants.getRestTemplate()
					.postForObject(Constants.url + "/employeepartnerwiseworkreport", map, EmpwithPartnerList[].class);
			List<EmpwithPartnerList> empwithpartnerlist = new ArrayList<>(Arrays.asList(empwithPartnerList));

			EmpIdNameList[] empIdNameList = Constants.getRestTemplate().getForObject(Constants.url + "/getPartnerList",
					EmpIdNameList[].class);
			List<EmpIdNameList> partnerList = new ArrayList<>(Arrays.asList(empIdNameList));

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();
			char userLetter = 'F';
			//char userLetter1 = 'Z';
			//char userLetter2 = userLetter1++;
			
			//System.out.println("cahr is "+userLetter2);
			rowData.add("Sr. No");
			rowData.add("Name of Employee/ Manager/ TL");
			rowData.add("Total Hrs");
			rowData.add("Hrs worked");
			rowData.add("Idle time");
			rowData.add("Overtime");
			for (int i = 0; i < partnerList.size(); i++) {

				rowData.add(partnerList.get(i).getEmpName());
				userLetter++;
			}

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			int cnt = 1;

			for (int i = 0; i < empwithpartnerlist.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				cnt = cnt + i;

				rowData.add("" + (i + 1));
				rowData.add("" + empwithpartnerlist.get(i).getEmpName());
				rowData.add("" + empwithpartnerlist.get(i).getBugetedHrs());
				rowData.add("" + empwithpartnerlist.get(i).getWorkedHrs());
				rowData.add("" + empwithpartnerlist.get(i).getIdealtime());
				rowData.add("" + empwithpartnerlist.get(i).getOvertime());

				for (int j = 0; j < empwithpartnerlist.get(i).getList().size(); j++) {
					rowData.add("" + empwithpartnerlist.get(i).getList().get(j).getTotalHrs());

				}
				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}
			// System.out.println("userLetter***" + userLetter);
			XSSFWorkbook wb = null;
			try {

				wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
						"Partner Type:" + part + "  From Date:" + fromDate[0] + "   To Date:" + fromDate[1] + "", "",
						userLetter);

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
}

/***********************
 * Team Leader Task Completed
 *************************************//*
										 * @RequestMapping(value = "/getTeamLeadCompletTask", method =
										 * RequestMethod.POST) public void
										 * getTeamLeadCompletTaskReport(HttpServletRequest request, HttpServletResponse
										 * response) {
										 * 
										 * String reportName = "Team Leader Task Completed";
										 * 
										 * try {
										 * 
										 * 
										 * String fromDate = request.getParameter("fromDate"); String toDate =
										 * request.getParameter("toDate");
										 * System.out.println("Dates--------"+fromDate+" to "+toDate);
										 * 
										 * MultiValueMap<String, Object> map = new LinkedMultiValueMap<String,
										 * Object>(); String fDate = DateConvertor.convertToYMD(fromDate); String tDate
										 * = DateConvertor.convertToYMD(toDate); map.add("fromDate",
										 * fDate.concat("  00:00:01")); map.add("toDate", tDate.concat("  23:59:59"));
										 * 
										 * TlTaskCompletReport[] ttlArr = Constants.getRestTemplate()
										 * .postForObject(Constants.url + "/getTlCompletedTeskRepot", map,
										 * TlTaskCompletReport[].class); List<TlTaskCompletReport> ttlList = new
										 * ArrayList<TlTaskCompletReport>(Arrays.asList(ttlArr));
										 * System.out.println("List-------------"+ttlList);
										 * 
										 * Document document = new Document(PageSize.A4); document.setMargins(50, 45,
										 * 50, 60); document.setMarginMirroring(false);
										 * 
										 * String FILE_PATH = Constants.REPORT_SAVE; File file = new File(FILE_PATH);
										 * 
										 * PdfWriter writer = null;
										 * 
										 * FileOutputStream out = new FileOutputStream(FILE_PATH); try { writer =
										 * PdfWriter.getInstance(document, out); } catch (DocumentException e) {
										 * 
										 * e.printStackTrace(); }
										 * 
										 * String header = ""; String title = "                 ";
										 * 
										 * DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy"); String repDate =
										 * DF2.format(new Date());
										 * 
										 * ItextPageEvent event = new ItextPageEvent(header, title, "", "");
										 * 
										 * writer.setPageEvent(event); // writer.add(new
										 * Paragraph("Curricular Aspects"));
										 * 
										 * PdfPTable table = new PdfPTable(14);
										 * 
										 * table.setHeaderRows(1);
										 * 
										 * try { table.setWidthPercentage(100); table.setWidths(new float[] { 2.3f,
										 * 2.3f, 2.3f, 2.3f,2.3f, 2.3f, 2.3f, 2.3f,2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f
										 * }); Font headFontData = ReportCostants.headFontData;// new
										 * Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL, // BaseColor.BLACK); Font
										 * tableHeaderFont = ReportCostants.tableHeaderFont; // new
										 * Font(FontFamily.HELVETICA, 12, Font.BOLD, // BaseColor.BLACK);
										 * tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);
										 * 
										 * PdfPCell hcell = new PdfPCell();
										 * hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);
										 * 
										 * hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("Client Name", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("Service", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("Activity", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * 
										 * hcell = new PdfPCell(new Phrase("Task/ Periodicity", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("Execution Partner", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("Manager Name", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("TL Name", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("Due Date", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("Completion Date", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * hcell = new PdfPCell(new Phrase("Employee Budgeted Hrs", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * 
										 * hcell = new PdfPCell(new Phrase("Total Hrs Employee", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * 
										 * hcell = new PdfPCell(new Phrase("TL Hrs Total", tableHeaderFont));
										 * hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * 
										 * hcell = new PdfPCell(new Phrase("TL Hrs for the selected period",
										 * tableHeaderFont)); hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);
										 * 
										 * table.addCell(hcell);
										 * 
										 * 
										 * int index = 0; for (int i = 0; i < ttlList.size(); i++) { //
										 * System.err.println("I " + i); TlTaskCompletReport prog = ttlList.get(i);
										 * 
										 * index++; PdfPCell cell; cell = new PdfPCell(new Phrase(String.valueOf(index),
										 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_CENTER);
										 * 
										 * table.addCell(cell);
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getClientName(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_LEFT);
										 * 
										 * table.addCell(cell);
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getService(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getActivity(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getTaskPeriodicity(),
										 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getExecutionPartner(),
										 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getManagerName(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getTeamLeadName(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getDueDate(), headFontData));
										 * //statutory due date cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getCompletionDate(), headFontData));
										 * //end date cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getEmpBudHr(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getTtlEmpHrs(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getTlTotalHrs(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * cell = new PdfPCell(new Phrase("" + prog.getTlPeriodHrs(), headFontData));
										 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
										 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
										 * 
										 * table.addCell(cell);
										 * 
										 * }
										 * 
										 * document.open(); Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f,
										 * Font.UNDERLINE, BaseColor.BLACK);
										 * 
										 * Paragraph name = new Paragraph(reportName, hf);
										 * name.setAlignment(Element.ALIGN_CENTER); document.add(name); document.add(new
										 * Paragraph("\n")); document.add(new Paragraph("Start Date:" + fromDate +
										 * ""+"    ")); document.add(new Paragraph("\n"));
										 * 
										 * DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");
										 * 
										 * document.add(table);
										 * 
										 * int totalPages = writer.getPageNumber();
										 * 
										 * // System.out.println("Page no " + totalPages);
										 * 
										 * document.close(); int p = Integer.parseInt(request.getParameter("p")); //
										 * System.err.println("p " + p);
										 * 
										 * if (p == 1) {
										 * 
										 * if (file != null) {
										 * 
										 * String mimeType = URLConnection.guessContentTypeFromName(file.getName());
										 * 
										 * if (mimeType == null) {
										 * 
										 * mimeType = "application/pdf";
										 * 
										 * }
										 * 
										 * response.setContentType(mimeType);
										 * 
										 * response.addHeader("content-disposition",
										 * String.format("inline; filename=\"%s\"", file.getName()));
										 * 
										 * response.setContentLength((int) file.length());
										 * 
										 * InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
										 * 
										 * try { FileCopyUtils.copy(inputStream, response.getOutputStream()); } catch
										 * (IOException e) { // System.out.println("Excep in Opening a Pdf File");
										 * e.printStackTrace(); } } } else {
										 * 
										 * List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();
										 * 
										 * ExportToExcel expoExcel = new ExportToExcel(); List<String> rowData = new
										 * ArrayList<String>();
										 * 
										 * rowData.add("Sr. No"); rowData.add("Client Name"); rowData.add("Service");
										 * rowData.add("Activity"); rowData.add("Task/ Periodicity");
										 * rowData.add("Execution Partner"); rowData.add("Manager Name");
										 * rowData.add("TL Name"); rowData.add("Due Date");
										 * rowData.add("Completion Date"); rowData.add("Employee Budgeted Hrs");
										 * rowData.add("Total Hrs Employee"); rowData.add("TL Hrs total");
										 * rowData.add("TL Hrs for the selected period");
										 * 
										 * expoExcel.setRowData(rowData); exportToExcelList.add(expoExcel); int cnt = 1;
										 * for (int i = 0; i < ttlList.size(); i++) { expoExcel = new ExportToExcel();
										 * rowData = new ArrayList<String>(); cnt = cnt + i;
										 * 
										 * rowData.add("" + (i + 1)); rowData.add("" + ttlList.get(i).getClientName());
										 * rowData.add("" + ttlList.get(i).getService()); rowData.add("" +
										 * ttlList.get(i).getActivity()); rowData.add("" +
										 * ttlList.get(i).getTaskPeriodicity()); rowData.add("" +
										 * ttlList.get(i).getExecutionPartner()); rowData.add("" +
										 * ttlList.get(i).getManagerName()); rowData.add("" +
										 * ttlList.get(i).getTeamLeadName()); rowData.add("" +
										 * ttlList.get(i).getDueDate()); rowData.add("" +
										 * ttlList.get(i).getCompletionDate()); rowData.add("" +
										 * ttlList.get(i).getEmpBudHr()); rowData.add("" +
										 * ttlList.get(i).getTtlEmpHrs()); rowData.add("" +
										 * ttlList.get(i).getTlTotalHrs()); rowData.add("" +
										 * ttlList.get(i).getTlPeriodHrs());
										 * 
										 * 
										 * expoExcel.setRowData(rowData); exportToExcelList.add(expoExcel);
										 * 
										 * }
										 * 
										 * XSSFWorkbook wb = null; try {
										 * 
										 * wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "From Date:"
										 * +fromDate + "", "", 'L');
										 * 
										 * ExceUtil.autoSizeColumns(wb, 3);
										 * response.setContentType("application/vnd.ms-excel"); String date = new
										 * SimpleDateFormat("yyyy-MM-dd").format(new Date());
										 * response.setHeader("Content-disposition", "attachment; filename=" +
										 * reportName + "-" + date + ".xlsx"); wb.write(response.getOutputStream());
										 * 
										 * } catch (IOException ioe) { throw new
										 * RuntimeException("Error writing spreadsheet to output stream"); } finally {
										 * if (wb != null) { wb.close(); } }
										 * 
										 * }
										 * 
										 * } catch (DocumentException ex) {
										 * 
										 * // System.out.println("Pdf Generation Error: " + ex.getMessage());
										 * 
										 * ex.printStackTrace();
										 * 
										 * }
										 * 
										 * } catch (Exception e) {
										 * 
										 * System.err.println("Exce in showProgReport " + e.getMessage());
										 * e.printStackTrace();
										 * 
										 * }
										 * 
										 * }
										 */
