package com.lanou.cn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lanou.cn.mapper.MenuMapper;
import com.lanou.cn.service.MenuService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/12.
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Resource
    private MenuMapper menuMapper;

    @Override
    public void addMenu(Map<String, Object> params) throws Exception {
        System.out.println(params);
        if(null == params.get("organizationOne")){
            params.put("organizationOne",0);
        }
        if(null == params.get("url")){
            params.put("url","");
        }
        menuMapper.addMenu(params);
    }

    @Override
    public List<Map<String, Object>> getFirstMenu() {
        return menuMapper.getFirstMenu();
    }


    @Override
    public PageInfo<Map<String,Object>> getMenu(Map<String,Object> params){
        Integer currentPage = null == params.get("currentPage") ? 1 : Integer.parseInt((String) params.get("currentPage"));
        PageHelper.startPage(currentPage,3);
        List<Map<String,Object>> list = menuMapper.getMenu(params);
        PageInfo<Map<String,Object>> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public Map<String,Object> getOneMenu(Map<String,Object> params){
        return menuMapper.getMenu(params).get(0);
    }

    @Override
    public void modifyMenu(Map<String,Object> params) throws Exception{
        menuMapper.modifyMenu(params);
    }
}
