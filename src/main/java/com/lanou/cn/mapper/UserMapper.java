package com.lanou.cn.mapper;

import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/11.
 */
public interface UserMapper {


    /**
     * 动态sql   根据username或者user_id查用户的个人信息
     * @param params
     * @return
     */
    Map<String,Object> getUser(Map<String, Object> params);

    /**
     * 保存用户个人信息
     * @param params
     * @throws Exception
     */
    void updateUserInfo(Map<String, Object> params) throws Exception;

    /**
     * 获得用户的密码
     * @param params
     * @return
     */
    @Select("select password from users where id=#{user_id}")
    String getPassword(Map<String, Object> params);

    /**
     * 修改用户密码
     * @param params
     */
    void modifyPassword(Map<String, Object> params);

    /**
     * 获得用户的个人信息
     * @param params
     * @return
     */
    List<Map<String,Object>> getUserInfo(Map<String, Object> params);

    /**
     * 注册新用户
     * @param params
     */
    void addUserInfo(Map<String, Object> params);
}
