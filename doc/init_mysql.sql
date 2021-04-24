/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/3/12 9:16:46                            */
/*==============================================================*/


drop table if exists SYS_ADMIN_ROLE_MODULE;

drop table if exists SYS_AUDIT_LOG;

drop table if exists SYS_AUDIT_LOG_EXT;

drop table if exists SYS_DICT;

drop table if exists SYS_DICT_ITEM;

drop table if exists SYS_LOGIN_LOG;

drop table if exists SYS_MASTER_DATA;

drop table if exists SYS_MASTER_DATA_FIELD;

drop table if exists SYS_MODULE;

drop table if exists SYS_MODULE_FUN;

drop table if exists SYS_MODULE_FUN_GROUP;

drop table if exists SYS_OPERATE_LOG;

drop table if exists SYS_OPERATE_TABLE;

drop table if exists SYS_OPERATE_TABLE_FIELD;

drop table if exists SYS_ORGAN;

drop table if exists SYS_PART_TIME;

drop table if exists SYS_PROMPT_MSG;

drop table if exists SYS_ROLE;

drop table if exists SYS_ROLE_MODULE;

drop table if exists SYS_SHORTCUT_MENU;

drop table if exists SYS_USER;

drop table if exists SYS_USER_ROLE;

drop table if exists SYS_USER_ROLE_PART_TIME;

drop table if exists SYS_JOB;
drop table if exists SYS_JOB_GROUP;
drop table if exists SYS_JOB_TYPE;
drop table if exists SYS_JOB_TYPE_PARAM;
drop table if exists SYS_JOB_PARAM;
drop table if exists SYS_JOB_LOG;
DROP TABLE if exists SYS_MODULE_LOG;

/*==============================================================*/
/* Table: SYS_ADMIN_ROLE_MODULE                                 */
/*==============================================================*/
create table SYS_ADMIN_ROLE_MODULE
(
   ROLE_ID              varchar(32) not null comment '管理员角色ID',
   MODULE_ID            varchar(32) not null comment '模块ID',
   primary key (ROLE_ID, MODULE_ID)
);

alter table SYS_ADMIN_ROLE_MODULE comment '保存管理员有权分配给本机构的人员的模块';

/*==============================================================*/
/* Table: SYS_AUDIT_LOG                                         */
/*==============================================================*/
create table SYS_AUDIT_LOG
(
   LOG_ID               varchar(32) not null,
   ACTOR_ID             varchar(32),
   LOG_CREATE_TIME      timestamp,
   LOG_IPADDRESS        varchar(20),
   ORGAN_ID             varchar(32),
   MODEL_ID             varchar(32),
   LOG_SERVICE_ID       varchar(1024),
   LOG_OP_FLAG          varchar(2),
   LOG_DESCRPTION       varchar(100),
   primary key (LOG_ID)
);

/*==============================================================*/
/* Table: SYS_AUDIT_LOG_EXT                                     */
/*==============================================================*/
create table SYS_AUDIT_LOG_EXT
(
   LOG_ID               varchar(32),
   LOG_NAME             varchar(64),
   LOG_VALUE            varchar(1024),
   LOG_OLDVALUE         varchar(1024)
);

