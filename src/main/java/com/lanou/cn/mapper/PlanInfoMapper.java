package com.lanou.cn.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * Created by zhaoce on 17/7/25.
 */
public interface PlanInfoMapper {

    /**
     * 查询促销信息
     * @return
     */
    @Select("select id,con_no conNo,con_name conName,con_type conType from sale_con")
    List<Map<String,Object>> findConNo();

    /**
     * 查询限额信息
     * @return
     */
    @Select("select id,lmt_no lmtNo,lmt_name lmtName from lmt_info")
    List<Map<String,Object>> findLmtNo();

    /**
     * 获取tp_cd查询商品类型表
     * @return
     */
    @Select("select id,tp_cd tpCd,tp_nm tpNm from prd_type")
    List<Map<String,Object>> findTpCd();

    /**
     * 根据conNO查询con_type
     * @param conNo
     * @return
     */
    @Select("select id,con_no conNo,con_name conName,con_type conType from sale_con where con_no = #{conNo}")
    Map<String,Object> findConType(@Param("conNo") String conNo);

    /**
     * 获取dis_no
     * @return
     */
    @Select("select id,dis_no disNo,dis_name disName from pre_info where con_no = #{conNo}")
    List<Map<String,Object>> findDisNo(@Param("conNo") String conNo);

    /**
     * 获取g_no
     * @return
     */
    @Select("select id,g_no gNo,g_name gName from slgf_info where con_no = #{conNo}")
    List<Map<String,Object>> findGNo(@Param("conNo") String conNo);

    /**
     * 提交数据到数据库pla_bsc
     * @param params
     */
    void addPlanInfoForm(Map<String,Object> params);

    /**
     * 提交数据到数据库pla_cpn_r
     * @param params
     */
    void addPlanCpn(@Param("params") Map<String,Object> params);

    /**
     * 将数据存到sale_pro_r表中
     * @param params
     */
    void addSaleProR(@Param("params") Map<String,Object> params);

    /**
     * 获取类别下的所有商品编号
     * @param tpCd
     * @return
     */
    @Select("select id,prd_no prdNo,prd_name prdName from prd_bsc where tp_cd = #{tpCd}")
    List<Map<String,Object>> findPrdNo(@Param("tpCd") String tpCd);

    /**
     * 分页查询
     * @param params
     * @return
     */
    List<Map<String,Object>> planInfoPage(@Param("params") Map<String, Object> params);

    /**
     * 修改信息通过pbId获取本次信息
     * @param pbId
     * @return
     */
    Map<String,Object> findPlanInfoById(@Param("pbId") String pbId);

    /**
     * 更新数据到数据库
     */
    void updatePlanInfoForm(@Param("params") Map<String,Object> params);

    /**
     * 获取代金券cpn_no
     * @return
     */
    @Select("select distinct cpn_no cpnNo,cpn_content cpnContent from pla_cpn_r")
    List<Map<String,Object>> findCpnNo();

    /**
     * 更新数据到pla_cpn_r
     */
    void updatePlaCpnR(@Param("params") Map<String,Object> params);

    /**
     * 查询pla_cpn_r有没有spNo的信息
     * @param spNo
     * @return
     */
    @Select("select sp_no from pla_cpn_r where sp_no = #{spNo}")
    Map<String,Object> findSpNoInPCR(@Param("spNo") String spNo);

    /**
     * 添加数据到pla_cpn_r
     * @param params
     */
    void addPlaCpnR(@Param("params") Map<String,Object> params);
}
