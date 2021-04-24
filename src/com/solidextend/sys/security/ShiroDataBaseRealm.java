package com.solidextend.sys.security;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.authc.AccountException;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.BeanUtils;

import com.solidextend.sys.user.service.UserService;
import com.solidextend.sys.user.vo.User;

import java.util.Hashtable;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
/**
 * Realms在Shiro和应用程序的安全数据之间担当“桥梁”或“连接器”。 它实际上与安全相关的数据(如用来执行身份验证（登录）及
 * 授权（访问控制）的用户帐户)交互时，Shiro从程序配置的Realm 中寻找身份验证或者授权的数据。
 * 
 * @author 宋俊杰
 */
public class ShiroDataBaseRealm extends AuthorizingRealm {
	private static final Log log = LogFactory.getLog(ShiroDataBaseRealm.class);
	@Resource
	private UserService userService;
	
	private String SECURITY_TYPE;
	private String ADServerIP;
	private String ADServerPort;
	private String ADServerDomain;
	private String AD_SECURITY_AUTHENTICATION;
	private boolean UserNametoUpperCase;
	
	
	
	public boolean isUserNametoUpperCase() {
		return UserNametoUpperCase;
	}

	public void setUserNametoUpperCase(boolean userNametoUpperCase) {
		UserNametoUpperCase = userNametoUpperCase;
	}

	public String getSECURITY_TYPE() {
		return SECURITY_TYPE;
	}

	public void setSECURITY_TYPE(String SECURITY_TYPE) {
		this.SECURITY_TYPE = SECURITY_TYPE;
	}

	
	public String getADServerIP() {
		return ADServerIP;
	}

	public void setADServerIP(String aDServerIP) {
		ADServerIP = aDServerIP;
	}

	public String getADServerPort() {
		return ADServerPort;
	}

	public void setADServerPort(String aDServerPort) {
		ADServerPort = aDServerPort;
	}

	public String getADServerDomain() {
		return ADServerDomain;
	}

	public void setADServerDomain(String aDServerDomain) {
		ADServerDomain = aDServerDomain;
	}

	
	public String getAD_SECURITY_AUTHENTICATION() {
		return AD_SECURITY_AUTHENTICATION;
	}

	public void setAD_SECURITY_AUTHENTICATION(String aD_SECURITY_AUTHENTICATION) {
		AD_SECURITY_AUTHENTICATION = aD_SECURITY_AUTHENTICATION;
	}

	/**
	 * 当用户进行访问链接时的授权方法
	 * 
	 */
	protected AuthorizationInfo doGetAuthorizationInfo(
			PrincipalCollection principals) {

		if (principals == null) {
			throw new AuthorizationException("Principal对象不能为空");
		}

		UserDetails user = (UserDetails) principals.fromRealm(getName())
				.iterator().next();
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		return info;
	}

	/**
	 * 用户登录的认证方法。根据用登录凭证，返回登录人认证信息。
	 * 
	 */
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException  {
		UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;

		String loginname = usernamePasswordToken.getUsername();
		
        
        //加密后的字符串
       
		if (loginname == null) {
			throw new AccountException("用户名不能为空");
		}
		User user= this.userService.getUserByLoginname(loginname);
		if(user==null){
			throw new AccountException("用户名或密码不正确");
		}
		UserDetails userDetails = new UserDetails();
		BeanUtils.copyProperties(user, userDetails);
		String md5Password=null;
		if("AD".equals(this.SECURITY_TYPE)){
			//AD域验证
			
			String username = loginname+this.ADServerDomain;
			String password = new String(usernamePasswordToken.getPassword());
			DirContext ctx=null;
	        Hashtable<String,String> HashEnv = new Hashtable<String,String>();
	        HashEnv.put(Context.SECURITY_AUTHENTICATION, this.AD_SECURITY_AUTHENTICATION); // LDAP访问安全级别(none,simple,strong)
	        HashEnv.put(Context.SECURITY_PRINCIPAL, username); //AD的用户名
	        HashEnv.put(Context.SECURITY_CREDENTIALS, password); //AD的密码
	        HashEnv.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory"); // LDAP工厂类
	        HashEnv.put("com.sun.jndi.ldap.connect.timeout", "3000");//连接超时设置为3秒
	        HashEnv.put(Context.PROVIDER_URL, "ldap://" + this.ADServerIP + ":" + this.ADServerPort);// 默认端口389
            try {
            	// 初始化上下文
				ctx = new InitialDirContext(HashEnv);
				md5Password=DigestUtils.md5Hex(password);
			} catch (NamingException e1) {
				// TODO Auto-generated catch block
				throw new AccountException("AD域登录失败!");
			}finally{
	            if(null!=ctx){
	                try {
	                    ctx.close();
	                    ctx=null;
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }
	        }
		}else{
			md5Password=user.getPassword();
			
			
            
		}
		return new SimpleAuthenticationInfo(userDetails, md5Password, getName());
	}
	
	/**
     * 使用java连接AD域
     * @author Herman.Xiong
     * @date 2014-12-23 下午02:24:04
     * @return void  
     * @throws 异常说明
     * @param host 连接AD域服务器的ip
     * @param post AD域服务器的端口
     * @param username 用户名
     * @param password 密码
     */
    public static void connect(String host,String post,String username,String password) {
        DirContext ctx=null;
        Hashtable<String,String> HashEnv = new Hashtable<String,String>();
        HashEnv.put(Context.SECURITY_AUTHENTICATION, "simple"); // LDAP访问安全级别(none,simple,strong)
        HashEnv.put(Context.SECURITY_PRINCIPAL, username); //AD的用户名
        HashEnv.put(Context.SECURITY_CREDENTIALS, password); //AD的密码
        HashEnv.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory"); // LDAP工厂类
        HashEnv.put("com.sun.jndi.ldap.connect.timeout", "3000");//连接超时设置为3秒
        HashEnv.put(Context.PROVIDER_URL, "ldap://" + host + ":" + post);// 默认端口389
        try {
            ctx = new InitialDirContext(HashEnv);// 初始化上下文
            System.out.println("身份验证成功!");
        } catch (javax.naming.AuthenticationException e) {
            System.out.println("身份验证失败!");
            e.printStackTrace();
        } catch (javax.naming.CommunicationException e) {
            System.out.println("AD域连接失败!");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("身份验证未知异常!");
            e.printStackTrace();
        } finally{
            if(null!=ctx){
                try {
                    ctx.close();
                    ctx=null;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
     
   
}
