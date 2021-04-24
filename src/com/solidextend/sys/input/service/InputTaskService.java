package com.solidextend.sys.input.service;

import java.util.List;

import com.solidextend.sys.input.vo.SysInputTask;
import com.solidextend.sys.input.vo.SysInputTaskInstance;
import org.bson.Document;

public interface InputTaskService {
	public void saveInputTask(SysInputTask inputTask);
	public List<SysInputTask> getInputTaskList(SysInputTask inputTask);
	public int deleteInputTask(String taskId);
	
	public void saveInputTaskInstance(SysInputTaskInstance inputTaskInstance,Document doc,int inputType);
	public List<SysInputTaskInstance> getInputTaskInstanceList(SysInputTaskInstance inputTaskInstance);
	public Document getInputTaskInstanceData(String taskId,String taskInstanceId);
}
