package com.lanou.cn.service;

import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/12.
 */
public interface MenuService {

    void addMenu(Map<String, Object> params) throws Exception;

    List<Map<String,Object>> getFirstMenu();

    PageInfo<Map<String,Object>> getMenu(Map<String, Object> params);

    Map<String,Object> getOneMenu(Map<String, Object> params);

    void modifyMenu(Map<String, Object> params) throws Exception;
}
