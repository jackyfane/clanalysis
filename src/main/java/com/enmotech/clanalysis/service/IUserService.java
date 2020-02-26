package com.enmotech.clanalysis.service;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.User;
import com.enmotech.clanalysis.exception.ClanalysisException;

/**
 * Created by Administrator on 2015/5/22.
 */
public interface IUserService extends IOperations<User> {

	/**
	 * 用户登录
	 *
	 * @param username
	 * @param password
	 * @return
	 * @throws ClanalysisException
	 */
	public User login(String username, String password);

	/**
	 * @param uid
	 * @param password
	 */
	public boolean modifypwd(String uid, String password);
}
