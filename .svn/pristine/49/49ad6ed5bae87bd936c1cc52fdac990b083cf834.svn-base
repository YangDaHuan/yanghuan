package com.solidextend.core.util;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.context.ApplicationContext;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.lic.SolidBILicense;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class SysConfigUtil {
	private static SolidBILicense lic;
	private static final SysConfigUtil sysConfigUtil=new SysConfigUtil();
	private static String licModules;
	private static String licDate;
	private static String licCompany;
	private SysConfigUtil(){}
	
	public static SysConfigUtil getInstance(){
		if(lic==null){
			ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
			lic=appContext.getBean("license",SolidBILicense.class);
		}
		return sysConfigUtil;
	}
	/*module
	 * 1 portal
	 * 2 job
	 * 3 report
	 * 4 olap
	 */
	public boolean checkRegModule(String module){
		try{
			if(licCompany==null){
				String regCode=getFromBase64(lic.getLicense());
				String [] lics=regCode.split("@");
				if(lics.length!=3||lics[0]==null){
					return false;
				}else{
					licModules=lics[0];
					licDate=lics[1];
					licCompany=lics[2];
				}
					
				
			}
			Date today = new Date();
			DateFormat format = new SimpleDateFormat("yyyyMMdd"); 
			String todayStr = format.format(today); 
			if(Integer.parseInt(todayStr) <= Integer.parseInt(licDate)&&licCompany.equals(lic.getCompany())&&licModules.indexOf(module)>=0){
				return true;
			}else{
				return false;
			}
		}catch(Exception e){
			e.printStackTrace(); 
			return false;
		}
		
	}
    // 加密  
	private String getBase64(String str) {  
        byte[] b = null;  
        String s = null;  
        try {  
            b = str.getBytes("utf-8");  
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        }  
        if (b != null) {  
            s = new BASE64Encoder().encode(b);  
        }  
        return s;  
    }  
  
    // 解密  
	private String getFromBase64(String s) {  
        byte[] b = null;  
        String result = null;  
        if (s != null) {  
            BASE64Decoder decoder = new BASE64Decoder();  
            try {  
                b = decoder.decodeBuffer(s);  
                result = new String(b, "utf-8");  
            } catch (Exception e) {  
                e.printStackTrace();  
            }  
        }  
        return result;  
    }  
	
	
}
