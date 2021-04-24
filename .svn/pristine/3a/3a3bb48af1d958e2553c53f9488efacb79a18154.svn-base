package com.solidextend.sys.raqsoft.service;

import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import com.raqsoft.report.ide.base.DataSourceDefine;
import com.raqsoft.report.usermodel.Context;
import com.raqsoft.report.view.ReportServlet;
import com.raqsoft.web.view.ReportConfigModel;
import com.solidextend.sys.raqsoft.controller.RaqsoftController;
import com.solidextend.sys.raqsoft.vo.RaqSoftDataSource;
import com.solidextend.sys.raqsoft.vo.ReportFile;

@Service("raqsoftService")
public class RaqsoftServiceImpl implements RaqsoftService {
	private static final Log log = LogFactory.getLog(RaqsoftServiceImpl.class);
	private Document document;
	private String configFile;
	@Override
	public List<ReportFile> getReportFileList(String fileSuffix) {
		// TODO Auto-generated method stub
		Context cxt = new Context();
		String reportFileHome = cxt.getMainDir();
		// String rootPath=System.getProperty("solidbi");
		// reportFileHome=rootPath+reportFileHome;
		reportFileHome = getRealPath(reportFileHome);
		// reportFileHome="D:\\硕迪制信\\solidextend\\tomcat\\webapps\\solidbi\\raqsoft\\reportFiles";
		File reportFileHomeFolder = new File(reportFileHome);
		List<ReportFile> reportFileList = new ArrayList<ReportFile>();
		addReportFile(reportFileHomeFolder, fileSuffix, reportFileHome, reportFileList, null);
		return reportFileList;
	}

	private void addReportFile(File file, String fileSuffix, String reportFileHome, List<ReportFile> reportFileList,
			String parentId) {
		// System.out.println(getRealPath(file.getPath()).replaceFirst(getRealPath(reportFileHome),
		// ""));
		ReportFile rf = new ReportFile();
		rf.setName(file.getName());
		String id = getRealPath("/" + file.getPath());
		id = id.replaceFirst(reportFileHome, "");
		rf.setId(id);
		rf.setParentId(parentId);
		rf.setIsParent(file.isDirectory());
		reportFileList.add(rf);
		if (file.isDirectory()) {

			File[] files;
			if ("directory".equals(fileSuffix)) {
				FileFilter filter = new FileFilter() {
					@Override
					public boolean accept(File pathname) {
						return pathname.isDirectory();
					}
				};
				files = file.listFiles(filter);
			} else if ("rpx".equals(fileSuffix)) {
				FileFilter filter = new FileFilter() {
					@Override
					public boolean accept(File pathname) {
						boolean accept = false;
						String fileName = pathname.getName();
						accept = fileName.endsWith(".rpx") || fileName.endsWith(".rpg") || fileName.endsWith(".sht")
								|| pathname.isDirectory();
						return accept;
					}
				};
				files = file.listFiles(filter);
			} else {

				files = file.listFiles();
			}
			for (File f : files) {
				addReportFile(f, fileSuffix, reportFileHome, reportFileList, id);
			}
		}

	}

	private String getRealPath(String path) {
		return path.replaceAll("\\\\", "/").replaceAll("//", "/");
	}

	private String getResourceHome() {
		Context cxt = new Context();
		String reportFileHome = cxt.getMainDir();
		// String rootPath=System.getProperty("solidbi");
		// reportFileHome=rootPath+reportFileHome;
		reportFileHome = getRealPath(reportFileHome);
		return reportFileHome;
	}

	private String getNewFilePath(String filePath) {
		File file = new File(filePath);
		// 路径为文件且不为空则修改文件名
		if (file.isFile() && file.exists()) {
			String name = file.getName();
			String path = file.getParent();
			String suffix = name.substring(name.indexOf("."));
			name = name.substring(0, name.indexOf("."));
			String last = name.substring(name.length() - 1);
			String prefix = name.substring(0, name.length() - 1);
			int num = 1;
			try {
				num = Integer.parseInt(last);
				num++;
				name = prefix + String.valueOf(num) + suffix;
			} catch (NumberFormatException e) {
				name = name + "1" + suffix;

			}
			String newFilePath = path + File.separatorChar + name;
			return getNewFilePath(newFilePath);
		} else {
			return filePath;
		}
	}

