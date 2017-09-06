package com.lanou.cn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lanou.cn.mapper.LimitMapper;
import com.lanou.cn.service.LimitService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
@Service
public class LimitServiceImpl implements LimitService {
    
    @Resource
    private LimitMapper limitMapper;

    //添加限额表
    public void addLimit(Map<String,String > params){
        limitMapper.addLimit(params);
    }

    //查询限额表，分页 动态sql
    public PageInfo<Map<String,Object>> showPlayLimit(Map<String, Object> params){
        Integer currentPage=params.get("currentPage")==null?1: Integer.parseInt((String)params.get("currentPage"));
        PageHelper.startPage(currentPage,5);
        List<Map<String,Object>> list=limitMapper.showLimit(params);   //查询限额来分页
        return new PageInfo<Map<String,Object>>(list);
    }

    //修改限额的信息
    public void   upLimit(Map<String,String> map){
       limitMapper.upLimit(map);
    }
    //根据username得到相应的id
    public int getId( String username){
        return  limitMapper.getId(username);
   }
}
