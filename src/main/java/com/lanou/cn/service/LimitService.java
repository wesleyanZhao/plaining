package com.lanou.cn.service;

import com.github.pagehelper.PageInfo;

import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
public interface LimitService {

    /**
     *  添加限额表
     */
    void addLimit(Map<String, String> params);

    /**
     * 查询限额表，分页 动态sql
     */
    PageInfo<Map<String,Object>> showPlayLimit(Map<String, Object> params);

    /**
     * 修改限额表，用动态sql
     */
    void   upLimit(Map<String, String> map);

    /**
     * 根据username得到相应的id
     */
    int getId( String username);
}


