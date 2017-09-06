package com.lanou.cn.service;

import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/12.
 */
public interface SaleService {
    /**
     * 查询数据库
     * 返回页面所需数据
     * @return
     */
    List<Map<String,Object>> selectSup();

    /**
     * 添加数据入库
     * @param params
     */
    void insertSaleValue(Map<String,Object> params);

    /**
     * 分页查询
     * @param params
     * @return
     */
    PageInfo<Map<String,Object>> saleManagePage(Map<String, Object> params);

    /**
     * 查询修改页面所需数据
     * @param id
     * @return
     */
    Map<String,Object> saleSelectUpdata(int id);

    /**
     * 更新数据库数据
     * @param params
     */
    void saleUpdata(Map<String,Object> params);
}
