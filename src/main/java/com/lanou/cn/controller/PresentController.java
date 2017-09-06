package com.lanou.cn.controller;

import com.github.pagehelper.PageInfo;
import com.lanou.cn.service.PresentService;
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
 * Created by lanou on 2017/7/25.
 */
@Controller
@RequestMapping("/present")
public class PresentController {
    @Resource
    private PresentService presentService;
    /**
     * 买赠信息添加开始
     *
     */
    @RequestMapping("addPresent")
    public ModelAndView addPresent(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("planning/buyAddPresent");
        Map<String,List<Map<String,Object>>> saleConAndPrdBsc = presentService.saleConAndPrdBscPage();
        Map<String,List<Map<String,Object>>> findBuyPresent = presentService.findZengPage();
        modelAndView.addObject("findBuyPresent",findBuyPresent);
        modelAndView.addObject("saleConAndPrdBsc",saleConAndPrdBsc);
        return modelAndView;
    }
    /**
     *
     *买赠信息添加前台页面数据
     */
    @RequestMapping("addPresentForm")
    @ResponseBody
    public Map<String,Object> addPresentForm(@RequestParam Map<String,Object> params, HttpServletRequest request){
        Map<String,Object> result = new HashMap<>();
        try {
            int uId= (int) request.getSession().getAttribute("uId");
            params.put("uId",uId);
            System.out.println(params);
            presentService.addPresent(params);
            result.put("result","success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result","error");
        }
        return result;
    }
    /**
     *买赠信息查询
     *
     */
    @RequestMapping("findZengPage")
    public ModelAndView findZengPage(@RequestParam Map<String,Object> params){
        System.out.println(params+".............");
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("planning/buyPresent");
        PageInfo<Map<String,Object>> pageInfo = presentService.getBuyZengPageList(params);
        Map<String,List<Map<String,Object>>> findBuyPresent = presentService.findZengPage();
        modelAndView.addObject("page",pageInfo);
        modelAndView.addObject("list",pageInfo.getList());
        modelAndView.addObject("findBuyPresent",findBuyPresent);
//        modelAndView.addObject("prdName",prdName);
//        modelAndView.addObject("tpName",tpName);
        modelAndView.addObject("cond",params);
        return modelAndView;
    }
    /**
     *
     *二级联动下拉框根据商品类别选择赠品
     */

    @RequestMapping("findZeng")
    @ResponseBody
    public List<Map<String,Object>> findZeng(String tpCd){
        System.out.println(tpCd);
        List<Map<String,Object>> list=presentService.findZenglist(tpCd);
        return list;
    }
    @RequestMapping("presentUpdate")
    public ModelAndView presentUpdate(@RequestParam Map<String,Object> params){
        System.out.println(params);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/planning/updatePresent");
        Map<String,List<Map<String,Object>>> saleConAndPrdBsc = presentService.saleConAndPrdBscPage();
        Map<String,List<Map<String,Object>>> findBuyPresent = presentService.findZengPage();
        modelAndView.addObject("findBuyPresent",findBuyPresent);
        modelAndView.addObject("saleConAndPrdBsc",saleConAndPrdBsc);
        modelAndView.addObject("params",params);
        return modelAndView;
    }
    @RequestMapping("UpdatePresent")
    @ResponseBody
    public Map<String,Object> UpdatePresent(@RequestParam Map<String,Object> params){
        Map<String,Object> result = new HashMap<>();
        try {
            presentService.updateBuy(params);
            result.put("result","success");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("result","error");
        }
        return result;
    }
}
