package com.solidextend.sys.shortcut.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.solidextend.sys.shortcut.dao.ShortcutMenuMapper;
import com.solidextend.sys.shortcut.vo.ShortcutMenu;

/**
 * 快捷方式
 * @author songjunjie
 * @version 2014-2-13 上午9:15:02
 */
@Service
public class ShortcutMenuServiceImpl implements ShortcutMenuService {
	private ShortcutMenuMapper shortcutMenuMapper;
	
	@Override
	public void delete(@Param("moduleId") String moduleId,
			@Param("userId") String userId) {
		this.shortcutMenuMapper.delete(moduleId, userId);
	}

	@Override
	public void deleteByUserId(String userId) {
		this.shortcutMenuMapper.deleteByUserId(userId);
	}

	@Override
	public void insert(ShortcutMenu shortcutMenu) {
		this.shortcutMenuMapper.insert(shortcutMenu);
	}
}
