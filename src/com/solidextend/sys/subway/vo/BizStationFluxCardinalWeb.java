package com.solidextend.sys.subway.vo;
import java.sql.Timestamp;
/**
 *
 * @author 
 */
 import java.util.Date;
 
public class BizStationFluxCardinalWeb{
    /**
     * 编号
     */
    private String id;
    /**
     * 站名
     */
    private String stationName;
    /**
     * 进站基数
     */
    private Integer stationEntryCardinal;
    /**
     * 出站基数
     */
    private Integer stationExitCardinal;
    /**
     * 换乘基数
     */
    private Integer stationTransforCardinal;
    /**
     * 统计间隔
     */
    private Integer alartCycle;
    /**
     * 更新时间
     */
    private Timestamp updateTime;

    /**
     * 编号
     */
    public String getId(){
        return this.id;
    }

    /**
     * 编号
     */
    public void setId(String id){
        this.id = id;
    }    
    /**
     * 站名
     */
    public String getStationName(){
        return this.stationName;
    }

    /**
     * 站名
     */
    public void setStationName(String stationName){
        this.stationName = stationName;
    }    
    /**
     * 进站基数
     */
    public Integer getStationEntryCardinal(){
        return this.stationEntryCardinal;
    }

    /**
     * 进站基数
     */
    public void setStationEntryCardinal(Integer stationEntryCardinal){
        this.stationEntryCardinal = stationEntryCardinal;
    }    
    /**
     * 出站基数
     */
    public Integer getStationExitCardinal(){
        return this.stationExitCardinal;
    }

    /**
     * 出站基数
     */
    public void setStationExitCardinal(Integer stationExitCardinal){
        this.stationExitCardinal = stationExitCardinal;
    }    
    /**
     * 换乘基数
     */
    public Integer getStationTransforCardinal(){
        return this.stationTransforCardinal;
    }

    /**
     * 换乘基数
     */
    public void setStationTransforCardinal(Integer stationTransforCardinal){
        this.stationTransforCardinal = stationTransforCardinal;
    }    
    /**
     * 统计间隔
     */
    public Integer getAlartCycle(){
        return this.alartCycle;
    }

    /**
     * 统计间隔
     */
    public void setAlartCycle(Integer alartCycle){
        this.alartCycle = alartCycle;
    }    
    /**
     * 更新时间
     */
    public Timestamp getUpdateTime(){
        return this.updateTime;
    }

    /**
     * 更新时间
     */
    public void setUpdateTime(Timestamp updateTime){
        this.updateTime = updateTime;
    }    
}