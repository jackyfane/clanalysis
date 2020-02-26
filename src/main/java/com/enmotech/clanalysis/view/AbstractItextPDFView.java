/**
 *
 */
package com.enmotech.clanalysis.view;

import com.enmotech.clanalysis.entity.DocElement;
import com.enmotech.clanalysis.entity.ReportElement;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.Pipeline;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
import org.springframework.web.servlet.view.AbstractView;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

/**
 * @author Administrator
 */
public abstract class AbstractItextPDFView extends AbstractView {

	public static BaseFont baseFont;

	static {
		try {
			baseFont = BaseFont.createFont("simsun.ttc,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public AbstractItextPDFView() {
		setContentType("application/pdf");
	}

	@Override
	protected boolean generatesDownloadContent() {
		return false;
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> map, HttpServletRequest req, HttpServletResponse resp)
			throws Exception {

		DocElement el = (DocElement) map.get("model");

		ByteArrayOutputStream baos = createTemporaryOutputStream();
		// Document document = getDocument(el.getWidth(), el.getHeight());
		// PdfWriter pdfWriter = newWriter(document, baos);
		// pdfWriter.setInitialLeading(100.0f);
		// buildPdfMetadata(el, document, req);
		// document.open();
		// convertHtmlToPdf(document, pdfWriter, el, req);
		// document.close();

		rendererHtmlToPdf(el, req, baos);

		writeToResponse(resp, baos);
	}

	/**
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException
	 * @throws DocumentException
	 */
	public Document getDocument(float width, float height) throws DocumentException, IOException {
		Rectangle rectangle = new Rectangle(width, height);
		return new Document(rectangle);
	}

	protected PdfWriter newWriter(Document document, OutputStream os) throws DocumentException {
		return PdfWriter.getInstance(document, os);
	}

	protected void prepareWriter(DocElement model, PdfWriter writer, HttpServletRequest request)
			throws DocumentException {

		writer.setViewerPreferences(getViewerPreferences());
	}

	protected int getViewerPreferences() {
		return PdfWriter.ALLOW_PRINTING | PdfWriter.PageLayoutSinglePage;
	}

	protected void buildPdfMetadata(DocElement model, Document document, HttpServletRequest request) {
		document.addTitle(model.getTitle());
		document.addSubject(model.getSubTitle());
	}

	protected Map<Integer, String> generateSvg(ReportElement[] elements, HttpServletRequest req) {

		ServletContext ctxt = req.getServletContext();
		File file = new File(ctxt.getRealPath(SVGUtil.TEMP_DIR));
		if (!file.exists()) {
			file.mkdirs();
		}
		SVGUtil util = new SVGUtil();
		Map<Integer, String> svgFiles = util.generateSvgFile(elements, file.getPath());
		return svgFiles;
	}

	protected Map<Integer, String> svgToPng(ReportElement[] elements, HttpServletRequest req) {

		ServletContext ctxt = req.getServletContext();
		File file = new File(ctxt.getRealPath(SVGUtil.TEMP_DIR));
		if (!file.exists()) {
			file.mkdirs();
		}
		SVGUtil util = new SVGUtil();
		return util.convertToPNG(elements, file.getPath());
	}

	/**
	 * html文档转PDF
	 *
	 * @param document
	 * @param pdfWriter
	 * @param el
	 * @param req
	 */
	protected void convertHtmlToPdf(Document document, PdfWriter pdfWriter, DocElement el, HttpServletRequest req)
			throws Exception {

		Map<Integer, String> imgFiles = svgToPng(el.getElements(), req);
		Iterator<Entry<Integer, String>> iter = imgFiles.entrySet().iterator();
		String html = el.getHtml();
		while (iter.hasNext()) {
			Entry<Integer, String> entry = iter.next();
			String imgTag = "<img src=\"" + entry.getValue() + "\"/>";
			html = html.replace("img_path_" + entry.getKey(), imgTag);
		}

		HtmlPipelineContext htmlContext = new HtmlPipelineContext(null);
		htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
		final String roopath = req.getServletContext().getRealPath(SVGUtil.TEMP_DIR);
		htmlContext.setImageProvider(new AbstractImageProvider() {
			@Override
			public String getImageRootPath() {
				return roopath;
			}
		});

		// final String linkroot = "http://"+req.getServerName() +
		// ":"+req.getServerPort()+"/"+req.getContextPath()+"/asset/css";
		// htmlContext.setLinkProvider(new LinkProvider() {
		// @Override
		// public String getLinkRoot() {
		// return linkroot;
		// }
		// });

		CSSResolver cssResolver = new StyleAttrCSSResolver();
		InputStream bootstrapCsspath = Thread.currentThread().getContextClassLoader()
				.getResourceAsStream("asset/css/bootstrap.min.css");
		CssFile bcssFile = XMLWorkerHelper.getCSS(bootstrapCsspath);
		InputStream reportCsspath = Thread.currentThread().getContextClassLoader()
				.getResourceAsStream("asset/css/report.css");
		CssFile rcssFile = XMLWorkerHelper.getCSS(reportCsspath);

		cssResolver.addCss(bcssFile);
		cssResolver.addCss(rcssFile);
		// cssResolver.addCssFile("/asset/css/bootstrap.min.css", true);
		// cssResolver.addCssFile("/asset/css/report.css", true);

		Pipeline<?> pipeline = new CssResolverPipeline(cssResolver,
				new HtmlPipeline(htmlContext, new PdfWriterPipeline(document, pdfWriter)));
		XMLWorker xmlWorker = new XMLWorker(pipeline, true);
		XMLParser parser = new XMLParser(xmlWorker);
		InputStream in = new ByteArrayInputStream(html.getBytes());
		parser.parse(in, false);
	}

	/**
	 * @param document
	 * @param pdfWriter
	 * @param el
	 * @param req
	 * @throws Exception
	 */
	protected void rendererHtmlToPdf(DocElement el, HttpServletRequest req, OutputStream os) throws Exception {
		String html = el.getHtml();
		Map<Integer, String> imgFiles = generateSvg(el.getElements(), req);
		Iterator<Entry<Integer, String>> iter = imgFiles.entrySet().iterator();
		while (iter.hasNext()) {
			Entry<Integer, String> entry = iter.next();
			String url = new File(entry.getValue()).toURI().toURL().toString();
			String imgTag = "<img src=\"" + url + "\"/>";
			html = html.replace("img_path_" + entry.getKey(), imgTag);
		}
		ITextRenderer renderer = new ITextRenderer();
		ITextFontResolver fontResolver = renderer.getFontResolver();
		fontResolver.addFont("simsun.ttc", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

		renderer.setDocumentFromString(html);
		renderer.layout();
		renderer.createPDF(os);
	}

	/**
	 * @param document
	 * @param pdfWriter
	 * @param el
	 * @param req
	 * @param resp
	 * @throws Exception
	 */
	protected void typesettingPdf(Document document, PdfWriter pdfWriter, DocElement el, HttpServletRequest req,
			HttpServletResponse resp) throws Exception {
		/* 使用中文字体 */
		Font font = new Font(baseFont, 30, Font.NORMAL);
		Paragraph paragraph = new Paragraph(el.getTitle(), font);
		paragraph.setAlignment(Paragraph.ALIGN_CENTER);
		paragraph.setLeading(10f);
		document.add(paragraph);

		font = new Font(baseFont, 16, Font.NORMAL);
		paragraph = new Paragraph(el.getTitle(), font);
		paragraph.setAlignment(Paragraph.ALIGN_CENTER);
		paragraph.setLeading(20f);
		document.add(paragraph);

		Map<Integer, String> svgFiles = generateSvg(el.getElements(), req);

		buildPdfDocument(el, document, pdfWriter, svgFiles, req, resp);
	}

	protected abstract void buildPdfDocument(DocElement model, Document document, PdfWriter writer,
			Map<Integer, String> svgFiles, HttpServletRequest request, HttpServletResponse response) throws Exception;

}
