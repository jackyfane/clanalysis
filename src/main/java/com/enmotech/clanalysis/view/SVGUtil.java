package com.enmotech.clanalysis.view;

import com.enmotech.clanalysis.entity.ReportElement;
import org.apache.batik.transcoder.TranscoderException;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.JPEGTranscoder;
import org.apache.batik.transcoder.image.PNGTranscoder;

import java.io.*;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

public class SVGUtil {

	/**
	 * 临时文件的存放目录
	 */
	public static final String TEMP_DIR = "/temp_images";

	/**
	 * @param array
	 * @param path
	 */
	public Map<Integer, String> convertToPNG(ReportElement[] array, String path) {

		Map<Integer, String> pngMap = new LinkedHashMap<Integer, String>();

		Map<Integer, String> fileMap = generateSvgFile(array, path);
		Iterator<Map.Entry<Integer, String>> entries = fileMap.entrySet().iterator();
		while (entries.hasNext()) {
			try {
				Map.Entry<Integer, String> entry = entries.next();
				ReportElement el = array[entry.getKey()];

				String filename = path + File.separator + entry.getKey() + ".png";
				String svg_uri_input = Paths.get(entry.getValue()).toUri().toURL().toString();

				PNGTranscoder trans = new PNGTranscoder();
				TranscoderInput ti = new TranscoderInput(svg_uri_input);

				FileOutputStream osStream = new FileOutputStream(filename);
				TranscoderOutput to = new TranscoderOutput(osStream);

				trans.transcode(ti, to);

				osStream.flush();
				osStream.close();

				pngMap.put(entry.getKey(), filename);
			} catch (IOException | TranscoderException e) {
				e.printStackTrace();
			}

		}

		return pngMap;
	}

	public Map<Integer, String> convertToJPG(ReportElement[] array, String path) {

		Map<Integer, String> JPGMap = new LinkedHashMap<Integer, String>();

		Map<Integer, String> fileMap = generateSvgFile(array, path);
		Iterator<Map.Entry<Integer, String>> entries = fileMap.entrySet().iterator();
		while (entries.hasNext()) {
			try {
				Map.Entry<Integer, String> entry = entries.next();
				String filename = path + File.separator + entry.getKey() + ".jpg";
				String svg_uri_input = Paths.get(entry.getValue()).toUri().toURL().toString();

				JPEGTranscoder trans = new JPEGTranscoder();
				trans.addTranscodingHint(JPEGTranscoder.KEY_QUALITY, new Float(.99));
				TranscoderInput input = new TranscoderInput(svg_uri_input);

				OutputStream out = new FileOutputStream(filename);
				TranscoderOutput output = new TranscoderOutput(out);
				trans.transcode(input, output);

				out.flush();
				out.close();

				JPGMap.put(entry.getKey(), filename);
			} catch (IOException | TranscoderException e) {
				e.printStackTrace();
			}

		}

		return JPGMap;
	}

	/**
	 * 生成SVG文件
	 *
	 * @param array
	 * @param path
	 * @return
	 */
	public Map<Integer, String> generateSvgFile(ReportElement[] array, String path) {
		Map<Integer, String> fileMap = new LinkedHashMap<Integer, String>();
		try {
			for (int i = 0; i < array.length; i++) {
				ReportElement re = array[i];
				if ("chart".equals(re.getType())) {
					String filename = path + File.separator + i + ".svg";
					File file = new File(filename);
					BufferedWriter writer = new BufferedWriter(new FileWriter(file));
					writer.write(re.getSvg());
					writer.flush();
					writer.close();

					fileMap.put(i, filename);
				}
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return fileMap;
	}

}
