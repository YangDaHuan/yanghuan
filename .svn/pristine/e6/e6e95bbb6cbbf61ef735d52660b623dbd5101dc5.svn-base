package com.solidextend.sys.df.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;

import com.solidextend.core.util.DateUtil;
import com.solidextend.core.util.Identities;
import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.JsonTree;
import com.solidextend.sys.df.service.DFService;
import com.solidextend.sys.df.vo.ConfigInfo;
import com.solidextend.sys.df.vo.FieldInfo;
import com.solidextend.sys.df.vo.FormInfo;
import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.module.vo.Module;

import freemarker.template.Template;
import freemarker.template.TemplateException;

@Controller
@RequestMapping("dfcode")
public class DFCodeController implements ServletContextAware{
	
	protected static final Log log = LogFactory.getLog(DFCodeController.class);
	
	private ServletContext servletContext;
	
	@Resource
	private DFService dFService;
	
	@Resource
	private ModuleService moduleService;

	@RequestMapping
	public String index(HttpServletRequest request){
		request.setAttribute("viewBasicPath", "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/");
		//检查数据库版本
		ConfigInfo configInfo = dFService.getConfigById("1");
		if(DFUpdateController.DF_VERSION.compareTo(configInfo.getVersion())>0){
			request.setAttribute("dbUpdate", DFUpdateController.DF_VERSION);
		}else{
			request.setAttribute("dbUpdate", "1");
		}
		return "../df/form";
	}
	
	@RequestMapping("tree")
	@ResponseBody
	public List<JsonTree> tree(String publish){
		if(StringUtils.isEmpty(publish)) publish = "-1";
		List<FormInfo> formInfos = dFService.getFormList(Integer.parseInt(publish));
		JsonTree tree = new JsonTree("all","自定义表单", "", true);
		JsonTree nTree = new JsonTree("no-publish", "未发布", "", true);
		JsonTree yTree = new JsonTree("yes-publish", "已发布", "", true);
		tree.getChildren().add(nTree);
		tree.getChildren().add(yTree);
		for(FormInfo formInfo : formInfos){
			JsonTree formTree = new JsonTree(formInfo.getId(), "【"+formInfo.getNo()+"】 "+formInfo.getName());
			formTree.setState("open");
			formTree.setLeaf(true);
			if(formInfo.getPublish()==0){				
				nTree.getChildren().add(formTree);
			}else{
				formTree.setPublish(true);
				yTree.getChildren().add(formTree);				
			}
		}
		List<JsonTree> trees = new ArrayList<JsonTree>();
		trees.add(tree);
		return trees;
	}
	
	@RequestMapping("moduletree")
	@ResponseBody
	public List<JsonTree> moduleTree(){
		return getModuleTree("0");
	}
	
	public List<JsonTree> getModuleTree(String parentId){
		List<JsonTree> trees = new ArrayList<JsonTree>();
		List<Module> modules = dFService.getModules(parentId);
		for(Module module : modules){
			JsonTree tree = new JsonTree(module.getId(),module.getModuleName());
			tree.setParentId(module.getParentId());
			tree.setChildren(getModuleTree(module.getId()));
			tree.setState("open");
			trees.add(tree);
		}
		return trees;
	}
	
