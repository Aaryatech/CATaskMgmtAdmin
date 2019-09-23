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

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
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
import com.ats.taskmgmtadmin.model.EmployeeMaster;
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

		} catch (Exception e) {

			System.err.println("Exce in showReports " + e.getMessage());
			e.printStackTrace();

		}

		return model;
	}

	@RequestMapping(value = "/showMangPerfHeadList", method = RequestMethod.POST)
	public ModelAndView mangPerfHeadList(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		ModelAndView mav = null;
		System.err.println("Hello");

		try {

			mav = new ModelAndView("report/mangPerfHeadList");
			EmployeeMaster emp = (EmployeeMaster) session.getAttribute("empLogin");
			int userId = emp.getEmpId();
			String fromDate = request.getParameter("fromDate");
			String toDate = request.getParameter("toDate");
			String empIdList = new String();
			int empId = Integer.parseInt(request.getParameter("empId"));
			if (empId == 0) {

				MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

				map.add("empId", userId);
				EmployeeMaster[] employee = Constants.getRestTemplate()
						.postForObject(Constants.url + "/getAllEmployeesByIds", map, EmployeeMaster[].class);
				List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));

				System.out.println("emp are**********" + epmList.toString());
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
			System.err.println("getInactiveTaskReport**" + progList.toString());
			mav.addObject("progList", progList);
			mav.addObject("fromDate", fromDate);
			mav.addObject("toDate", toDate);
			mav.addObject("emps", empId);

		} catch (Exception e) {

			e.printStackTrace();

		}

		return mav;
	}
	
	@RequestMapping(value = "/showEmpAndMngPerformanceRep", method = RequestMethod.POST)
	public void showEmpAndMngPerformanceRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Employee And Manager Performance Report";
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

				System.out.println("emp are**********" + epmList.toString());
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
			System.err.println("getInactiveTaskReport**" + progList.toString());
			Document document = new Document(PageSize.A4);
			document.setMargins(50, 45, 50, 60);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(8);

			table.setHeaderRows(1);

			try {
				table.setWidthPercentage(100);
				table.setWidths(new float[] { 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f });
				Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
				// BaseColor.BLACK);
				Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																		// BaseColor.BLACK);
				tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

				PdfPCell hcell = new PdfPCell();
				hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

				hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("No. of tasks", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Budgeted Time", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Actual Time in Selected Period", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Actual Till Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Total Available Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Variance", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				int index = 0;
				for (int i = 0; i < progList.size(); i++) {
					// System.err.println("I " + i);
					EmpAndMngPerformanceRep prog = progList.get(i);

					index++;
					PdfPCell cell;
					cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmpName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getTaskCount(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getActWork(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getAllWork(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getTillDate(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getBudgetedCap(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getExVar1(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

				}

				document.open();
				Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

				Paragraph name = new Paragraph(reportName, hf);
				name.setAlignment(Element.ALIGN_CENTER);
				document.add(name);
				document.add(new Paragraph("\n"));
				document.add(new Paragraph("Start Date:" + fromDate + "" + "    "));
				document.add(new Paragraph("End Date:" + toDate + "" + "    "));
				document.add(new Paragraph("\n"));

				DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

				document.add(table);

				int totalPages = writer.getPageNumber();

				// System.out.println("Page no " + totalPages);

				document.close();
				int p = Integer.parseInt(request.getParameter("p"));
				// System.err.println("p " + p);

				if (p == 1) {

					if (file != null) {

						String mimeType = URLConnection.guessContentTypeFromName(file.getName());

						if (mimeType == null) {

							mimeType = "application/pdf";

						}

						response.setContentType(mimeType);

						response.addHeader("content-disposition",
								String.format("inline; filename=\"%s\"", file.getName()));

						response.setContentLength((int) file.length());

						InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

						try {
							FileCopyUtils.copy(inputStream, response.getOutputStream());
						} catch (IOException e) {
							// System.out.println("Excep in Opening a Pdf File");
							e.printStackTrace();
						}
					}
				} else {

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
						rowData.add("" + 0);
						rowData.add("" + progList.get(i).getActWork());
						rowData.add("" + 0);

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

				}

			} catch (DocumentException ex) {

				// System.out.println("Pdf Generation Error: " + ex.getMessage());

				ex.printStackTrace();

			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}


	@RequestMapping(value = "/showMangPerfHeadListDetail", method = RequestMethod.POST)
	public void showMangPerfHeadListDetail(HttpServletRequest request, HttpServletResponse response) {
//
		String reportName = "Employee Manager Performance Report Detail";

		try {
			HttpSession session = request.getSession();
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
			List<EmpAndMangPerfRepDetail> progList = new ArrayList<>(Arrays.asList(resArray));

			Document document = new Document(PageSize.A4);
			document.setMargins(50, 45, 50, 60);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(12);

			table.setHeaderRows(1);

			try {
				table.setWidthPercentage(100);
				table.setWidths(new float[] { 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f });
				Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
				// BaseColor.BLACK);
				Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																		// BaseColor.BLACK);
				tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

				PdfPCell hcell = new PdfPCell();
				hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

				hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Client Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Service", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Activity", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Task/ Periodicity", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Execution partner", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Manager Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("TL Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Due Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Completion Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);
				hcell = new PdfPCell(new Phrase("Employee Budgeted Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);
				hcell = new PdfPCell(new Phrase("Total Hrs Employee", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				int index = 0;
				for (int i = 0; i < progList.size(); i++) {
					// System.err.println("I " + i);
					EmpAndMangPerfRepDetail prog = progList.get(i);

					index++;
					PdfPCell cell;
					cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getCustFirmName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getServName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getActiName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getPeriodicityName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getPartner(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getManager(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getTeamLeader(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					String[] splited = prog.getTaskStatutoryDueDate().split("T");
					// Date date=new
					// SimpleDateFormat("dd/MM/yyyy").parse(prog.getTaskStatutoryDueDate());
					cell = new PdfPCell(new Phrase("" + splited[0], headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);
					String[] splited1 = prog.getTaskEndDate().split("T");

					// Date date1=new SimpleDateFormat("dd/MM/yyyy").parse(prog.getTaskEndDate());
					cell = new PdfPCell(new Phrase("" + splited1[0], headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmpBudHr(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getWorkHours(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

				}

				document.open();
				Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

				Paragraph name = new Paragraph(reportName, hf);
				name.setAlignment(Element.ALIGN_CENTER);
				document.add(name);
				document.add(new Paragraph("\n"));
				document.add(new Paragraph("Start Date:" + fromDate + "" + "    "));
				document.add(new Paragraph("End Date:" + toDate + "" + "    "));
				document.add(new Paragraph("\n"));

				DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

				document.add(table);

				int totalPages = writer.getPageNumber();

				// System.out.println("Page no " + totalPages);

				document.close();
				int p = Integer.parseInt(request.getParameter("p"));
				// System.err.println("p " + p);

				if (p == 1) {

					if (file != null) {

						String mimeType = URLConnection.guessContentTypeFromName(file.getName());

						if (mimeType == null) {

							mimeType = "application/pdf";

						}

						response.setContentType(mimeType);

						response.addHeader("content-disposition",
								String.format("inline; filename=\"%s\"", file.getName()));

						response.setContentLength((int) file.length());

						InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

						try {
							FileCopyUtils.copy(inputStream, response.getOutputStream());
						} catch (IOException e) {
							// System.out.println("Excep in Opening a Pdf File");
							e.printStackTrace();
						}
					}
				} else {

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
					rowData.add("Total Hrs Employee");
					rowData.add("TL Total Hrs");
					rowData.add("Manager Budgeted Hrs");
					rowData.add("Manager Total Hrs");
					rowData.add("Total manager hrs for selected period");
					rowData.add("Total Employee hrs for selected period");
					rowData.add("Total TL hrs for selected period");
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
						String[] splited1 = progList.get(i).getTaskStatutoryDueDate().split("T");
						rowData.add("" + DateConvertor.convertToDMY(splited1[0]));
						String[] splited2 = progList.get(i).getTaskEndDate().split("T");
						rowData.add("" + DateConvertor.convertToDMY(splited2[0]));
						rowData.add("" + progList.get(i).getStatusText());
						System.out.println("******"+progList.get(i).getTaskCompletionDate());
						if(progList.get(i).getTaskCompletionDate()!="" && progList.get(i).getTaskCompletionDate()!=null ) {
							String[] splited3 = progList.get(i).getTaskCompletionDate().split("T");
							rowData.add("" + DateConvertor.convertToDMY(splited3[0]));
						}
						rowData.add("" + "");
						rowData.add("" + progList.get(i).getEmpBudHr());
						rowData.add("" + progList.get(i).getEmployeeHrs());
						rowData.add("" + progList.get(i).getTeamLeaderHrs());
						rowData.add("" + progList.get(i).getMngrBudHr());
						rowData.add("" + progList.get(i).getManagerHrs());
						rowData.add("" + progList.get(i).getManagerBetHrs());
						rowData.add("" + progList.get(i).getEmpBetHrs());
						rowData.add("" + progList.get(i).getTlBetHrs());
						rowData.add("" + progList.get(i).getExvar1());

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

				}

			} catch (DocumentException ex) {

				// System.out.println("Pdf Generation Error: " + ex.getMessage());

				ex.printStackTrace();

			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	
	@RequestMapping(value = "/showCompletedTaskRep", method = RequestMethod.POST)
	public void showStudentParticipatedNssNccReport(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Task completed";

		try {
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

			Document document = new Document(PageSize.A4);
			document.setMargins(50, 45, 50, 60);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(12);

			table.setHeaderRows(1);

			try {
				table.setWidthPercentage(100);
				table.setWidths(new float[] { 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f, 2.3f });
				Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
				// BaseColor.BLACK);
				Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																		// BaseColor.BLACK);
				tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

				PdfPCell hcell = new PdfPCell();
				hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

				hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Client Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Service", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Activity", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Task/ Periodicity", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Execution partner", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Manager Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("TL Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Due Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Completion Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);
				hcell = new PdfPCell(new Phrase("Employee Budgeted Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);
				hcell = new PdfPCell(new Phrase("Total Hrs Employee", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				int index = 0;
				for (int i = 0; i < progList.size(); i++) {
					// System.err.println("I " + i);
					CompletedTaskReport prog = progList.get(i);

					index++;
					PdfPCell cell;
					cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getCustFirmName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getServName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getActiName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getPeriodicityName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getPartner(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getManager(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getTeamLeader(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					String[] splited = prog.getTaskStatutoryDueDate().split(" ");
					// Date date=new
					// SimpleDateFormat("dd/MM/yyyy").parse(prog.getTaskStatutoryDueDate());
					cell = new PdfPCell(new Phrase("" + splited[0], headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);
					String[] splited1 = prog.getTaskEndDate().split(" ");

					// Date date1=new SimpleDateFormat("dd/MM/yyyy").parse(prog.getTaskEndDate());
					cell = new PdfPCell(new Phrase("" + splited1[0], headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmpBudHr(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getWorkHours(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

				}

				document.open();
				Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

				Paragraph name = new Paragraph(reportName, hf);
				name.setAlignment(Element.ALIGN_CENTER);
				document.add(name);
				document.add(new Paragraph("\n"));
				document.add(new Paragraph("Start Date:" + fromDate + "" + "    "));
				document.add(new Paragraph("End Date:" + toDate + "" + "    "));
				document.add(new Paragraph("\n"));

				DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

				document.add(table);

				int totalPages = writer.getPageNumber();

				// System.out.println("Page no " + totalPages);

				document.close();
				int p = Integer.parseInt(request.getParameter("p"));
				// System.err.println("p " + p);

				if (p == 1) {

					if (file != null) {

						String mimeType = URLConnection.guessContentTypeFromName(file.getName());

						if (mimeType == null) {

							mimeType = "application/pdf";

						}

						response.setContentType(mimeType);

						response.addHeader("content-disposition",
								String.format("inline; filename=\"%s\"", file.getName()));

						response.setContentLength((int) file.length());

						InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

						try {
							FileCopyUtils.copy(inputStream, response.getOutputStream());
						} catch (IOException e) {
							// System.out.println("Excep in Opening a Pdf File");
							e.printStackTrace();
						}
					}
				} else {

					List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

					ExportToExcel expoExcel = new ExportToExcel();
					List<String> rowData = new ArrayList<String>();

					rowData.add("Sr. No");
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

					expoExcel.setRowData(rowData);
					exportToExcelList.add(expoExcel);
					int cnt = 1;
					for (int i = 0; i < progList.size(); i++) {
						expoExcel = new ExportToExcel();
						rowData = new ArrayList<String>();
						cnt = cnt + i;

						rowData.add("" + (i + 1));
						rowData.add("" + progList.get(i).getCustFirmName());
						rowData.add("" + progList.get(i).getServName());
						rowData.add("" + progList.get(i).getActiName());
						rowData.add("" + progList.get(i).getPeriodicityName());
						rowData.add("" + progList.get(i).getPartner());
						rowData.add("" + progList.get(i).getManager());
						rowData.add("" + progList.get(i).getTeamLeader());
						rowData.add("" + progList.get(i).getTaskStatutoryDueDate());
						rowData.add("" + progList.get(i).getTaskEndDate());
						rowData.add("" + progList.get(i).getEmpBudHr());
						rowData.add("" + progList.get(i).getWorkHours());

						expoExcel.setRowData(rowData);
						exportToExcelList.add(expoExcel);

					}

					XSSFWorkbook wb = null;
					try {

						wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
								"From Date:" + fromDate + "   To Date:" + toDate + "", "", 'L');

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

				}

			} catch (DocumentException ex) {

				// System.out.println("Pdf Generation Error: " + ex.getMessage());

				ex.printStackTrace();

			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	@RequestMapping(value = "/showInactiveTaskRepForManager", method = RequestMethod.POST)
	public void showInactiveTaskRep(HttpServletRequest request, HttpServletResponse response) {

		String reportName = "Inactive Task";

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
			System.err.println("getInactiveTaskReport**" + progList.toString());

			Document document = new Document(PageSize.A4);
			document.setMargins(50, 45, 50, 60);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(17);

			table.setHeaderRows(1);

			try {
				table.setWidthPercentage(100);
				table.setWidths(new float[] { 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f,
						4.3f, 4.3f, 4.3f, 4.3f, 4.3f });
				Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
				// BaseColor.BLACK);
				Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																		// BaseColor.BLACK);
				tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

				PdfPCell hcell = new PdfPCell();
				hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

				hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Client Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Service", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Activity", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Task/ Periodicity", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Owner Partner", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Execution partner", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("TL Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Due Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Inactive Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);
				hcell = new PdfPCell(new Phrase("Employee Budgeted Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);
				hcell = new PdfPCell(new Phrase("Total Hrs Employee", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("TL Total Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Manager Budgeted Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Manager Total Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Google Drive Link", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				int index = 0;
				for (int i = 0; i < progList.size(); i++) {
					// System.err.println("I " + i);
					InactiveTaskReport prog = progList.get(i);

					index++;
					PdfPCell cell;
					cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getCustFirmName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getServName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getActiName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getPeriodicityName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getOwnerPartner(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getPartner(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmployee(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getTeamLeader(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					String[] splited = prog.getTaskStatutoryDueDate().split(" ");

					cell = new PdfPCell(new Phrase("" + splited[0], headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);
					String[] splited1 = prog.getTaskEndDate().split(" ");

					cell = new PdfPCell(new Phrase("" + splited1[0], headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmpBudHr(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmployeeHrs(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getTeamLeaderHrs(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getMngrBudHr(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getManagerHrs(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getExVar1(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

				}

				document.open();
				Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

				Paragraph name = new Paragraph(reportName, hf);
				name.setAlignment(Element.ALIGN_CENTER);
				document.add(name);
				document.add(new Paragraph("\n"));
				document.add(new Paragraph("Start Date:" + fromDate + "" + "    "));
				document.add(new Paragraph("End Date:" + toDate + "" + "    "));
				document.add(new Paragraph("\n"));

				DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

				document.add(table);

				int totalPages = writer.getPageNumber();

				// System.out.println("Page no " + totalPages);

				document.close();
				int p = Integer.parseInt(request.getParameter("p"));
				// System.err.println("p " + p);

				if (p == 1) {

					if (file != null) {

						String mimeType = URLConnection.guessContentTypeFromName(file.getName());

						if (mimeType == null) {

							mimeType = "application/pdf";

						}

						response.setContentType(mimeType);

						response.addHeader("content-disposition",
								String.format("inline; filename=\"%s\"", file.getName()));

						response.setContentLength((int) file.length());

						InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

						try {
							FileCopyUtils.copy(inputStream, response.getOutputStream());
						} catch (IOException e) {
							// System.out.println("Excep in Opening a Pdf File");
							e.printStackTrace();
						}
					}
				} else {

					List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

					ExportToExcel expoExcel = new ExportToExcel();
					List<String> rowData = new ArrayList<String>();

					rowData.add("Sr. No");
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
						rowData.add("" + progList.get(i).getCustFirmName());
						rowData.add("" + progList.get(i).getServName());
						rowData.add("" + progList.get(i).getActiName());
						rowData.add("" + progList.get(i).getPeriodicityName());
						rowData.add("" + progList.get(i).getOwnerPartner());
						rowData.add("" + progList.get(i).getPartner());
						rowData.add("" + progList.get(i).getEmployee());
						rowData.add("" + progList.get(i).getTeamLeader());
						String[] splited = progList.get(i).getTaskStatutoryDueDate().split(" ");
						rowData.add("" + splited[0]);
						String[] splited1 = progList.get(i).getTaskEndDate().split(" ");
						rowData.add("" + splited1[0]);
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
								"From Date:" + fromDate + "   To Date:" + toDate + "", "", 'Q');

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

				}

			} catch (DocumentException ex) {

				// System.out.println("Pdf Generation Error: " + ex.getMessage());

				ex.printStackTrace();

			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	@RequestMapping(value = "/showCompletedTaskRepForManager", method = RequestMethod.POST)
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
			System.err.println("getInactiveTaskReport**" + progList.toString());

			Document document = new Document(PageSize.A4);
			document.setMargins(50, 45, 50, 60);
			document.setMarginMirroring(false);

			String FILE_PATH = Constants.REPORT_SAVE;
			File file = new File(FILE_PATH);

			PdfWriter writer = null;

			FileOutputStream out = new FileOutputStream(FILE_PATH);
			try {
				writer = PdfWriter.getInstance(document, out);
			} catch (DocumentException e) {

				e.printStackTrace();
			}

			String header = "";
			String title = "                 ";

			DateFormat DF2 = new SimpleDateFormat("dd-MM-yyyy");
			String repDate = DF2.format(new Date());

			ItextPageEvent event = new ItextPageEvent(header, title, "", "");

			writer.setPageEvent(event);
			// writer.add(new Paragraph("Curricular Aspects"));

			PdfPTable table = new PdfPTable(17);

			table.setHeaderRows(1);

			try {
				table.setWidthPercentage(100);
				table.setWidths(new float[] { 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f, 4.3f,
						4.3f, 4.3f, 4.3f, 4.3f, 4.3f });
				Font headFontData = ReportCostants.headFontData;// new Font(FontFamily.TIMES_ROMAN, 12, Font.NORMAL,
				// BaseColor.BLACK);
				Font tableHeaderFont = ReportCostants.tableHeaderFont; // new Font(FontFamily.HELVETICA, 12, Font.BOLD,
																		// BaseColor.BLACK);
				tableHeaderFont.setColor(ReportCostants.tableHeaderFontBaseColor);

				PdfPCell hcell = new PdfPCell();
				hcell.setBackgroundColor(BaseColor.LIGHT_GRAY);

				hcell = new PdfPCell(new Phrase("Sr.No.", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Client Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Service", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Activity", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Task/ Periodicity", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Owner Partner", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Execution partner", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Employee Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("TL Name", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Due Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Completed Date", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);
				hcell = new PdfPCell(new Phrase("Employee Budgeted Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);
				hcell = new PdfPCell(new Phrase("Total Hrs Employee", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("TL Total Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Manager Budgeted Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Manager Total Hrs", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				hcell = new PdfPCell(new Phrase("Google Drive Link", tableHeaderFont));
				hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
				hcell.setBackgroundColor(ReportCostants.baseColorTableHeader);

				table.addCell(hcell);

				int index = 0;
				for (int i = 0; i < progList.size(); i++) {
					// System.err.println("I " + i);
					InactiveTaskReport prog = progList.get(i);

					index++;
					PdfPCell cell;
					cell = new PdfPCell(new Phrase(String.valueOf(index), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_CENTER);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getCustFirmName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_LEFT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getServName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getActiName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getPeriodicityName(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getOwnerPartner(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getPartner(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmployee(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getTeamLeader(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					String[] splited = prog.getTaskStatutoryDueDate().split(" ");

					cell = new PdfPCell(new Phrase("" + splited[0], headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);
					String[] splited1 = prog.getTaskEndDate().split(" ");

					cell = new PdfPCell(new Phrase("" + splited1[0], headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmpBudHr(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getEmployeeHrs(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getTeamLeaderHrs(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getMngrBudHr(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getManagerHrs(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

					cell = new PdfPCell(new Phrase("" + prog.getExVar1(), headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);

				}

				document.open();
				Font hf = new Font(FontFamily.TIMES_ROMAN, 12.0f, Font.UNDERLINE, BaseColor.BLACK);

				Paragraph name = new Paragraph(reportName, hf);
				name.setAlignment(Element.ALIGN_CENTER);
				document.add(name);
				document.add(new Paragraph("\n"));
				document.add(new Paragraph("Start Date:" + fromDate + "" + "    "));
				document.add(new Paragraph("End Date:" + toDate + "" + "    "));
				document.add(new Paragraph("\n"));

				DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");

				document.add(table);

				int totalPages = writer.getPageNumber();

				// System.out.println("Page no " + totalPages);

				document.close();
				int p = Integer.parseInt(request.getParameter("p"));
				// System.err.println("p " + p);

				if (p == 1) {

					if (file != null) {

						String mimeType = URLConnection.guessContentTypeFromName(file.getName());

						if (mimeType == null) {

							mimeType = "application/pdf";

						}

						response.setContentType(mimeType);

						response.addHeader("content-disposition",
								String.format("inline; filename=\"%s\"", file.getName()));

						response.setContentLength((int) file.length());

						InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

						try {
							FileCopyUtils.copy(inputStream, response.getOutputStream());
						} catch (IOException e) {
							// System.out.println("Excep in Opening a Pdf File");
							e.printStackTrace();
						}
					}
				} else {

					List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

					ExportToExcel expoExcel = new ExportToExcel();
					List<String> rowData = new ArrayList<String>();

					rowData.add("Sr. No");
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
						rowData.add("" + progList.get(i).getCustFirmName());
						rowData.add("" + progList.get(i).getServName());
						rowData.add("" + progList.get(i).getActiName());
						rowData.add("" + progList.get(i).getPeriodicityName());
						rowData.add("" + progList.get(i).getOwnerPartner());
						rowData.add("" + progList.get(i).getPartner());
						rowData.add("" + progList.get(i).getEmployee());
						rowData.add("" + progList.get(i).getTeamLeader());
						String[] splited = progList.get(i).getTaskStatutoryDueDate().split(" ");
						rowData.add("" + splited[0]);
						String[] splited1 = progList.get(i).getTaskEndDate().split(" ");
						rowData.add("" + splited1[0]);
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
								"From Date:" + fromDate + "   To Date:" + toDate + "", "", 'Q');

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

				}

			} catch (DocumentException ex) {

				// System.out.println("Pdf Generation Error: " + ex.getMessage());

				ex.printStackTrace();

			}

		} catch (Exception e) {

			System.err.println("Exce in showProgReport " + e.getMessage());
			e.printStackTrace();

		}

	}

	/***********************
	 * Team Leader Task Completed
	 *************************************//*
											 * @RequestMapping(value = "/getTeamLeadCompletTask", method =
											 * RequestMethod.POST) public void
											 * getTeamLeadCompletTaskReport(HttpServletRequest request,
											 * HttpServletResponse response) {
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
											 * Object>(); String fDate = DateConvertor.convertToYMD(fromDate); String
											 * tDate = DateConvertor.convertToYMD(toDate); map.add("fromDate",
											 * fDate.concat("  00:00:01")); map.add("toDate",
											 * tDate.concat("  23:59:59"));
											 * 
											 * TlTaskCompletReport[] ttlArr = Constants.getRestTemplate()
											 * .postForObject(Constants.url + "/getTlCompletedTeskRepot", map,
											 * TlTaskCompletReport[].class); List<TlTaskCompletReport> ttlList = new
											 * ArrayList<TlTaskCompletReport>(Arrays.asList(ttlArr));
											 * System.out.println("List-------------"+ttlList);
											 * 
											 * Document document = new Document(PageSize.A4); document.setMargins(50,
											 * 45, 50, 60); document.setMarginMirroring(false);
											 * 
											 * String FILE_PATH = Constants.REPORT_SAVE; File file = new
											 * File(FILE_PATH);
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
											 * 2.3f, 2.3f, 2.3f,2.3f, 2.3f, 2.3f, 2.3f,2.3f, 2.3f, 2.3f, 2.3f, 2.3f,
											 * 2.3f }); Font headFontData = ReportCostants.headFontData;// new
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
											 * hcell = new PdfPCell(new Phrase("Employee Budgeted Hrs",
											 * tableHeaderFont)); hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
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
											 * index++; PdfPCell cell; cell = new PdfPCell(new
											 * Phrase(String.valueOf(index), headFontData));
											 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
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
											 * cell = new PdfPCell(new Phrase("" + prog.getManagerName(),
											 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
											 * cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
											 * 
											 * table.addCell(cell);
											 * 
											 * 
											 * cell = new PdfPCell(new Phrase("" + prog.getTeamLeadName(),
											 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
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
											 * cell = new PdfPCell(new Phrase("" + prog.getCompletionDate(),
											 * headFontData)); //end date
											 * cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
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
											 * cell = new PdfPCell(new Phrase("" + prog.getTlPeriodHrs(),
											 * headFontData)); cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
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
											 * name.setAlignment(Element.ALIGN_CENTER); document.add(name);
											 * document.add(new Paragraph("\n")); document.add(new
											 * Paragraph("Start Date:" + fromDate + ""+"    ")); document.add(new
											 * Paragraph("\n"));
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
											 * InputStream inputStream = new BufferedInputStream(new
											 * FileInputStream(file));
											 * 
											 * try { FileCopyUtils.copy(inputStream, response.getOutputStream()); }
											 * catch (IOException e) { //
											 * System.out.println("Excep in Opening a Pdf File"); e.printStackTrace(); }
											 * } } else {
											 * 
											 * List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();
											 * 
											 * ExportToExcel expoExcel = new ExportToExcel(); List<String> rowData = new
											 * ArrayList<String>();
											 * 
											 * rowData.add("Sr. No"); rowData.add("Client Name");
											 * rowData.add("Service"); rowData.add("Activity");
											 * rowData.add("Task/ Periodicity"); rowData.add("Execution Partner");
											 * rowData.add("Manager Name"); rowData.add("TL Name");
											 * rowData.add("Due Date"); rowData.add("Completion Date");
											 * rowData.add("Employee Budgeted Hrs"); rowData.add("Total Hrs Employee");
											 * rowData.add("TL Hrs total");
											 * rowData.add("TL Hrs for the selected period");
											 * 
											 * expoExcel.setRowData(rowData); exportToExcelList.add(expoExcel); int cnt
											 * = 1; for (int i = 0; i < ttlList.size(); i++) { expoExcel = new
											 * ExportToExcel(); rowData = new ArrayList<String>(); cnt = cnt + i;
											 * 
											 * rowData.add("" + (i + 1)); rowData.add("" +
											 * ttlList.get(i).getClientName()); rowData.add("" +
											 * ttlList.get(i).getService()); rowData.add("" +
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
											 * wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName,
											 * "From Date:" +fromDate + "", "", 'L');
											 * 
											 * ExceUtil.autoSizeColumns(wb, 3);
											 * response.setContentType("application/vnd.ms-excel"); String date = new
											 * SimpleDateFormat("yyyy-MM-dd").format(new Date());
											 * response.setHeader("Content-disposition", "attachment; filename=" +
											 * reportName + "-" + date + ".xlsx"); wb.write(response.getOutputStream());
											 * 
											 * } catch (IOException ioe) { throw new
											 * RuntimeException("Error writing spreadsheet to output stream"); } finally
											 * { if (wb != null) { wb.close(); } }
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

}
