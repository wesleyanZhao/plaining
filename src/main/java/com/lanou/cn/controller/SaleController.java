package com.lanou.cn.controller;

import com.github.pagehelper.PageInfo;
import com.lanou.cn.service.SaleService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Lanou3G on 2017/7/25.
 */
@Controller
@RequestMapping("/sale")
public class SaleController {
    @Resource
    private SaleService saleService;

    /**
     * 跳转到数据添加页面
     * 并回显数据
     * @return
     */
    @RequestMapping("saleAddConditionPage")
    public ModelAndView saleAddConditionPage(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("planning/saleAddConditionPage");
        List<Map<String,Object>> params=saleService.selectSup();
        modelAndView.addObject("params",params);
        return modelAndView;
    }

    /**
     * 数据添加页面添加数据进入数据库
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("insertSaleValue")
    @ResponseBody
    public String insertSaleValue(@RequestParam Map<String,Object> params, HttpServletRequest request){
        int uId= (int) request.getSession().getAttribute("uId");
        params.put("uId",uId);
        saleService.insertSaleValue(params);
        return "success";
    }

    /**
     * 跳转查询页面并回显数
     * 据实现分页及条件查询
     * @param params
     * @return
     */
    @RequestMapping("saleManagePage")
    public ModelAndView saleManagePage(@RequestParam Map<String,Object> params){
        ModelAndView modelAndView = new ModelAndView();
        // 后期需要优化
        PageInfo<Map<String, Object>> pageInfo = saleService.saleManagePage(params);
        List<Map<String,Object>> result=saleService.selectSup();
        modelAndView.addObject("page",pageInfo);
        modelAndView.addObject("list",pageInfo.getList());
        modelAndView.addObject("params",params);
        modelAndView.addObject("result",result);
        //System.out.println(params);
        modelAndView.setViewName("/planning/saleManagePage");
        return modelAndView;
    }

    /**
     * 调转信息修改页面
     * 回显页面所需数据
     * @param id
     * @return
     */
    @RequestMapping("saleUpdataPage")
    public ModelAndView saleUpdataPage(@RequestParam int id){
        ModelAndView modelAndView=new ModelAndView();
        Map<String,Object> params= saleService.saleSelectUpdata(id);
        List<Map<String,Object>> supValue=saleService.selectSup();
        modelAndView.setViewName("/planning/saleUpdataPage");
        modelAndView.addObject("params",params);
        modelAndView.addObject("result",id);
        modelAndView.addObject("supValue",supValue);
        return modelAndView;
    }

    /**
     * 信息修改页面提交数据
     * 更新数据库
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("saleUpdata")
    @ResponseBody
    public Map<String,Object> saleUpdata(@RequestParam Map<String,Object> params,HttpServletRequest request){
        int uId= (int) request.getSession().getAttribute("uId");
        params.put("uId",uId);
        saleService.saleUpdata(params);
        Map<String,Object> result=new HashMap<>();
        result.put("result","success");
        return result;
    }

}
