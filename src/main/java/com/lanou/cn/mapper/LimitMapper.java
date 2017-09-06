package com.lanou.cn.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
public interface LimitMapper {

    //往限额表里插入数据
    void addLimit(Map<String, String> params);

    //查询限额表，和分页
    List<Map<String,Object>> showLimit(@Param("params") Map<String, Object> params);
    //修改限额表

    @Update("update lmt_info set lmt_name=#{map.lmtName},lmt_type=#{map.lmtType},lmt_count=#{map.lmtCount},is_used=#{map.isUsed} where id=#{map.id}")
    void   upLimit(@Param("map") Map<String, String> map);

    //根据username得到相应的id。
    @Select("select id from users where username=#{username}")
    int getId(@Param("username") String username);
}
