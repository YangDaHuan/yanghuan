package com.solidextend.sys.shortcut.dao;

import org.apache.ibatis.annotations.Param;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.shortcut.vo.ShortcutMenu;

/**
 * 用户快捷方式表
 * 
 * @author songjunjie
 * @version 2014-2-13 上午9:05:55
 */
@Mapper
public interface ShortcutMenuMapper {

	/**
	 * 删除快捷方式
	 * @param moduleId 用户id
	 * @param userId 模块id
	 * @return
	 */
	public int delete(@Param("moduleId") String moduleId,
			@Param("userId") String userId);

	/**
	 * 删除快捷方式
	 * @param userId 用户id
	 * @return
	 */
	public int deleteByUserId(String userId);

	/**
	 * 保存一条快捷方式
	 * @param shortcutMenu
	 * @return
	 */
	public int insert(ShortcutMenu shortcutMenu);
}