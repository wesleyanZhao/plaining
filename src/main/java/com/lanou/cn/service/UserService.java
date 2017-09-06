package com.lanou.cn.service;

import java.util.Map;

/**
 * Created by landfash on 2017/7/11.
 */
public interface UserService {

    Map<String,Object> getUserInfo(int username);

    void updateUserInfo(Map<String, Object> params) throws Exception;

//    Map<String,Object> modifyPassword(Map<String,Object> params) throws Exception;

    Map<String,Object> validatePassword(Map<String, Object> params);

    Map<String,Object> validateDifferent(Map<String, Object> params);
}
