package com.lanou.cn.controller;

import com.github.pagehelper.PageInfo;
import com.lanou.cn.service.BaseService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by admin on 27/6/17.
 */
@Controller
@RequestMapping("/index")
public class IndexController {

	private static final String HOST_URL_BASE = "http://192.168.2.1:8280";

	@Resource
	private BaseService baseService;

	/**
	 * 首页
	 * @return
	 */
	@RequestMapping("home")//起初的形参是Map<String,String> params
	public ModelAndView home(@RequestParam Map<String,Object> params) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("base/home");
//		System.out.println(params);
		RestTemplate restTemplate = new RestTemplate();
		Map<String,Object> map = restTemplate.getForObject(HOST_URL_BASE + "/rest/home.do",Map.class);
//		List<LinkedHashMap<String,Object>> list = baseService.findAllMenuList();
//		String result = JSONArray.toJSONString(list);
		modelAndView.addObject("result",map.get("result"));
		modelAndView.addObject("loginUser",params.get("loginUser"));
		return modelAndView;
	}

	/**
	 * 分页例子
	 * @return
	 */
	@RequestMapping("mainPage")
	public ModelAndView mainPage(@RequestParam Map<String,Object> params){
		ModelAndView modelAndView = new ModelAndView();
		// 后期需要优化
		PageInfo<Map<String, Object>> pageInfo = baseService.findAllUsersPageList(params);
		modelAndView.addObject("page",pageInfo);
		modelAndView.addObject("list",pageInfo.getList());

		modelAndView.setViewName("/base/mainPage");
		return modelAndView;
	}


}
