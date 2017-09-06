package com.lanou.cn.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
public interface RESTMapper {

    /**
     * 得到优惠或买赠编号
     * @param params
     * @return
     */
    List<Map<String,Object>> getSaleWay(Map<String,Object> params);

    /**
     * 得到会员等级
     * @param params
     * @return
     */
    int getLevel(Map<String,Object> params);

    /**
     * 根据会员等级查询可参加的企划
     * @param params
     * @return
     */
    List<Map<String,Object>> getPlan(Map<String,Object> params);

    List<Map<String,Object>> getCon(@Param("conNo") String conNo);

    /**
     * 查询企划
     * @param conNo
     * @return
     */
    List<Map<String,Object>> getPlanName(@Param("conNo") String conNo);

    /**
     * 获得赠品商品
     * @param gNo
     * @return
     */
    List<Map<String,Object>> getGiftsNo(@Param("gNo") String gNo);

    /**
     * 获得返现优惠值
     * @param disNo
     * @return
     */
    List<Map<String,Object>> getPre(@Param("disNo") String disNo);

    /**
     * 获得此商品能使用的代金券
     * @param params
     * @return
     */
    List<Map<String,Object>> getCpn(Map<String,Object> params);

    /**
     * 获得限额信息
     * @param lmtNo
     * @return
     */
    List<Map<String,Object>> getLmt(@Param("lmtNo") String lmtNo);
}
