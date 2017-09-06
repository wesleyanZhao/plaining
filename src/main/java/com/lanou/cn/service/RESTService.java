package com.lanou.cn.service;

import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
public interface RESTService {

    /**
     * 根据活动，计算优惠值
     * @param params
     * @return
     */
    Map<String,Object> getGifts(Map<String,Object> params);

    /**
     * 根据条件判断能参加的企划活动，并计算符合条件的支付前活动 算出最后价格
     * @param params
     * @return
     */
    Map<String,Object> getPlanning(Map<String,Object> params);
}
