package com.lanou.cn.controller;

import com.lanou.cn.service.BaseService;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by admin on 27/6/17.
 */
@Controller
@RequestMapping("/base")
public class BaseController {

	private static final String HOST_URL ="http://192.168.2.1:8280";
	private final String LOGIN_INFO = "loginInfo";
	@Resource
	private BaseService baseService;

	/**
	 * 登录页面
	 * @return
	 */
	@RequestMapping("login")
	public String login(HttpServletRequest request) {
		request.getSession().setAttribute(LOGIN_INFO,null);
		return "base/login";
	}

	/**
	 * 注册页面
	 * @return
	 */
	@RequestMapping("register")
	public String register() {
		return "base/register";
	}

	/**
	 * 没有权限页面
	 * @return
	 */
	@RequestMapping("noPermission")
	public String noPermission() {
		return "base/noPermission";
	}

	/**
	 * 登录提交、权限验证
	 * @param params
	 * @return
	 */
	@RequestMapping("loginForm")
	@ResponseBody
	public Map<String,String> loginForm(@RequestParam() Map<String,String> params, HttpServletRequest request) {
		RestTemplate restTemplate = new RestTemplate();
		MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap<>();
		bodyMap.add("username",params.get("username"));
		bodyMap.add("password",params.get("password"));
		Map<String,String> result = restTemplate.postForObject(HOST_URL + "/rest/login.do",bodyMap,Map.class);
		MultiValueMap<String,Object> bodyMap1 = new LinkedMultiValueMap<>();
		bodyMap1.add("username",params.get("username"));
		Map<String,Object> result1 = restTemplate.postForObject(HOST_URL + "/rest/findUserInfo.do",bodyMap1,Map.class);
		int uId= (int) result1.get("uId");
		request.getSession().setAttribute("uId",uId);
		if("success".equals(result.get("result"))){
			request.getSession().setAttribute(LOGIN_INFO,params.get("username"));
		}
		return result;
	}

	/**
	 * 新用户注册
	 * 学生完成
	 * @param params
	 * @return
	 */
	@RequestMapping("registerForm")
	@ResponseBody
	public Map<String,String> registerForm(@RequestParam() Map<String,Object> params) {
		Map<String,String> result = new HashMap<>();
		try{
			String flage = baseService.joinNewUser(params);
			if("haven".equals(flage)){
				result.put("result","haven");
			}
			else if("success".equals(flage)){
				result.put("result","success");
			}
		}catch (Exception e){
			result.put("result","error");
		}
		return result;
	}

	@RequestMapping("upload")
	@ResponseBody
	public Map<String,Object> upload(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
		Map<String,Object> result = new HashMap<>();
		// 判断文件是否为空
		if (!file.isEmpty()) {
			try {
				// 文件保存路径
				String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/avatar/" + file.getOriginalFilename();
				File newfile = new File(filePath);
				if(!newfile.exists()){
					newfile.mkdirs();
				}
				// 转存文件
				file.transferTo(new File(filePath));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		result.put("result","success");
		result.put("imgUrl","/upload/avatar/"+file.getOriginalFilename());
		return result;
	}

}
