package com.solidextend.sys.role.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solidextend.core.web.JsonData;
import com.solidextend.core.web.PageParam;
import com.solidextend.sys.role.service.RoleService;
import com.solidextend.sys.role.vo.Role;
import com.solidextend.sys.user.service.UserService;
import com.solidextend.sys.user.vo.User;

@Controller
@RequestMapping("/role")
public class RoleController {
	
	private static final Log log = LogFactory.getLog(RoleController.class);

	@Resource
	private RoleService roleService;
	
	@Resource
	private UserService userService;
	
	@RequestMapping("/roleIndex")
	public String index(){
		return "role/roleIndex";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public JsonData save(Role role){
		JsonData jsonData = new JsonData();
		try {
			roleService.save(role);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("系统内部错误");
		}
		return jsonData;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public JsonData list( @RequestParam(required=false) String orgId, @RequestParam(required=false) String roleName){
		if(StringUtils.isEmpty(orgId)) orgId = "0";
		return roleService.selectPage(orgId,roleName);
	}
	
	/**
	 * 根据机构id查询出机构下面的角色。
	 * @param orgId
	 * @return
	 */
	@RequestMapping("/findRoleByOrginId")
	@ResponseBody
	public JsonData findRoleByOrginId(@RequestParam(required=false) String organId){
		if(StringUtils.isEmpty(organId)){
			organId = "0";
		}
		JsonData jsonData = new JsonData();
		try {
			List<Role> rows = this.roleService.getRolesByOrgId(organId);
			jsonData.setSuccess(true);
			jsonData.setRows(rows);
		} catch (Exception e) {
			jsonData.setSuccess(false);
			log.error("",e);
		}
		
		return jsonData;
	}
	
	/**
	 * 根据机构id查询出机构下面的角色。
	 * @param orgId
	 * @return
	 */
	@RequestMapping("/getRoleTree")
	@ResponseBody
	public List getRoleTree(@RequestParam(required=false) String organId){
		if(StringUtils.isEmpty(organId)){
			organId = "0";
		}
		return this.roleService.findRoleTreeByOrginId(organId);
	}
	/**
	 * 根据模块id查询出授权的角色。
	 * @param moduleId
	 * @return
	 */
	@RequestMapping("/getRoleListByModule")
	@ResponseBody
	public List getRoleListByModule(@RequestParam(required=true) String moduleId,String funForm){
		
		return this.roleService.getRoleListByModule(moduleId,funForm);
	}
	
	@RequestMapping("/listAll")
	@ResponseBody
	public JsonData listAll( @RequestParam(required=false) String orgId){
		if(StringUtils.isEmpty(orgId)) orgId = "0";
		return roleService.select( orgId,"");
	}
	
	
	@RequestMapping("/remove")
	@ResponseBody
	public JsonData remove(@RequestParam String id){
		JsonData jsonData = new JsonData ();
		String[] str = id.split(",");
		List<String> ids = new ArrayList<String>();
		List<String> names = new ArrayList<String>();
		for(int i = 0 ; i<str.length; i++){
			String[] infos = str[i].split("~");
			//判断该角色下是否有用户
			List<User> list = userService.getUsersByRoleId(infos[0]);
			if(list!=null&&list.size()>0){
				names.add(infos[1]);
			}else{
				ids.add(infos[0]);
			}
		}
		try {
			if(ids!=null&&ids.size()>0){
				this.roleService.remove((String[])ids.toArray(new String[ids.size()]));
			}
			if(names!=null&&names.size()>0){
				String msg = "";
				for(String stc : names){
					msg+=stc+",";
				}
				if(msg!=""&&msg.length()>0){
					msg = msg.substring(0, msg.length()-1);
				}
				jsonData.setMsg(msg+"&nbsp;角色已有关联人员，请解除关联人员后再删除");
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
	 * 根据角色id查询角色的基本信息
	 * @param orgId
	 * @return
	 */
	@RequestMapping("/getRoleById")
	@ResponseBody
	public JsonData getOrgById(String roleId){
		JsonData jsonData = new JsonData ();
		try {
			Role role = this.roleService.getRoleById(roleId);
			jsonData.setExtData(role);
			jsonData.setSuccess(true);
		} catch (Exception e) {
			log.error("",e);
			jsonData.setSuccess(false);
			jsonData.setMsg("出现系统内部错误");
		}
		return jsonData;
	}
	
	/**
	 * 通过机构id查询角色
	 * @param organId
	 * @return
	 */
	@RequestMapping("/getRolesByOrgId")
	@ResponseBody
	public List<Role> getRolesByOrgId(String organId){
		List<Role> list = this.roleService.getRolesByOrgId(organId);
		return list;
	}
	
	/**
	 * 判断角色名称是否已经存在
	 * @param organId
	 * @return
	 */
	@RequestMapping("/isExist")
	@ResponseBody
	public boolean isExist(String organId ,String roleName){
		List<Role> list = this.roleService.findRoleByNameAndOrganId(roleName,organId);
		if(list!=null && !list.isEmpty()){
			return true;
		}else{
			return false;
		}
		
	}
}
