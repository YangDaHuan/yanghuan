package com.solidextend.sys.security;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.mgt.SecurityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.lic.SolidBILicense;
import com.solidextend.core.util.DateUtil;
import com.solidextend.core.util.SysConfigUtil;
import com.solidextend.core.web.UserSessionStorage;
import com.solidextend.sys.log.service.LoginLogService;
import com.solidextend.sys.log.vo.LoginLog;
import com.solidextend.sys.module.service.ModuleService;
import com.solidextend.sys.module.vo.Module;
import com.solidextend.sys.quartz.service.JobService;
import com.solidextend.sys.role.service.RoleService;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.user.service.UserService;
import com.solidextend.sys.user.vo.PartTimeInfo;

/**
 * 安全控制。主要负责登录、退出操作，及在线用户统计等。
 * 
 * @author 宋俊杰
 */
@Controller
public class SecurityController  {
	 private static final Log log = LogFactory.getLog(SecurityController.class);
	//@Autowired
	//private DefaultSessionManager defaultSessionManager;
	@Autowired
	private SecurityManager securityManager;
	@Resource
	private ModuleService moduleService;
	@Resource
	private UserService userService;
	@Resource
	private RoleService roleService;
	@Resource
	private LoginLogService loginLogService;

	/**
	 * 显示登录页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String showLoginForm(Model model,HttpServletRequest reqs,HttpServletResponse response) {
		String theme=reqs.getParameter("theme");
		if(theme!=null){
			reqs.getSession().setAttribute("_theme", theme);
		}
//		if(theme!=null){
//			Cookie cookie = new Cookie("theme", theme);
//			cookie.setMaxAge(60 * 60 * 24 * 365 * 10);// 设置为30min
//            cookie.setPath("/");
//            response.addCookie(cookie);
//		}else{
//			Cookie[] cookies = reqs.getCookies();
//			if(cookies!=null){
//				for(Cookie cookie : cookies){
//	                if(cookie.getName().equals("theme")){
//	                    theme=cookie.getValue();
//	                    break;
//	                }
//	            }
//			}
//			
//			
//		}
		
		if("mobile".equals(theme)){
			return "loginMobile";
		}
		return "login";
	}


	/**
	 * 具体执行登录操作的方法。如果用户已经在另外地方登录，先前的用户将被系统退出。
	 * 
	 * @param model
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> login(HttpServletRequest request,
			@RequestParam("username") String username,
			@RequestParam("password") String password, Model model) {
		Map<String, Object> message = new HashMap<String, Object>();
		//避免重复登陆，先退出
		SecurityUtils.getSubject().logout();
//		SysConfigUtil lic=SysConfigUtil.getInstance();
//		if(!lic.checkRegModule("1")){
//			message.put("msg", "授权不合法");
//			message.put("success", false);
//			return message;
//		}
		if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
			message.put("msg", "请填写用户名和密码");
		}
		
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		ShiroDataBaseRealm shiroDataBaseRealm = appContext.getBean("shiroDataBaseRealm",ShiroDataBaseRealm.class);
		if(shiroDataBaseRealm.isUserNametoUpperCase()){
			username=username.toUpperCase();
		}
		String md5pwd = DigestUtils.md5Hex(password);
		UsernamePasswordToken token = new UsernamePasswordToken(username,password, false);
		try {
			SecurityUtils.getSubject().login(token);
		} catch (AuthenticationException e) {
			log.debug("",e);
			message.put("msg", "用户名或密码错误，请重新输入！");
			message.put("success", false);
			return message;
		}
		
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		if(!userDetails.getEnable().equals("1")){
			message.put("msg", "账号已停用!");
			message.put("success", false);
			return message;
		}
		String expriationDate = userDetails.getExpirationDatetime();
		//如果没有过期时间，认为永不过期
		if(StringUtils.isNotBlank(expriationDate)){
			Date sxrq = DateUtil.parseDate(expriationDate+" 23:59:59", "yyyy-MM-dd HH:mm:ss");
			Calendar cal=Calendar.getInstance();
			cal.setTime(sxrq);
			cal.add(Calendar.DATE, -1);  //减1天
			if(new Date().after(cal.getTime())
					  ||"0".equals(userDetails.getEnable())
							){
						message.put("msg", "账号已过期!");
						message.put("success", false);
						return message;
					}
		}
		
		
		HttpSession session = UserSessionStorage.get(username);
		
		if(session != null ){
			try {
				session.setAttribute("_kickout_", true);
				session.invalidate();
			} catch (Exception e) {
//				log.error("-------",e);
			}
			UserSessionStorage.remove(username);
		}
		request.getSession().setAttribute("_username_", username);
		
		UserSessionStorage.add(username, request.getSession());
		
		String ip = request.getRemoteAddr();
		List<Role> roles = this.roleService.getRolesByUser(userDetails.getId());
		userDetails.setRoles(roles);
		// 将登陆成功用户的ip地址设置到登陆用户信息中。
		userDetails.setIp(ip);
		
		try {
			LoginLog loginLog = new LoginLog();
			loginLog.setJsessionid(request.getSession().getId());
			loginLog.setIp(ip);
			loginLog.setLoginTime(DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
			loginLog.setOrganId(userDetails.getOrganId());
			loginLog.setUserId(userDetails.getId());
			loginLog.setUserName(userDetails.getFullname());
			this.loginLogService.insert(loginLog);
			userDetails.setLoginLogId(loginLog.getId());
			
		} catch (Exception e) {
			log.error("保存登录日志信息时出现错误",e);
		}
		message.put("success", true);
		return message;
	}
	@RequestMapping(value = "urlLogin", method = RequestMethod.GET)
	public String urlLogin(HttpServletRequest request,
			@RequestParam("username") String username,
			@RequestParam("password") String password, String target) {
		String targetUrl="redirect:login.zb";
		if(StringUtils.isBlank(target)){
			target="home.zb";
		}else{
				target = "redirect:"+target;
		}
		
		//避免重复登陆，先退出
		SecurityUtils.getSubject().logout();
		
		
		if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
			return targetUrl;
		}
		
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		ShiroDataBaseRealm shiroDataBaseRealm = appContext.getBean("shiroDataBaseRealm",ShiroDataBaseRealm.class);
		if(shiroDataBaseRealm.isUserNametoUpperCase()){
			username=username.toUpperCase();
		}
		String md5pwd = DigestUtils.md5Hex(password);
		UsernamePasswordToken token = new UsernamePasswordToken(username,password, false);
		try {
			SecurityUtils.getSubject().login(token);
		} catch (AuthenticationException e) {
			log.debug("",e);
			return targetUrl;
		}
		
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		if(!userDetails.getEnable().equals("1")){
			return targetUrl;
		}
		String expriationDate = userDetails.getExpirationDatetime();
		//如果没有过期时间，认为永不过期
		if(StringUtils.isNotBlank(expriationDate)){
			Date sxrq = DateUtil.parseDate(expriationDate+" 23:59:59", "yyyy-MM-dd HH:mm:ss");
			Calendar cal=Calendar.getInstance();
			cal.setTime(sxrq);
			cal.add(Calendar.DATE, -1);  //减1天
			if(new Date().after(cal.getTime())
					  ||"0".equals(userDetails.getEnable())
							){
				return targetUrl;
					}
		}
		
		
		HttpSession session = UserSessionStorage.get(username);
		
		if(session != null ){
			try {
				session.setAttribute("_kickout_", true);
				session.invalidate();
			} catch (Exception e) {
//				log.error("-------",e);
			}
			UserSessionStorage.remove(username);
		}
		request.getSession().setAttribute("_username_", username);
		
		UserSessionStorage.add(username, request.getSession());
		
		String ip = request.getRemoteAddr();
		List<Role> roles = this.roleService.getRolesByUser(userDetails.getId());
		userDetails.setRoles(roles);
		// 将登陆成功用户的ip地址设置到登陆用户信息中。
		userDetails.setIp(ip);
		
		try {
			LoginLog loginLog = new LoginLog();
			loginLog.setJsessionid(request.getSession().getId());
			loginLog.setIp(ip);
			loginLog.setLoginTime(DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
			loginLog.setOrganId(userDetails.getOrganId());
			loginLog.setUserId(userDetails.getId());
			loginLog.setUserName(userDetails.getFullname());
			this.loginLogService.insert(loginLog);
			userDetails.setLoginLogId(loginLog.getId());
			
		} catch (Exception e) {
			log.error("保存登录日志信息时出现错误",e);
		}
		
		
		targetUrl=target;
		return targetUrl;
	}

	/**
	 * 退出
	 * @return
	 */
	@RequestMapping("logout")
	@ResponseBody
	public Map<String, Object> logout(HttpServletRequest request) {
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		try {
			if(userDetails!=null){
				LoginLog loginLog = new LoginLog();
				loginLog.setId(userDetails.getLoginLogId());
				loginLog.setLogoutTime(DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss"));
				this.loginLogService.updateById(loginLog);
			}
		} catch (Exception e) {
			log.error("保存登录日志信息时出现错误",e);
		}
		if(userDetails!=null){
			UserSessionStorage.remove(userDetails.getLoginName());	
		}
		SecurityUtils.getSubject().logout();
		Map<String, Object> message = new HashMap<String, Object>();
		message.put("success", true);
		return message;
	}

	
	@RequestMapping("securityTest")
	public String securityTest() {
		return "securityTest";
	}

}
