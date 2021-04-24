package com.solidextend.sys.df.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.apache.commons.beanutils.BeanUtils;

import com.solidextend.core.util.DateUtil;
import com.solidextend.core.util.Identities;
import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.df.service.DFService;
import com.solidextend.sys.df.vo.ExportInfo;
import com.solidextend.sys.df.vo.FieldInfo;
import com.solidextend.sys.df.vo.FormInfo;
import com.solidextend.sys.dict.service.DictService;
import com.solidextend.sys.dict.vo.DictItem;

/**
 * DF核心类
 * @author 王聚金
 * @version 2014-3-04 09:47
 */
@Controller
@RequestMapping("/df")
public class DFController {

	@Resource
	private DFService dFService;
	@Resource
	private DictService dictService;
	@Resource
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 主页面
	 */
	@RequestMapping("/index")
	public String index(@RequestParam String fid, HttpServletRequest request){
		FormInfo formInfo = dFService.getFormInfo(fid);	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("formId", fid);
		map.put("dbNull", 1);
		//如果存在选择框、单选框、多选框，需将选项值获取
		List<FieldInfo> fields = dFService.getFieldList(map);
		for(FieldInfo fieldInfo : fields){
			if(fieldInfo.getDsType()==1){//自定义选项
				StringBuffer options = new StringBuffer("[{ID:'',TEXT:'请选择'}");				
				String[] dsValues = fieldInfo.getDsValue().split("\\|");
				for(String dsValue : dsValues){
					options.append(",{")
					.append("ID:'").append(dsValue.split(",")[0]).append("',")
					.append("TEXT:'").append(dsValue.split(",")[1]).append("'")
					.append("}");
				}
				options.append("]");
				request.setAttribute(fieldInfo.getNo(), options);
			}else if(fieldInfo.getDsType()==2){//字典选项
				StringBuffer options = new StringBuffer("[");
				DictItem dictItem = new DictItem();
				dictItem.setDictId(fieldInfo.getDsValue());
				List<DictItem> rows = this.dictService.findDictItem(dictItem);
				for(DictItem item : rows){
					options.append("{")
					.append("ID:'").append(item.getId()).append("',")
					.append("TEXT:'").append(item.getItemName()).append("'")
					.append("},");
				}
				if(options.length()>1) options.deleteCharAt(options.length()-1);
				options.append("]");
				request.setAttribute(fieldInfo.getNo(), options);
			}else if(fieldInfo.getDsType()==3){//表单关联
				
			}
		}
		return "df/"+formInfo.getNo();
	}
	
	/**
	 * 列表
	 */
	@RequestMapping("/list")
	@ResponseBody
	public JsonData list(PageParam pageParam, @RequestParam String fid, HttpServletRequest request){
		FormInfo formInfo = dFService.getFormInfo(fid);
		Map<String, Object> fieldMap = new HashMap<String, Object>();
		fieldMap.put("formId", fid);
		fieldMap.put("dbNull", 1);
		List<FieldInfo> fields = dFService.getFieldList(fieldMap);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("table", formInfo.getTable());				
		List<FieldInfo> queryFields = new ArrayList<FieldInfo>();
		Map<String, String> queryMap = new HashMap<String, String>();
		for(FieldInfo fieldInfo : fields){
			//查询字段设置
			//如果字段的列表显示为隐藏模式且该字段不是主键，那么不查询此字段
			if(fieldInfo.getGridHide()>0&&!fieldInfo.getNo().equals(formInfo.getPrimary())) continue;
			if(fieldInfo.getDsType()==3){//如果该字段的数据源模式为关联表单
				fieldInfo.setDsValue(dFService.getFormInfo(fieldInfo.getDsValue()).getTable());//设置关联表单表名
				fieldInfo.setDsUrlId(dFService.getFieldInfo(fieldInfo.getDsUrlId()).getDbId());//设置字段名
				fieldInfo.setDsUrlText(dFService.getFieldInfo(fieldInfo.getDsUrlText()).getDbId());//设置描述字段名
				queryFields.add(fieldInfo);
			}else{
				queryFields.add(fieldInfo);
			}
			//查询条件设置
			String key = fieldInfo.getNo().toUpperCase();
			if(fieldInfo.getType().equals("checkbox")){
				String[] checkboxs = request.getParameterValues(key);
				StringBuffer cbStr = new StringBuffer();
				if(checkboxs!=null){
					for(String s : checkboxs){
						cbStr.append(s).append(",");
					}
				}
				if(cbStr.length()>0) cbStr.deleteCharAt(cbStr.length()-1);
				if(!StringUtils.isEmpty(cbStr.toString())){
					queryMap.put("','||"+fieldInfo.getDbId()+"||','", ","+cbStr.toString()+",");
				}
			}else{
				String value = request.getParameter(key);
				if(!StringUtils.isEmpty(value)){
					queryMap.put(fieldInfo.getDbId(), value);
				}
			}
		}
		map.put("fields", queryFields);
		map.put("querys", queryMap);
		return dFService.select(pageParam, map);
	}
	
