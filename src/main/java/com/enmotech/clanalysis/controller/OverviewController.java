package com.enmotech.clanalysis.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Administrator on 2015/5/28.
 */
@Controller
public class OverviewController {

	private static Logger logger = Logger.getLogger(OverviewController.class);

	@RequestMapping(value = "/overview")
	public ModelAndView mainContent(ModelMap model) {
		logger.info("正在加载总览数据.....");
		ModelAndView mv = new ModelAndView("overview");
		return mv;
	}
}
