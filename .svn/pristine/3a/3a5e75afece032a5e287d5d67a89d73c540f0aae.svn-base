/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     2015/3/6 10:38:50                            */
/*==============================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_ADMIN_ROLE_MODULE')
            and   type = 'U')
   drop table SYS_ADMIN_ROLE_MODULE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_AUDIT_LOG')
            and   type = 'U')
   drop table SYS_AUDIT_LOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_AUDIT_LOG_EXT')
            and   type = 'U')
   drop table SYS_AUDIT_LOG_EXT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_DICT')
            and   type = 'U')
   drop table SYS_DICT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_DICT_ITEM')
            and   type = 'U')
   drop table SYS_DICT_ITEM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_LOGIN_LOG')
            and   type = 'U')
   drop table SYS_LOGIN_LOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_MASTER_DATA')
            and   type = 'U')
   drop table SYS_MASTER_DATA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_MASTER_DATA_FIELD')
            and   type = 'U')
   drop table SYS_MASTER_DATA_FIELD
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_MODULE')
            and   type = 'U')
   drop table SYS_MODULE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_MODULE_FUN')
            and   type = 'U')
   drop table SYS_MODULE_FUN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_MODULE_FUN_GROUP')
            and   type = 'U')
   drop table SYS_MODULE_FUN_GROUP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_OPERATE_LOG')
            and   type = 'U')
   drop table SYS_OPERATE_LOG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_OPERATE_TABLE')
            and   type = 'U')
   drop table SYS_OPERATE_TABLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_OPERATE_TABLE_FIELD')
            and   type = 'U')
   drop table SYS_OPERATE_TABLE_FIELD
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_ORGAN')
            and   type = 'U')
   drop table SYS_ORGAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_PART_TIME')
            and   type = 'U')
   drop table SYS_PART_TIME
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_PROMPT_MSG')
            and   type = 'U')
   drop table SYS_PROMPT_MSG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_ROLE')
            and   type = 'U')
   drop table SYS_ROLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_ROLE_MODULE')
            and   type = 'U')
   drop table SYS_ROLE_MODULE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_SHORTCUT_MENU')
            and   type = 'U')
   drop table SYS_SHORTCUT_MENU
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_USER')
            and   type = 'U')
   drop table SYS_USER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_USER_ROLE')
            and   type = 'U')
   drop table SYS_USER_ROLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SYS_USER_ROLE_PART_TIME')
            and   type = 'U')
   drop table SYS_USER_ROLE_PART_TIME
go

/*==============================================================*/
/* Table: SYS_ADMIN_ROLE_MODULE                                 */
/*==============================================================*/
create table SYS_ADMIN_ROLE_MODULE (
   ROLE_ID              varchar(32)          not null,
   MODULE_ID            varchar(32)          not null,
   constraint PK_SYS_ADMIN_ROLE_MODULE primary key nonclustered (ROLE_ID, MODULE_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '保存管理员有权分配给本机构的人员的模块',
   'user', @CurrentUser, 'table', 'SYS_ADMIN_ROLE_MODULE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '管理员角色ID',
   'user', @CurrentUser, 'table', 'SYS_ADMIN_ROLE_MODULE', 'column', 'ROLE_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块ID',
   'user', @CurrentUser, 'table', 'SYS_ADMIN_ROLE_MODULE', 'column', 'MODULE_ID'
go

/*==============================================================*/
/* Table: SYS_AUDIT_LOG                                         */
/*==============================================================*/
create table SYS_AUDIT_LOG (
   LOG_ID               varchar(32)          not null,
   ACTOR_ID             varchar(32)          null,
   LOG_CREATE_TIME      timestamp            null,
   LOG_IPADDRESS        varchar(20)          null,
   ORGAN_ID             varchar(32)          null,
   MODEL_ID             varchar(32)          null,
   LOG_SERVICE_ID       varchar(1024)        null,
   LOG_OP_FLAG          varchar(2)           null,
   LOG_DESCRPTION       varchar(100)         null,
   constraint PK_SYS_AUDIT_LOG primary key nonclustered (LOG_ID)
)
go

/*==============================================================*/
/* Table: SYS_AUDIT_LOG_EXT                                     */
/*==============================================================*/
create table SYS_AUDIT_LOG_EXT (
   LOG_ID               varchar(32)          null,
   LOG_NAME             varchar(64)          null,
   LOG_VALUE            varchar(1024)        null,
   LOG_OLDVALUE         varchar(1024)        null
)
go

/*==============================================================*/
/* Table: SYS_DICT                                              */
/*==============================================================*/
create table SYS_DICT (
   ID                   varchar(32)          not null,
   DICT_CODE            varchar(32)          not null,
   DICT_NAME            varchar(20)          not null,
   REMARK               varchar(200)         null,
   PARENT_ID            varchar(32)          null default '0',
   ORDER_NO             numeric(3)           null,
   DICT_TYPE            varchar(1)           null,
   DELETED              varchar(1)           null default '0',
   constraint PK_SYS_DICT primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型ID',
   'user', @CurrentUser, 'table', 'SYS_DICT', 'column', 'ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典编码',
   'user', @CurrentUser, 'table', 'SYS_DICT', 'column', 'DICT_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典名称',
   'user', @CurrentUser, 'table', 'SYS_DICT', 'column', 'DICT_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注信息',
   'user', @CurrentUser, 'table', 'SYS_DICT', 'column', 'REMARK'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '上级字典',
   'user', @CurrentUser, 'table', 'SYS_DICT', 'column', 'PARENT_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'SYS_DICT', 'column', 'ORDER_NO'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型 1具体字典 2字典类别',
   'user', @CurrentUser, 'table', 'SYS_DICT', 'column', 'DICT_TYPE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '删除标志 1是 0否',
   'user', @CurrentUser, 'table', 'SYS_DICT', 'column', 'DELETED'
go

/*==============================================================*/
/* Table: SYS_DICT_ITEM                                         */
/*==============================================================*/
create table SYS_DICT_ITEM (
   ID                   varchar(32)          not null,
   ITEM_CODE            varchar(50)          not null,
   ITEM_NAME            varchar(50)          not null,
   DICT_ID              varchar(32)          null,
   ORDER_NO             numeric(3)           null,
   JIANPIN              varchar(50)          null,
   DELETED              varchar(1)           null default '0',
   constraint PK_SYS_DICT_ITEM primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典ID',
   'user', @CurrentUser, 'table', 'SYS_DICT_ITEM', 'column', 'ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型ID',
   'user', @CurrentUser, 'table', 'SYS_DICT_ITEM', 'column', 'ITEM_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典名称',
   'user', @CurrentUser, 'table', 'SYS_DICT_ITEM', 'column', 'ITEM_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '所属字典ID',
   'user', @CurrentUser, 'table', 'SYS_DICT_ITEM', 'column', 'DICT_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'SYS_DICT_ITEM', 'column', 'ORDER_NO'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '简拼',
   'user', @CurrentUser, 'table', 'SYS_DICT_ITEM', 'column', 'JIANPIN'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '删除标志 1是 0否',
   'user', @CurrentUser, 'table', 'SYS_DICT_ITEM', 'column', 'DELETED'
go

/*==============================================================*/
/* Table: SYS_LOGIN_LOG                                         */
/*==============================================================*/
create table SYS_LOGIN_LOG (
   ID                   varchar(32)          not null,
   USER_ID              varchar(32)          null,
   USER_NAME            varchar(50)          null,
   IP                   varchar(50)          null,
   LOGIN_TIME           varchar(20)          null,
   ORGAN_ID             varchar(32)          null,
   LOGOUT_TIME          varchar(20)          null,
   JSESSIONID           VARCHAR(32)		 	 null,
   constraint PK_SYS_LOGIN_LOG primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户ID',
   'user', @CurrentUser, 'table', 'SYS_LOGIN_LOG', 'column', 'USER_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户名',
   'user', @CurrentUser, 'table', 'SYS_LOGIN_LOG', 'column', 'USER_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'IP地址',
   'user', @CurrentUser, 'table', 'SYS_LOGIN_LOG', 'column', 'IP'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '登录时间 yyyy-MM-dd HH:mm:ss',
   'user', @CurrentUser, 'table', 'SYS_LOGIN_LOG', 'column', 'LOGIN_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机构ID',
   'user', @CurrentUser, 'table', 'SYS_LOGIN_LOG', 'column', 'ORGAN_ID'
go

/*==============================================================*/
/* Table: SYS_MASTER_DATA                                       */
/*==============================================================*/
create table SYS_MASTER_DATA (
   ID                   varchar(32)          not null,
   MD_NAME              varchar(20)          null,
   TABLE_NAME           varchar(50)          null,
   REMARK               varchar(500)         null,
   MD_TYPE              varchar(32)          null,
   constraint PK_SYS_MASTER_DATA primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '名字',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA', 'column', 'MD_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '表名',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA', 'column', 'TABLE_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA', 'column', 'REMARK'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '类型',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA', 'column', 'MD_TYPE'
go

/*==============================================================*/
/* Table: SYS_MASTER_DATA_FIELD                                 */
/*==============================================================*/
create table SYS_MASTER_DATA_FIELD (
   ID_                  varchar(32)          not null,
   FIELD_NAME           varchar(30)          null,
   DISPLAY_NAME         varchar(30)          null,
   FIELD_TYPE           varchar(20)          null,
   REMARK               varchar(200)         null,
   FIELD_LENGTH         varchar(20)          null,
   DICT_CODE            varchar(20)          null,
   NULLABLE             varchar(1)           null,
   ORDER_NO             numeric(2)           null,
   MASTER_DATA_ID       varchar(32)          null,
   DISPLAYABLE          varchar(1)           null,
   CHECK_RULE           varchar(2000)        null,
   constraint PK_SYS_MASTER_DATA_FIELD primary key nonclustered (ID_)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主数据字段信息',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'ID_',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'ID_'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字段名字',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'FIELD_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字段显示名称',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'DISPLAY_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字段类型',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'FIELD_TYPE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字段说明',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'REMARK'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字段长度 ，如果是数字型，那么可以使用小数，例如5.2表示长度是5，其中小数部分是2',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'FIELD_LENGTH'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典类型代码。如此字段引用的是字典，那么需要制定字典代码',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'DICT_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否允许为空',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'NULLABLE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'ORDER_NO'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '主数据ID',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'MASTER_DATA_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否显示',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'DISPLAYABLE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '校验规则',
   'user', @CurrentUser, 'table', 'SYS_MASTER_DATA_FIELD', 'column', 'CHECK_RULE'
go

/*==============================================================*/
/* Table: SYS_MODULE                                            */
/*==============================================================*/
create table SYS_MODULE (
   ID                   varchar(32)          not null,
   MODULE_CODE          varchar(20)          null,
   MODULE_NAME          varchar(100)         not null,
   URL                  varchar(255)         null,
   ICON                 varchar(255)         null,
   ORDER_NO             numeric(3)           null,
   REMARK               varchar(200)         null,
   MODULE_TYPE          varchar(1)           null,
   PARENT_ID            varchar(32)          null default '0',
   IS_PUBLIC            varchar(1)           null default '0',
   DISABLED             varchar(1)           null default '0',
   IS_FOLDER            varchar(1)           null,
   FUN_GROUP_CODE       varchar(20)          null,
   constraint PK_SYS_MODULE primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能模块表',
   'user', @CurrentUser, 'table', 'SYS_MODULE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块ID',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '编号',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'MODULE_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块名称',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'MODULE_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'URL地址',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'URL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '图标地址',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'ICON'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'ORDER_NO'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'REMARK'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否为系统 1模块 2功能',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'MODULE_TYPE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '上级模块ID',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'PARENT_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否为公共模块 1是 0 否',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'IS_PUBLIC'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否停用 1是 0 否',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'DISABLED'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否文件夹 1是 0 否',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'IS_FOLDER'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能组编号',
   'user', @CurrentUser, 'table', 'SYS_MODULE', 'column', 'FUN_GROUP_CODE'
go

/*==============================================================*/
/* Table: SYS_MODULE_FUN                                        */
/*==============================================================*/
create table SYS_MODULE_FUN (
   ID                   varchar(32)          not null,
   FUN_CODE             varchar(20)          not null,
   FUN_NAME             varchar(100)         not null,
   FUN_GROUP_CODE       varchar(20)          not null,
   DICT_CODE            varchar(32)          null,
   ORDER_NO             numeric(3)           null,
   constraint PK_SYS_MODULE_FUN primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能编号',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN', 'column', 'FUN_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能名称',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN', 'column', 'FUN_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块类型编号',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN', 'column', 'FUN_GROUP_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字典编号',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN', 'column', 'DICT_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN', 'column', 'ORDER_NO'
go

/*==============================================================*/
/* Table: SYS_MODULE_FUN_GROUP                                  */
/*==============================================================*/
create table SYS_MODULE_FUN_GROUP (
   ID                   varchar(32)          not null,
   FUN_GROUP_CODE       varchar(20)          not null,
   FUN_GROUP_NAME       varchar(100)         null,
   DISABLED             varchar(1)           null default '0',
   IS_PUBLIC            varchar(1)           null default '0',
   ORDER_NO             numeric(3)           null,
   constraint PK_SYS_MODULE_FUN_GROUP primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块类型编号',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN_GROUP', 'column', 'FUN_GROUP_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块类型名称',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN_GROUP', 'column', 'FUN_GROUP_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否停用 1是 0 否',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN_GROUP', 'column', 'DISABLED'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否为公共模块 1是 0 否',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN_GROUP', 'column', 'IS_PUBLIC'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'SYS_MODULE_FUN_GROUP', 'column', 'ORDER_NO'
go

/*==============================================================*/
/* Table: SYS_OPERATE_LOG                                       */
/*==============================================================*/
create table SYS_OPERATE_LOG (
   ID                   varchar(32)          not null,
   OPERATE_NAME         varchar(20)          null,
   USER_ID              varchar(32)          null,
   USERNAME             varchar(20)          null,
   LOGIN_NAME           varchar(20)          null,
   OPERATE_DATETIME     varchar(20)          null,
   IP                   varchar(20)          null,
   PARAMETER            varchar(1000)        null,
   CODE_INFO            varchar(1000)        null,
   DEVICE_TYPE          varchar(1)           null,
   OPERATE_TYPE         varchar(1)           null,
   constraint PK_SYS_OPERATE_LOG primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作名称',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'OPERATE_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作人ID',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'USER_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作人姓名',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'USERNAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作人登录ID',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'LOGIN_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作时间',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'OPERATE_DATETIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'IP地址',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'IP'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '参数信息',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'PARAMETER'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '调用代码',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'CODE_INFO'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 pc  2 手机 3 pad',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'DEVICE_TYPE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1 登录 2 退出 3 业务操作',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_LOG', 'column', 'OPERATE_TYPE'
go

/*==============================================================*/
/* Table: SYS_OPERATE_TABLE                                     */
/*==============================================================*/
create table SYS_OPERATE_TABLE (
   ID                   varchar(32)          not null,
   TABLE_NAME           varchar(30)          null,
   OPERATE_LOG_ID       varchar(32)          null,
   OPERATE_TYPE         varchar(1)           null,
   constraint PK_SYS_OPERATE_TABLE primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '表名',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_TABLE', 'column', 'TABLE_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作日志ID',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_TABLE', 'column', 'OPERATE_LOG_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '操作类型 C增加 U修改  R查询  D删除',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_TABLE', 'column', 'OPERATE_TYPE'
go

/*==============================================================*/
/* Table: SYS_OPERATE_TABLE_FIELD                               */
/*==============================================================*/
create table SYS_OPERATE_TABLE_FIELD (
   ID                   varchar(32)          not null,
   FIELD_NAME           varchar(30)          null,
   OLD_VALUE            varchar(2000)        null,
   NEW_VALUE            varchar(2000)        null,
   OPERATE_TABLE_ID     varchar(32)          null,
   constraint PK_SYS_OPERATE_TABLE_FIELD primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '字段名字',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_TABLE_FIELD', 'column', 'FIELD_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '旧值',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_TABLE_FIELD', 'column', 'OLD_VALUE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '新值',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_TABLE_FIELD', 'column', 'NEW_VALUE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '业务操作表ID',
   'user', @CurrentUser, 'table', 'SYS_OPERATE_TABLE_FIELD', 'column', 'OPERATE_TABLE_ID'
go

/*==============================================================*/
/* Table: SYS_ORGAN                                             */
/*==============================================================*/
create table SYS_ORGAN (
   ID                   varchar(32)          not null,
   ORGAN_NAME           varchar(120)         null,
   ORGAN_CODE           varchar(20)          null,
   TEL                  varchar(20)          null,
   ADDRESS              varchar(100)         null,
   REMARK               varchar(2000)        null,
   LEGAL_PERSON         varchar(100)         null,
   WEBSITE              varchar(100)         null,
   PARENT_ID            varchar(32)          null default '0',
   DELETED              varchar(1)           null default '0',
   TIER_CODE            varchar(300)         null,
   ORGAN_TYPE           varchar(1)           null,
   constraint PK_SYS_ORGAN primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机构名称',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'ORGAN_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机构编码',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'ORGAN_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机构电话',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'TEL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机构地址',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'ADDRESS'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '描述',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'REMARK'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '法人',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'LEGAL_PERSON'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '网址',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'WEBSITE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '上级机构ID',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'PARENT_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '删除标志 1是 0否',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'DELETED'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '层级码 100100',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'TIER_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '类型 1机构 2部门',
   'user', @CurrentUser, 'table', 'SYS_ORGAN', 'column', 'ORGAN_TYPE'
go

/*==============================================================*/
/* Table: SYS_PART_TIME                                         */
/*==============================================================*/
create table SYS_PART_TIME (
   USER_ID              varchar(32)          not null,
   ORGAN_ID             varchar(32)          not null,
   POST                 varchar(32)          null,
   POSITION             varchar(32)          null,
   ISLEADER             varchar(1)           null default '0',
   constraint PK_SYS_PART_TIME primary key nonclustered (USER_ID, ORGAN_ID)
)
go

/*==============================================================*/
/* Table: SYS_PROMPT_MSG                                        */
/*==============================================================*/
create table SYS_PROMPT_MSG (
   ID                   varchar(32)          not null,
   CODE                 varchar(20)          null,
   CONTENT              varchar(100)         null,
   REF_CODE             varchar(100)         null,
   IS_PUBLIC            varchar(1)           null,
   constraint PK_SYS_PROMPT_MSG primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'prompt',
   'user', @CurrentUser, 'table', 'SYS_PROMPT_MSG'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '编码',
   'user', @CurrentUser, 'table', 'SYS_PROMPT_MSG', 'column', 'CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '内容',
   'user', @CurrentUser, 'table', 'SYS_PROMPT_MSG', 'column', 'CONTENT'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '代码位置',
   'user', @CurrentUser, 'table', 'SYS_PROMPT_MSG', 'column', 'REF_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否公共消息 1是 0否',
   'user', @CurrentUser, 'table', 'SYS_PROMPT_MSG', 'column', 'IS_PUBLIC'
go

/*==============================================================*/
/* Table: SYS_ROLE                                              */
/*==============================================================*/
create table SYS_ROLE (
   ID                   varchar(32)          not null,
   ROLE_NAME            varchar(30)          null,
   REMARK               varchar(500)         null,
   ROLE_TYPE            varchar(1)           null,
   ORGAN_ID             varchar(32)          null,
   constraint PK_SYS_ROLE primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '名称',
   'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'ROLE_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'REMARK'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '类型 1普通角色  2 管理员角色',
   'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'ROLE_TYPE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '所属机构',
   'user', @CurrentUser, 'table', 'SYS_ROLE', 'column', 'ORGAN_ID'
go

/*==============================================================*/
/* Table: SYS_ROLE_MODULE                                       */
/*==============================================================*/
create table SYS_ROLE_MODULE (
   ROLE_ID              varchar(32)          not null,
   MODULE_ID            varchar(32)          not null,
   FUN_CODE             varchar(20)          null,
   FUN_VALUE            varchar(20)          null,
   constraint PK_SYS_ROLE_MODULE primary key nonclustered (ROLE_ID, MODULE_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色ID',
   'user', @CurrentUser, 'table', 'SYS_ROLE_MODULE', 'column', 'ROLE_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块ID',
   'user', @CurrentUser, 'table', 'SYS_ROLE_MODULE', 'column', 'MODULE_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能编号',
   'user', @CurrentUser, 'table', 'SYS_ROLE_MODULE', 'column', 'FUN_CODE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '功能值',
   'user', @CurrentUser, 'table', 'SYS_ROLE_MODULE', 'column', 'FUN_VALUE'
go

/*==============================================================*/
/* Table: SYS_SHORTCUT_MENU                                     */
/*==============================================================*/
create table SYS_SHORTCUT_MENU (
   MODULE_ID            varchar(32)          not null,
   USER_ID              varchar(32)          not null,
   constraint PK_SYS_SHORTCUT_MENU primary key nonclustered (MODULE_ID, USER_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '模块ID',
   'user', @CurrentUser, 'table', 'SYS_SHORTCUT_MENU', 'column', 'MODULE_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用户ID',
   'user', @CurrentUser, 'table', 'SYS_SHORTCUT_MENU', 'column', 'USER_ID'
go

/*==============================================================*/
/* Table: SYS_USER                                              */
/*==============================================================*/
create table SYS_USER (
   ID                   varchar(32)          not null,
   LOGIN_NAME           varchar(20)          null,
   PASSWORD             varchar(32)          null,
   FULLNAME             varchar(20)          null,
   SEX                  varchar(2)           null,
   BIRTHDAY             varchar(20)          null,
   ORGAN_ID             varchar(32)          null,
   POSITION             varchar(32)          null,
   POST                 varchar(32)          null,
   TEL                  varchar(20)          null,
   MOBILE               varchar(20)          null,
   REMARK               varchar(500)         null,
   EMAIL                varchar(255)         null,
   ENABLE               varchar(1)           null default '1',
   DELETED              varchar(1)           null default '0',
   ORDER_NO             numeric(3)           null,
   ENABLED_DATETIME     varchar(20)          null,
   DISABLE_DATE_TIME    varchar(20)          null,
   CREATE_TIME          varchar(20)          null default 'SYSDATE',
   IP                   varchar(20)          null,
   ISLEADER             varchar(1)           null default '0',
   EXPIRATION_DATE      varchar(20)          null,
   ISSECRET             varchar(1)           null default '0',
   HOME_MODULE          VARCHAR(32)          null,
   constraint PK_SYS_USER primary key nonclustered (ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '登录名',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'LOGIN_NAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '密码',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'PASSWORD'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '姓名',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'FULLNAME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '性别',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'SEX'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '生日',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'BIRTHDAY'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机构ID',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'ORGAN_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '职务',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'POSITION'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '岗位',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'POST'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '电话',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'TEL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '手机',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'MOBILE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '备注',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'REMARK'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   'email',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'EMAIL'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否停用 0 停用 1启用',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'ENABLE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '删除标志 1是 0否',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'DELETED'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '排序号',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'ORDER_NO'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '启用时间',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'ENABLED_DATETIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '停用时间',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'DISABLE_DATE_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '创建时间yyyy-MM-dd HH:mm:ss',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'CREATE_TIME'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机器IP',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'IP'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否领导 1 是 0否',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'ISLEADER'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '失效日期 yyyy-MM-dd',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'EXPIRATION_DATE'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '是否保密 1 是 0否',
   'user', @CurrentUser, 'table', 'SYS_USER', 'column', 'ISSECRET'
go

/*==============================================================*/
/* Table: SYS_USER_ROLE                                         */
/*==============================================================*/
create table SYS_USER_ROLE (
   USER_ID              varchar(32)          not null,
   ROLE_ID              varchar(32)          not null,
   constraint PK_SYS_USER_ROLE primary key nonclustered (USER_ID, ROLE_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用ID',
   'user', @CurrentUser, 'table', 'SYS_USER_ROLE', 'column', 'USER_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色ID',
   'user', @CurrentUser, 'table', 'SYS_USER_ROLE', 'column', 'ROLE_ID'
go

/*==============================================================*/
/* Table: SYS_USER_ROLE_PART_TIME                               */
/*==============================================================*/
create table SYS_USER_ROLE_PART_TIME (
   USER_ID              varchar(32)          not null,
   ROLE_ID              varchar(32)          not null,
   ORGAN_ID             varchar(32)          null,
   constraint PK_SYS_USER_ROLE_PART_TIME primary key nonclustered (USER_ID, ROLE_ID)
)
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '用ID',
   'user', @CurrentUser, 'table', 'SYS_USER_ROLE_PART_TIME', 'column', 'USER_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '角色ID',
   'user', @CurrentUser, 'table', 'SYS_USER_ROLE_PART_TIME', 'column', 'ROLE_ID'
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '机构ID',
   'user', @CurrentUser, 'table', 'SYS_USER_ROLE_PART_TIME', 'column', 'ORGAN_ID'
go




