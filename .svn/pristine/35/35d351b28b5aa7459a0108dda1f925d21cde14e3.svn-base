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
drop table if exists SYS_MODULE_LOG;

/*==============================================================*/
/* Table: SYS_ADMIN_ROLE_MODULE                                 */
/*==============================================================*/
create table SYS_ADMIN_ROLE_MODULE
(
   ROLE_ID              varchar(32) not null,
   MODULE_ID            varchar(32) not null,
   primary key (ROLE_ID, MODULE_ID)
);


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
   ID                   varchar(32) not null,
   DICT_CODE            varchar(32) not null,
   DICT_NAME            varchar(20) not null,
   REMARK               varchar(200),
   PARENT_ID            varchar(32) default '0',
   ORDER_NO             numeric(3,0),
   DICT_TYPE            varchar(1),
   DELETED              varchar(1) default '0',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_DICT_ITEM                                         */
/*==============================================================*/
create table SYS_DICT_ITEM
(
   ID                   varchar(32) not null,
   ITEM_CODE            varchar(50) not null,
   ITEM_NAME            varchar(50) not null,
   DICT_ID              varchar(32),
   ORDER_NO             numeric(3,0),
   JIANPIN              varchar(50),
   DELETED              varchar(1) default '0',
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_LOGIN_LOG                                         */
/*==============================================================*/
create table SYS_LOGIN_LOG
(
   ID                   varchar(32) not null,
   USER_ID              varchar(32),
   USER_NAME            varchar(50),
   IP                   varchar(50),
   LOGIN_TIME           varchar(20),
   ORGAN_ID             varchar(32),
   LOGOUT_TIME          varchar(20),
   JSESSIONID           VARCHAR(32),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_MASTER_DATA                                       */
/*==============================================================*/
create table SYS_MASTER_DATA
(
   ID                   varchar(32) not null,
   MD_NAME              varchar(20),
   TABLE_NAME           varchar(50),
   REMARK               varchar(500),
   MD_TYPE              varchar(32),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_MASTER_DATA_FIELD                                 */
/*==============================================================*/
create table SYS_MASTER_DATA_FIELD
(
   ID_                  varchar(32) not null,
   FIELD_NAME           varchar(30),
   DISPLAY_NAME         varchar(30) ,
   FIELD_TYPE           varchar(20) ,
   REMARK               varchar(200),
   FIELD_LENGTH         varchar(20) ,
   DICT_CODE            varchar(20) ,
   NULLABLE             varchar(1) ,
   ORDER_NO             numeric(2,0),
   MASTER_DATA_ID       varchar(32),
   DISPLAYABLE          varchar(1),
   CHECK_RULE           varchar(2000),
   primary key (ID_)
);


/*==============================================================*/
/* Table: SYS_MODULE                                            */
/*==============================================================*/
create table SYS_MODULE
(
   ID                   varchar(32) not null,
   MODULE_CODE          varchar(20) ,
   MODULE_NAME          varchar(100) not null,
   URL                  varchar(255) ,
   ICON                 varchar(255) ,
   ORDER_NO             numeric(3,0) ,
   REMARK               varchar(200) ,
   MODULE_TYPE          varchar(1) ,
   PARENT_ID            varchar(32) default '0',
   IS_PUBLIC            varchar(1) default '0' ,
   DISABLED             varchar(1) default '0' ,
   IS_FOLDER            varchar(1) ,
   FUN_GROUP_CODE       varchar(20) ,
   primary key (ID)
);


/*==============================================================*/
/* Table: SYS_MODULE_FUN                                        */
/*==============================================================*/
create table SYS_MODULE_FUN
(
   ID                   varchar(32) not null,
   FUN_CODE             varchar(20) not null,
   FUN_NAME             varchar(100) not null,
   FUN_GROUP_CODE       varchar(20) not null,
   DICT_CODE            varchar(32) ,
   ORDER_NO             numeric(3,0),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_MODULE_FUN_GROUP                                  */
/*==============================================================*/
create table SYS_MODULE_FUN_GROUP
(
   ID                   varchar(32) not null,
   FUN_GROUP_CODE       varchar(20) not null,
   FUN_GROUP_NAME       varchar(100),
   DISABLED             varchar(1) default '0',
   IS_PUBLIC            varchar(1) default '0',
   ORDER_NO             numeric(3,0),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_OPERATE_LOG                                       */
/*==============================================================*/
create table SYS_OPERATE_LOG
(
   ID                   varchar(32) not null,
   OPERATE_NAME         varchar(20) ,
   USER_ID              varchar(32) ,
   USERNAME             varchar(20) ,
   LOGIN_NAME           varchar(20) ,
   OPERATE_DATETIME     varchar(20) ,
   IP                   varchar(20) ,
   PARAMETER            varchar(1000),
   CODE_INFO            varchar(1000),
   DEVICE_TYPE          varchar(1),
   OPERATE_TYPE         varchar(1),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_OPERATE_TABLE                                     */
/*==============================================================*/
create table SYS_OPERATE_TABLE
(
   ID                   varchar(32) not null,
   TABLE_NAME           varchar(30) ,
   OPERATE_LOG_ID       varchar(32) ,
   OPERATE_TYPE         varchar(1),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_OPERATE_TABLE_FIELD                               */
/*==============================================================*/
create table SYS_OPERATE_TABLE_FIELD
(
   ID                   varchar(32) not null,
   FIELD_NAME           varchar(30),
   OLD_VALUE            varchar(2000),
   NEW_VALUE            varchar(2000),
   OPERATE_TABLE_ID     varchar(32),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_ORGAN                                             */
/*==============================================================*/
create table SYS_ORGAN
(
   ID                   varchar(32) not null,
   ORGAN_NAME           varchar(120),
   ORGAN_CODE           varchar(20),
   TEL                  varchar(20),
   ADDRESS              varchar(100),
   REMARK               varchar(2000),
   LEGAL_PERSON         varchar(100),
   WEBSITE              varchar(100),
   PARENT_ID            varchar(32) default '0',
   DELETED              varchar(1) default '0' ,
   TIER_CODE            varchar(300),
   ORGAN_TYPE           varchar(1) ,
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
   CODE                 varchar(20) ,
   CONTENT              varchar(100),
   REF_CODE             varchar(100),
   IS_PUBLIC            varchar(1) ,
   primary key (ID)
);


/*==============================================================*/
/* Table: SYS_ROLE                                              */
/*==============================================================*/
create table SYS_ROLE
(
   ID                   varchar(32) not null,
   ROLE_NAME            varchar(30),
   REMARK               varchar(500),
   ROLE_TYPE            varchar(1) ,
   ORGAN_ID             varchar(32),
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_ROLE_MODULE                                       */
/*==============================================================*/
create table SYS_ROLE_MODULE
(
   ROLE_ID              varchar(32) not null,
   MODULE_ID            varchar(32) not null,
   FUN_CODE             varchar(20) ,
   FUN_VALUE            varchar(20) ,
   primary key (ROLE_ID, MODULE_ID)
);

/*==============================================================*/
/* Table: SYS_SHORTCUT_MENU                                     */
/*==============================================================*/
create table SYS_SHORTCUT_MENU
(
   MODULE_ID            varchar(32) not null,
   USER_ID              varchar(32) not null,
   primary key (MODULE_ID, USER_ID)
);

/*==============================================================*/
/* Table: SYS_USER                                              */
/*==============================================================*/
create table SYS_USER
(
   ID                   varchar(32) not null,
   LOGIN_NAME           varchar(20),
   PASSWORD             varchar(32),
   FULLNAME             varchar(20),
   SEX                  varchar(2),
   BIRTHDAY             varchar(20),
   ORGAN_ID             varchar(32),
   POSITION             varchar(32),
   POST                 varchar(32),
   TEL                  varchar(20),
   MOBILE               varchar(20),
   REMARK               varchar(500) ,
   EMAIL                varchar(255) ,
   ENABLE               varchar(1) default '1',
   DELETED              varchar(1) default '0',
   ORDER_NO             numeric(3,0) ,
   ENABLED_DATETIME     varchar(20) ,
   DISABLE_DATE_TIME    varchar(20) ,
   CREATE_TIME          varchar(20) default 'SYSDATE',
   IP                   varchar(20) ,
   ISLEADER             varchar(1) default '0',
   EXPIRATION_DATE      varchar(20) ,
   ISSECRET             varchar(1) default '0' ,
   HOME_MODULE          VARCHAR(32) ,
   primary key (ID)
);

/*==============================================================*/
/* Table: SYS_USER_ROLE                                         */
/*==============================================================*/
create table SYS_USER_ROLE
(
   USER_ID              varchar(32) not null,
   ROLE_ID              varchar(32) not null,
   primary key (USER_ID, ROLE_ID)
);

/*==============================================================*/
/* Table: SYS_USER_ROLE_PART_TIME                               */
/*==============================================================*/
create table SYS_USER_ROLE_PART_TIME
(
   USER_ID              varchar(32) not null,
   ROLE_ID              varchar(32) not null,
   ORGAN_ID             varchar(32),
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
   CREATE_TIME          TIMESTAMP,
   LAST_UP_TIME         TIMESTAMP,
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
   CREATE_TIME          TIMESTAMP,
   LAST_UP_TIME         TIMESTAMP,
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
   CREATE_TIME          TIMESTAMP,
   LAST_UP_TIME         TIMESTAMP,
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
   NEXT_FIRE_TIME       TIMESTAMP,
   TIMEOUT              INT,
   RETRY_COUNT          INT,
   LOG_DAYS             INT,
   STATE                int,
   CREATE_TIME          TIMESTAMP,
   LAST_UP_TIME         TIMESTAMP,
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
   FIRE_TIME            TIMESTAMP,
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