package com.solidextend.sys.subway.vo;
/**
 *
 * @author 
 */
 import java.util.Date;
 
public class BizStationFluxSection{
    /**
     * 编号
     */
    private String id;
    /**
     * 日期
     */
    private Date settlementDate;
    /**
     * 线路编号
     */
    private String lineId;
    /**
     * 线路名称
     */
    private String lineName;
    /**
     * 开始站名称
     */
    private String stationNameBegin;
    /**
     * 开始站编号
     */
    private String stationIdBegin;
    /**
     * 结束站名称
     */
    private String stationNameEnd;
    /**
     * 结束站编号
     */
    private String stationIdEnd;
    /**
     * 查询时间
     */
    private Date sectionTime;
    /**
     * 开始时间
     */
    private Date sectionBegin;
    /**
     * 结束时间
     */
    private Date sectionEnd;
    /**
     * 客流
     */
    private Integer sectionFluxNum;
    /**
     * 上下行
     */
    private Integer direction;

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
     * 线路编号
     */
    public String getLineId(){
        return this.lineId;
    }

    /**
     * 线路编号
     */
    public void setLineId(String lineId){
        this.lineId = lineId;
    }    
    /**
     * 线路名称
     */
    public String getLineName(){
        return this.lineName;
    }

    /**
     * 线路名称
     */
    public void setLineName(String lineName){
        this.lineName = lineName;
    }    
    /**
     * 开始站名称
     */
    public String getStationNameBegin(){
        return this.stationNameBegin;
    }

    /**
     * 开始站名称
     */
    public void setStationNameBegin(String stationNameBegin){
        this.stationNameBegin = stationNameBegin;
    }    
    /**
     * 开始站编号
     */
    public String getStationIdBegin(){
        return this.stationIdBegin;
    }

    /**
     * 开始站编号
     */
    public void setStationIdBegin(String stationIdBegin){
        this.stationIdBegin = stationIdBegin;
    }    
    /**
     * 结束站名称
     */
    public String getStationNameEnd(){
        return this.stationNameEnd;
    }

    /**
     * 结束站名称
     */
    public void setStationNameEnd(String stationNameEnd){
        this.stationNameEnd = stationNameEnd;
    }    
    /**
     * 结束站编号
     */
    public String getStationIdEnd(){
        return this.stationIdEnd;
    }

    /**
     * 结束站编号
     */
    public void setStationIdEnd(String stationIdEnd){
        this.stationIdEnd = stationIdEnd;
    }    
    /**
     * 查询时间
     */
    public Date getSectionTime(){
        return this.sectionTime;
    }

    /**
     * 查询时间
     */
    public void setSectionTime(Date sectionTime){
        this.sectionTime = sectionTime;
    }    
    /**
     * 开始时间
     */
    public Date getSectionBegin(){
        return this.sectionBegin;
    }

    /**
     * 开始时间
     */
    public void setSectionBegin(Date sectionBegin){
        this.sectionBegin = sectionBegin;
    }    
    /**
     * 结束时间
     */
    public Date getSectionEnd(){
        return this.sectionEnd;
    }

    /**
     * 结束时间
     */
    public void setSectionEnd(Date sectionEnd){
        this.sectionEnd = sectionEnd;
    }    
    /**
     * 客流
     */
    public Integer getSectionFluxNum(){
        return this.sectionFluxNum;
    }

    /**
     * 客流
     */
    public void setSectionFluxNum(Integer sectionFluxNum){
        this.sectionFluxNum = sectionFluxNum;
    }    
    /**
     * 上下行
     */
    public Integer getDirection(){
        return this.direction;
    }

    /**
     * 上下行
     */
    public void setDirection(Integer direction){
        this.direction = direction;
    }    
}