	/**
	 * 递归删除目录下的所有文件及子目录下所有文件
	 * 
	 * @param dir
	 *            将要删除的文件目录
	 * @return boolean Returns "true" if all deletions were successful. If a
	 *         deletion fails, the method stops attempting to delete and returns
	 *         "false".
	 */
	private boolean deleteFile(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();
			// 递归删除目录中的子目录下
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteFile(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}
		// 目录此时为空，可以删除
		return dir.delete();
	}

	@Override
	public List<ReportFile> getFileList(String pid, String fileSuffix) {
		// TODO Auto-generated method stub
		String reportFileHome = getResourceHome();
		// reportFileHome="D:\\硕迪制信\\solidextend\\tomcat\\webapps\\solidbi\\raqsoft\\reportFiles";
		File file = new File(reportFileHome + File.separatorChar + pid);

		List<ReportFile> reportFileList = new ArrayList<ReportFile>();
		if (file.isDirectory()) {

			File[] files;
			if ("directory".equals(fileSuffix)) {
				FileFilter filter = new FileFilter() {
					@Override
					public boolean accept(File pathname) {
						return pathname.isDirectory();
					}
				};
				files = file.listFiles(filter);
			} else if ("rpx".equals(fileSuffix)) {
				FileFilter filter = new FileFilter() {
					@Override
					public boolean accept(File pathname) {
						boolean accept = false;
						String fileName = pathname.getName();
						accept = fileName.endsWith(".rpx") || fileName.endsWith(".rpg") || fileName.endsWith(".sht")
								|| pathname.isDirectory();
						return accept;
					}
				};
				files = file.listFiles(filter);
			} else {

				files = file.listFiles();
			}
			for (File f : files) {
				ReportFile rf = new ReportFile();
				rf.setName(f.getName());
				String id = getRealPath("/" + f.getPath());
				id = id.replaceFirst(reportFileHome, "");
				rf.setId(id);
				rf.setParentId(pid);
				long time = f.lastModified();
				rf.setLastModified(new Date(time));
				if (f.isDirectory()) {
					rf.setType("文件夹");
					rf.setSize("");
				} else {
					rf.setType("文件");
					rf.setSize((f.length() / 1024) + "k");
				}

				rf.setIsParent(f.isDirectory());
				reportFileList.add(rf);
			}
		}
		return reportFileList;
	}

