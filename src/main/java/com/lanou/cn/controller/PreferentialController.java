package com.lanou.cn.controller;

import com.github.pagehelper.PageInfo;
import com.lanou.cn.service.PerferentialService;
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
 * Created by admin on 27/6/17.
 */
@Controller
@RequestMapping("/preInfo")
public class PreferentialController {

	@Resource
	private PerferentialService perferentialService;


	/**
	 * 跳转到优惠信息添加页面
	 * 查询优惠类型
	 * @return
	 */
	@RequestMapping("jumpAdd")
	public ModelAndView jumpAdd() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("planning/preferentialAdd");
        List<Map<String,Object>> list=perferentialService.getContype();
		modelAndView.addObject("list",list);
		return modelAndView;
	}
	/**
	 * 查询条件名称
	 * @return
	 */
	@RequestMapping("conditionName")
	@ResponseBody
	public List<Map<String,Object>> conditionName(@RequestParam Map<String,Object> params) {
		List<Map<String,Object>> list=perferentialService.getConditionName(params);
		System.out.println(list);
		return list;
	}
	/**
	 * 添加优惠信息
	 * @return
	 */
	@RequestMapping("addPreferential")
	@ResponseBody
	public Map<String,String> addPreferential(@RequestParam Map<String,Object> params, HttpServletRequest request) {
		Map<String,String> result = new HashMap<>();
		int uId= (int) request.getSession().getAttribute("uId");
		params.put("uId",uId);
		perferentialService.addPerferential(params);
		result.put("result","success");
		return result;
	}
	/**
	 * 跳转到优惠信息管理页面
	 * @return
	 */
	@RequestMapping("management")
	public ModelAndView findperferential(@RequestParam Map<String,Object> params) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("planning/preferentialmanagement");
		PageInfo<Map<String,Object>> pageInfo= perferentialService.findPerferential(params);
		List<Map<String,Object>> list=perferentialService.getContype();
		List<Map<String,Object>> list1=perferentialService.getConName(params);
		modelAndView.addObject("page",pageInfo);
		modelAndView.addObject("list",pageInfo.getList());
		modelAndView.addObject("params",params);
		modelAndView.addObject("list1",list);
		modelAndView.addObject("list2",list1);
		return modelAndView;
	}
	/**
	 * 跳转到优惠信息修改页面
	 * @return
	 */
	@RequestMapping("preferentialUpdate")
	public ModelAndView preferentialUpdate(@RequestParam Map<String,Object> params) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("planning/preferentialUpdate");
		List<Map<String,Object>> list=perferentialService.findConditionsName(params);
		List<Map<String,Object>> list1=perferentialService.getContype();
		List<Map<String,Object>> list2=perferentialService.getConName(params);
		params.get("conName");
		modelAndView.addObject("params",params);
		modelAndView.addObject("list",list);
		modelAndView.addObject("list1",list1);
		modelAndView.addObject("list2",list2);
		return modelAndView;
	}
	/**
	 * 优惠信息修改
	 * @return
	 */
	@RequestMapping("preferentialUpdateFrom")
	@ResponseBody
	public Map<String,String> preferentialUpdateFrom(@RequestParam Map<String,Object> params,HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView();
		Map<String,String> result = new HashMap<>();
		int uId= (int) request.getSession().getAttribute("uId");
		params.put("uId",uId);
			perferentialService.preferentialUpdateFrom(params);
			result.put("result","success");
		return result;
	}
}
