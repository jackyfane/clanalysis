package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.LocalFile;
import com.enmotech.clanalysis.service.ILocalFileService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2015/6/10.
 */
@Controller
@RequestMapping("/localFile")
public class LocalFileController extends AbstractController<LocalFile> {
	private ILocalFileService localFileService;

	@Override
	protected IOperations<LocalFile> getService() {
		return localFileService;
	}
}
