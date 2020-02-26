package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.entity.User;
import com.enmotech.clanalysis.service.IUserService;
import com.enmotech.clanalysis.util.Constant;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/5/28.
 */
@Controller
@SessionAttributes(Constant.USER_SESSION)
public class LoginController {
	private static final Logger logger = Logger.getLogger(LoginController.class);

	@Autowired
	private IUserService userService;

	/**
	 * 用户登录
	 *
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "/login")
	@ResponseBody
	public Map<String, Object> login(String username, String password, ModelMap model) {
		String message = "";
		boolean success = false;
		logger.info("------------用户[" + username + "]正在登陆----------------");
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
			message = "用户名和者密码不能为空！";
		} else {
			try {
				User user = userService.login(username, password);
				if (user != null) {
					success = true;
					model.addAttribute(Constant.USER_SESSION, user);
					message = "登录成功！";
				} else {
					message = "用户名或密码不正确！";
				}

			} catch (Exception e) {
				message = "系统异常，请联系管理员！";
				e.printStackTrace();
			}
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("message", message);

		return map;
	}

	/**
	 * 退出系统
	 *
	 * @param model
	 * @param sessionStatus
	 * @return
	 */
	@RequestMapping(value = "/logout")
	protected String logout(ModelMap model, SessionStatus sessionStatus) {
		User user = (User) model.get(Constant.USER_SESSION);
		if (user != null)
			// 清除Session
			sessionStatus.setComplete();
		return "redirect:/";
	}

}
