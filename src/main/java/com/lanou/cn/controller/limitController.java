package com.lanou.cn.controller;

import com.github.pagehelper.PageInfo;
import com.lanou.cn.service.LimitService;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/lim")
public class limitController {

    private static final String HOST_URL_USER = "http://192.168.2.1:8280";

    private static final String LOGIN_INFO = "loginInfo";
    @Resource
    private LimitService limitService;
   //传入到退额信息添加的界面
    @RequestMapping("addMessage")
    public ModelAndView aa(HttpServletRequest request){
        String username=  (String) request.getSession().getAttribute(LOGIN_INFO);
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap<>();
        bodyMap.add("username",username);
        Map<String,Object> result = restTemplate.postForObject(HOST_URL_USER + "/rest/findUserInfo.do",bodyMap,Map.class);
        int id= (int) result.get("uId");
        ModelAndView model=new ModelAndView();
        model.setViewName("limit/addLimit");
        model.addObject("id",id);
      return model;

    }//添加退额信息
    @RequestMapping("addLimit")
    @ResponseBody
    public Map<String,String > addLimit(@RequestParam Map<String,String > params){
      Map<String,String > map=new HashMap<>();
      limitService.addLimit( params);
      map.put("result","success");
      return map;

  }


   //退额信息的分页
    @RequestMapping("manageLimit")
    public ModelAndView showLimit(@RequestParam Map<String,Object> params){
        PageInfo<Map<String, Object>> pageInfo = limitService.showPlayLimit(params);
        ModelAndView model=new ModelAndView();
        model.setViewName("limit/showLimit");
        model.addObject("page",pageInfo);
        model.addObject("params",params);
        model.addObject("list",pageInfo.getList());
        System.out.println(pageInfo.getList().get(0));
        return model;
    }
    //传入修改信息
    @RequestMapping("alter")
    public ModelAndView alter(@RequestParam int id, String lmtName, String lmtCount , String lmtType ,String isUsed){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("limit/modify");
        modelAndView.addObject("id",id);
        modelAndView.addObject("lmtName",lmtName);
        modelAndView.addObject("lmtCount",lmtCount);
        modelAndView.addObject("lmtType",lmtType);
        modelAndView.addObject("isUsed",isUsed);
        System.out.println(id+"----------13312654431");
        System.out.println(lmtName+"----------1332561511231");
        System.out.println(lmtCount+"----------1331234554541");
        System.out.println(lmtType+"----------13312365411");
        System.out.println(isUsed+"----------1331153655231");
        return  modelAndView;

    }//修改信息成功
     @RequestMapping("alterLimit")
     @ResponseBody
    public  Map<String,Object>  alterLimit(@RequestParam Map<String,String> map){
        Map<String,Object> params=new HashMap<>();
        limitService.upLimit(map);
        params.put("result","success");
        return params;


    }



}
