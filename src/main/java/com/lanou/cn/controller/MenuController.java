package com.lanou.cn.controller;

import com.github.pagehelper.PageInfo;
import com.lanou.cn.service.MenuService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/12.
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

    @Resource
    private MenuService menuService;

    @RequestMapping("addMenu")
    public String addMenu(){
        return "base/addMenu";
    }

    @RequestMapping("addSureMenu")
    @ResponseBody
    public Map<String,Object> addSureMenu(@RequestParam Map<String,Object> params){
        Map<String,Object> result = new HashMap<>();
        try {
            menuService.addMenu(params);
            result.put("result","success");
        }catch(Exception e){
            e.printStackTrace();
            result.put("result","error");
        }
        return result;
    }

    @RequestMapping("getFirstMenu")
    @ResponseBody
    public List<Map<String,Object>> getFirstMenu(){
        return menuService.getFirstMenu();
    }

    @RequestMapping("managerMenu")
    public ModelAndView getMenu(@RequestParam Map<String,Object> params){
        System.out.println(params);
        ModelAndView modelAndView = new ModelAndView();
        PageInfo<Map<String,Object>> pageInfo = menuService.getMenu(params);
        modelAndView.setViewName("base/managerMenu");
        modelAndView.addObject("page",pageInfo);
        modelAndView.addObject("list",pageInfo.getList());
        modelAndView.addObject("cond",params);
        return modelAndView;
    }

    @RequestMapping("toModifyMenu")
    public ModelAndView toModifyMenu(@RequestParam Map<String,Object> params){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("base/modifyMenu");
        modelAndView.addObject("menuInfo",menuService.getOneMenu(params));
        return modelAndView;
    }

    @RequestMapping("modifyMenu")
    @ResponseBody
    public Map<String,Object> modifyMenu(@RequestParam Map<String,Object> params){
        Map<String,Object> result = new HashMap<>();
        try{
//            int id = Integer.parseInt((String)params.get("id"));
//            int organizationOne = Integer.parseInt((String)params.get("organizationOne"));
//            params.put("id",id);
//            params.put("organizationOne",organizationOne);
            menuService.modifyMenu(params);
            result.put("result","success");
        } catch (Exception e){
            e.printStackTrace();
            result.put("result","error");
        }
        return result;
    }
}