	@RequestMapping("init")
	@ResponseBody
	public FormInfo initForm(String id){
		FormInfo formInfo = dFService.getFormInfo(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("formId", id);
		map.put("dbNull", -1);
		List<FieldInfo> fields = dFService.getFieldList(map);
		formInfo.setFields(fields);
		return formInfo;
	}
	
	@RequestMapping("save")
	@ResponseBody
	public JsonData save(HttpServletRequest request){
		JsonData jsonData = new JsonData();
		boolean update = false;		
		try{
			FormInfo verifyForm = new FormInfo();
			FormInfo formInfo = new FormInfo();
			if(StringUtils.isEmpty(request.getParameter("id"))){
				update = false;
				formInfo.setId(Identities.uuid());
			}else{
				update = true;
				formInfo.setId(request.getParameter("id"));
				verifyForm.setId(request.getParameter("id"));
			}			
			formInfo.setNo(request.getParameter("no"));
			verifyForm.setNo(request.getParameter("no"));
			formInfo.setName(request.getParameter("name"));
			if(StringUtils.isEmpty(formInfo.getName())){
				//如果名称为空，以编码代替
				formInfo.setName(formInfo.getNo());
			}
			formInfo.setTable(request.getParameter("table"));
			if(StringUtils.isEmpty(formInfo.getTable())){
				//如果未输入表名，那么以编码作为表名
				formInfo.setTable(formInfo.getNo());
			}
			formInfo.setRemark(request.getParameter("remark"));
			formInfo.setTempType(request.getParameter("tempType"));
			if(StringUtils.isEmpty(formInfo.getTempType())){
				//如果未选择风格，默认标准界面
				formInfo.setTempType("grid");
			}
			formInfo.setModuleId(request.getParameter("moduleId"));
			int fieldCount = Integer.parseInt(request.getParameter("fieldCount"));//字段总数
			formInfo.setActionAdd(Integer.parseInt(request.getParameter("actionAdd")));
			formInfo.setActionUpdate(Integer.parseInt(request.getParameter("actionUpdate")));
			formInfo.setActionDel(Integer.parseInt(request.getParameter("actionDel")));
			formInfo.setActionImp(Integer.parseInt(request.getParameter("actionImp")));
			formInfo.setActionExp(Integer.parseInt(request.getParameter("actionExp")));
			boolean QUERY = false;
			List<String> fieldNos = new ArrayList<String>();
			for(int i=0; i<fieldCount; i++){
				FieldInfo fieldInfo = new FieldInfo();
				Field[] fields = fieldInfo.getClass().getDeclaredFields();
				for(Field field : fields){
					try {
						Method method = fieldInfo.getClass().getDeclaredMethod("set"+StringUtils.capitalize(field.getName()), field.getType());
						if(field.getType().getName().equals("int")){
							method.invoke(fieldInfo, Integer.parseInt(request.getParameter("fields["+i+"]["+field.getName()+"]")));
						}else{
							method.invoke(fieldInfo, request.getParameter("fields["+i+"]["+field.getName()+"]"));
						}
					} catch (Exception e) {}				
				}
				fieldInfo.setId(Identities.uuid());
				//如果字段类型为空，默认为text
				if(StringUtils.isEmpty(fieldInfo.getType())) fieldInfo.setType("text");
				//如果字段名为空，以字段编码为字段名
				if(StringUtils.isEmpty(fieldInfo.getDbId())) fieldInfo.setDbId(fieldInfo.getNo());
				//字段长度默认为255
				if(fieldInfo.getDbLength()<=0) fieldInfo.setDbLength(255);
				//如果字段是checkbox，且未设置默认值和数据源，那么默认值设置为1
				if(fieldInfo.getType().equals("checkbox")&&fieldInfo.getDsType()==0&&StringUtils.isEmpty(fieldInfo.getDefaultValue())){
					fieldInfo.setDefaultValue("1");
				}
				//如果存在字段验证，那么该字段不与数据库表绑定
				if(!StringUtils.isEmpty(fieldInfo.getFieldEquals())) fieldInfo.setDbNull(0);
				if(fieldInfo.getPrimary()>0) {//设置主键
					formInfo.setPrimary(fieldInfo.getNo());
					formInfo.setPrimaryField(fieldInfo.getDbId());
				}
				if(fieldInfo.getUnique()>0) {//设置唯一约束
					formInfo.getUniques().put(fieldInfo.getNo(), fieldInfo.getDbId());
				}
				fieldInfo.setFormId(formInfo.getId());
				fieldInfo.setOrderBy(i);
				//如果未设置最大值，将自动设置为数据库表的字段长度除以3
				if(fieldInfo.getMaxLen()<=0) fieldInfo.setMaxLen(fieldInfo.getDbLength() / 3);
				//如果编码为空，自动省略此字段
				if(StringUtils.isEmpty(fieldInfo.getNo())) continue;
				formInfo.getFields().add(fieldInfo);
				if(fieldInfo.getGridQuery()==1) QUERY = true;
				//判断字段名是否重复，如果重复，不允许保存
				if(fieldNos.contains(fieldInfo.getNo())){
					fieldNos.clear();
					break;
				}else fieldNos.add(fieldInfo.getNo());
				//判断字段是否为文件上传框
				if(fieldInfo.getType().equals("fileUpload")){
					formInfo.setFileUpload(1);
				}
			}
			if(!QUERY) {
				//如果未设置任何查询条件，那么采用默认标准界面
				formInfo.setTempType("grid");
			}
			//判断表单编码是否存在，如果存在，不允许保存			
			int count = dFService.verifyFormNo(verifyForm);
			if(count==0){
				//检查表名是否存在，如果存在，不允许保存
				count = dFService.existsTable(formInfo.getTable().toUpperCase());
				if(count==0){
					if(fieldNos.size()>0){
						//如果数据存在，删除
						String SQL = "DELETE FROM DF_FIELD A WHERE EXISTS(SELECT 'X' FROM DF_FORM B WHERE A.FORM_ID=B.FORM_ID AND UPPER(B.FORM_NO) = '"+formInfo.getNo().toUpperCase()+"' )";
						dFService.createTable(SQL);
						if(update) dFService.updateForm(formInfo);
						else dFService.saveForm(formInfo);
						
						//生成JSP文件
						Map<String, Object> data = new HashMap<String, Object>();  
				        data.put("model", formInfo);
						generate(servletContext.getRealPath("/df/template/"), formInfo.getTempType()+".ftl", data
								, servletContext.getRealPath("/jsp/df/")+File.separator+formInfo.getNo()+".jsp");
						
						jsonData.setSuccess(true);
						jsonData.setMsg("表单保存成功");
						jsonData.setExtData(formInfo.getId());
					}else{
						jsonData.setSuccess(false);
						jsonData.setMsg("字段名存在编码重复，请检查");
					}
				}else{
					jsonData.setSuccess(false);
					jsonData.setMsg("数据库已存在"+formInfo.getTable()+"表");
				}
			}else{
				jsonData.setSuccess(false);
				jsonData.setMsg("编码为"+verifyForm.getNo()+"的表单已存在");
			}
		}catch(Exception e){
			log.error("表单保存失败",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误，表单保存失败");
		}
		return jsonData;
	}	
	
	@RequestMapping("publish")
	@ResponseBody
	public JsonData publish(String id){
		JsonData jsonData = new JsonData();
		FormInfo formInfo = dFService.getFormInfo(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("formId", id);
		map.put("dbNull", -1);//获取所有字段
		List<FieldInfo> fields = dFService.getFieldList(map);
		formInfo.setFields(fields);
		String SQL = "DROP TABLE "+formInfo.getTable();
		try{dFService.createTable(SQL);}catch(Exception e){log.info("未发现表"+formInfo.getTable(),e);}
		try{
			
			StringBuffer tableSql = new StringBuffer("CREATE TABLE "+formInfo.getTable()+"(");		
			
			for(FieldInfo fieldInfo : formInfo.getFields()){
				if(fieldInfo.getDbNull()==0) continue; //字段不与数据库绑定
				tableSql.append(fieldInfo.getDbId()).append(" varchar2("+fieldInfo.getDbLength()+") ");
				if(fieldInfo.getFieldNull()==0) tableSql.append(" not null ");
				tableSql.append(",");
			}
			//生成数据库表
			if(!StringUtils.isEmpty(formInfo.getPrimary())){
				tableSql.append("primary key(").append(formInfo.getPrimaryField()).append("),");
			}
			for(Map.Entry<String, String> entry : formInfo.getUniques().entrySet()){
				tableSql.append("unique(").append(entry.getValue()).append("),");
			}
			tableSql.deleteCharAt(tableSql.length()-1).append(")");
			dFService.createTable(tableSql.toString());
			formInfo.setPublish(1);
			//生成JSP文件
			Map<String, Object> data = new HashMap<String, Object>();  
	        data.put("model", formInfo);
			generate(servletContext.getRealPath("/df/template/"), formInfo.getTempType()+".ftl", data
					, servletContext.getRealPath("/jsp/df/")+File.separator+formInfo.getNo()+".jsp");			
			dFService.publishForm(formInfo);
			
			if(!StringUtils.isEmpty(formInfo.getModuleId())){
				//将表单添加到模块
				Module module = new Module();
				module.setId(formInfo.getId());
				module.setModuleCode(formInfo.getNo());
				module.setModuleName(formInfo.getName());
				module.setUrl("df/index.zb?fid="+formInfo.getId());
				module.setRemark(formInfo.getRemark());
				module.setModuleType("1");
				module.setParentId(formInfo.getModuleId());
				module.setIsPublic("0");
				module.setDisabled("0");
				moduleService.saveModule(module);
			}
			jsonData.setSuccess(true);
			jsonData.setMsg("表单发布成功");
			jsonData.setExtData(formInfo.getId());
		}catch(Exception e){
			log.error("表单发布失败",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误，表单发布失败");
		}
		return jsonData;
	}
	
	@RequestMapping("preview")
	@ResponseBody
	public JsonData preview(String id){
		JsonData jsonData = new JsonData();
		FormInfo formInfo = dFService.getFormInfo(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("formId", id);
		map.put("dbNull", -1);
		List<FieldInfo> fields = dFService.getFieldList(map);
		formInfo.setFields(fields);		
		try{		
			//生成JSP文件
			Map<String, Object> data = new HashMap<String, Object>();  
	        data.put("model", formInfo);
			generate(servletContext.getRealPath("/df/template/"), formInfo.getTempType()+".ftl", data
					, servletContext.getRealPath("/jsp/df/")+File.separator+formInfo.getNo()+".jsp");
			jsonData.setSuccess(true);
			jsonData.setExtData(formInfo.getId());
		}catch(Exception e){
			log.error("表单预览失败",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误，表单预览失败");
		}
		return jsonData;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public JsonData delete(String id){
		JsonData jsonData = new JsonData();
		try{
			dFService.deleteForm(id, servletContext.getRealPath("/jsp/df/")+File.separator);
			//删除模块
			moduleService.deleteModuleById(id);
			jsonData.setSuccess(true);
		}catch(Exception e){
			log.error("表单删除失败",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误，表单删除失败");
		}
		return jsonData;
	}
	
	@RequestMapping("listForLoad")
	@ResponseBody
	public List<FormInfo> getFormInfoForLoad(@RequestParam(required=false)String id){
		return dFService.getFormListForCopy(id);
	}
	
	//表单取消发布
	@RequestMapping("unpublish")
	@ResponseBody
	public JsonData unpublish(String id){
		JsonData jsonData = new JsonData();
		FormInfo formInfo = dFService.getFormInfo(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("formId", id);
		map.put("dbNull", -1);
		List<FieldInfo> fields = dFService.getFieldList(map);
		formInfo.setFields(fields);
		
		try{
			//备份表名 BAK+源表名+时间戳
			String TABLE_NAME = "BAK_"+formInfo.getTable()+"_"+DateUtil.getCurrentDate("yyyyMMddHHmmss");
			//复制表结构和数据
			String SQL = "CREATE TABLE "+TABLE_NAME+" AS SELECT * FROM "+formInfo.getTable();
			dFService.createTable(SQL);
			//删除源表
			SQL = "DROP TABLE "+formInfo.getTable();
			try{dFService.createTable(SQL);}catch(Exception e){log.info("未发现表"+formInfo.getTable(),e);}			
			formInfo.setPublish(0);
			//生成JSP文件
			Map<String, Object> data = new HashMap<String, Object>();  
	        data.put("model", formInfo);
			generate(servletContext.getRealPath("/df/template/"), formInfo.getTempType()+".ftl", data
					, servletContext.getRealPath("/jsp/df/")+File.separator+formInfo.getNo()+".jsp");			
			dFService.publishForm(formInfo);
			
			//删除表与模块的关联
			if(!StringUtils.isEmpty(formInfo.getModuleId())){
				moduleService.deleteModuleById(id);
			}
			jsonData.setSuccess(true);
			jsonData.setMsg("表单取消发布成功");
			jsonData.setExtData(formInfo.getId());
			jsonData.setMsg(TABLE_NAME);
		}catch(Exception e){
			log.error("表单发布失败",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误，表单发布失败");
		}
		return jsonData;
	}
	//复制表单
	@RequestMapping("copyForm")
	@ResponseBody
	public JsonData copyForm(@RequestParam(required=false)String id, HttpServletRequest request){
		JsonData jsonData = new JsonData();		
		FormInfo verifyForm = new FormInfo();
		FormInfo formInfo = new FormInfo();
		formInfo.setId(Identities.uuid());
		formInfo.setNo(request.getParameter("no"));
		verifyForm.setNo(request.getParameter("no"));
		formInfo.setName(request.getParameter("name"));
		if(StringUtils.isEmpty(formInfo.getName())){
			//如果名称为空，以编码代替
			formInfo.setName(formInfo.getNo());
		}
		formInfo.setTable(request.getParameter("table"));
		if(StringUtils.isEmpty(formInfo.getTable())){
			//如果未输入表名，那么以编码作为表名
			formInfo.setTable(formInfo.getNo());
		}
		formInfo.setRemark(request.getParameter("remark"));
		try{
			//判断表单编码是否存在，如果存在，不允许保存			
			int count = dFService.verifyFormNo(verifyForm);
			if(count==0){
				//检查表名是否存在，如果存在，不允许保存
				count = dFService.existsTable(formInfo.getTable().toUpperCase());
				if(count==0){
					//获取源表单信息
					FormInfo sourceForm = dFService.getFormInfo(id);
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("formId", id);
					map.put("dbNull", -1);
					List<FieldInfo> fields = dFService.getFieldList(map);
					//复制表单信息
					for(FieldInfo fieldInfo : fields){
						fieldInfo.setId(Identities.uuid());
						fieldInfo.setFormId(formInfo.getId());
						formInfo.getFields().add(fieldInfo);
					}
					formInfo.setPrimary(sourceForm.getPrimary());
					formInfo.setPrimaryField(sourceForm.getPrimaryField());
					formInfo.setTempType(sourceForm.getTempType());
					formInfo.setUniques(formInfo.getUniques());
					//复制完后表单是未发布状态
					formInfo.setPublish(0);
					//如果数据存在，删除
					String SQL = "DELETE FROM DF_FIELD A WHERE EXISTS(SELECT 'X' FROM DF_FORM B WHERE A.FORM_ID=B.FORM_ID AND UPPER(B.FORM_NO) = '"+formInfo.getNo().toUpperCase()+"' )";
					dFService.createTable(SQL);
					dFService.saveForm(formInfo);
					
					//生成JSP文件
					Map<String, Object> data = new HashMap<String, Object>();  
			        data.put("model", formInfo);
					generate(servletContext.getRealPath("/df/template/"), formInfo.getTempType()+".ftl", data
							, servletContext.getRealPath("/jsp/df/")+File.separator+formInfo.getNo()+".jsp");
					
					jsonData.setSuccess(true);
					jsonData.setMsg("表单复制成功");
					jsonData.setExtData(formInfo.getId());
				}else{
					jsonData.setSuccess(false);
					jsonData.setMsg("数据库已存在"+formInfo.getTable()+"表");
				}
			}else{
				jsonData.setSuccess(false);
				jsonData.setMsg("编码为"+verifyForm.getNo()+"的表单已存在");
			}
		}catch(Exception e){
			log.error("表单复制失败",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误，表单复制失败");
		}
		return jsonData; 
	}
	
	//获取不等于ID的表单，如果ID为空，获取所有表单
	@RequestMapping("getForms")
	@ResponseBody
	public List<FormInfo> getFormInfos(@RequestParam(required=false)String id){
		return dFService.getFormListNotId(id);
	}
	
	//获取表单对应的所有与数据库关联的字段信息
	@RequestMapping("getFields")
	@ResponseBody
	public List<FieldInfo> getFields(@RequestParam(required=true)String id){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("formId", id);
		map.put("dbNull", -1);
		return dFService.getFieldList(map);		
	}
	
	public boolean generate(String templateFileDir, String templateFile, Map<String, Object> data,
			String fileName) {
		Writer writer = null;
		try {	
			//取得生成文件的路径
			String genFileDir=fileName.substring(0, fileName.lastIndexOf("\\"));
	        Template template = ConfigurationHelper.getConfiguration(templateFileDir).getTemplate(templateFile);
	        template.setEncoding("UTF-8");
	        File fileDir=new File(genFileDir);
	        FileUtils.forceMkdir(fileDir);
	        
	        File output = new File(fileName);
	       if(output.exists()){
	    	   //如何代码已存在不重复生成
//	    	   return false;
	    	   output.delete();
	       }
	        writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(output), "UTF-8"));
	        template.process(data, writer);
	        writer.close();
		} catch (TemplateException e) {
			e.printStackTrace();
			 return false;		
		} catch (IOException e) {
			e.printStackTrace();
			 return false;
		} finally{			
			try {
				if(writer!=null) writer.close();
			} catch (IOException e) {}
		}
		return true;
	}
	//导入字段
	@RequestMapping("impRecords")
	@ResponseBody
	public JsonData impRecords(){
		JsonData jsonData = new JsonData();
		try{
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("formId", "0");
			map.put("dbNull", -1);
			List<FieldInfo> fieldInfos = dFService.getFieldList(map); 
			jsonData.setRows(fieldInfos);
			jsonData.setTotal(fieldInfos.size());
			jsonData.setSuccess(true);
		}catch(Exception e){
			log.error("字段导入失败",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误，字段导入失败");
		}
		return jsonData;
	}
	
	/***********************以下是系统设置的Controller****************************/
	@RequestMapping("setting/loadFields")
	@ResponseBody
	public JsonData loadFields(){
		JsonData jsonData = new JsonData();
		return jsonData;
	}
	@RequestMapping("setting/saveFields")
	@ResponseBody
	public JsonData saveFields(HttpServletRequest request){
		JsonData jsonData = new JsonData();
		boolean update = false;
		try{
			FormInfo formInfo = dFService.getFormInfo("0");
			if(formInfo==null) {
				formInfo = new FormInfo();
			}else update = true;
			List<String> fieldNos = new ArrayList<String>();			
			formInfo.setId("0");
			formInfo.setNo("系统设置");
			int fieldCount = Integer.parseInt(request.getParameter("fieldCount"));//字段总数
			for(int i=0; i<fieldCount; i++){
				FieldInfo fieldInfo = new FieldInfo();
				Field[] fields = fieldInfo.getClass().getDeclaredFields();
				for(Field field : fields){
					try {
						Method method = fieldInfo.getClass().getDeclaredMethod("set"+StringUtils.capitalize(field.getName()), field.getType());
						if(field.getType().getName().equals("int")){
							method.invoke(fieldInfo, Integer.parseInt(request.getParameter("fields["+i+"]["+field.getName()+"]")));
						}else{
							method.invoke(fieldInfo, request.getParameter("fields["+i+"]["+field.getName()+"]"));
						}
					} catch (Exception e) {}				
				}
				fieldInfo.setId(Identities.uuid());
				//如果字段类型为空，默认为text
				if(StringUtils.isEmpty(fieldInfo.getType())) fieldInfo.setType("text");
				//如果字段名为空，以字段编码为字段名
				if(StringUtils.isEmpty(fieldInfo.getDbId())) fieldInfo.setDbId(fieldInfo.getNo());
				//字段长度默认为255
				if(fieldInfo.getDbLength()<=0) fieldInfo.setDbLength(255);
				//如果字段是checkbox，且未设置默认值和数据源，那么默认值设置为1
				if(fieldInfo.getType().equals("checkbox")&&fieldInfo.getDsType()==0&&StringUtils.isEmpty(fieldInfo.getDefaultValue())){
					fieldInfo.setDefaultValue("1");
				}
				//如果存在字段验证，那么该字段不与数据库表绑定
				if(!StringUtils.isEmpty(fieldInfo.getFieldEquals())) fieldInfo.setDbNull(0);
				if(fieldInfo.getPrimary()>0) {//设置主键
					formInfo.setPrimary(fieldInfo.getNo());
					formInfo.setPrimaryField(fieldInfo.getDbId());
				}
				if(fieldInfo.getUnique()>0) {//设置唯一约束
					formInfo.getUniques().put(fieldInfo.getNo(), fieldInfo.getDbId());
				}
				fieldInfo.setFormId(formInfo.getId());
				fieldInfo.setOrderBy(i);
				//如果未设置最大值，将自动设置为数据库表的字段长度除以3
				if(fieldInfo.getMaxLen()<=0) fieldInfo.setMaxLen(fieldInfo.getDbLength() / 3);
				//如果编码为空，自动省略此字段
				if(StringUtils.isEmpty(fieldInfo.getNo())) continue;
				formInfo.getFields().add(fieldInfo);
				//判断字段名是否重复，如果重复，不允许保存
				if(fieldNos.contains(fieldInfo.getNo())){
					fieldNos.clear();
					break;
				}else fieldNos.add(fieldInfo.getNo());
				//判断字段是否为文件上传框
				if(fieldInfo.getType().equals("fileUpload")){
					formInfo.setFileUpload(1);
				}
			}
			if(fieldNos.size()>0){
				//如果数据存在，删除
				String SQL = "DELETE FROM DF_FIELD A WHERE A.FORM_ID = '0' ";
				dFService.createTable(SQL);
				if(update) dFService.updateForm(formInfo);
				else dFService.saveForm(formInfo);
				
				jsonData.setSuccess(true);
				jsonData.setMsg("默认字段设置成功");
				jsonData.setExtData(formInfo.getId());
			}else{
				jsonData.setSuccess(false);
				jsonData.setMsg("字段名存在编码重复，请检查");
			}				
		}catch(Exception e){
			log.error("表单保存失败",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误，表单保存失败");
		}
		return jsonData;
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
}
