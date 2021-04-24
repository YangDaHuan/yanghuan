-- 模块数据
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('e09c343741154ab9a6c0895733d97c3f', 'sys_resource', '资源管理', null, 'icon-module', 4, null, '1', '1', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('eca3af1fcc9544bf98a6b7af0fa955f5', 'sys_role_authorize', '角色授权', 'authorize/roleAuthorize.zb', 'icon-auth', 0, null, '1', '7', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('5facf848f8a0494eb2000cbdb7db3617', 'designer', '设计师', null, 'icon-design', 6, null, '1', '0', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('8c0a7411f6794869ac0b365fdf8204e3', 'design', '页面设计', 'EsayUiDesigner.html', 'icon-designer', null, null, '1', '5facf848f8a0494eb2000cbdb7db3617', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('7d96ee84f8a244f18b57f1b1273ce65c', 'sys_module_fun', '模块功能管理', 'moduleFun/index.zb', 'icon-module', 1, null, '1', 'e09c343741154ab9a6c0895733d97c3f', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('0', 'root', '模块树', null, null, 0, null, '1', null, '0', '0', '1', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('bb88765e1c4b4e3390d72aac3577bb93', 'monitor', '运行监控', null, 'icon-monitor', 4, null, '1', '0', '0', '0', '1', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('8e667f6e0f4a41b1ab3f9efd28094dbd', 'monitor_url', 'URL监控', 'jsp/monitor/urlStatIndex.jsp', null, 23, null, '1', 'bb88765e1c4b4e3390d72aac3577bb93', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('1', 'sys', '系统管理', null, 'icon-sys', 5, null, '1', '0', '0', '0', '1', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('2', 'sys_module', '模块管理', 'module/index.zb', 'icon-module', 0, null, '1', 'e09c343741154ab9a6c0895733d97c3f', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('3', 'sys_dict', '字典管理', 'dict/dictIndex.zb', 'icon-dict', 0, null, '1', '1', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('4', 'sys_organ', '机构管理', 'organ/organIndex.zb', 'icon-dept', 1, null, '1', '1', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('5', 'sys_orle', '角色管理', 'role/roleIndex.zb', 'icon-role', 2, null, '1', '1', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('6', 'sys_user', '用户管理', 'user/userIndex.zb', 'icon-user', 3, null, '1', '1', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('7', 'sys_authorize', '权限管理', null, 'icon-auth', 5, null, '1', '1', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('9', 'sys_log', '日志管理', null, 'icon-log', 6, null, '1', '1', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('8a54a86065de4e468cac09fbc9319d84', 'monitor_sql', 'SQL监控', 'jsp/monitor/sqlStatIndex.jsp', null, 22, null, '1', 'bb88765e1c4b4e3390d72aac3577bb93', '0', '0', '0', null);
insert into SYS_MODULE (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
values ('e24143d3c00449d5928270ebe81959ea', 'sys_module_authorize', '模块授权', 'authorize/moduleAuthorize.zb', 'icon-auth', 1, null, '1', '7', '0', '0', '0', null);
INSERT INTO sys_module (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE) 
VALUES ('61969da5cc9a45089112863bd29ac870', 'sys_quartz', '调度器管理', '', '', 5, '', '1', '1', '0', '0', null, '');
INSERT INTO sys_module (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE) 
VALUES ('dba49768f9c9480a84ce1d471ab21f4a', 'sys_jobType', '任务类型管理', 'job/jobTypeIndex.zb', '', 0, '', '1', '61969da5cc9a45089112863bd29ac870', '0', '0', null, '');
INSERT INTO sys_module (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE) 
VALUES ('f0d84f02a7a34e3491182fb69f1356cf', 'sys_job', '任务管理', 'job/jobIndex.zb', '', 1, '', '1', '61969da5cc9a45089112863bd29ac870', '0', '0', null, '');
INSERT INTO sys_module (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE)
VALUES ('2168f92b01c3413eb4f709a386f1e3c6', 'sys_log_login', '登录日志', 'log/loginLogIndex.zb', 'icon-log', null, '', '1', '9', '0', '0', null, '');
INSERT INTO sys_module (ID, MODULE_CODE, MODULE_NAME, URL, ICON, ORDER_NO, REMARK, MODULE_TYPE, PARENT_ID, IS_PUBLIC, DISABLED, IS_FOLDER, FUN_GROUP_CODE) 
VALUES ('10d6a8eb0323438f9439f7a7185a70b9', 'sys_log_job', '任务日志', 'log/jobLogIndex.zb', 'icon-log', null, '', '1', '9', '0', '0', null, '');

-- 机构
insert into SYS_ORGAN (ID, ORGAN_NAME, ORGAN_CODE, TEL, ADDRESS, REMARK, LEGAL_PERSON, WEBSITE, PARENT_ID, DELETED, TIER_CODE, ORGAN_TYPE)
values ('1bc8e0a662f641eaa32bd39e51f42470', '系统管理机构', '0001', '88888888', '88888', '888', '888', 'http://www.baidu.com', '', '0', '1000', '1');
-- 角色
insert into SYS_ROLE (ID, ROLE_NAME, REMARK, ROLE_TYPE, ORGAN_ID)
values ('1', '超级管理员', '2', '2', '1bc8e0a662f641eaa32bd39e51f42470');
-- 字典
insert into SYS_DICT (ID, DICT_CODE, DICT_NAME, REMARK, PARENT_ID, ORDER_NO, DICT_TYPE, DELETED)
values ('61b61d2d0b51403790dfb8e1def5a6ce', 'icon', '图标', null, 'ea2956851a354d1d8647324dfefe521c', null, '1', '0');
insert into SYS_DICT (ID, DICT_CODE, DICT_NAME, REMARK, PARENT_ID, ORDER_NO, DICT_TYPE, DELETED)
values ('ea2956851a354d1d8647324dfefe521c', 'base', '基础字典', null, '0', null, '2', '0');
-- 字典项
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('bc19848eb9b246fea67a79a3932e81a2', 'icon-sys', '系统管理', '61b61d2d0b51403790dfb8e1def5a6ce', 7, 'xtgl', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('607736a3786c4d32bf8cdbbb0e714e32', 'icon-monitor', '运行监控', '61b61d2d0b51403790dfb8e1def5a6ce', 9, 'yxjk', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('5682e5ef06fc4768a498e0cbe582c243', 'icon-module', '模块管理', '61b61d2d0b51403790dfb8e1def5a6ce', 8, 'mkgl', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('a4acf0e25f44447da726b3f2157fe7e1', 'icon-dict', '字典管理', '61b61d2d0b51403790dfb8e1def5a6ce', 10, 'zdgl', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('cf18bc0b710c4abeb63270b1d1105186', 'icon-dept', '机构管理', '61b61d2d0b51403790dfb8e1def5a6ce', 11, 'jggl', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('de7ce62b84ce40f69766c7fe71e219ba', 'icon-auth', '权限管理', '61b61d2d0b51403790dfb8e1def5a6ce', 12, 'qxgl', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('a95bcab817624c798d5f229b49078ca4', 'icon-role', '角色管理', '61b61d2d0b51403790dfb8e1def5a6ce', 13, 'jsgl', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('5205af3ce26e490db97446f0da3bd1f3', 'icon-user', '用户管理', '61b61d2d0b51403790dfb8e1def5a6ce', 14, 'yhgl', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('7911abecc36e448c9195a8af5bb509e8', 'icon-log', '日志管理', '61b61d2d0b51403790dfb8e1def5a6ce', 15, 'rzgl', '0');
insert into SYS_DICT_ITEM (ID, ITEM_CODE, ITEM_NAME, DICT_ID, ORDER_NO, JIANPIN, DELETED)
values ('42c7a9efa31646a6ab79f493dd0c18a7', 'report', '报表', '61b61d2d0b51403790dfb8e1def5a6ce', 2, 'bb', '0');
-- 超级管理员用户
insert into SYS_USER (ID, LOGIN_NAME, PASSWORD, FULLNAME, SEX, BIRTHDAY, ORGAN_ID, POSITION, POST, TEL, MOBILE, REMARK, EMAIL, ENABLE, DELETED, ORDER_NO, ENABLED_DATETIME, DISABLE_DATE_TIME, CREATE_TIME, IP, ISLEADER, EXPIRATION_DATE, ISSECRET)
values ('1', 'admin', '670b14728ad9902aecba32e22fa4f6bd', '超级管理员', '1', '1989-02-01', '1bc8e0a662f641eaa32bd39e51f42470', null, null, '88888888', '11111111111', null, 'song@song.song', '1', '0', null, null, null, '10-2月 -14', '192.168.1.162', '1', '2020-04-02', '1');
-- 超级管理员的用户角色关系
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values ('1', '1');



-- 任务组根目录
INSERT INTO sys_job_group (JOB_GROUP_ID, JOB_GROUP_NAME, STATE, PARENT_ID, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('0', '根目录', 1, null,sysdate,sysdate, 'admin', 0);

--任务类型
INSERT INTO sys_job_type (JOB_TYPE_ID, JOB_TYPE_NAME, DISCRIPTION, JOB_CLASS, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('345b472aa7cf4b6a8663ff6710e01b92', '运行报表发邮件', '运行报表，多个报表以分号分割，报表文件和导出文件名以逗号分割；发送多人以分号分割邮件地址', 'com.solidextend.sys.quartz.job.SendEmail', 1, sysdate, sysdate, 'admin', 0);
INSERT INTO sys_job_type (JOB_TYPE_ID, JOB_TYPE_NAME, DISCRIPTION, JOB_CLASS, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('f94656e3c9a04119af3b4e23a3882379', '运行报表发短信', '运行报表，将报表中指定单元格内容作为短信内容发送给指定用户', 'com.solidextend.sys.quartz.job.SendMessage', 1,sysdate, sysdate, 'admin', 1);
INSERT INTO sys_job_type (JOB_TYPE_ID, JOB_TYPE_NAME, DISCRIPTION, JOB_CLASS, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('e8e7272531de4a1ebeebb71d1087f71e', '执行shell或cmd脚本', 'windows command = "cmd.exe /c  startup.bat" linux command = "sh startServer.sh server1"', 'com.solidextend.sys.quartz.job.RunTimeUtils', 1,sysdate, sysdate, 'admin', 2);
INSERT INTO SYS_JOB_TYPE (JOB_TYPE_ID, JOB_TYPE_NAME, DISCRIPTION, JOB_CLASS, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('cdc12b3be6f74fc7866f1520b8a968a8', '清理任务日志', '按照任务日志保留天数清理任务日志', 'com.solidextend.sys.quartz.job.ClearJobLog', 1,sysdate, sysdate, 'admin', 3);

--任务类型参数
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('0082ac99fac147eb976de28a2900fa38', 'f94656e3c9a04119af3b4e23a3882379', 'sn', '序列号', 'SDK-BBX-010-23598', 'textbox', '', 1, null, sysdate, 'admin', 0);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('2bdc979d14834063a02d9a1afaf7579e', 'f94656e3c9a04119af3b4e23a3882379', 'row', '行号', '', 'numberspinner', '', 1, null,sysdate, 'admin', 3);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('38df197c4c11422790d79135fdfb3c0e', 'f94656e3c9a04119af3b4e23a3882379', 'col', '列号', '', 'numberbox', '', 1, null, sysdate, 'admin', 4);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('4855f327123b4573a69c0aebd5dc17a5', 'f94656e3c9a04119af3b4e23a3882379', 'mobile', '手机号码', '', 'textbox', '', 1, null,sysdate, 'admin', 5);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('48d8aab382484c678655e1b3545856ee', '345b472aa7cf4b6a8663ff6710e01b92', 'fileType', '报表导出类型', '', 'combobox', 'valueField: ''value'',textField: ''label'',required:true,data:[{label: ''Word'',value: ''WORD''},{label: ''Pdf'',value: ''PDF''},{label: ''Excel'',value: ''EXCEL''}]', 1,sysdate,sysdate, 'admin', 1);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('660fb08610ae415ea39987486d319f63', '345b472aa7cf4b6a8663ff6710e01b92', 'subject', '邮件标题', '', 'textbox', '', 1, sysdate,sysdate, 'admin', 5);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('81084de3e7dd417fa9d4d248cf3e2ea3', 'f94656e3c9a04119af3b4e23a3882379', 'report', '报表', '', 'textbox', '', 1, null, sysdate, 'admin', 2);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('93beb9cb932f409c84a35b0b0f962099', '345b472aa7cf4b6a8663ff6710e01b92', 'savePath', '保存目录', '', 'textbox', '', 1, sysdate,sysdate, 'admin', 2);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('dab333a91fea43f5b5ea71a1f64354ee', 'f94656e3c9a04119af3b4e23a3882379', 'pwd', '密码', 'd2887@35', 'textbox', '', 1, null, sysdate, 'admin', 1);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('dcf8628323de4b409e9019dd2d3a4a8b', '345b472aa7cf4b6a8663ff6710e01b92', 'reports', '报表名称', '', 'textbox', '', 1,sysdate,sysdate, 'admin', 0);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('e80d3d069af84dc883cb87b4b1cf34d5', '345b472aa7cf4b6a8663ff6710e01b92', 'body', '邮件内容', '', 'textbox', 'multiline:true,height:100', 1, sysdate,sysdate, 'admin', 6);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('efcacf04b37c4f308da5f5f8072b596a', '345b472aa7cf4b6a8663ff6710e01b92', 'to', '收件人', '', 'textbox', '', 1,sysdate,sysdate, 'admin', 4);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('f304879b1a474e00a451861730bb6a52', '345b472aa7cf4b6a8663ff6710e01b92', 'sendEmail', '发送邮件', '', 'combobox', 'valueField: ''value'',textField: ''label'',required:true,data:[{label: ''是'',value: ''true''},{label: ''否'',value: ''false''}]', 1,sysdate, sysdate, 'admin', 3);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('d71a1277c0004cfdaade4e35dc146ece', 'e8e7272531de4a1ebeebb71d1087f71e', 'command', '命令', '', 'textbox', '', 1, sysdate, sysdate, null, 0);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('37edfb9d29664a42939577c36a477314', 'e8e7272531de4a1ebeebb71d1087f71e', 'dir', '执行路径', '', 'textbox', '', 1, sysdate,sysdate, null, 1);
INSERT INTO sys_job_type_param (PARAM_ID, JOB_TYPE_ID, PARAM_NAME, DISCRIPTION, DEFAULT_VALUE, PARAM_TYPE, DATA_OPTION, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO) VALUES ('76139565905f4e0fbf3a3393a6c3d71c', 'e8e7272531de4a1ebeebb71d1087f71e', 'envp', '参数', '', 'textbox', '', 1,sysdate,sysdate, null, 2);

--任务
INSERT INTO SYS_JOB (JOB_ID, JOB_GROUP_ID, JOB_TYPE_ID, JOB_NAME, DISCRIPTION, CRONEXP, NEXT_FIRE_TIME, TIMEOUT, RETRY_COUNT, STATE, CREATE_TIME, LAST_UP_TIME, USER_ID, SORT_NO, LOG_DAYS) VALUES ('746446a0bd154dc886388d1c88b1eadb', '0', 'cdc12b3be6f74fc7866f1520b8a968a8', '按照任务日志保留天数清理日志', '', '0 0 0 1/1 * ? *', sysdate, 20, 1, 0, sysdate, sysdate, 'admin', 0, 1);

