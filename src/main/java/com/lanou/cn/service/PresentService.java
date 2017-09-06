package com.lanou.cn.service;

import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
public interface PresentService {
    //获取促销和赠品编号下拉框内容
    Map<String,List<Map<String,Object>>> saleConAndPrdBscPage();
    //添加前台页面信息
    void addPresent(Map<String,Object> params) throws Exception;
   //赠品下拉框
    List<Map<String,Object>> findZenglist(String tpCd);
   // 减满促销方式和商品类别下拉框
    Map<String, List<Map<String, Object>>> findZengPage();
    //根据条件查询表单
    PageInfo<Map<String,Object>> getBuyZengPageList(Map<String,Object> params);
    //修改数据
    void updateBuy(Map<String,Object> params)throws Exception;

}
