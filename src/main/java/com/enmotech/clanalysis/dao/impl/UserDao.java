package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IUserDao;
import com.enmotech.clanalysis.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 数据层用户具体实现类 Created by Administrator on 2015/5/14.
 */
@Repository("userDao")
public class UserDao extends AbstractOperations<User> implements IUserDao {

	public UserDao() {
		super();
		setClazz(User.class);
	}

	@Override
	public User login(String username, String password) {
		String hql = "from User u where u.username =? and u.password =?";
		List<User> users = (List<User>) hibernateTemplate.find(hql, new Object[] { username, password });
		if (users != null && users.size() > 0)
			return users.get(0);
		return null;
	}

	@Override
	public List<User> loginHistory(String username) {
		String hql = "u.username, h from LoginHistory h, User u where u.id = h.user.id and u.username = :username";
		return null;
	}

	@Override
	public void logout(User user) {

	}

	@Override
	public boolean updatepwd(String hql, Object[] values) {
		int count = hibernateTemplate.bulkUpdate(hql, values);
		if (count <= 0)
			return false;
		return true;
	}
}
