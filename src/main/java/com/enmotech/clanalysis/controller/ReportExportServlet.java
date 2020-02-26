package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.entity.DocElement;
import com.enmotech.clanalysis.util.DateUtils;
import com.enmotech.clanalysis.view.SVGUtil;
import com.itextpdf.text.pdf.BaseFont;
import com.lowagie.text.Document;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfWriter;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.xhtmlrenderer.pdf.ITextRenderer;
import org.xhtmlrenderer.pdf.PDFCreationListener;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

/**
 * Servlet implementation class ReportExportServlet
 */
@WebServlet(name = "reportExportServlet", urlPatterns = { "/reportExportServlet" })
public class ReportExportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String docType = request.getParameter("docType"), element = request.getParameter("element");
		JSONObject json = JSONObject.fromObject(element);
		DocElement docEl = new DocElement(docType, json);
		try {
			exportHtmlToPdf(docEl, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void exportHtmlToPdf(DocElement el, HttpServletRequest req, HttpServletResponse response) throws Exception {

		String timestr = DateUtils.getTimestamp(new Date(), "yyyyMMddHHmmss");
		String pdfName = el.getDocName() + "-" + timestr;
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/pdf");

		// 解决导出文件名称问中文的问题
		final String userAgent = req.getHeader("USER-AGENT");
		if (StringUtils.contains(userAgent, "MSIE")) {// IE浏览器
			pdfName = URLEncoder.encode(pdfName, "UTF8");
		} else if (StringUtils.contains(userAgent, "Mozilla")) {// google,火狐浏览器
			pdfName = new String(pdfName.getBytes(), "ISO8859-1");
		} else {
			pdfName = URLEncoder.encode(pdfName, "UTF8");// 其他浏览器
		}
		response.addHeader("Content-disposition", "attachment; filename=" + pdfName + ".pdf");

		SVGUtil util = new SVGUtil();
		ServletContext ctxt = req.getServletContext();
		File file = new File(ctxt.getRealPath(SVGUtil.TEMP_DIR));
		if (!file.exists()) {
			file.mkdirs();
		}
		String rootpath = ctxt.getRealPath("");
		String bootstrap_css_url = new File(rootpath + "\\asset\\css\\bootstrap_custom.min.css").toURI().toURL()
				.toString();
		String report_css_url = new File(rootpath + "\\asset\\css\\report.css").toURI().toURL().toString();
		String html = el.getHtml().replace("bootstrap_css_path", bootstrap_css_url);
		html = html.replace("report_css_path", report_css_url);

		Map<Integer, String> imgFiles = util.convertToPNG(el.getElements(), ctxt.getRealPath(SVGUtil.TEMP_DIR));
		Iterator<Entry<Integer, String>> iter = imgFiles.entrySet().iterator();
		while (iter.hasNext()) {
			Entry<Integer, String> entry = iter.next();
			String url = new File(entry.getValue()).toURI().toURL().toString();
			String imgTag = "<img src=\"" + url + "\"/>";
			html = html.replace("img_path_" + entry.getKey(), imgTag);
		}

		ITextRenderer renderer = new ITextRenderer();

		// Rectangle rectangle = new Rectangle(el.getWidth(), el.getHeight());
		// MyPdfPageEvent pdfPageEvent = new MyPdfPageEvent(rectangle);
		// PDFCreationListener listener = new
		// FlyingSaucerPDFCreationListener(pdfPageEvent);
		// renderer.setListener(listener);

		// 添加字体，以支持中文
		renderer.getFontResolver().addFont("simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
		renderer.getFontResolver().addFont("arialuni.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

		// String imgPath = "file:/" + rootpath.replace("\\", "/") +
		// SVGUtil.TEMP_DIR;
		// renderer.getSharedContext().setBaseURL(imgPath);
		renderer.setDocumentFromString(html);
		renderer.layout();

		ServletOutputStream out = response.getOutputStream();
		renderer.createPDF(out);

		out.flush();
		out.close();
	}

	class MyPdfPageEvent extends PdfPageEventHelper {
		Rectangle rectangle;

		public MyPdfPageEvent(float width, float height) {
			rectangle = new Rectangle(width, height);
		}

		public MyPdfPageEvent(Rectangle rectangle) {
			this.rectangle = rectangle;
		}

		@Override
		public void onStartPage(PdfWriter writer, Document document) {
			document.setPageSize(rectangle);
		}
	}

	class FlyingSaucerPDFCreationListener implements PDFCreationListener {

		MyPdfPageEvent pdfPageEvent = null;

		public FlyingSaucerPDFCreationListener(MyPdfPageEvent pdfPageEvent) {
			this.pdfPageEvent = pdfPageEvent;
		}

		@Override
		public void preOpen(ITextRenderer renderer) {
			renderer.getWriter().setPageEvent(pdfPageEvent);
		}

		@Override
		public void preWrite(ITextRenderer iTextRenderer, int i) {

		}

		@Override
		public void onClose(ITextRenderer renderer) {

		}

	}
}
