package com.solidextend.sys.test.dao;

import java.util.List;

import com.solidextend.core.mybatis.Mapper;
import com.solidextend.sys.test.vo.RepresentativeInfo;
import org.apache.ibatis.annotations.Param;

/**
 * TODO
 * @author 
 */
@Mapper
public interface RepresentativeInfoMapper{   
    /**
     * 根据主键查询
     */
    public RepresentativeInfo getRepresentativeInfoById(@Param("id")String id); 

    /**
     * 查询出所有记录
     */
    public List<RepresentativeInfo> findAllRepresentativeInfo(RepresentativeInfo representativeInfo);    
    
    /**
     * 保存
     */
    public int saveRepresentativeInfo(RepresentativeInfo representativeInfo);
    
    /**
     * 根据主键更新（参数对象中的主键将作为更新条件）
     */
    public int updateRepresentativeInfo(RepresentativeInfo representativeInfo);
    
    /**
     * 根据主键删除
     */
    public int deleteRepresentativeInfo(@Param("id")String id);
}

