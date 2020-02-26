package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.entity.User;
import com.enmotech.clanalysis.util.Constant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2015/5/27.
 */
@Controller
public class IndexController {
	@RequestMapping(value = "/")
	protected String index(HttpSession session) {
		User user = (User) session.getAttribute(Constant.USER_SESSION);
		if (user == null) {
			return "login";
		}
		return "index";
	}

}
