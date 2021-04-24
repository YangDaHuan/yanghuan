package com.solidextend.sys.subway.vo;
/**
 *
 * @author 
 */
 import java.util.Date;
 
public class BizStationFluxTransfer{
    /**
     * 编号
     */
    private String id;
    /**
     * 换乘站名
     */
    private String stationNameTransfer;
    /**
     * 日期
     */
    private Date settlementDate;
    /**
     * 开始线路名称
     */
    private String lineNameStart;
    /**
     * 开始线路ID
     */
    private String lineIdStart;
    /**
     * 开始线路上下行
     */
    private String directionBegin;
    /**
     * 换乘线路名称
     */
    private String lineNameEnd;
    /**
     * 换乘线路ID
     */
    private String lineIdEnd;
    /**
     * 换乘线路上下行
     */
    private String directionEnd;
    /**
     * 换乘量
     */
    private Integer transforNum;
    /**
     * 时间段开始
     */
    private Date sectionBegin;
    /**
     * 时间段结束
     */
    private Date sectionEnd;

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
     * 换乘站名
     */
    public String getStationNameTransfer(){
        return this.stationNameTransfer;
    }

    /**
     * 换乘站名
     */
    public void setStationNameTransfer(String stationNameTransfer){
        this.stationNameTransfer = stationNameTransfer;
    }    
    /**
     * 日期
     */
    public Date getSettlementDate(){
        return this.settlementDate;
    }

    /**
     * 日期
     */
    public void setSettlementDate(Date settlementDate){
        this.settlementDate = settlementDate;
    }    
    /**
     * 开始线路名称
     */
    public String getLineNameStart(){
        return this.lineNameStart;
    }

    /**
     * 开始线路名称
     */
    public void setLineNameStart(String lineNameStart){
        this.lineNameStart = lineNameStart;
    }    
    /**
     * 开始线路ID
     */
    public String getLineIdStart(){
        return this.lineIdStart;
    }

    /**
     * 开始线路ID
     */
    public void setLineIdStart(String lineIdStart){
        this.lineIdStart = lineIdStart;
    }    
    /**
     * 开始线路上下行
     */
    public String getDirectionBegin(){
        return this.directionBegin;
    }

    /**
     * 开始线路上下行
     */
    public void setDirectionBegin(String directionBegin){
        this.directionBegin = directionBegin;
    }    
    /**
     * 换乘线路名称
     */
    public String getLineNameEnd(){
        return this.lineNameEnd;
    }

    /**
     * 换乘线路名称
     */
    public void setLineNameEnd(String lineNameEnd){
        this.lineNameEnd = lineNameEnd;
    }    
    /**
     * 换乘线路ID
     */
    public String getLineIdEnd(){
        return this.lineIdEnd;
    }

    /**
     * 换乘线路ID
     */
    public void setLineIdEnd(String lineIdEnd){
        this.lineIdEnd = lineIdEnd;
    }    
    /**
     * 换乘线路上下行
     */
    public String getDirectionEnd(){
        return this.directionEnd;
    }

    /**
     * 换乘线路上下行
     */
    public void setDirectionEnd(String directionEnd){
        this.directionEnd = directionEnd;
    }    
    /**
     * 换乘量
     */
    public Integer getTransforNum(){
        return this.transforNum;
    }

    /**
     * 换乘量
     */
    public void setTransforNum(Integer transforNum){
        this.transforNum = transforNum;
    }    
    /**
     * 时间段开始
     */
    public Date getSectionBegin(){
        return this.sectionBegin;
    }

    /**
     * 时间段开始
     */
    public void setSectionBegin(Date sectionBegin){
        this.sectionBegin = sectionBegin;
    }    
    /**
     * 时间段结束
     */
    public Date getSectionEnd(){
        return this.sectionEnd;
    }

    /**
     * 时间段结束
     */
    public void setSectionEnd(Date sectionEnd){
        this.sectionEnd = sectionEnd;
    }    
}