/*==============================================================*/
/* Table: SYS_DICT                                              */
/*==============================================================*/
create table SYS_DICT
(
   ID                   varchar(32) not null comment '字典类型ID',
   DICT_CODE            varchar(32) not null comment '字典编码',
   DICT_NAME            varchar(20) not null comment '字典名称',
   REMARK               varchar(200) comment '备注信息',
   PARENT_ID            varchar(32) default '0' comment '上级字典',
   ORDER_NO             numeric(3,0) comment '排序号',
   DICT_TYPE            varchar(1) comment '字典类型 1具体字典 2字典类别',
   DELETED              varchar(1) default '0' comment '删除标志 1是 0否',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_DICT_ITEM                                         */
/*==============================================================*/
create table SYS_DICT_ITEM
(
   ID                   varchar(32) not null comment '字典ID',
   ITEM_CODE            varchar(50) not null comment '字典类型ID',
   ITEM_NAME            varchar(50) not null comment '字典名称',
   DICT_ID              varchar(32) comment '所属字典ID',
   ORDER_NO             numeric(3,0) comment '排序号',
   JIANPIN              varchar(50) comment '简拼',
   DELETED              varchar(1) default '0' comment '删除标志 1是 0否',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_LOGIN_LOG                                         */
/*==============================================================*/
create table SYS_LOGIN_LOG
(
   ID                   varchar(32) not null,
   USER_ID              varchar(32) comment '用户ID',
   USER_NAME            varchar(50) comment '用户名',
   IP                   varchar(50) comment 'IP地址',
   LOGIN_TIME           varchar(20) comment '登录时间 yyyy-MM-dd HH:mm:ss',
   ORGAN_ID             varchar(32) comment '机构ID',
   LOGOUT_TIME          varchar(20),
   JSESSIONID           varchar(32),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_MASTER_DATA                                       */
/*==============================================================*/
create table SYS_MASTER_DATA
(
   ID                   varchar(32) not null,
   MD_NAME              varchar(20) comment '名字',
   TABLE_NAME           varchar(50) comment '表名',
   REMARK               varchar(500) comment '备注',
   MD_TYPE              varchar(32) comment '类型',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_MASTER_DATA_FIELD                                 */
/*==============================================================*/
create table SYS_MASTER_DATA_FIELD
(
   ID_                  varchar(32) not null comment 'ID_',
   FIELD_NAME           varchar(30) comment '字段名字',
   DISPLAY_NAME         varchar(30) comment '字段显示名称',
   FIELD_TYPE           varchar(20) comment '字段类型',
   REMARK               varchar(200) comment '字段说明',
   FIELD_LENGTH         varchar(20) comment '字段长度 ，如果是数字型，那么可以使用小数，例如5.2表示长度是5，其中小数部分是2',
   DICT_CODE            varchar(20) comment '字典类型代码。如此字段引用的是字典，那么需要制定字典代码',
   NULLABLE             varchar(1) comment '是否允许为空',
   ORDER_NO             numeric(2,0) comment '排序号',
   MASTER_DATA_ID       varchar(32) comment '主数据ID',
   DISPLAYABLE          varchar(1) comment '是否显示',
   CHECK_RULE           varchar(2000) comment '校验规则',
   primary key (ID_)
);

alter table SYS_MASTER_DATA_FIELD comment '主数据字段信息';

/*==============================================================*/
/* Table: SYS_MODULE                                            */
/*==============================================================*/
create table SYS_MODULE
(
   ID                   varchar(32) not null comment '模块ID',
   MODULE_CODE          varchar(20) comment '编号',
   MODULE_NAME          varchar(100) not null comment '模块名称',
   URL                  varchar(255) comment 'URL地址',
   ICON                 varchar(255) comment '图标地址',
   ORDER_NO             numeric(3,0) comment '排序号',
   REMARK               varchar(200) comment '备注',
   MODULE_TYPE          varchar(1) comment '是否为系统 1模块 2功能',
   PARENT_ID            varchar(32) default '0' comment '上级模块ID',
   IS_PUBLIC            varchar(1) default '0' comment '是否为公共模块 1是 0 否',
   DISABLED             varchar(1) default '0' comment '是否停用 1是 0 否',
   IS_FOLDER            varchar(1) comment '是否文件夹 1是 0 否',
   FUN_GROUP_CODE       varchar(20) comment '功能组编号',
   primary key (ID)
);

alter table SYS_MODULE comment '功能模块表';

/*==============================================================*/
/* Table: SYS_MODULE_FUN                                        */
/*==============================================================*/
create table SYS_MODULE_FUN
(
   ID                   varchar(32) not null,
   FUN_CODE             varchar(20) not null comment '功能编号',
   FUN_NAME             varchar(100) not null comment '功能名称',
   FUN_GROUP_CODE       varchar(20) not null comment '模块类型编号',
   DICT_CODE            varchar(32) comment '字典编号',
   ORDER_NO             numeric(3,0) comment '排序号',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_MODULE_FUN_GROUP                                  */
/*==============================================================*/
create table SYS_MODULE_FUN_GROUP
(
   ID                   varchar(32) not null,
   FUN_GROUP_CODE       varchar(20) not null comment '模块类型编号',
   FUN_GROUP_NAME       varchar(100) comment '模块类型名称',
   DISABLED             varchar(1) default '0' comment '是否停用 1是 0 否',
   IS_PUBLIC            varchar(1) default '0' comment '是否为公共模块 1是 0 否',
   ORDER_NO             numeric(3,0) comment '排序号',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_OPERATE_LOG                                       */
/*==============================================================*/
create table SYS_OPERATE_LOG
(
   ID                   varchar(32) not null,
   OPERATE_NAME         varchar(20) comment '操作名称',
   USER_ID              varchar(32) comment '操作人ID',
   USERNAME             varchar(20) comment '操作人姓名',
   LOGIN_NAME           varchar(20) comment '操作人登录ID',
   OPERATE_DATETIME     varchar(20) comment '操作时间',
   IP                   varchar(20) comment 'IP地址',
   PARAMETER            varchar(1000) comment '参数信息',
   CODE_INFO            varchar(1000) comment '调用代码',
   DEVICE_TYPE          varchar(1) comment '1 pc  2 手机 3 pad',
   OPERATE_TYPE         varchar(1) comment '1 登录 2 退出 3 业务操作',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_OPERATE_TABLE                                     */
/*==============================================================*/
create table SYS_OPERATE_TABLE
(
   ID                   varchar(32) not null,
   TABLE_NAME           varchar(30) comment '表名',
   OPERATE_LOG_ID       varchar(32) comment '操作日志ID',
   OPERATE_TYPE         varchar(1) comment '操作类型 C增加 U修改  R查询  D删除',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_OPERATE_TABLE_FIELD                               */
/*==============================================================*/
create table SYS_OPERATE_TABLE_FIELD
(
   ID                   varchar(32) not null,
   FIELD_NAME           varchar(30) comment '字段名字',
   OLD_VALUE            varchar(2000) comment '旧值',
   NEW_VALUE            varchar(2000) comment '新值',
   OPERATE_TABLE_ID     varchar(32) comment '业务操作表ID',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_ORGAN                                             */
/*==============================================================*/
create table SYS_ORGAN
(
   ID                   varchar(32) not null,
   ORGAN_NAME           varchar(120) comment '机构名称',
   ORGAN_CODE           varchar(20) comment '机构编码',
   TEL                  varchar(20) comment '机构电话',
   ADDRESS              varchar(100) comment '机构地址',
   REMARK               varchar(2000) comment '描述',
   LEGAL_PERSON         varchar(100) comment '法人',
   WEBSITE              varchar(100) comment '网址',
   PARENT_ID            varchar(32) default '0' comment '上级机构ID',
   DELETED              varchar(1) default '0' comment '删除标志 1是 0否',
   TIER_CODE            varchar(300) comment '层级码 100100',
   ORGAN_TYPE           varchar(1) comment '类型 1机构 2部门',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_PART_TIME                                         */
/*==============================================================*/
create table SYS_PART_TIME
(
   USER_ID              varchar(32) not null,
   ORGAN_ID             varchar(32) not null,
   POST                 varchar(32),
   POSITION             varchar(32),
   ISLEADER             varchar(1) default '0',
   primary key (USER_ID, ORGAN_ID)
);

/*==============================================================*/
/* Table: SYS_PROMPT_MSG                                        */
/*==============================================================*/
create table SYS_PROMPT_MSG
(
   ID                   varchar(32) not null,
   CODE                 varchar(20) comment '编码',
   CONTENT              varchar(100) comment '内容',
   REF_CODE             varchar(100) comment '代码位置',
   IS_PUBLIC            varchar(1) comment '是否公共消息 1是 0否',
   primary key (ID)
);

alter table SYS_PROMPT_MSG comment 'prompt';

/*==============================================================*/
/* Table: SYS_ROLE                                              */
/*==============================================================*/
create table SYS_ROLE
(
   ID                   varchar(32) not null,
   ROLE_NAME            varchar(30) comment '名称',
   REMARK               varchar(500) comment '备注',
   ROLE_TYPE            varchar(1) comment '类型 1普通角色  2 管理员角色',
   ORGAN_ID             varchar(32) comment '所属机构',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_ROLE_MODULE                                       */
/*==============================================================*/
create table SYS_ROLE_MODULE
(
   ROLE_ID              varchar(32) not null comment '角色ID',
   MODULE_ID            varchar(32) not null comment '模块ID',
   FUN_CODE             varchar(20) comment '功能编号',
   FUN_VALUE            varchar(20) comment '功能值',
   primary key (ROLE_ID, MODULE_ID)
);

/*==============================================================*/
/* Table: SYS_SHORTCUT_MENU                                     */
/*==============================================================*/
create table SYS_SHORTCUT_MENU
(
   MODULE_ID            varchar(32) not null comment '模块ID',
   USER_ID              varchar(32) not null comment '用户ID',
   primary key (MODULE_ID, USER_ID)
);

/*==============================================================*/
/* Table: SYS_USER                                              */
/*==============================================================*/
create table SYS_USER
(
   ID                   varchar(32) not null,
   LOGIN_NAME           varchar(20) comment '登录名',
   PASSWORD             varchar(32) comment '密码',
   FULLNAME             varchar(20) comment '姓名',
   SEX                  varchar(2) comment '性别',
   BIRTHDAY             varchar(20) comment '生日',
   ORGAN_ID             varchar(32) comment '机构ID',
   POSITION             varchar(32) comment '职务',
   POST                 varchar(32) comment '岗位',
   TEL                  varchar(20) comment '电话',
   MOBILE               varchar(20) comment '手机',
   REMARK               varchar(500) comment '备注',
   EMAIL                varchar(255) comment 'email',
   ENABLE               varchar(1) default '1' comment '是否停用 0 停用 1启用',
   DELETED              varchar(1) default '0' comment '删除标志 1是 0否',
   ORDER_NO             numeric(3,0) comment '排序号',
   ENABLED_DATETIME     varchar(20) comment '启用时间',
   DISABLE_DATE_TIME    varchar(20) comment '停用时间',
   CREATE_TIME          varchar(20) default 'SYSDATE' comment '创建时间yyyy-MM-dd HH:mm:ss',
   IP                   varchar(20) comment '机器IP',
   ISLEADER             varchar(1) default '0' comment '是否领导 1 是 0否',
   EXPIRATION_DATE      varchar(20) comment '失效日期 yyyy-MM-dd',
   ISSECRET             varchar(1) default '0' comment '是否保密 1 是 0否',
   HOME_MODULE          VARCHAR(32) comment '用户自定义首页模块',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_USER_ROLE                                         */
/*==============================================================*/
create table SYS_USER_ROLE
(
   USER_ID              varchar(32) not null comment '用ID',
   ROLE_ID              varchar(32) not null comment '角色ID',
   primary key (USER_ID, ROLE_ID)
);

/*==============================================================*/
/* Table: SYS_USER_ROLE_PART_TIME                               */
/*==============================================================*/
create table SYS_USER_ROLE_PART_TIME
(
   USER_ID              varchar(32) not null comment '用ID',
   ROLE_ID              varchar(32) not null comment '角色ID',
   ORGAN_ID             varchar(32) comment '机构ID',
   primary key (USER_ID, ROLE_ID)
);


/*==============================================================*/
/* Table: SYS_JOB_TYPE                                          */
/*==============================================================*/
create table SYS_JOB_TYPE  (
   JOB_TYPE_ID          VARCHAR(32)                     not null,
   JOB_TYPE_NAME        VARCHAR(50),
   DISCRIPTION          VARCHAR(200),
   JOB_CLASS            VARCHAR(200),
   STATE                int,
   CREATE_TIME          datetime,
   LAST_UP_TIME         datetime,
   USER_ID              VARCHAR(32),
   SORT_NO              INT,
   constraint PK_SYS_JOB_TYPE primary key (JOB_TYPE_ID)
);

/*==============================================================*/
/* Table: SYS_JOB_TYPE_PARAM                                    */
/*==============================================================*/
create table SYS_JOB_TYPE_PARAM  (
   PARAM_ID             VARCHAR(32)                     not null,
   JOB_TYPE_ID          VARCHAR(32),
   PARAM_NAME           VARCHAR(50),
   DISCRIPTION          VARCHAR(200),
   DEFAULT_VALUE        VARCHAR(500),
   PARAM_TYPE           VARCHAR(50),
   DATA_OPTION          VARCHAR(500),
   STATE                int,
   CREATE_TIME          datetime,
   LAST_UP_TIME         datetime,
   USER_ID              VARCHAR(32),
   SORT_NO              INT,
   constraint PK_SYS_JOB_TYPE_PARAM primary key (PARAM_ID)
);


/*==============================================================*/
/* Table: SYS_JOB_GROUP                                         */
/*==============================================================*/
create table SYS_JOB_GROUP  (
   JOB_GROUP_ID         VARCHAR(32)                     not null,
   JOB_GROUP_NAME       VARCHAR(50),
   STATE                int,
   PARENT_ID            VARCHAR(32),
   CREATE_TIME          datetime,
   LAST_UP_TIME         datetime,
   USER_ID              VARCHAR(32),
   SORT_NO              INT,
   constraint PK_SYS_JOB_GROUP primary key (JOB_GROUP_ID)
);


/*==============================================================*/
/* Table: SYS_JOB                                               */
/*==============================================================*/
create table SYS_JOB  (
   JOB_ID               VARCHAR(32)                     not null,
   JOB_GROUP_ID         VARCHAR(32),
   JOB_TYPE_ID          VARCHAR(32),
   JOB_NAME             VARCHAR(200),
   DISCRIPTION          VARCHAR(200),
   CronExp            VARCHAR(32),
   NEXT_FIRE_TIME       datetime,
   TIMEOUT              INT,
   RETRY_COUNT          INT,
   LOG_DAYS             INT,
   STATE                int,
   CREATE_TIME          datetime,
   LAST_UP_TIME         datetime,
   USER_ID              VARCHAR(32),
   SORT_NO              INT,
   constraint PK_SYS_JOB primary key (JOB_ID)
);


/*==============================================================*/
/* Table: SYS_JOB_PARAM                                         */
/*==============================================================*/
create table SYS_JOB_PARAM  (
   JOB_ID               VARCHAR(32)                     not null,
   PARAM_ID             VARCHAR(32)                     not null,
   PARAM_NAME           VARCHAR(50),
   PARAM_VALUE          VARCHAR(500),
   SORT_NO              INT,
   constraint PK_SYS_JOB_PARAM primary key (JOB_ID, PARAM_ID)
);


/*==============================================================*/
/* Table: SYS_JOB_LOG                                           */
/*==============================================================*/
create table SYS_JOB_LOG  (
   LOG_ID               VARCHAR(32)                     not null,
   JOB_ID               VARCHAR(32),
   FIRE_TIME            datetime,
   FIRE_STATE           VARCHAR(10),
   LOG_INFO             VARCHAR(255),
   TIME_LENGTH          INT,
   RETRY_COUNT          INT,
   constraint PK_SYS_JOB_LOG primary key (LOG_ID)
);

/*==============================================================*/
/* Table: SYS_MODULE_LOG                                        */
/*==============================================================*/

create table SYS_MODULE_LOG  (
   ID                   VARCHAR(32)                    not null,
   USER_ID              VARCHAR(32),
   MODULE_ID            VARCHAR(50),
   IP                   VARCHAR(50),
   ACCESS_TIME         TIMESTAMP,
   ORGAN_ID             VARCHAR(32)
   
)