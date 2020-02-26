package com.enmotech.clanalysis.service;

import com.enmotech.clanalysis.dao.IOperations;
import com.enmotech.clanalysis.entity.Association;

import java.io.File;
import java.io.IOException;

/**
 * Created by Administrator on 2015/6/10.
 */
public interface IAssociationService extends IOperations<Association> {
	public void upload(File file) throws IOException;
}
