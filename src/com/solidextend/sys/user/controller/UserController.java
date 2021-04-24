package com.solidextend.sys.user.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.ApplicationContextHolder;
import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.security.ShiroDataBaseRealm;
import com.solidextend.sys.security.UserDetails;
import com.solidextend.sys.user.service.UserService;
import com.solidextend.sys.user.vo.PartTimeInfo;
import com.solidextend.sys.user.vo.User;

/**
 * 用户管理
 * @author songjunjie
 * @version 2014-1-6 下午1:45:45
 */
@RequestMapping("/user")
@Controller
public class UserController {
	private static final Log log = LogFactory.getLog(UserController.class);

	@Resource
	private UserService userService; 
	/**
	 * 用管理的首页面
	 * @return
	 */
	@RequestMapping("/userIndex")
	public String index(HttpServletRequest request){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		String organId = userDetails.getOrganId();
		request.setAttribute("organId", organId);
		return "user/userIndex";
	}
	
	/**
	 * 返回当前登陆用户信息
	 * @return
	 */
	@RequestMapping("/getCurrentUser")
	@ResponseBody
	public User getCurrentUser(){
		UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
		User user = this.userService.getUserById(userDetails.getId());
		return user;
	}
	
	/**
	 * 保存用户信息
	 * @param user 
	 * @param otherOrganIds 兼职机构ID列表
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public JsonData save(User user , String roleType,String jzjgs){
		JsonData jsonData = new JsonData();
		try {
			List<PartTimeInfo> partTimeList = new ArrayList<PartTimeInfo>();
			if(jzjgs!=null&&jzjgs.length()>0){
				String[] jzjg = jzjgs.split("`");
				for(String str : jzjg){
					String[] jgInfo = str.split("~",4);
					PartTimeInfo partTimeInfo = new PartTimeInfo();
					partTimeInfo.setUserId(user.getId());
					partTimeInfo.setOrganId(jgInfo[0]);
					partTimeInfo.setJzRoles(jgInfo[1]);
					partTimeInfo.setPosition(jgInfo[2]);
					if("true".equals(jgInfo[3])){
						partTimeInfo.setIsleader("1");
					}else{
						partTimeInfo.setIsleader("0");
					}
					partTimeList.add(partTimeInfo);
				}
			}
			user.setPassword(DigestUtils.md5Hex("000000"));
			this.userService.save(user , partTimeList,roleType);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("保存用户信息时出现内部错误！");
		}
		return jsonData;
	}
	
	/**
	 * 删除用户信息
	 * @param userId 用户ID
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public JsonData delete(String userId){
		JsonData jsonData = new JsonData();
		try {
			this.userService.deleteUserById(userId);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 更新用信息
	 * @param user
	 * @param partTime 兼职机构ID
	 * @return
	 */
	@RequestMapping("/update")
	@ResponseBody
	public JsonData update(User user,String roleType,String jzjgs){
		JsonData jsonData = new JsonData();
		try {
			List<PartTimeInfo> partTimeList = new ArrayList<PartTimeInfo>();
			if(jzjgs!=null&&jzjgs.length()>0){
				String[] jzjg = jzjgs.split("`");
				for(String str : jzjg){
					String[] jgInfo = str.split("~",4);
					PartTimeInfo partTimeInfo = new PartTimeInfo();
					partTimeInfo.setUserId(user.getId());
					partTimeInfo.setOrganId(jgInfo[0]);
					partTimeInfo.setJzRoles(jgInfo[1]);
					partTimeInfo.setPosition(jgInfo[2]);
					if("true".equals(jgInfo[3])){
						partTimeInfo.setIsleader("1");
					}else{
						partTimeInfo.setIsleader("0");
					}
					partTimeList.add(partTimeInfo);
				}
			}
			this.userService.updateUserById(user,partTimeList,roleType);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 更新当前用户信息
	 * @param user
	 * @return
	 */
	@RequestMapping("/updateCurrentUser")
	@ResponseBody
	public JsonData updateCurrentUser(User user){
		JsonData jsonData = new JsonData();
		try {
			this.userService.updateCurrentUser(user);
			UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
			userDetails.setFullname(user.getFullname());
			userDetails.setSex(user.getSex());
			userDetails.setTel(user.getTel());
			userDetails.setMobile(user.getMobile());
			userDetails.setEmail(user.getEmail());
			userDetails.setBirthday(user.getBirthday());
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
	
	
	/**
	 * 根据用户ID，得到用户信息
	 * @param id
	 * @return
	 */
	@RequestMapping("/getUserById")
	@ResponseBody
	public JsonData getUserById(String userId){
		JsonData jsonData = new JsonData ();
		try {
			User user = this.userService.getUserById(userId);
			String roles = this.userService.getUserRolesById(userId);
			List<PartTimeInfo> partTimeList = this.userService.getPartTimeInfosById(userId);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("user", user);
			map.put("roleType", roles);
			map.put("list", partTimeList);
			jsonData.setExtData(map);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 查询用户信息
	 * @param pageParam
	 * @param user
	 * @return
	 */
	@RequestMapping("/findUser")
	@ResponseBody
	public JsonData findUser(PageParam pageParam ,User user){
		JsonData jsonData = new JsonData ();
		try {
			jsonData= this.userService.findUser(pageParam , user);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	@RequestMapping("/findUserByOranAndName")
	@ResponseBody
	public JsonData findUserByOranAndName(PageParam pageParam , String organId ,String name,String mobile){
		JsonData jsonData = new JsonData ();
		try {
			if(organId==null||"".equals(organId)){
				UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
				organId = userDetails.getOrganId();
				jsonData= this.userService.findUserByOranAndNameFirst(pageParam,organId,name,mobile);
			}else{
				jsonData= this.userService.findUserByOranAndName(pageParam,organId,name,mobile);
			}
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 保存密码
	 * @param userId
	 * @param originPwd
	 * @param password
	 * @return
	 */
	@RequestMapping("/savePwd")
	@ResponseBody
	public JsonData savePassWord(String originPwd,String password){
		JsonData jsonData = new JsonData ();
		try {
			UserDetails userDetails = (UserDetails) SecurityUtils.getSubject().getPrincipal();
			if(DigestUtils.md5Hex(originPwd).equals(userDetails.getPassword())){
				this.userService.savePassWord(userDetails.getId(),DigestUtils.md5Hex(password));
				userDetails.setPassword(DigestUtils.md5Hex(password));
				jsonData.setSuccess(true);
			}else{
				jsonData.setSuccess(false);
				jsonData.setMsg("原始密码错误!");
			}
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误!");
		}
		return jsonData;
	}
	
	/**
	 *  校验登录名是否存在。如果是修改要指定老的用户名。新老用户名一直返回true
	 * @param loginName 登录名
	 * @param oldLoginName 老的登录名，如果是修改需要此参数。
	 * @return
	 */
	@RequestMapping("/isLoginNameExist")
	@ResponseBody
	public boolean isLoginNameExist(String loginName,String oldLoginName){
		ApplicationContext appContext = ApplicationContextHolder.getApplicationContext();
		ShiroDataBaseRealm shiroDataBaseRealm = appContext.getBean("shiroDataBaseRealm",ShiroDataBaseRealm.class);
		if(shiroDataBaseRealm.isUserNametoUpperCase()){
			loginName=loginName.toUpperCase();
		}
		User user = this.userService.getUserByLoginname(loginName);
		return user!=null;
	}
	
	/**
	 * 密码初始化
	 * @param userId 用户ID
	 * @return
	 */
	@RequestMapping("/initpsw")
	@ResponseBody
	public JsonData initpsw(String userId){
		JsonData jsonData = new JsonData();
		try {
			this.userService.initpswById(userId);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
}
