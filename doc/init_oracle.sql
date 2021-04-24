/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     2015/3/6 11:16:24                            */
/*==============================================================*/


drop table SYS_ADMIN_ROLE_MODULE cascade constraints;

drop table SYS_AUDIT_LOG cascade constraints;

drop table SYS_AUDIT_LOG_EXT cascade constraints;

drop table SYS_DICT cascade constraints;

drop table SYS_DICT_ITEM cascade constraints;

drop table SYS_LOGIN_LOG cascade constraints;

drop table SYS_MASTER_DATA cascade constraints;

drop table SYS_MASTER_DATA_FIELD cascade constraints;

drop table SYS_MODULE cascade constraints;

drop table SYS_MODULE_FUN cascade constraints;

drop table SYS_MODULE_FUN_GROUP cascade constraints;

drop table SYS_OPERATE_LOG cascade constraints;

drop table SYS_OPERATE_TABLE cascade constraints;

drop table SYS_OPERATE_TABLE_FIELD cascade constraints;

drop table SYS_ORGAN cascade constraints;

drop table SYS_PART_TIME cascade constraints;

drop table SYS_PROMPT_MSG cascade constraints;

drop table SYS_ROLE cascade constraints;

drop table SYS_ROLE_MODULE cascade constraints;

drop table SYS_SHORTCUT_MENU cascade constraints;

drop table SYS_USER cascade constraints;

drop table SYS_USER_ROLE cascade constraints;

drop table SYS_USER_ROLE_PART_TIME cascade constraints;

drop table SYS_JOB_TYPE cascade constraints;

drop table SYS_JOB_TYPE_PARAM cascade constraints;

drop table SYS_JOB_GROUP cascade constraints;

drop table SYS_JOB cascade constraints;

drop table SYS_JOB_PARAM cascade constraints;

drop table SYS_JOB_LOG cascade constraints;

drop table SYS_MODULE_LOG cascade constraints;

