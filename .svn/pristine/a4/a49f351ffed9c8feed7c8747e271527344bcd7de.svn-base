/**
 * ==================   =============   ============   =================================
 * Author               OperateType     Date           Description
 * ==================   =============   ============   =================================
 * lilin                New             2012-12-5      记录审计日志的切面类
 */
package com.solidextend.sys.log.aop;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;

import com.solidextend.core.util.ReflectUtil;
import com.solidextend.sys.log.LogConstant;
import com.solidextend.sys.log.LogContext;
import com.solidextend.sys.log.service.BtpLog;
import com.solidextend.sys.log.vo.LogConfigInfo;

/**
 * 记录审计日志的切面类<br>
 * 该类需要重构，先实现功能
 * 
 * @author lilin
 * @version [版本号, 2012-12-5]
 */
public class AuditLogAspect {
	
	private static final Log log = LogFactory.getLog(AuditLogAspect.class);
	/**
	 * 日志配置初始化信息对象
	 */
	private LogContext logContext;
	

	/**
	 * BTP日志接口
	 */
	private BtpLog btpLog;

	/**
	 * 记录审计日志
	 * 
	 * @param joinPoint
	 *            切入点，存放代理对象的相关信息
	 * @return obj
	 * @throws Throwable
	 *             Throwable
	 */
	public Object logging(ProceedingJoinPoint joinPoint) throws Throwable {
		// 获得参数
		Object[] args = joinPoint.getArgs();
		// 获得目标对象的类名
		String className = joinPoint.getTarget().getClass().getName();
		// 获得所执行的方法名
		String methodName = joinPoint.getSignature().getName();

		String key = className + '.' + methodName;

		// 获取配置信息
		LogConfigInfo logConfigInfo = logContext.getLogConfigInfo(key);

		// 为空则表示没有配置日志，则直接调用方法返回
		if (logConfigInfo == null) {
			return joinPoint.proceed(args);
		}

		// 无参的方法
		if (args == null || args.length == 0) {
			// 记录审计日志
			btpLog.log(key);
			return joinPoint.proceed();
		}

		// 取得需要记录的参数信息
		Object param = args[logConfigInfo.getParamIndex()];
		String serviceId = null;
		// 修改的情况先要取旧值
		Object oldValue = null;
		// 获取旧值
		if (StringUtils.isNotEmpty(logConfigInfo.getServiceId())
				&& StringUtils.isNotEmpty(logConfigInfo.getUpdateBeanId())
				&& StringUtils.isNotEmpty(logConfigInfo.getUpdateMethod())) {
			// 反射获取serviceId
			serviceId = (String) ReflectUtil.getFieldValue(param, logConfigInfo
					.getServiceId());

			// 获取spring的bean
			Object bean = logContext.getBean(logConfigInfo.getUpdateBeanId());
			// 反射获取oldValue，根据主键查询旧值
			oldValue = ReflectUtil.invokeMethod(
					logConfigInfo.getUpdateMethod(), bean, serviceId);
		}

		// 直接执行代理对象的方法
		Object result = joinPoint.proceed(args);

		// 删除的情况直接把参数记为serviceId
		if (LogConstant.LOG_OPFLAG_DELETE.equals(logConfigInfo.getOpFlag())) {
			serviceId = ArrayUtils.toString(param);
		} else if (StringUtils.isNotEmpty(logConfigInfo.getServiceId())) {
			// 反射获取serviceId
			serviceId = (String) ReflectUtil.getFieldValue(param, logConfigInfo
					.getServiceId());
		}

		// 记录审计日志
		btpLog.log(key, serviceId, param, oldValue);

		return result;
	}

	
	public void setLogContext(LogContext logContext) {
		this.logContext = logContext;
	}

	public void setBtpLog(BtpLog btpLog) {
		this.btpLog = btpLog;
	}
}