	@Override
	public void saveReportFile(String path, MultipartFile report) {
		// TODO Auto-generated method stub
		String reportFileHome = getResourceHome();
		String name = report.getOriginalFilename();

		String filePath = reportFileHome + File.separatorChar + path + File.separatorChar + name;
		filePath = getNewFilePath(filePath);
		try {
			InputStream is = report.getInputStream();
			FileOutputStream fos = new FileOutputStream(filePath);

			byte[] b = new byte[1024];

			while ((is.read(b)) != -1) {

				fos.write(b);

			}
			report = null;
			is.close();

			fos.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public String download(String fileName, String filePath, HttpServletResponse response) {
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		String isoFileName = "myReport";
		try {
			isoFileName = new String(fileName.getBytes("gb2312"), "ISO8859-1");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;fileName=" + isoFileName);
		try {
			String path = getResourceHome();
			InputStream inputStream = new FileInputStream(new File(path + File.separator + filePath));

			OutputStream os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = inputStream.read(b)) > 0) {
				os.write(b, 0, length);
			}

			// 这里主要关闭。
			os.close();

			inputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 返回值要注意，要不然就出现下面这句错误！
		// java+getOutputStream() has already been called for this response
		return null;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		RaqsoftServiceImpl rs = new RaqsoftServiceImpl();
		System.out
				.println(rs.getNewFilePath("D:/workspace/solidbi/WebRoot/raqsoft/reportFiles/dashboard/dashboard.rpx"));
	}

	@Override
	public boolean deleteFile(String filePath) {
		// TODO Auto-generated method stub
		String reportFileHome = getResourceHome();
		String path = reportFileHome + File.separatorChar + filePath;
		File file = new File(path);

		if (file.exists()) {
			// 路径为文件且不为空则进行删除
			return deleteFile(file);
		} else {
			return false;
		}

	}

	@Override
	public boolean creatFolder(String path, String folderName) {
		// TODO Auto-generated method stub
		String reportFileHome = getResourceHome();
		String folderPath = reportFileHome + File.separatorChar + path + File.separatorChar + folderName;
		File file = new File(folderPath);
		// 路径为目录且不为空则不能创建
		if (file.isDirectory() && file.exists()) {
			return false;
		} else {
			return file.mkdir();

		}

	}

	@Override
	public boolean fileExists(String path, String name) {
		// TODO Auto-generated method stub
		String reportFileHome = getResourceHome();
		String filePath = reportFileHome + File.separatorChar + path + File.separatorChar + name;
		File file = new File(filePath);
		// 路径为目录且不为空则不能创建
		if (file.exists()) {
			return true;
		} else {
			return false;

		}
	}

	@Override
	public boolean renameTo(String oldPath, String oldName, String newPath, String newName) {
		// TODO Auto-generated method stub
		String reportFileHome = getResourceHome();
		String filePath = reportFileHome + File.separatorChar + oldPath + File.separatorChar + oldName;
		String newFilePath = reportFileHome + File.separatorChar + newPath + File.separatorChar + newName;
		File file = new File(filePath);
		File newFile = new File(newFilePath);
		return file.renameTo(newFile);

	}

	@Override
	public List<List<Map<String, Object>>> runDfx(String dfx, List<Object> param) throws Exception {
		// TODO Auto-generated method stub 
		Connection con = null;
		List<List<Map<String, Object>>> rsList = new ArrayList<List<Map<String,Object>>>();
		com.esproc.jdbc.InternalCStatement st;

			// 建立连接
			Class.forName("com.esproc.jdbc.InternalDriver");

			con = DriverManager.getConnection("jdbc:esproc:local://");

			// 调用存储过程，其中createTable1是dfx的文件名
			String call="call "+dfx+"(";
			for(Object o:param){
				call+="?,";
			}
			if(call.endsWith(",")){
				call=call.substring(0,call.length()-1);
			}
			call+=")";
			st = (com.esproc.jdbc.InternalCStatement) con.prepareCall(call);

			// 执行存储过程

			boolean hasResult = st.execute();

			// 获取多个结果集并输出结果

			while (hasResult) {
				List<Map<String,Object>> dataSet=new ArrayList<Map<String,Object>>();
				ResultSet rs = st.getResultSet();
				//输出结果
				ResultSetMetaData rsmd = rs.getMetaData();

				int colCount = rsmd.getColumnCount();

				  while (rs.next()) {
					  Map<String,Object> row=new HashMap<String,Object>();
					  for (int c = 1; c<= colCount; c++) {
						  String key = rsmd.getColumnName(c);
						  Object value = rs.getObject(key);
						  row.put(key, value);
					  }
					  dataSet.add(row);
				  }
				rsList.add(dataSet);
				//查看是否返回了其它结果集
				hasResult = st.getMoreResults();


			}

			// 关闭连接

			if (con != null) {

				con.close();

			}
		
		return rsList;

	}

	@Override
	public List<RaqSoftDataSource> getDataSourceList(HttpServletRequest request) {
		// TODO Auto-generated method stub
		List<RaqSoftDataSource> dsList=new ArrayList<RaqSoftDataSource>();
		Context cxt = Context.getInitCtx();
		if(configFile==null){
			ServletContext sc=request.getSession().getServletContext();
			configFile=(String) sc.getAttribute( "___reportConfigFile" );
			System.out.println(configFile);
			if(configFile==null){
				configFile="/WEB-INF/raqsoftConfig.xml";
			}
			configFile = sc.getRealPath(configFile);
			
		}
		
		try {
			if(document==null){
				SAXReader reader = new SAXReader();             
				document = reader.read(new File(configFile));
			}
		    Element root = document.getRootElement();
		    Element dbList=root.element("Runtime").element("DBList");
		    List<Element> dbs = dbList.elements("DB");
		    for (Element db : dbs) {  
		    	RaqSoftDataSource dsoc=getDataSourceDefine(db);
	            dsList.add(dsoc);
	        } 
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return dsList;
	}

	@Override
	public boolean addDataSource(ServletContext sc,RaqSoftDataSource ds) {
		// TODO Auto-generated method stub
		Element root = document.getRootElement();
		Element dbList=root.element("Runtime").element("DBList");
		List<Element> dbs = dbList.elements("DB");
		Element db=dbList.addElement("DB");
		db.addAttribute("name", ds.getName());
		Element url=db.addElement("property");
		url.addAttribute("name", "url");
		url.addAttribute("value", ds.getUrl());
		Element driver=db.addElement("property");
		driver.addAttribute("name", "driver");
		driver.addAttribute("value", ds.getDriver());
		Element user=db.addElement("property");
		user.addAttribute("name", "user");
		user.addAttribute("value", ds.getUser());
		Element password=db.addElement("property");
		password.addAttribute("name", "password");
		password.addAttribute("value", ds.getPassword());
		Element dbtype=db.addElement("property");
		dbtype.addAttribute("name", "type");
		dbtype.addAttribute("value", String.valueOf(ds.getType()));
		Element dbcharset=db.addElement("property");
		dbcharset.addAttribute("name", "dbCharset");
		dbcharset.addAttribute("value", ds.getDbCharset());
		Element clientCharset=db.addElement("property");
		clientCharset.addAttribute("name", "clientCharset");
		clientCharset.addAttribute("value", ds.getClientCharset());
		Element needTranContent=db.addElement("property");
		needTranContent.addAttribute("name", "needTranContent");
		needTranContent.addAttribute("value", ds.getNeedTransContent());
		Element needTranSentence=db.addElement("property");
		needTranSentence.addAttribute("name", "needTranSentence");
		needTranSentence.addAttribute("value", ds.getNeedTransSentence());
		Element caseSentence=db.addElement("property");
		caseSentence.addAttribute("name", "caseSentence");
		caseSentence.addAttribute("value", ds.getCaseSentence());
		Element addTilde=db.addElement("property");
		addTilde.addAttribute("name", "addTilde");
		addTilde.addAttribute("value", ds.getAddTilde());
		Element useSchema=db.addElement("property");
		useSchema.addAttribute("name", "useSchema");
		useSchema.addAttribute("value",ds.getUseSchema());
		try {
			this.saveDoc(sc);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	}

	@Override
	public boolean deleteDataSource(ServletContext sc,String dsName) {
		// TODO Auto-generated method stub
		Element root = document.getRootElement();
		Element dbList=root.element("Runtime").element("DBList");
		List<Element> dbs = dbList.elements("DB");
		for (Element db : dbs) {
			if(db.attributeValue("name").equals(dsName)){
				dbs.remove(db);
				break;
			}
		    
		}
		
		try {
			this.saveDoc(sc);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	private void saveDoc(ServletContext sc) throws Exception{
		FileOutputStream fos;
			fos = new FileOutputStream(configFile);
			OutputStreamWriter osw = new OutputStreamWriter(fos,"UTF-8");  
		     OutputFormat of =  OutputFormat.createPrettyPrint();//缩减型格式
		     of.setEncoding("UTF-8");  
		     of.setIndent(true);  
		     of.setIndent("    ");  
		     of.setNewlines(true);  
		     XMLWriter writer = new XMLWriter(osw, of);  
		     writer.write(document);  
		     writer.close();  
		     ReportServlet.reloadRaqsoftConfig(sc, configFile);
	     
	}
	private void setDBPropertys(RaqSoftDataSource dsoc,Element db){
		List<Element> propertys = db.elements("property");
		db.attributeValue("name", dsoc.getName());
		for(Element property :propertys){
			String name=property.attributeValue("name");
			Attribute valueAttr =property.attribute("value");
			if(valueAttr==null){
				property.addAttribute("value", "");
				valueAttr=property.attribute("value");
			}
			if("url".equals(name)){
				property.attribute("value").setValue(dsoc.getUrl());
			}else
				if("driver".equals(name)){
					property.attribute("value").setValue(dsoc.getDriver());
	    		}else
	    			if("type".equals(name)){
	    				property.attribute("value").setValue(dsoc.getType());
		    		}else
		    			if("user".equals(name)){
		    				property.attribute("value").setValue(dsoc.getUser());
			    		}else
			    			if("password".equals(name)){
			    				property.attribute("value").setValue(dsoc.getPassword());
				    		}else
				    			if("useSchema".equals(name)){
				    				property.attribute("value").setValue(dsoc.getUseSchema());
					    			
					    		}else
					    			if("addTilde".equals(name)){
					    				property.attribute("value").setValue(dsoc.getUseSchema());
						    		}else
						    			if("dbCharset".equals(name)){
						    				property.attribute("value").setValue(dsoc.getDbCharset());
							    		}else
							    			if("clientCharset".equals(name)){
							    				property.attribute("value").setValue(dsoc.getClientCharset());
								    		}else
								    			if("needTransContent".equals(name)){
								    				property.attribute("value").setValue(dsoc.getNeedTransContent());
									    		}else
									    			if("needTransSentence".equals(name)){
									    				property.attribute("value").setValue(dsoc.getNeedTransSentence());
										    		}else
										    			if("caseSentence".equals(name)){
										    				property.attribute("value").setValue(dsoc.getCaseSentence());
											    		}
		}
	}
	private RaqSoftDataSource getDataSourceDefine(Element element){
		List<Element> propertys = element.elements("property");
		RaqSoftDataSource dsoc=new RaqSoftDataSource();
    	dsoc.setName(element.attributeValue("name"));
    	for(Element property :propertys){
    		String name=property.attributeValue("name");
    		String value=property.attributeValue("value");
    		
    		if("url".equals(name)){
    			dsoc.setUrl(value);
    		}else
    			if("driver".equals(name)){
	    			dsoc.setDriver(value);
	    		}else
	    			if("type".equals(name)){
		    			dsoc.setType(value);
		    		}else
		    			if("user".equals(name)){
			    			dsoc.setUser(value);
			    		}else
			    			if("password".equals(name)){
				    			dsoc.setPassword(value);
				    		}else
				    			if("useSchema".equals(name)){
				    				dsoc.setUseSchema(value);
					    			
					    		}else
					    			if("addTilde".equals(name)){
					    				dsoc.setAddTilde(value);
					    				
						    		}else
						    			if("dbCharset".equals(name)){
							    			dsoc.setDbCharset(value);
							    		}else
							    			if("clientCharset".equals(name)){
								    			dsoc.setClientCharset(value);
								    		}else
								    			if("needTransContent".equals(name)){
								    				dsoc.setNeedTransContent(value);
								    				
									    		}else
									    			if("needTransSentence".equals(name)){
									    				dsoc.setNeedTransSentence(value);
									    				
										    		}else
										    			if("caseSentence".equals(name)){
										    				dsoc.setCaseSentence(value);
										    				
											    		}
    	}
    	return dsoc;
	}
	@Override
	public boolean updateDataSource(ServletContext sc,RaqSoftDataSource ds) {
		// TODO Auto-generated method stub
		
		Element root = document.getRootElement();
		Element dbList=root.element("Runtime").element("DBList");
		List<Element> dbs = dbList.elements("DB");
		for (Element db : dbs) {
			if(db.attributeValue("name").equals(ds.getName())){
				this.setDBPropertys(ds, db);
			}
		    
		}
		try {
			this.saveDoc(sc);
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	}
	

}
