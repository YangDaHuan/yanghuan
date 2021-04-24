package com.solidextend.sys.shortcut.service;

import org.apache.ibatis.annotations.Param;

import com.solidextend.sys.shortcut.vo.ShortcutMenu;

/**
 * 快捷方式服务
 * @author songjunjie
 * @version 2014-2-13 上午9:09:57
 */
public interface ShortcutMenuService {
	/**
	 * 删除快捷方式
	 * @param moduleId 用户id
	 * @param userId 模块id
	 * @return
	 */
	public void delete(@Param("moduleId") String moduleId,
			@Param("userId") String userId);

	/**
	 * 删除快捷方式
	 * @param userId 用户id
	 * @return
	 */
	public void deleteByUserId(String userId);

	/**
	 * 保存一条快捷方式
	 * @param shortcutMenu
	 * @return
	 */
	public void insert(ShortcutMenu shortcutMenu);
}
