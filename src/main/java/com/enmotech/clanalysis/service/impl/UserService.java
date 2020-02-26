package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.dao.IUserDao;
import com.enmotech.clanalysis.entity.User;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Administrator on 2015/5/22.
 */
@Service("userService")
public class UserService extends AbstractService<User> implements IUserService {

	@Autowired
	private IUserDao userDao;

	@Override
	public User login(String username, String password) {
		User user = userDao.login(username, password);
		return user;
	}

	@Override
	protected IOperations<User> getDao() {
		return this.userDao;
	}

	@Override
	public boolean modifypwd(String uid, String password) {
		String hql = "update User u set u.password =? where u.id =?";
		boolean flag = userDao.updatepwd(hql, new String[] { password, uid });
		return flag;
	}
}
