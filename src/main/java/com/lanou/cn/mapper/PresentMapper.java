package com.lanou.cn.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
public interface PresentMapper {
    List<Map<String,Object>> getSaleCon();
    List<Map<String,Object>> getisGifts();
    void addPresent(Map<String,Object> params);
    List<Map<String,Object>> findZenglist(@Param("tpCd") String tpCd);
    List<Map<String,Object>> getCdName();
    List<Map<String,Object>> getBuyZeng(@Param("params") Map<String,Object> params);
    void updateBuy(@Param("params") Map<String,Object> params);
}