	/**
	 * 查询单条记录
	 */
	@RequestMapping("/get")
	@ResponseBody
	public JsonData get(@RequestParam String fid, @RequestParam(required=false) String id){
		FormInfo formInfo = dFService.getFormInfo(fid);
		Map<String, Object> fieldMap = new HashMap<String, Object>();
		fieldMap.put("formId", fid);
		fieldMap.put("dbNull", 1);
		List<FieldInfo> fields = dFService.getFieldList(fieldMap);
		JsonData jsonData = new JsonData();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("table", formInfo.getTable());
		map.put("primary", formInfo.getPrimary());
		map.put("primaryField", formInfo.getPrimaryField());
		map.put("fields", fields);
		map.put("id", id);
		try {
			jsonData.setExtData(dFService.get(map));
			jsonData.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 删除表单
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public JsonData delete(@RequestParam String fid, @RequestParam String id){
		FormInfo formInfo = dFService.getFormInfo(fid);
		JsonData jsonData = new JsonData ();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("table", formInfo.getTable());
		map.put("primary", formInfo.getPrimary());
		map.put("primaryField", formInfo.getPrimaryField());
		try {
			String[] ids = id.split(",");
			for(String s : ids){								
				map.put("id", s);
				dFService.delete(map);
			}
			jsonData.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 保存表单
	 */
	@RequestMapping("/save")
	@ResponseBody
	public JsonData save(@RequestParam String fid, HttpServletRequest request){
		JsonData jsonData = new JsonData ();
		Map<String, Object> fieldParamMap = new HashMap<String, Object>();
		fieldParamMap.put("formId", fid);
		fieldParamMap.put("dbNull", 1);
		FormInfo formInfo = dFService.getFormInfo(fid);
		List<FieldInfo> fields = dFService.getFieldList(fieldParamMap);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("table", formInfo.getTable());
		map.put("primary", formInfo.getPrimary());
		map.put("primaryField", formInfo.getPrimaryField());
		
		Map<String, Object> getMap = new HashMap<String, Object>();
		getMap.put("table", formInfo.getTable());
		getMap.put("primary", formInfo.getPrimary());
		getMap.put("primaryField", formInfo.getPrimaryField());
		getMap.put("fields", fields);
		getMap.put("id", request.getParameter(formInfo.getPrimary().toUpperCase()));
		
		Map<String, Object> fieldMap = new HashMap<String, Object>();
		//如果主键值为空，或者通过查询该主键值的记录为空，执行新建操作
		if(StringUtils.isEmpty(request.getParameter(formInfo.getPrimary().toUpperCase()))
			|| dFService.get(getMap)==null){//新建
			for(FieldInfo fieldInfo : fields){
				if(fieldInfo.getNo().equals(formInfo.getPrimary())){
					if(StringUtils.isEmpty(request.getParameter(formInfo.getPrimary().toUpperCase())))
						fieldMap.put(fieldInfo.getDbId(), Identities.uuid());
					else
						fieldMap.put(fieldInfo.getDbId(), request.getParameter(formInfo.getPrimary().toUpperCase()));
				}else if(fieldInfo.getType().equals("checkbox")){
					String[] checkboxs = request.getParameterValues(fieldInfo.getNo().toUpperCase());
					StringBuffer cbStr = new StringBuffer();
					if(checkboxs!=null){
						for(String s : checkboxs){
							cbStr.append(s).append(",");
						}
					}
					if(cbStr.length()>0) cbStr.deleteCharAt(cbStr.length()-1);
					fieldMap.put(fieldInfo.getDbId(), StringUtils.defaultString(cbStr.toString()));
				}else if(fieldInfo.getType().equals("password")){
					//如果是密码，且不为空，进行MD5加密
					String password = request.getParameter(fieldInfo.getNo().toUpperCase());
					if(!StringUtils.isEmpty(password)) password = DigestUtils.md5Hex(password);
						fieldMap.put(fieldInfo.getDbId(), password);
				}else{
					String value = StringUtils.defaultString(request.getParameter(fieldInfo.getNo().toUpperCase()));
					//此处设置默认值
					if(fieldInfo.getAllowAdd()==0){
						if("now()".equals(fieldInfo.getAllowValue())) value = DateUtil.getCurrentDate("yyyyMMddHHmmss");
						else if(!StringUtils.isEmpty(fieldInfo.getAllowValue())) value = fieldInfo.getAllowValue();
					}
					fieldMap.put(fieldInfo.getDbId(), value);
				}
			}
			map.put("operation", "insert");
		}else{//修改
			for(FieldInfo fieldInfo : fields){
				if(fieldInfo.getNo().equals(formInfo.getPrimary())) continue;
				if(fieldInfo.getType().equals("checkbox")){
					String[] checkboxs = request.getParameterValues(fieldInfo.getNo().toUpperCase());
					StringBuffer cbStr = new StringBuffer();
					if(checkboxs!=null){
						for(String s : checkboxs){
							cbStr.append(s).append(",");
						}
					}
					if(cbStr.length()>0) cbStr.deleteCharAt(cbStr.length()-1);
					fieldMap.put(fieldInfo.getDbId(), StringUtils.defaultString(cbStr.toString()));
				}else if(fieldInfo.getType().equals("password")){
					//如果是密码，如果为空，不更新。反之，进行MD5加密
					String password = request.getParameter(fieldInfo.getNo().toUpperCase());
					if(!StringUtils.isEmpty(password)) {
						fieldMap.put(fieldInfo.getDbId(), DigestUtils.md5Hex(password));
					}
				}else{
					String value = StringUtils.defaultString(request.getParameter(fieldInfo.getNo().toUpperCase()));
					//此处设置默认值
					if(fieldInfo.getAllowUpdate()==0){
						if("now()".equals(fieldInfo.getAllowValue())) value = DateUtil.getCurrentDate("yyyyMMddHHmmss");
						else if(!StringUtils.isEmpty(fieldInfo.getAllowValue())) value = fieldInfo.getAllowValue();
					}
					fieldMap.put(fieldInfo.getDbId(), value);
				}
			}
			map.put("id", request.getParameter(formInfo.getPrimary().toUpperCase()));
			map.put("operation", "update");
		}
		map.put("data", fieldMap);
		try {
			dFService.save(map);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 保存表单(文件上传)
	 */
	@RequestMapping("/saveu")
	@ResponseBody
	public JsonData saveu(@RequestParam String fid, HttpServletRequest request){	
		JsonData jsonData = new JsonData ();
		Map<String, Object> fieldParamMap = new HashMap<String, Object>();
		fieldParamMap.put("formId", fid);
		fieldParamMap.put("dbNull", 1);
		FormInfo formInfo = dFService.getFormInfo(fid);
		if(formInfo.getFileUpload()==0){
			//如果是一般表单，直接跳转到标准表单提交
			jsonData = save(fid, request);
			return jsonData;
		}		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		List<FieldInfo> fields = dFService.getFieldList(fieldParamMap);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("table", formInfo.getTable());
		map.put("primary", formInfo.getPrimary());
		map.put("primaryField", formInfo.getPrimaryField());
		
		Map<String, Object> getMap = new HashMap<String, Object>();
		getMap.put("table", formInfo.getTable());
		getMap.put("primary", formInfo.getPrimary());
		getMap.put("primaryField", formInfo.getPrimaryField());
		getMap.put("fields", fields);
		getMap.put("id", multipartRequest.getParameter(formInfo.getPrimary().toUpperCase()));
		
		Map<String, Object> fieldMap = new HashMap<String, Object>();
		//如果主键值为空，或者通过查询该主键值的记录为空，执行新建操作
		if(StringUtils.isEmpty(multipartRequest.getParameter(formInfo.getPrimary().toUpperCase()))
			|| dFService.get(getMap)==null){//新建
			for(FieldInfo fieldInfo : fields){
				if(fieldInfo.getNo().equals(formInfo.getPrimary())){
					if(StringUtils.isEmpty(multipartRequest.getParameter(formInfo.getPrimary().toUpperCase())))
						fieldMap.put(fieldInfo.getDbId(), Identities.uuid());
					else
						fieldMap.put(fieldInfo.getDbId(), multipartRequest.getParameter(formInfo.getPrimary().toUpperCase()));
				}else if(fieldInfo.getType().equals("checkbox")){
					String[] checkboxs = multipartRequest.getParameterValues(fieldInfo.getNo().toUpperCase());
					StringBuffer cbStr = new StringBuffer();
					if(checkboxs!=null){
						for(String s : checkboxs){
							cbStr.append(s).append(",");
						}
					}
					if(cbStr.length()>0) cbStr.deleteCharAt(cbStr.length()-1);
					fieldMap.put(fieldInfo.getDbId(), StringUtils.defaultString(cbStr.toString()));
				}else if(fieldInfo.getType().equals("password")){
					//如果是密码，且不为空，进行MD5加密
					String password = multipartRequest.getParameter(fieldInfo.getNo().toUpperCase());
					if(!StringUtils.isEmpty(password)) password = DigestUtils.md5Hex(password);
						fieldMap.put(fieldInfo.getDbId(), password);
				}else if(fieldInfo.getType().equals("fileUpload")){//文件上传
					MultipartFile file = multipartRequest.getFile(fieldInfo.getNo().toUpperCase());
					if(!StringUtils.isEmpty(file.getOriginalFilename())){
						String fileName = System.currentTimeMillis()+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
						String path = request.getSession().getServletContext().getRealPath("upload/"+formInfo.getNo());
						File newFile = new File(path, fileName);
						if(!newFile.exists()) newFile.mkdirs();
						try {
							file.transferTo(newFile);
							fieldMap.put(fieldInfo.getDbId(), fileName);
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}else{
					fieldMap.put(fieldInfo.getDbId(), StringUtils.defaultString(multipartRequest.getParameter(fieldInfo.getNo().toUpperCase())));
				}
			}
			map.put("operation", "insert");
		}else{//修改
			for(FieldInfo fieldInfo : fields){
				if(fieldInfo.getNo().equals(formInfo.getPrimary())) continue;
				if(fieldInfo.getType().equals("checkbox")){
					String[] checkboxs = multipartRequest.getParameterValues(fieldInfo.getNo().toUpperCase());
					StringBuffer cbStr = new StringBuffer();
					if(checkboxs!=null){
						for(String s : checkboxs){
							cbStr.append(s).append(",");
						}
					}
					if(cbStr.length()>0) cbStr.deleteCharAt(cbStr.length()-1);
					fieldMap.put(fieldInfo.getDbId(), StringUtils.defaultString(cbStr.toString()));
				}else if(fieldInfo.getType().equals("password")){
					//如果是密码，如果为空，不更新。反之，进行MD5加密
					String password = multipartRequest.getParameter(fieldInfo.getNo().toUpperCase());
					if(!StringUtils.isEmpty(password)) {
						fieldMap.put(fieldInfo.getDbId(), DigestUtils.md5Hex(password));
					}
				}else if(fieldInfo.getType().equals("fileUpload")){//文件上传
					MultipartFile file = multipartRequest.getFile(fieldInfo.getNo().toUpperCase());
					if(!StringUtils.isEmpty(file.getOriginalFilename())){
						String fileName = System.currentTimeMillis()+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
						String path = request.getSession().getServletContext().getRealPath("upload/"+formInfo.getNo());
						File newFile = new File(path, fileName);
						if(!newFile.exists()) newFile.mkdirs();
						try {
							file.transferTo(newFile);
							fieldMap.put(fieldInfo.getDbId(), fileName);
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}else{
					fieldMap.put(fieldInfo.getDbId(), StringUtils.defaultString(multipartRequest.getParameter(fieldInfo.getNo().toUpperCase())));
				}
			}
			map.put("id", multipartRequest.getParameter(formInfo.getPrimary().toUpperCase()));
			map.put("operation", "update");
		}
		map.put("data", fieldMap);
		try {
			dFService.save(map);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	@RequestMapping("check")
	@ResponseBody
	public boolean check(@RequestParam String fid, HttpServletRequest request){
		FormInfo formInfo = dFService.getFormInfo(fid);
		Map<String, Object> fieldParamMap = new HashMap<String, Object>();
		fieldParamMap.put("formId", fid);
		fieldParamMap.put("dbNull", 1);
		List<FieldInfo> fields = dFService.getFieldList(fieldParamMap);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("table", formInfo.getTable());
		String uniqueParam = "";
		String uniqueValue = "";
		for(FieldInfo fieldInfo : fields){
			System.out.println(fieldInfo.getUnique()+":"+fieldInfo.getNo()+":"+request.getParameter(fieldInfo.getNo()));
			if(fieldInfo.getUnique()>0&&!StringUtils.isEmpty(request.getParameter(fieldInfo.getNo()))){
				uniqueParam = fieldInfo.getNo();
				uniqueValue = request.getParameter(fieldInfo.getNo());
				break;
			}
		}
		if(StringUtils.isEmpty(uniqueParam)){
			return true;
		}else{
			System.out.println(uniqueParam+":"+uniqueValue);
			map.put("uniqueParam", uniqueParam);
			map.put("uniqueValue", uniqueValue);
			try {
				if(dFService.check(map)>0){
					return false;
				}else{
					return true;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}
	}	
	
	//获取关联表单数据源
	@RequestMapping("ds")
	@ResponseBody
	public List<Map<String, Object>> getDsValuesForForm(@RequestParam String fieldId){
		FieldInfo fieldInfo = dFService.getFieldInfo(fieldId);
		FormInfo formInfo = dFService.getFormInfo(fieldInfo.getDsValue());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dsTable", formInfo.getTable());
		map.put("dsId", dFService.getFieldInfo(fieldInfo.getDsUrlId()).getDbId());
		map.put("dsText", dFService.getFieldInfo(fieldInfo.getDsUrlText()).getDbId());
		return dFService.getDsValues(map);
	}
	//数据导入
	@RequestMapping("imp")
	public String imp(String fid, HttpServletRequest request){
		request.setAttribute("fid", fid);		
		return "../df/imp";
	}
	//数据导入-文件上传
	@RequestMapping("imp/upload")
	@ResponseBody
	public JsonData impUpload(HttpServletRequest request){
		JsonData jsonData = new JsonData();
		jsonData.setSuccess(false);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		FormInfo formInfo = dFService.getFormInfo(request.getParameter("id"));
		int fileType = Integer.parseInt(request.getParameter("fileType"));
		MultipartFile file = multipartRequest.getFile("file");
		if(!StringUtils.isEmpty(file.getOriginalFilename())){
			String fileName = System.currentTimeMillis()+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			String path = request.getSession().getServletContext().getRealPath("upload/"+formInfo.getNo());
			File newFile = new File(path, fileName);
			if(!newFile.exists()) newFile.mkdirs();
			try {
				file.transferTo(newFile);
				//获取表单所有字段
				Map<String, Object> fieldParamMap = new HashMap<String, Object>();
				fieldParamMap.put("formId", formInfo.getId());
				fieldParamMap.put("dbNull", 1);
				List<FieldInfo> fields = dFService.getFieldList(fieldParamMap);
				jsonData.setRows(fields);
				//获取文件第一行信息
				if(fileType==1||fileType==3){//txt或csv
					FileReader fileReader = new FileReader(newFile);
					BufferedReader in = new BufferedReader(fileReader);
					String str = in.readLine();
					if(StringUtils.isEmpty(str)){
						jsonData.setExtData("");
					}else{
						jsonData.setExtData(str);
					}
					in.close();
					fileReader.close();
				}else if(fileType==2){//excel
					Workbook wb = new HSSFWorkbook(new FileInputStream(newFile));
					Sheet sheet = wb.getSheetAt(0);
					int rows = sheet.getPhysicalNumberOfRows();					
					StringBuffer str = new StringBuffer();
					if(rows>0){
						int cols = sheet.getRow(0).getPhysicalNumberOfCells();						
						for(int i=0; i<cols; i++){
							str.append(sheet.getRow(0).getCell(i).getStringCellValue().toString()).append(",");
						}
						if(str.length()>0) str.deleteCharAt(str.length()-1);
					}
					jsonData.setExtData(str.toString());
				}				
				jsonData.setSuccess(true);			
				jsonData.setMsg(fileName);
				return jsonData;
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return jsonData;
	}
	//数据导入执行程序
	@RequestMapping("imp/exec")
	@ResponseBody
	public String impExec(ExportInfo exportInfo, HttpServletRequest request){
		FormInfo formInfo = dFService.getFormInfo(exportInfo.getId());
		Map<String, Object> fieldMap = new HashMap<String, Object>();
		fieldMap.put("formId", exportInfo.getId());
		fieldMap.put("dbNull", 1);
		List<FieldInfo> fields = dFService.getFieldList(fieldMap);	
		String path = request.getSession().getServletContext().getRealPath("upload/"+formInfo.getNo());
		File file = new File(path, exportInfo.getFileName());
		try{
			switch (exportInfo.getFileType()) {
			case 1: //txt	
				impTxtFile(file, exportInfo, fields, formInfo.getPrimary(), formInfo.getTable());
				break;
			case 2: //excel
				impExcelFile(file, exportInfo, fields, formInfo.getPrimary(), formInfo.getTable());				
				break;
			case 3: //csv
				impTxtFile(file, exportInfo, fields, formInfo.getPrimary(), formInfo.getTable());
				break;
			default: //txt
				impTxtFile(file, exportInfo, fields, formInfo.getPrimary(), formInfo.getTable());
				break;
			}
			return "success";
		}catch(IOException e){
			e.printStackTrace();
			return "error";
		} catch (SQLException e) {
			e.printStackTrace();
			return "error";
		}		
	}
	
	//Txt(Csv)文件导入
	public void impTxtFile(File file, ExportInfo exportInfo, List<FieldInfo> fields, String primary, String table) throws IOException, SQLException{	
		String expFields[] = exportInfo.getFields().split(",");
		FileReader fileReader = new FileReader(file);
		BufferedReader in = new BufferedReader(fileReader);
		String str = in.readLine();
		StringBuffer fieldSql = new StringBuffer();
		StringBuffer valSql = new StringBuffer();
		int primaryIndex = 0;
		for(int x=0; x<expFields.length; x++){			
			if(fields.get(x).getNo().equals(primary)) primaryIndex = x;
			fieldSql.append(fields.get(x).getDbId()).append(",");
			valSql.append("?,");
		}
		if(fieldSql.length()>0) {
			fieldSql.deleteCharAt(fieldSql.length()-1);
			valSql.deleteCharAt(valSql.length()-1);
		}
		String SQL = "insert into "+table+"("+fieldSql.toString()+") values("+valSql.toString()+")";
		Connection a = null;
		PreparedStatement p = null;
		try{
			a = jdbcTemplate.getDataSource().getConnection();
			a.setAutoCommit(false);
			p = a.prepareStatement(SQL);
			int i=0;
			while(str!=null){
				if(exportInfo.getTitle()==1&&i==0) {
					str = in.readLine();
					i++;
					continue;//如果是第一行且存在标题，那么直接跳过
				}				
				String[] vals = str.split(",");
				int flag=1;
				for(int x=0; x<expFields.length; x++){
					if(x==primaryIndex&&exportInfo.getAutoPrimary()==1){
						p.setString(flag++, Identities.uuid());
					}else{
						p.setString(flag++, vals[Integer.parseInt(expFields[x])]);
					}
				}
				p.addBatch();				
				str = in.readLine();
				i++;
				if(i%10000==0){
					p.executeBatch();
					p.clearBatch();
				}
			}
			p.executeBatch();
			p.close();
			a.commit();
			a.close();
			in.close();
			fileReader.close();
		}catch(SQLException sqle){
			a.rollback();
			throw new SQLException(sqle);
		}finally{
			if(p!=null) p.close();
			if(a!=null) a.close();			
		}		
	}
	
	//Excel文件导入
	public void impExcelFile(File file, ExportInfo exportInfo, List<FieldInfo> fields, String primary, String table) throws IOException, SQLException{	
		String expFields[] = exportInfo.getFields().split(",");
		Workbook wb = new HSSFWorkbook(new FileInputStream(file));
		Sheet sheet = wb.getSheetAt(0);
		int rows = sheet.getPhysicalNumberOfRows();
				
		StringBuffer fieldSql = new StringBuffer();
		StringBuffer valSql = new StringBuffer();
		int primaryIndex = 0;
		for(int x=0; x<expFields.length; x++){			
			if(fields.get(x).getNo().equals(primary)) primaryIndex = x;
			fieldSql.append(fields.get(x).getDbId()).append(",");
			valSql.append("?,");
		}
		if(fieldSql.length()>0) {
			fieldSql.deleteCharAt(fieldSql.length()-1);
			valSql.deleteCharAt(valSql.length()-1);
		}
		String SQL = "insert into "+table+"("+fieldSql.toString()+") values("+valSql.toString()+")";
		Connection a = null;
		PreparedStatement p = null;
		try{
			a = jdbcTemplate.getDataSource().getConnection();
			a.setAutoCommit(false);
			p = a.prepareStatement(SQL);
			for(int i=0; i<rows; i++){
				if(exportInfo.getTitle()==1&&i==0) {
					continue;//如果是第一行且存在标题，那么直接跳过
				}
				int flag=1;
				for(int x=0; x<expFields.length; x++){
					if(x==primaryIndex&&exportInfo.getAutoPrimary()==1){
						p.setString(flag++, Identities.uuid());
					}else{
						p.setString(flag++, sheet.getRow(i).getCell(Integer.parseInt(expFields[x])).getStringCellValue().toString());
					}					
				}
				p.addBatch();
				if(i%10000==0){
					p.executeBatch();
					p.clearBatch();
				}
			}			
			p.executeBatch();
			p.close();
			a.commit();
			a.close();
		}catch(SQLException sqle){
			a.rollback();
			throw new SQLException(sqle);
		}finally{
			if(p!=null) p.close();
			if(a!=null) a.close();			
		}		
	}
	
	//数据导出
	@RequestMapping("export")
	public String export(@RequestParam String fid, HttpServletRequest request){
		Map<String, Object> fieldParamMap = new HashMap<String, Object>();
		fieldParamMap.put("formId", fid);
		fieldParamMap.put("dbNull", 1);
		List<FieldInfo> fields = dFService.getFieldList(fieldParamMap);
		request.setAttribute("fields", fields);
		request.setAttribute("fid", fid);
		return "../df/export";
	}
	
	@RequestMapping("download")	
	public void download(String fn, String fid, int t, HttpServletRequest request, HttpServletResponse response) throws IOException{
		FormInfo formInfo = dFService.getFormInfo(fid);
		String path = request.getSession().getServletContext().getRealPath("download/"+formInfo.getNo());
		String fileName = formInfo.getNo()+"_"+fn;
		switch (t) {
			case 1:
				fileName += ".txt";
				break;
			case 2:
				fileName += ".xls";
				break;
			case 3:
				fileName += ".csv";
				break;
			default:
				fileName += ".txt";
				break;
		}
		OutputStream os = response.getOutputStream();  
	    try {  
	    	response.reset();  
	    	response.setHeader("Content-Disposition", "attachment; filename="+fileName);  
	    	response.setContentType("application/octet-stream; charset=utf-8");  
	        os.write(FileUtils.readFileToByteArray(new File(path, fileName)));  
	        os.flush();  
	    } finally {  
	        if (os != null) {  
	            os.close();  
	        }  
	    }  
	}
	@RequestMapping("export/exec")
	@ResponseBody
	public String exportExec(ExportInfo exportInfo, HttpServletRequest request){
		String expfields[] = exportInfo.getFields().split(",");
		FormInfo formInfo = dFService.getFormInfo(exportInfo.getId());
		Map<String, Object> fieldMap = new HashMap<String, Object>();
		fieldMap.put("formId", exportInfo.getId());
		fieldMap.put("dbNull", 1);
		List<FieldInfo> fields = dFService.getFieldList(fieldMap);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("table", formInfo.getTable());				
		List<FieldInfo> queryFields = new ArrayList<FieldInfo>();
		Map<String, String> queryMap = new HashMap<String, String>();
		Map<String, Map<String, String>> dsMap = new HashMap<String, Map<String, String>>();
		List<String> relFormFields = new ArrayList<String>();
		for(String field : expfields){//进行字段匹配和转换
			for(FieldInfo fieldInfo : fields){
				if(field.equals(fieldInfo.getNo())){
					FieldInfo fi = new FieldInfo();
					try {
						BeanUtils.copyProperties(fi,fieldInfo);
						if(fieldInfo.getDsType()==3){//如果该字段的数据源模式为关联表单
							fi.setDsValue(dFService.getFormInfo(fieldInfo.getDsValue()).getTable());//设置关联表单表名
							fi.setDsUrlId(dFService.getFieldInfo(fieldInfo.getDsUrlId()).getDbId());//设置字段名
							fi.setDsUrlText(dFService.getFieldInfo(fieldInfo.getDsUrlText()).getDbId());//设置描述字段名
							if(relFormFields.contains(fieldInfo.getNo())){
								fi.setDsUrlId("");//设置字段名
							}else{								
								relFormFields.add(fieldInfo.getNo());
							}
							queryFields.add(fi);
						}else{
							queryFields.add(fi);
						}
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					} catch (InvocationTargetException e) {
						e.printStackTrace();
					}					
					//如果该字段有数据源，那么必须将数据源的信息保存起来，供导出使用
					if(!dsMap.containsKey(fieldInfo.getNo())){
						if(fieldInfo.getDsType()==1){//自定义
							Map<String, String> valMap = new HashMap<String, String>();
							String[] dsValues = fieldInfo.getDsValue().split("\\|");
							for(String dsValue : dsValues){
								valMap.put(dsValue.split(",")[0], dsValue.split(",")[1]);
							}
							dsMap.put(fieldInfo.getNo(), valMap);
						}else if(fieldInfo.getDsType()==2){//字典
							DictItem dictItem = new DictItem();
							dictItem.setDictId(fieldInfo.getDsValue());
							List<DictItem> rows = this.dictService.findDictItem(dictItem);
							Map<String, String> valMap = new HashMap<String, String>();
							for(DictItem item : rows){							
								valMap.put(item.getId(), item.getItemName());							
							}
							dsMap.put(fieldInfo.getNo(), valMap);
						}
					}
					break;
				}
			}
		}
		map.put("fields", queryFields);
		map.put("querys", queryMap);
		List<Map<String, Object>> result = dFService.selectAll(map);
		String path = request.getSession().getServletContext().getRealPath("download/"+formInfo.getNo());
		File file = new File(path);
		if(!file.exists()) file.mkdirs();
		String fname = System.currentTimeMillis()+"";
		String fileName = formInfo.getNo() + "_" + fname;
		try{
			switch (exportInfo.getFileType()) {
				case 1:
					fileName += ".txt";
					createTxtFile(path, fileName, result, exportInfo, dsMap);			
					break;
				case 2:
					fileName += ".xls";
					createExcelFile(path, fileName, result, exportInfo, dsMap);					
					break;
				case 3:
					fileName += ".csv";
					createTxtFile(path, fileName, result, exportInfo, dsMap);
					break;
				default:
					fileName += ".txt";
					createTxtFile(path, fileName, result, exportInfo, dsMap);
					break;
			}
			return fname;
		}catch(IOException e){
			e.printStackTrace();
			return "error";
		}		
	}
	
	public void createTxtFile(String path, String fileName, List<Map<String, Object>> result, ExportInfo exportInfo,Map<String, Map<String, String>> dsMap) throws IOException{
		String expfields[] = exportInfo.getFields().split(",");
		File file = new File(path, fileName);
		if(file.exists()) file.delete();
		FileWriter writer = null;
		BufferedWriter out = null;
		try {
			writer = new FileWriter(file);
			out = new BufferedWriter(writer);	
			if(exportInfo.getTitle()==1){
				out.write(exportInfo.getFieldDescs()+"\n");
			}
			int i=0;
			for(Map<String, Object> map : result){
				i = 0;
				for(String field : expfields){
					if(dsMap.containsKey(field)){
						Map<String, String> dsValue = dsMap.get(field);
						//TODO 此处要处理多选框的值问题
						out.write(dsValue.get(map.get(field.toUpperCase())));
					}else{
						out.write(map.get(field.toUpperCase()).toString());
					}
					i++;
					if(i<expfields.length) out.write(",");
				}				
				out.write("\n");				
			}
			out.flush();
			out.close();
			writer.close();			
		} catch (IOException e) {
			throw new IOException(e);
		}finally{			
			try {
				if(out!=null) out.close();
				if(writer!=null) writer.close();
			} catch (IOException e) {}
		}
	}
	
	public void createExcelFile(String path, String fileName, List<Map<String, Object>> result, ExportInfo exportInfo,Map<String, Map<String, String>> dsMap) throws IOException{
		String expfields[] = exportInfo.getFields().split(",");
		HSSFWorkbook wb = new HSSFWorkbook();  
        HSSFSheet sheet = wb.createSheet("data");
        HSSFCellStyle style = wb.createCellStyle(); 
        int i=0, j=0;
        if(exportInfo.getTitle()==1){
        	HSSFCellStyle titleStyle = wb.createCellStyle();
        	style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 指定单元格居中对齐
        	//将标题加粗
        	HSSFFont f = wb.createFont();  
	        f.setFontHeightInPoints((short)10);  
	        f.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
	        titleStyle.setFont(f); 
        	String expfieldDescs[] = exportInfo.getFieldDescs().split(",");
        	HSSFRow row = sheet.createRow(i++);
        	for(String desc : expfieldDescs){
        		HSSFCell cell = row.createCell(j++);  
                cell.setCellValue(desc);
                cell.setCellStyle(titleStyle);
        	}
		}   

        for (Map<String, Object> map : result) {  
            HSSFRow row = sheet.createRow(i++);  
            j=0;
            for(String field : expfields){
            	HSSFCell cell = row.createCell(j++);  
				if(dsMap.containsKey(field)){
					Map<String, String> dsValue = dsMap.get(field);					
	                cell.setCellValue(dsValue.get(map.get(field.toUpperCase())));
				}else{  
	                cell.setCellValue(map.get(field.toUpperCase()).toString());	                
				}
				cell.setCellStyle(style);
			}
        }  
        
        File file = new File(path, fileName);
		if(file.exists()) file.delete();
        FileOutputStream fout = new FileOutputStream(file);  
        wb.write(fout);  
        fout.close();  
	}
	
	public void createCsvFile(String path, String fileName, List<Map<String, Object>> result, ExportInfo exportInfo,Map<String, Map<String, String>> dsMap) throws IOException{
		String expfields[] = exportInfo.getFields().split(",");
		File file = new File(path, fileName);
		if(file.exists()) file.delete();
		FileWriter writer = null;
		BufferedWriter out = null;
		try {
			writer = new FileWriter(file);
			out = new BufferedWriter(writer);
			if(exportInfo.getTitle()==1){
				out.write(exportInfo.getFieldDescs()+"\n");
			}
			int i=0;
			for(Map<String, Object> map : result){
				i = 0;
				for(String field : expfields){
					if(dsMap.containsKey(field)){
						Map<String, String> dsValue = dsMap.get(field);
						out.write(dsValue.get(map.get(field.toUpperCase())));
					}else{
						out.write(map.get(field.toUpperCase()).toString());
					}
					i++;
					if(i<expfields.length) out.write(",");
				}
				out.write("\n");				
			}
			out.flush();
			out.close();
			writer.close();			
		} catch (IOException e) {
			throw new IOException(e);
		}finally{			
			try {
				if(out!=null) out.close();
				if(writer!=null) writer.close();
			} catch (IOException e) {}
		}
	}
}
