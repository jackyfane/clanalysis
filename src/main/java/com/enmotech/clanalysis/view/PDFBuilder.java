package com.enmotech.clanalysis.view;

import com.enmotech.clanalysis.entity.Book;
import com.enmotech.clanalysis.entity.DocElement;
import com.enmotech.clanalysis.entity.ReportElement;
import com.itextpdf.awt.PdfGraphics2D;
import com.itextpdf.text.*;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.pdf.*;
import org.apache.batik.anim.dom.SAXSVGDocumentFactory;
import org.apache.batik.bridge.*;
import org.apache.batik.gvt.GraphicsNode;
import org.apache.batik.util.XMLResourceDescriptor;
import org.w3c.dom.svg.SVGDocument;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.List;

public class PDFBuilder extends AbstractItextPDFView {

	private static SAXSVGDocumentFactory factory;

	private static BridgeContext ctx;

	private static GVTBuilder builder;

	public PDFBuilder() {
		String parse = XMLResourceDescriptor.getXMLParserClassName();
		factory = new SAXSVGDocumentFactory(parse);
		UserAgent userAgent = new UserAgentAdapter();
		DocumentLoader loader = new DocumentLoader(userAgent);
		ctx = new BridgeContext(userAgent, loader);
		ctx.setDynamicState(BridgeContext.DYNAMIC);
		builder = new GVTBuilder();
	}

	@Override
	protected void buildPdfDocument(DocElement model, Document document, PdfWriter writer, Map<Integer, String> files,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		PdfContentByte cb = writer.getDirectContent();
		float top = 0;
		ReportElement[] rels = model.getElements();
		for (int i = 0; i < rels.length; i++) {

			ReportElement re = rels[i];

			if (top != re.getY()) {
				top += re.getHeight();
			}
			if (document.top() - top < re.getHeight()) {
				document.newPage();
				top = 0;
			}
			PdfPTable table = null;
			switch (re.getType()) {
			case "chart":
				String svg_uri_input = Paths.get(files.get(i)).toUri().toURL().toString();
				SVGDocument svgDoc = factory.createSVGDocument(svg_uri_input);
				PdfTemplate template = cb.createTemplate(re.getWidth(), re.getHeight());
				Graphics2D g2d = new PdfGraphics2D(template, re.getWidth(), re.getHeight());
				GraphicsNode mapGraphics = builder.build(ctx, svgDoc);
				mapGraphics.paint(g2d);
				g2d.dispose();

				Image image = Image.getInstance(template);
				image.setAbsolutePosition(re.getX(), document.top() - top - re.getHeight() - 160);
				// image.setAlignment(Image.ALIGN_CENTER);
				// image.scalePercent(80f);
				document.add(image);
				break;
			case "table":

				// create some sample data
				List<Book> listBooks = new ArrayList<Book>();
				listBooks.add(new Book("Spring in Action", "Craig Walls", "1935182358", "June 29th 2011", 31.98F));
				listBooks.add(new Book("Spring in Practice", "Willie Wheeler, Joshua White", "1935182056",
						"May 16th 2013", 31.95F));
				listBooks.add(
						new Book("Pro Spring 3", "Clarence Ho, Rob Harrop", "1430241071", "April 18th 2012", 31.85F));
				listBooks.add(new Book("Spring Integration in Action", "Mark Fisher", "1935182439",
						"September 26th 2012", 28.73F));

				table = new PdfPTable(5);
				table.setWidthPercentage(100.0f);
				table.setWidths(new float[] { 3.0f, 2.0f, 2.0f, 2.0f, 1.0f });
				table.setSpacingBefore(10);

				// define font for table header row
				Font font = FontFactory.getFont(FontFactory.HELVETICA);
				font.setColor(BaseColor.WHITE);

				// define table header cell
				PdfPCell cell = new PdfPCell();
				cell.setBackgroundColor(BaseColor.BLUE);
				cell.setPadding(5);

				// write table header
				cell.setPhrase(new Phrase("Book Title", font));
				table.addCell(cell);

				cell.setPhrase(new Phrase("Author", font));
				table.addCell(cell);

				cell.setPhrase(new Phrase("ISBN", font));
				table.addCell(cell);

				cell.setPhrase(new Phrase("Published Date", font));
				table.addCell(cell);

				cell.setPhrase(new Phrase("Price", font));
				table.addCell(cell);

				// write table row data
				for (Book aBook : listBooks) {
					table.addCell(aBook.getTitle());
					table.addCell(aBook.getAuthor());
					table.addCell(aBook.getIsbn());
					table.addCell(aBook.getPublishedDate());
					table.addCell(String.valueOf(aBook.getPrice()));
				}
				document.add(table);
				break;
			default:

				break;
			}
			// document.newPage();
		}
	}

	/**
	 * @param map
	 * @param resource
	 * @throws IOException
	 */
	public void drawSvg(PdfTemplate map, String resource, float width, float height) throws IOException {
		SVGDocument svgDoc = factory.createSVGDocument(resource);
		GraphicsNode mapGraphics = builder.build(ctx, svgDoc);
		Graphics2D g2d = new PdfGraphics2D(map, width, height);
		mapGraphics.paint(g2d);
		g2d.dispose();
	}

}
