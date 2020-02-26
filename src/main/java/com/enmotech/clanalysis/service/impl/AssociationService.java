package com.enmotech.clanalysis.service.impl;

import com.enmotech.clanalysis.dao.IAssociationDao;
import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Association;
import com.enmotech.clanalysis.service.AbstractService;
import com.enmotech.clanalysis.service.IAssociationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;

/**
 * Created by Administrator on 2015/6/10.
 */
@Service("associationService")
public class AssociationService extends AbstractService<Association> implements IAssociationService {
	@Autowired
	private IAssociationDao associationDao;

	@Override
	public void upload(File file) throws IOException {

	}

	@Override
	protected IOperations<Association> getDao() {
		return associationDao;
	}
}
