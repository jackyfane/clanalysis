package com.enmotech.clanalysis.controller;

import com.enmotech.clanalysis.controller.base.AbstractController;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.User;
import com.enmotech.clanalysis.service.IUserService;
import com.enmotech.clanalysis.util.Constant;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2015/5/14.
 */
@Controller
@RequestMapping(value = "/user")
public class UserController extends AbstractController<User> {

	private final static Logger LOG = Logger.getLogger(UserController.class);

	@Autowired
	private IUserService userService;

	@Override
	protected IOperations<User> getService() {
		return userService;
	}

	/**
	 * @param password
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/checkpwd")
	@ResponseBody
	protected boolean checkPassword(String password, HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute(Constant.USER_SESSION);
		if (password.equals(user.getPassword())) {
			return true;
		}
		return false;
	}

	/**
	 * @param uid
	 * @param password
	 */
	@RequestMapping(value = "/modifypwd")
	@ResponseBody
	protected Map<String, Object> modifypwd(String uid, String password) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (userService.modifypwd(uid, password)) {
			resultMap.put("flag", true);
			resultMap.put("msg", "密码修改成功！");
		} else {
			resultMap.put("flag", false);
			resultMap.put("msg", "密码修改失败！");
		}
		return resultMap;
	}
}
