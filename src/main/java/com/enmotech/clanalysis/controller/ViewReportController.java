package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.entity.DocElement;
import com.enmotech.clanalysis.entity.ReportParam;
import com.enmotech.clanalysis.service.IDataSourceService;
import com.enmotech.clanalysis.service.IReportService;
import com.enmotech.clanalysis.service.IViewReportService;
import com.enmotech.clanalysis.service.impl.ViewReportService;
import com.enmotech.clanalysis.view.SVGUtil;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.BaseFont;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

/**
 * Created by Administrator on 2015/9/23.
 */
@Controller
@RequestMapping(value = "/viewReport")
public class ViewReportController {
	@Autowired
	private IReportService reportService;

	@Autowired
	private IDataSourceService dataSourceService;

	@RequestMapping(value = "/view")
	@ResponseBody
	protected String view(@RequestBody ReportParam param, HttpServletRequest request) {
		String jsonStr = null;
		IViewReportService viewReportService = new ViewReportService(param, reportService, dataSourceService);
		if (viewReportService.isCallOK()) {
			if ("chart".equals(param.getType())) {
				jsonStr = viewReportService.getChartIndex().toString();
			} else if ("table".equals(param.getType())) {
				jsonStr = viewReportService.getTableIndex().toString();
			} else {
				jsonStr = viewReportService.getTextIndex().toString();
			}
		} else {
			jsonStr = viewReportService.getErrorInfo().toString();
		}
		// System.out.println(JSONObject.fromObject(param));
		return jsonStr;
	}

	@RequestMapping(value = "/export")
	protected void exportReport(String docType, String element, HttpServletRequest request, HttpServletResponse resp)
			throws IOException, DocumentException {
		JSONObject json = JSONObject.fromObject(element);
		DocElement docEl = new DocElement(docType, json);
		// return new ModelAndView("pdfView", "model", docEl);
		try {
			rendererHtmlToPdf(docEl, request, resp);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void rendererHtmlToPdf(DocElement el, HttpServletRequest req, HttpServletResponse response)
			throws Exception {

		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "attachment; filename=WebReport.pdf");

		String html = el.getHtml();
		SVGUtil util = new SVGUtil();
		ServletContext scxt = req.getServletContext();
		String path = scxt.getRealPath(SVGUtil.TEMP_DIR);
		Map<Integer, String> imgFiles = util.generateSvgFile(el.getElements(), path);
		Iterator<Entry<Integer, String>> iter = imgFiles.entrySet().iterator();
		while (iter.hasNext()) {
			Entry<Integer, String> entry = iter.next();
			String url = new File(entry.getValue()).toURI().toURL().toString();
			String imgTag = "<img src=\"" + url + "\"/>";
			html = html.replace("img_path_" + entry.getKey(), imgTag);
		}

		OutputStream os = response.getOutputStream();

		ITextRenderer renderer = new ITextRenderer();
		ITextFontResolver fontResolver = renderer.getFontResolver();
		fontResolver.addFont("simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

		renderer.setDocumentFromString(html);
		renderer.layout();
		renderer.createPDF(os);

		response.getWriter();
	}
}
