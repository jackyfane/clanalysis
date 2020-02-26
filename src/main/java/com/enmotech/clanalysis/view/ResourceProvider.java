package com.enmotech.clanalysis.view;

import com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider;
import com.itextpdf.tool.xml.pipeline.html.LinkProvider;

public class ResourceProvider {

	class ImageResourceProvider extends AbstractImageProvider {
		String rootpath;

		public ImageResourceProvider(String rootpath) {
			this.rootpath = rootpath;
		}

		@Override
		public String getImageRootPath() {
			return rootpath;
		}
	}

	class LinkResourceProvider implements LinkProvider {
		String linkroot;

		public LinkResourceProvider(String linkroot) {
			this.linkroot = linkroot;
		}

		@Override
		public String getLinkRoot() {
			return linkroot;
		}
	}
}
