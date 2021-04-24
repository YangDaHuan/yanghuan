package com.solidextend.core.mybatis.dynamic;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;

import org.apache.ibatis.builder.xml.XMLMapperBuilder;
import org.apache.ibatis.executor.ErrorContext;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;


public class MapperDynamicLoader implements InitializingBean,
		ApplicationContextAware {
	private final HashMap<String, String> mappers = new HashMap<String, String>();
	private volatile static ConfigurableApplicationContext context = null;
	private volatile Scanner scanner = null;
	private static String xmlPath="com/zebone/sys/**/dao/*.xml";
	private static String XML_RESOURCE_PATTERN=ResourcePatternResolver.CLASSPATH_ALL_URL_PREFIX +xmlPath;
    private boolean autoUpdate=false;
	private long firstDelay=10 * 1000;
	private long updatePeriod=5 * 1000;
	
	
	public String getXmlPath() {
		return xmlPath;
	}

	public void setXmlPath(String xmlPath) {
		this.xmlPath = xmlPath;
		
	}
	
	public boolean isAutoUpdate() {
		return autoUpdate;
	}

	public void setAutoUpdate(boolean autoUpdate) {
		this.autoUpdate = autoUpdate;
	}

	public long getFirstDelay() {
		return firstDelay;
	}

	public void setFirstDelay(long firstDelay) {
		this.firstDelay = firstDelay;
	}

	public long getUpdatePeriod() {
		return updatePeriod;
	}

	public void setUpdatePeriod(long updatePeriod) {
		this.updatePeriod = updatePeriod;
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		// TODO Auto-generated method stub
		this.context = (ConfigurableApplicationContext) applicationContext;

	}

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub
		this.XML_RESOURCE_PATTERN=ResourcePatternResolver.CLASSPATH_ALL_URL_PREFIX +xmlPath;
		if(this.autoUpdate){
		 try {
	            scanner = new Scanner();
	            new Timer(true).schedule(new TimerTask() {
	                public void run() {
	                    try {
	                        if (scanner.isChanged()) {
	                            System.out.println("load mapper.xml");
	                            scanner.reloadXML();
	                        }
	                    } catch (Exception e) {
	                        e.printStackTrace();
	                    }
	                }
	            }, this.firstDelay,this.updatePeriod);
	        } catch (Exception e1) {
	            e1.printStackTrace();
	        }
		 }
	}
	public static List selectList(String statement,Object parameter){
		List list=null;
		SqlSessionFactory factory = context.getBean(SqlSessionFactory.class);
        SqlSession sqlSession=factory.openSession();
        list=sqlSession.selectList(statement, parameter);
		return list;
	
		   
		
	}
	@SuppressWarnings("unchecked")
    class Scanner {
        private final ResourcePatternResolver resourcePatternResolver = new PathMatchingResourcePatternResolver();
        public Scanner() throws IOException {
            Resource[] resources = findResource();
            if (resources != null) {
                for (Resource resource : resources) {
                    String key = resource.getURI().toString();
                    String value = getMd(resource);
                    mappers.put(key, value);
                }
            }
        }
        
        public void reloadXML() throws Exception {
        	
            SqlSessionFactory factory = context.getBean(SqlSessionFactory.class);
            Configuration configuration = factory.getConfiguration();
            removeConfig(configuration);
            for (Resource resource : findResource()) {
                try {
                    XMLMapperBuilder xmlMapperBuilder = new XMLMapperBuilder(resource.getInputStream(), configuration, resource.toString(), configuration.getSqlFragments());
                    xmlMapperBuilder.parse();
                } finally {
                    ErrorContext.instance().reset();
                }
            }
        }
        private void removeConfig(Configuration configuration) throws Exception {
            Class<?> classConfig = configuration.getClass();
            clearMap(classConfig, configuration, "mappedStatements");
            clearMap(classConfig, configuration, "caches");
            clearMap(classConfig, configuration, "resultMaps");
            clearMap(classConfig, configuration, "parameterMaps");
            clearMap(classConfig, configuration, "keyGenerators");
            clearMap(classConfig, configuration, "sqlFragments");
            clearSet(classConfig, configuration, "loadedResources");
        }
        private void clearMap(Class<?> classConfig, Configuration configuration, String fieldName) throws Exception {
            Field field = classConfig.getDeclaredField(fieldName);
            field.setAccessible(true);
            ((Map) field.get(configuration)).clear();
        }
        private void clearSet(Class<?> classConfig, Configuration configuration, String fieldName) throws Exception {
            Field field = classConfig.getDeclaredField(fieldName);
            field.setAccessible(true);
            ((Set) field.get(configuration)).clear();
        }
        public boolean isChanged() throws IOException {
            boolean isChanged = false;
            for (Resource resource : findResource()) {
                String key = resource.getURI().toString();
                String value = getMd(resource);
                if (!value.equals(mappers.get(key))) {
                    isChanged = true;
                    mappers.put(key, value);
                }
            }
            return isChanged;
        }
        private Resource[] findResource() throws IOException {
        	return resourcePatternResolver.getResources(XML_RESOURCE_PATTERN);
        }
        private String getMd(Resource resource) throws IOException {
            return new StringBuilder().append(resource.contentLength()).append("-").append(resource.lastModified()).toString();
        }
    }
}