/*==============================================================*/
/* Table: SYS_ADMIN_ROLE_MODULE                                 */
/*==============================================================*/
create table SYS_ADMIN_ROLE_MODULE  (
   ROLE_ID              VARCHAR2(32)                    not null,
   MODULE_ID            VARCHAR2(32)                    not null,
   constraint PK_SYS_ADMIN_ROLE_MODULE primary key (ROLE_ID, MODULE_ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on table SYS_ADMIN_ROLE_MODULE is
'保存管理员有权分配给本机构的人员的模块';

comment on column SYS_ADMIN_ROLE_MODULE.ROLE_ID is
'管理员角色ID';

comment on column SYS_ADMIN_ROLE_MODULE.MODULE_ID is
'模块ID';

/*==============================================================*/
/* Table: SYS_AUDIT_LOG                                         */
/*==============================================================*/
create table SYS_AUDIT_LOG  (
   LOG_ID               VARCHAR2(32)                    not null,
   ACTOR_ID             VARCHAR2(32),
   LOG_CREATE_TIME      TIMESTAMP,
   LOG_IPADDRESS        VARCHAR2(20),
   ORGAN_ID             VARCHAR2(32),
   MODEL_ID             VARCHAR2(32),
   LOG_SERVICE_ID       VARCHAR2(1024),
   LOG_OP_FLAG          VARCHAR2(2),
   LOG_DESCRPTION       VARCHAR2(100),
   constraint PK_SYS_AUDIT_LOG primary key (LOG_ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

/*==============================================================*/
/* Table: SYS_AUDIT_LOG_EXT                                     */
/*==============================================================*/
create table SYS_AUDIT_LOG_EXT  (
   LOG_ID               VARCHAR2(32),
   LOG_NAME             VARCHAR2(64),
   LOG_VALUE            VARCHAR2(1024),
   LOG_OLDVALUE         VARCHAR2(1024)
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

/*==============================================================*/
/* Table: SYS_DICT                                              */
/*==============================================================*/
create table SYS_DICT  (
   ID                   VARCHAR2(32)                    not null,
   DICT_CODE            VARCHAR2(32)                    not null,
   DICT_NAME            NVARCHAR2(20)                   not null,
   REMARK               NVARCHAR2(200),
   PARENT_ID            VARCHAR2(32)                   default '0',
   ORDER_NO             NUMBER(3),
   DICT_TYPE            VARCHAR2(1),
   DELETED              VARCHAR2(1)                    default '0',
   constraint PK_SYS_DICT primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_DICT.ID is
'字典类型ID';

comment on column SYS_DICT.DICT_CODE is
'字典编码';

comment on column SYS_DICT.DICT_NAME is
'字典名称';

comment on column SYS_DICT.REMARK is
'备注信息';

comment on column SYS_DICT.PARENT_ID is
'上级字典';

comment on column SYS_DICT.ORDER_NO is
'排序号';

comment on column SYS_DICT.DICT_TYPE is
'字典类型 1具体字典 2字典类别';

comment on column SYS_DICT.DELETED is
'删除标志 1是 0否';

/*==============================================================*/
/* Table: SYS_DICT_ITEM                                         */
/*==============================================================*/
create table SYS_DICT_ITEM  (
   ID                   VARCHAR2(32)                    not null,
   ITEM_CODE            VARCHAR2(50)                    not null,
   ITEM_NAME            NVARCHAR2(50)                   not null,
   DICT_ID              VARCHAR2(32),
   ORDER_NO             NUMBER(3),
   JIANPIN              VARCHAR2(50),
   DELETED              VARCHAR2(1)                    default '0',
   constraint PK_SYS_DICT_ITEM primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_DICT_ITEM.ID is
'字典ID';

comment on column SYS_DICT_ITEM.ITEM_CODE is
'字典类型ID';

comment on column SYS_DICT_ITEM.ITEM_NAME is
'字典名称';

comment on column SYS_DICT_ITEM.DICT_ID is
'所属字典ID';

comment on column SYS_DICT_ITEM.ORDER_NO is
'排序号';

comment on column SYS_DICT_ITEM.JIANPIN is
'简拼';

comment on column SYS_DICT_ITEM.DELETED is
'删除标志 1是 0否';

/*==============================================================*/
/* Table: SYS_LOGIN_LOG                                         */
/*==============================================================*/
create table SYS_LOGIN_LOG  (
   ID                   VARCHAR2(32)                    not null,
   USER_ID              VARCHAR2(32),
   USER_NAME            VARCHAR2(50),
   IP                   VARCHAR2(50),
   LOGIN_TIME           VARCHAR2(20),
   ORGAN_ID             VARCHAR2(32),
   LOGOUT_TIME          VARCHAR2(20),
   JSESSIONID           VARCHAR2(32),
   constraint PK_SYS_LOGIN_LOG primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_LOGIN_LOG.USER_ID is
'用户ID';

comment on column SYS_LOGIN_LOG.USER_NAME is
'用户名';

comment on column SYS_LOGIN_LOG.IP is
'IP地址';

comment on column SYS_LOGIN_LOG.LOGIN_TIME is
'登录时间 yyyy-MM-dd HH:mm:ss';

comment on column SYS_LOGIN_LOG.ORGAN_ID is
'机构ID';

/*==============================================================*/
/* Table: SYS_MASTER_DATA                                       */
/*==============================================================*/
create table SYS_MASTER_DATA  (
   ID                   VARCHAR2(32)                    not null,
   MD_NAME              NVARCHAR2(20),
   TABLE_NAME           VARCHAR2(50),
   REMARK               NVARCHAR2(500),
   MD_TYPE              VARCHAR2(32),
   constraint PK_SYS_MASTER_DATA primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_MASTER_DATA.MD_NAME is
'名字';

comment on column SYS_MASTER_DATA.TABLE_NAME is
'表名';

comment on column SYS_MASTER_DATA.REMARK is
'备注';

comment on column SYS_MASTER_DATA.MD_TYPE is
'类型';

/*==============================================================*/
/* Table: SYS_MASTER_DATA_FIELD                                 */
/*==============================================================*/
create table SYS_MASTER_DATA_FIELD  (
   ID_                  VARCHAR2(32)                    not null,
   FIELD_NAME           VARCHAR2(30),
   DISPLAY_NAME         VARCHAR2(30),
   FIELD_TYPE           VARCHAR2(20),
   REMARK               VARCHAR2(200),
   FIELD_LENGTH         VARCHAR2(20),
   DICT_CODE            VARCHAR2(20),
   NULLABLE             VARCHAR2(1),
   ORDER_NO             NUMBER(2),
   MASTER_DATA_ID       VARCHAR2(32),
   DISPLAYABLE          VARCHAR2(1),
   CHECK_RULE           VARCHAR2(2000),
   constraint PK_SYS_MASTER_DATA_FIELD primary key (ID_)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on table SYS_MASTER_DATA_FIELD is
'主数据字段信息';

comment on column SYS_MASTER_DATA_FIELD.ID_ is
'ID_';

comment on column SYS_MASTER_DATA_FIELD.FIELD_NAME is
'字段名字';

comment on column SYS_MASTER_DATA_FIELD.DISPLAY_NAME is
'字段显示名称';

comment on column SYS_MASTER_DATA_FIELD.FIELD_TYPE is
'字段类型';

comment on column SYS_MASTER_DATA_FIELD.REMARK is
'字段说明';

comment on column SYS_MASTER_DATA_FIELD.FIELD_LENGTH is
'字段长度 ，如果是数字型，那么可以使用小数，例如5.2表示长度是5，其中小数部分是2';

comment on column SYS_MASTER_DATA_FIELD.DICT_CODE is
'字典类型代码。如此字段引用的是字典，那么需要制定字典代码';

comment on column SYS_MASTER_DATA_FIELD.NULLABLE is
'是否允许为空';

comment on column SYS_MASTER_DATA_FIELD.ORDER_NO is
'排序号';

comment on column SYS_MASTER_DATA_FIELD.MASTER_DATA_ID is
'主数据ID';

comment on column SYS_MASTER_DATA_FIELD.DISPLAYABLE is
'是否显示';

comment on column SYS_MASTER_DATA_FIELD.CHECK_RULE is
'校验规则';

/*==============================================================*/
/* Table: SYS_MODULE                                            */
/*==============================================================*/
create table SYS_MODULE  (
   ID                   VARCHAR2(32)                    not null,
   MODULE_CODE          VARCHAR2(20),
   MODULE_NAME          VARCHAR2(100)                   not null,
   URL                  VARCHAR2(255),
   ICON                 VARCHAR2(255),
   ORDER_NO             NUMBER(3),
   REMARK               NVARCHAR2(200),
   MODULE_TYPE          VARCHAR2(1),
   PARENT_ID            VARCHAR2(32)                   default '0',
   IS_PUBLIC            VARCHAR2(1)                    default '0',
   DISABLED             VARCHAR2(1)                    default '0',
   IS_FOLDER            VARCHAR2(1),
   FUN_GROUP_CODE       VARCHAR2(20),
   constraint PK_SYS_MODULE primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on table SYS_MODULE is
'功能模块表';

comment on column SYS_MODULE.ID is
'模块ID';

comment on column SYS_MODULE.MODULE_CODE is
'编号';

comment on column SYS_MODULE.MODULE_NAME is
'模块名称';

comment on column SYS_MODULE.URL is
'URL地址';

comment on column SYS_MODULE.ICON is
'图标地址';

comment on column SYS_MODULE.ORDER_NO is
'排序号';

comment on column SYS_MODULE.REMARK is
'备注';

comment on column SYS_MODULE.MODULE_TYPE is
'是否为系统 1模块 2功能';

comment on column SYS_MODULE.PARENT_ID is
'上级模块ID';

comment on column SYS_MODULE.IS_PUBLIC is
'是否为公共模块 1是 0 否';

comment on column SYS_MODULE.DISABLED is
'是否停用 1是 0 否';

comment on column SYS_MODULE.IS_FOLDER is
'是否文件夹 1是 0 否';

comment on column SYS_MODULE.FUN_GROUP_CODE is
'功能组编号';

/*==============================================================*/
/* Table: SYS_MODULE_FUN                                        */
/*==============================================================*/
create table SYS_MODULE_FUN  (
   ID                   VARCHAR2(32)                    not null,
   FUN_CODE             VARCHAR(20)                     not null,
   FUN_NAME             VARCHAR(100)                    not null,
   FUN_GROUP_CODE       VARCHAR(20)                     not null,
   DICT_CODE            VARCHAR2(32),
   ORDER_NO             NUMBER(3),
   constraint PK_SYS_MODULE_FUN primary key (ID)
);

comment on column SYS_MODULE_FUN.FUN_CODE is
'功能编号';

comment on column SYS_MODULE_FUN.FUN_NAME is
'功能名称';

comment on column SYS_MODULE_FUN.FUN_GROUP_CODE is
'模块类型编号';

comment on column SYS_MODULE_FUN.DICT_CODE is
'字典编号';

comment on column SYS_MODULE_FUN.ORDER_NO is
'排序号';

/*==============================================================*/
/* Table: SYS_MODULE_FUN_GROUP                                  */
/*==============================================================*/
create table SYS_MODULE_FUN_GROUP  (
   ID                   VARCHAR2(32)                    not null,
   FUN_GROUP_CODE       VARCHAR(20)                     not null,
   FUN_GROUP_NAME       VARCHAR(100),
   DISABLED             VARCHAR2(1)                    default '0',
   IS_PUBLIC            VARCHAR2(1)                    default '0',
   ORDER_NO             NUMBER(3),
   constraint PK_SYS_MODULE_FUN_GROUP primary key (ID)
);

comment on column SYS_MODULE_FUN_GROUP.FUN_GROUP_CODE is
'模块类型编号';

comment on column SYS_MODULE_FUN_GROUP.FUN_GROUP_NAME is
'模块类型名称';

comment on column SYS_MODULE_FUN_GROUP.DISABLED is
'是否停用 1是 0 否';

comment on column SYS_MODULE_FUN_GROUP.IS_PUBLIC is
'是否为公共模块 1是 0 否';

comment on column SYS_MODULE_FUN_GROUP.ORDER_NO is
'排序号';

/*==============================================================*/
/* Table: SYS_OPERATE_LOG                                       */
/*==============================================================*/
create table SYS_OPERATE_LOG  (
   ID                   VARCHAR2(32)                    not null,
   OPERATE_NAME         NVARCHAR2(20),
   USER_ID              VARCHAR2(32),
   USERNAME             NVARCHAR2(20),
   LOGIN_NAME           VARCHAR2(20),
   OPERATE_DATETIME     VARCHAR2(20),
   IP                   VARCHAR2(20),
   PARAMETER            VARCHAR2(1000),
   CODE_INFO            VARCHAR2(1000),
   DEVICE_TYPE          VARCHAR2(1),
   OPERATE_TYPE         VARCHAR2(1),
   constraint PK_SYS_OPERATE_LOG primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_OPERATE_LOG.OPERATE_NAME is
'操作名称';

comment on column SYS_OPERATE_LOG.USER_ID is
'操作人ID';

comment on column SYS_OPERATE_LOG.USERNAME is
'操作人姓名';

comment on column SYS_OPERATE_LOG.LOGIN_NAME is
'操作人登录ID';

comment on column SYS_OPERATE_LOG.OPERATE_DATETIME is
'操作时间';

comment on column SYS_OPERATE_LOG.IP is
'IP地址';

comment on column SYS_OPERATE_LOG.PARAMETER is
'参数信息';

comment on column SYS_OPERATE_LOG.CODE_INFO is
'调用代码';

comment on column SYS_OPERATE_LOG.DEVICE_TYPE is
'1 pc  2 手机 3 pad';

comment on column SYS_OPERATE_LOG.OPERATE_TYPE is
'1 登录 2 退出 3 业务操作';

/*==============================================================*/
/* Table: SYS_OPERATE_TABLE                                     */
/*==============================================================*/
create table SYS_OPERATE_TABLE  (
   ID                   VARCHAR2(32)                    not null,
   TABLE_NAME           VARCHAR2(30),
   OPERATE_LOG_ID       VARCHAR2(32),
   OPERATE_TYPE         VARCHAR2(1),
   constraint PK_SYS_OPERATE_TABLE primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_OPERATE_TABLE.TABLE_NAME is
'表名';

comment on column SYS_OPERATE_TABLE.OPERATE_LOG_ID is
'操作日志ID';

comment on column SYS_OPERATE_TABLE.OPERATE_TYPE is
'操作类型 C增加 U修改  R查询  D删除';

/*==============================================================*/
/* Table: SYS_OPERATE_TABLE_FIELD                               */
/*==============================================================*/
create table SYS_OPERATE_TABLE_FIELD  (
   ID                   VARCHAR2(32)                    not null,
   FIELD_NAME           VARCHAR2(30),
   OLD_VALUE            NVARCHAR2(2000),
   NEW_VALUE            NVARCHAR2(2000),
   OPERATE_TABLE_ID     VARCHAR2(32),
   constraint PK_SYS_OPERATE_TABLE_FIELD primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_OPERATE_TABLE_FIELD.FIELD_NAME is
'字段名字';

comment on column SYS_OPERATE_TABLE_FIELD.OLD_VALUE is
'旧值';

comment on column SYS_OPERATE_TABLE_FIELD.NEW_VALUE is
'新值';

comment on column SYS_OPERATE_TABLE_FIELD.OPERATE_TABLE_ID is
'业务操作表ID';

/*==============================================================*/
/* Table: SYS_ORGAN                                             */
/*==============================================================*/
create table SYS_ORGAN  (
   ID                   VARCHAR2(32)                    not null,
   ORGAN_NAME           NVARCHAR2(120),
   ORGAN_CODE           VARCHAR2(20),
   TEL                  VARCHAR2(20),
   ADDRESS              NVARCHAR2(100),
   REMARK               NVARCHAR2(2000),
   LEGAL_PERSON         NVARCHAR2(100),
   WEBSITE              VARCHAR2(100),
   PARENT_ID            VARCHAR2(32)                   default '0',
   DELETED              VARCHAR2(1)                    default '0',
   TIER_CODE            VARCHAR2(300),
   ORGAN_TYPE           VARCHAR2(1),
   constraint PK_SYS_ORGAN primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_ORGAN.ORGAN_NAME is
'机构名称';

comment on column SYS_ORGAN.ORGAN_CODE is
'机构编码';

comment on column SYS_ORGAN.TEL is
'机构电话';

comment on column SYS_ORGAN.ADDRESS is
'机构地址';

comment on column SYS_ORGAN.REMARK is
'描述';

comment on column SYS_ORGAN.LEGAL_PERSON is
'法人';

comment on column SYS_ORGAN.WEBSITE is
'网址';

comment on column SYS_ORGAN.PARENT_ID is
'上级机构ID';

comment on column SYS_ORGAN.DELETED is
'删除标志 1是 0否';

comment on column SYS_ORGAN.TIER_CODE is
'层级码 100100';

comment on column SYS_ORGAN.ORGAN_TYPE is
'类型 1机构 2部门';

/*==============================================================*/
/* Table: SYS_PART_TIME                                         */
/*==============================================================*/
create table SYS_PART_TIME  (
   USER_ID              VARCHAR2(32)                    not null,
   ORGAN_ID             VARCHAR2(32)                    not null,
   POST                 VARCHAR2(32),
   POSITION             VARCHAR2(32),
   ISLEADER             VARCHAR2(1)                    default '0',
   constraint PK_SYS_PART_TIME primary key (USER_ID, ORGAN_ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

/*==============================================================*/
/* Table: SYS_PROMPT_MSG                                        */
/*==============================================================*/
create table SYS_PROMPT_MSG  (
   ID                   VARCHAR2(32)                    not null,
   CODE                 VARCHAR2(20),
   CONTENT              NVARCHAR2(100),
   REF_CODE             VARCHAR2(100),
   IS_PUBLIC            VARCHAR2(1),
   constraint PK_SYS_PROMPT_MSG primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on table SYS_PROMPT_MSG is
'prompt';

comment on column SYS_PROMPT_MSG.CODE is
'编码';

comment on column SYS_PROMPT_MSG.CONTENT is
'内容';

comment on column SYS_PROMPT_MSG.REF_CODE is
'代码位置';

comment on column SYS_PROMPT_MSG.IS_PUBLIC is
'是否公共消息 1是 0否';

/*==============================================================*/
/* Table: SYS_ROLE                                              */
/*==============================================================*/
create table SYS_ROLE  (
   ID                   VARCHAR2(32)                    not null,
   ROLE_NAME            NVARCHAR2(30),
   REMARK               NVARCHAR2(500),
   ROLE_TYPE            VARCHAR2(1),
   ORGAN_ID             VARCHAR2(32),
   constraint PK_SYS_ROLE primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_ROLE.ROLE_NAME is
'名称';

comment on column SYS_ROLE.REMARK is
'备注';

comment on column SYS_ROLE.ROLE_TYPE is
'类型 1普通角色  2 管理员角色';

comment on column SYS_ROLE.ORGAN_ID is
'所属机构';

/*==============================================================*/
/* Table: SYS_ROLE_MODULE                                       */
/*==============================================================*/
create table SYS_ROLE_MODULE  (
   ROLE_ID              VARCHAR2(32)                    not null,
   MODULE_ID            VARCHAR2(32)                    not null,
   FUN_CODE             VARCHAR(20),
   FUN_VALUE            VARCHAR(20),
   constraint PK_SYS_ROLE_MODULE primary key (ROLE_ID, MODULE_ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_ROLE_MODULE.ROLE_ID is
'角色ID';

comment on column SYS_ROLE_MODULE.MODULE_ID is
'模块ID';

comment on column SYS_ROLE_MODULE.FUN_CODE is
'功能编号';

comment on column SYS_ROLE_MODULE.FUN_VALUE is
'功能值';

/*==============================================================*/
/* Table: SYS_SHORTCUT_MENU                                     */
/*==============================================================*/
create table SYS_SHORTCUT_MENU  (
   MODULE_ID            VARCHAR2(32)                    not null,
   USER_ID              VARCHAR2(32)                    not null,
   constraint PK_SYS_SHORTCUT_MENU primary key (MODULE_ID, USER_ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_SHORTCUT_MENU.MODULE_ID is
'模块ID';

comment on column SYS_SHORTCUT_MENU.USER_ID is
'用户ID';

/*==============================================================*/
/* Table: SYS_USER                                              */
/*==============================================================*/
create table SYS_USER  (
   ID                   VARCHAR2(32)                    not null,
   LOGIN_NAME           VARCHAR2(20),
   PASSWORD             VARCHAR2(32),
   FULLNAME             NVARCHAR2(20),
   SEX                  VARCHAR2(2),
   BIRTHDAY             VARCHAR2(20),
   ORGAN_ID             VARCHAR2(32),
   POSITION             VARCHAR2(32),
   POST                 VARCHAR2(32),
   TEL                  VARCHAR2(20),
   MOBILE               VARCHAR2(20),
   REMARK               NVARCHAR2(500),
   EMAIL                VARCHAR2(255),
   ENABLE               VARCHAR2(1)                    default '1',
   DELETED              VARCHAR2(1)                    default '0',
   ORDER_NO             NUMBER(3),
   ENABLED_DATETIME     VARCHAR2(20),
   DISABLE_DATE_TIME    VARCHAR2(20),
   CREATE_TIME          VARCHAR2(20)                   default SYSDATE,
   IP                   VARCHAR2(20),
   ISLEADER             VARCHAR2(1)                    default '0',
   EXPIRATION_DATE      VARCHAR2(20),
   ISSECRET             VARCHAR2(1)                    default '0',
   HOME_MODULE          VARCHAR2(32),
   constraint PK_SYS_USER primary key (ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_USER.LOGIN_NAME is
'登录名';

comment on column SYS_USER.PASSWORD is
'密码';

comment on column SYS_USER.FULLNAME is
'姓名';

comment on column SYS_USER.SEX is
'性别';

comment on column SYS_USER.BIRTHDAY is
'生日';

comment on column SYS_USER.ORGAN_ID is
'机构ID';

comment on column SYS_USER.POSITION is
'职务';

comment on column SYS_USER.POST is
'岗位';

comment on column SYS_USER.TEL is
'电话';

comment on column SYS_USER.MOBILE is
'手机';

comment on column SYS_USER.REMARK is
'备注';

comment on column SYS_USER.EMAIL is
'email';

comment on column SYS_USER.ENABLE is
'是否停用 0 停用 1启用';

comment on column SYS_USER.DELETED is
'删除标志 1是 0否';

comment on column SYS_USER.ORDER_NO is
'排序号';

comment on column SYS_USER.ENABLED_DATETIME is
'启用时间';

comment on column SYS_USER.DISABLE_DATE_TIME is
'停用时间';

comment on column SYS_USER.CREATE_TIME is
'创建时间yyyy-MM-dd HH:mm:ss';

comment on column SYS_USER.IP is
'机器IP';

comment on column SYS_USER.ISLEADER is
'是否领导 1 是 0否';

comment on column SYS_USER.EXPIRATION_DATE is
'失效日期 yyyy-MM-dd';

comment on column SYS_USER.ISSECRET is
'是否保密 1 是 0否';

/*==============================================================*/
/* Table: SYS_USER_ROLE                                         */
/*==============================================================*/
create table SYS_USER_ROLE  (
   USER_ID              VARCHAR2(32)                    not null,
   ROLE_ID              VARCHAR2(32)                    not null,
   constraint PK_SYS_USER_ROLE primary key (USER_ID, ROLE_ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_USER_ROLE.USER_ID is
'用ID';

comment on column SYS_USER_ROLE.ROLE_ID is
'角色ID';

/*==============================================================*/
/* Table: SYS_USER_ROLE_PART_TIME                               */
/*==============================================================*/
create table SYS_USER_ROLE_PART_TIME  (
   USER_ID              VARCHAR2(32)                    not null,
   ROLE_ID              VARCHAR2(32)                    not null,
   ORGAN_ID             VARCHAR2(32),
   constraint PK_SYS_USER_ROLE_PART_TIME primary key (USER_ID, ROLE_ID)
         using index
       pctfree 10
       initrans 2
       storage
       (
           initial 64K
           minextents 1
           maxextents unlimited
       )
       
        logging
)
pctfree 10
initrans 1
storage
(
    initial 64K
    minextents 1
    maxextents unlimited
)

logging
monitoring
 noparallel;

comment on column SYS_USER_ROLE_PART_TIME.USER_ID is
'用ID';

comment on column SYS_USER_ROLE_PART_TIME.ROLE_ID is
'角色ID';

comment on column SYS_USER_ROLE_PART_TIME.ORGAN_ID is
'机构ID';

create table SYS_JOB_TYPE  (
   JOB_TYPE_ID          VARCHAR(32)                     not null,
   JOB_TYPE_NAME        VARCHAR(50),
   DISCRIPTION          VARCHAR(200),
   JOB_CLASS            VARCHAR(200),
   STATE                int,
   CREATE_TIME          date,
   LAST_UP_TIME         date,
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
   CREATE_TIME          date,
   LAST_UP_TIME         date,
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
   CREATE_TIME          date,
   LAST_UP_TIME         date,
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
   NEXT_FIRE_TIME       date,
   TIMEOUT              INT,
   RETRY_COUNT          INT,
   LOG_DAYS             INT,
   STATE                int,
   CREATE_TIME          date,
   LAST_UP_TIME         date,
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
   FIRE_TIME            date,
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