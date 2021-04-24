package com.solidextend.sys.shortcut.vo;

/**
 * @author songjunjie
 * @version 2014-2-13 上午9:06:33
 */
public class ShortcutMenu {
    private String moduleId;

    private String userId;

    public String getModuleId() {
        return moduleId;
    }

    public void setModuleId(String moduleId) {
        this.moduleId = moduleId == null ? null : moduleId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }
}