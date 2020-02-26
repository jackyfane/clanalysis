package com.enmotech.clanalysis.dao.impl;

import com.enmotech.clanalysis.dao.AbstractOperations;
import com.enmotech.clanalysis.dao.IProjectDao;
import com.enmotech.clanalysis.entity.Project;
import org.springframework.stereotype.Repository;

/**
 * Created by Administrator on 2015/6/5.
 */
@Repository("projectDao")
public class ProjectDao extends AbstractOperations<Project> implements IProjectDao {

	public ProjectDao() {
		super();
		setClazz(Project.class);
	}
}
