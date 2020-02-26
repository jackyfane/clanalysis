package com.enmotech.clanalysis.transcode;

import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.JPEGTranscoder;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

public class SaveAsJPEG
{
    public static void main(String[] args) throws Exception
    {
        final String svg = "E:\\Workbench\\ClanalysisProject\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Clanalysis\\temp_images\\2.svg";

        // Create a JPEG transcoder
        JPEGTranscoder t = new JPEGTranscoder();

        // Set the transcoding hints.
        t.addTranscodingHint(JPEGTranscoder.KEY_QUALITY, new Float(.8));

        // Create the transcoder input.
        String svgURI = new File(svg).toURL().toString();
        TranscoderInput input = new TranscoderInput(svgURI);

        // Create the transcoder output.
        OutputStream ostream = new FileOutputStream(
                "C:\\Users\\Administrator\\Desktop\\out.jpg");
        TranscoderOutput output = new TranscoderOutput(ostream);

        // Save the image.
        t.transcode(input, output);

        // Flush and close the stream.
        ostream.flush();
        ostream.close();
        System.exit(0);
    }
}
