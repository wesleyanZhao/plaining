package com.lanou.cn.service.impl;

import com.lanou.cn.mapper.UserMapper;
import com.lanou.cn.service.UserService;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by landfash on 2017/7/11.
 */
@Service
public class UserServiceImpl implements UserService{

    @Resource
    private UserMapper userMapper;

    @Override
    public Map<String, Object> getUserInfo(int userId) {
        Map<String,Object> userInfo = new HashMap<>();
        userInfo.put("userId",userId);
        return userMapper.getUser(userInfo);
    }

    @Override
    public void updateUserInfo(Map<String, Object> params) throws Exception{
        userMapper.updateUserInfo(params);
    }

    /**
     * 验证输入的密码
     * @param params
     * @return
     */
    @Override
    public Map<String, Object> validatePassword(Map<String, Object> params) {
        Map<String,Object> result = new HashMap<>();
        String password = userMapper.getPassword(params);
        if(null != password && !CollectionUtils.isEmpty(params)){
            String pwd = (String) params.get("password");
            if(password.equals(pwd)){
                result.put("result","success");
                return result;
            }
        }
        result.put("result","error");
        return result;
    }

    /**
     * 验证两次输入的面是否一致
     * @param params
     * @return
     */
    @Override
    public Map<String,Object> validateDifferent(Map<String,Object> params){
        Map<String,Object> result = new HashMap<>();
        String password1 = (String)params.get("newPassword1");
        String password2 = (String)params.get("newPassword2");
        if(null != password1 && null != password2){
            if(password1.equals(password2)){
                userMapper.modifyPassword(params);
                result.put("result","success");
            }else{
                result.put("result","different");
            }
        }
        return result;
    }

}
