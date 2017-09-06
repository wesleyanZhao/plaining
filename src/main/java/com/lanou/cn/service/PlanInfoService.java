package com.lanou.cn.service;

import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by zhaoce on 17/7/25.
 */
public interface PlanInfoService {
    /**
     * 获取con_no
     * @return
     */
    List<Map<String,Object>> findConNo();

    /**
     * 获取dis_no
     * @return
     */
    List<Map<String,Object>> findDisNo(String conNo);

    /**
     * 根据conNO查询con_type
     * @param conNo
     * @return
     */
    Map<String,Object> findConType(String conNo);

    /**
     * 获取g_no
     * @return
     */
    List<Map<String,Object>> findGNo(String conNo);

    /**
     * 获取lmt_no
     * @return
     */
    List<Map<String,Object>> findLmtNo();

    /**
     * 获取tp_cd
     * @return
     */
    List<Map<String,Object>> findTpCd();

    /**
     * 提交form到数据库
     * @param params
     */
    void addPlanInfoForm(Map<String,Object> params);

    /**
     * 查询分页
     * @param params
     * @return
     */
    PageInfo<Map<String,Object>> planInfoPage(Map<String, Object> params);

    /**
     * 修改信息通过pbId获取本次信息
     * @param pbId
     * @return
     */
    Map<String,Object> findPlanInfoById(String pbId);

    /**
     * 更新数据
     */
    void updatePlanInfoForm(Map<String,Object> params);

    /**
     * 获取代金券cpn_no
     * @return
     */
    List<Map<String,Object>> findCpnNo();

}
