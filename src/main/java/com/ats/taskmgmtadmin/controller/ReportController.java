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

import com.ats.taskmgmtadmin.common.Constants;
import com.ats.taskmgmtadmin.common.DateConvertor;
import com.ats.taskmgmtadmin.common.ExceUtil;
import com.ats.taskmgmtadmin.common.ExportToExcel;
import com.ats.taskmgmtadmin.common.ReportCostants;
import com.ats.taskmgmtadmin.model.EmployeeMaster;
import com.ats.taskmgmtadmin.model.report.CompletedTaskReport;
import com.ats.taskmgmtadmin.model.report.TlTaskCompletReport;
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
			
			EmployeeMaster[] employee = Constants.getRestTemplate().getForObject(Constants.url + "/getAllEmployees",
					EmployeeMaster[].class);
			List<EmployeeMaster> epmList = new ArrayList<EmployeeMaster>(Arrays.asList(employee));
			model.addObject("epmList", epmList);

		} catch (Exception e) {

			System.err.println("Exce in showReports " + e.getMessage());
			e.printStackTrace();

		}

		return model;
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
					//Date date=new SimpleDateFormat("dd/MM/yyyy").parse(prog.getTaskStatutoryDueDate()); 
					cell = new PdfPCell(new Phrase("" +splited[0] , headFontData));
					cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
					cell.setHorizontalAlignment(Element.ALIGN_RIGHT);

					table.addCell(cell);
					String[] splited1 = prog.getTaskEndDate().split(" ");

					//Date date1=new SimpleDateFormat("dd/MM/yyyy").parse(prog.getTaskEndDate());  
					cell = new PdfPCell(new Phrase("" +splited1[0], headFontData));
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

						wb = ExceUtil.createWorkbook(exportToExcelList, "", reportName, "From Date:" + fromDate + "   To Date:" + toDate + "",
								"", 'L');

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
