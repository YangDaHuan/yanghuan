
package com.solidextend.sys.ticket.dao;

import com.solidextend.core.mybatis.Mapper;
import java.util.List;
import com.solidextend.sys.ticket.vo.BizTicketDeploy;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface BizTicketDeployMapper{   
    /**
     * 根据主键查询
     */
    public BizTicketDeploy getBizTicketDeployById(@Param("deployId")String deployId); 

    /**
     * 查询出所有记录
     */
    public List<BizTicketDeploy> findAllBizTicketDeploy();  
    
    /**
     * 查询出所有符合条件的记录
     */
    public List<BizTicketDeploy> findByAttrBizTicketDeploy(BizTicketDeploy bizTicketDeploy);    
    
    /**
     * 查询出所有和调配部门相关的的记录
     */
    public List<BizTicketDeploy> findByAboutBizTicketDeploy(BizTicketDeploy bizTicketDeploy);    
    
    
    /**
     * 保存
     */
    public int saveBizTicketDeploy(BizTicketDeploy bizTicketDeploy);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateBizTicketDeploy(BizTicketDeploy bizTicketDeploy);
    
    /**
     * 根据主键删除
     */
    public int deleteBizTicketDeploy(@Param("deployId")String deployId);
    /**
     * 根据Code更新调配状态
     */
    public int updateBizTicketStateDeployByCode(@Param("deployCode") String deployCode,@Param("deployState") int deployState);

    /*
	 * 获取最大的code
	 */
	public String getMaxBizTicketDeployCode();

	public List<BizTicketDeploy> findByAttrBizTicketDeployAndApply(@Param("bizTicketDeploy") BizTicketDeploy bizTicketDeploy, 
					@Param("auditingState") Integer auditingState,@Param("groupName") String groupName);
	
	
}

