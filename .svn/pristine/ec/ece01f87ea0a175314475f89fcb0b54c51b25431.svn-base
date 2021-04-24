package com.solidextend.sys.db;

import org.hsqldb.Server;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/** 
 * @ClassName: HsqlListener
 * @Version:1.0
 * @Author: zHouHuiHui 该类的职责是在WebApp启动时自动开启HSQL服务. 依然使用Server方式，不受AppServer的影响.
 */
public class HsqlListener implements ServletContextListener {
	private String dbName;
	private int port = -1;
	/**
	 * * Listener 初始化方法.
	 */
	public void contextInitialized(ServletContextEvent sce) {
		dbName = sce.getServletContext().getInitParameter("hsql.dbName");
		String cfgDir = sce.getServletContext().getRealPath(
				sce.getServletContext().getInitParameter("hsql.dbPath"));
		System.out.println("cfgDir:" + cfgDir);
		
		try {
			port = Integer.parseInt(sce.getServletContext().getInitParameter(
					"hsql.port"));
		} catch (Exception e) {
			port = 9001;
		}
		if (dbName == null || dbName.equals("")) {
			System.out
					.println("Cant' get hsqldb.dbName from web.xml Context Param");
			return;
		}
		File dbDir = new File(cfgDir);
		if (!dbDir.exists()) {// 判断目录是否存在
			if (!dbDir.mkdirs()) {// 如果不存在创建，如果创建失败直接返回
				System.out.println("Can not create DB Dir for Hsql:" + dbDir);
				return;
			}
		}
		// 以下代码是做数据库恢复的。我们把原始的数据库放在classpath下，当启动web的时候，检查目标
		// 数据库是否存在，如果不存在，就把原始数据库复制为指定的数据库
		if (!cfgDir.endsWith("/")) {
			cfgDir = cfgDir + "/";
		}
		File scriptFile = new File(cfgDir + dbName + ".script");
		File propertiesFile = new File(cfgDir + dbName + ".properties");
		if (scriptFile.exists() && propertiesFile.exists()) {// 判断数据文件是否存在
			this.startServer(cfgDir, dbName, port);
		} else {
			System.out
					.println("Connect failed:Connect Hsqldb error or database files not exits!");
		}
	}

	/**
	 * 启动Hsqldb服务的方法。
	 * 
	 * @param dbPath
	 *            数据库路径
	 * @param dbName
	 *            数据库名称
	 * @param port
	 *            所使用的端口号
	 */
	private void startServer(String dbPath, String dbName, int port) {
		Server server = new Server();// 它是hsqldb.jar里面的类
		server.setDatabaseName(0, dbName);
		server.setDatabasePath(0, dbPath + dbName);
		if (port != -1) {
			server.setPort(port);
		}
		server.setSilent(true);
		server.start();
		System.out.println("HSQL数据库启动了***");
		// 等待Server启动
		try {
			Thread.sleep(800);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	public void contextDestroyed(ServletContextEvent arg0) {
		// 这里就不用说了，自然是关闭数据库操作
		Connection conn = null;
		try {
			Class.forName("org.hsqldb.jdbcDriver");
			conn = DriverManager.getConnection(
					"jdbc:hsqldb:hsql://localhost:"+port+"/"+dbName, "sa", "");
			Statement stmt = conn.createStatement();
			stmt.executeUpdate("SHUTDOWN;");
		} catch (Exception e) {// do nothing
		}
	}
}
