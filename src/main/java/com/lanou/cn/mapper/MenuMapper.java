package com.lanou.cn.mapper;

import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/12.
 */
public interface MenuMapper {

    void addMenu(Map<String, Object> params);

    /**
     * 获得所有一级菜单
     * @return
     */
    List<Map<String,Object>> getFirstMenu();

    List<Map<String,Object>> getMenu(Map<String, Object> params);

    void modifyMenu(Map<String, Object> params);
}
