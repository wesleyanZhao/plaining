package com.lanou.cn.controller;

import com.lanou.cn.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by admin on 27/6/17.
 */
@Controller
@RequestMapping("/user")
public class UserController {

	@Resource
	private UserService userService;

	/**
	 * 修改个人信息页面
	 * @return
	 */
	@RequestMapping("getUserInfo")
	public ModelAndView getUserInfo(int userId){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/individualInformation");
		Map<String,Object> result = userService.getUserInfo(userId);
		//判断是否为空，不为空的话，说明之前设置过，需要将之前设置的信息展示出来
		if(CollectionUtils.isEmpty(result)){
			result = new HashMap<>();
		}
		result.put("userId",userId);
		modelAndView.addObject("userInfo",result);
		return modelAndView;
	}

//	@RequestMapping("upload")
//	@ResponseBody
//	public Map<String,Object> upload(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
//		Map<String,Object> result = new HashMap<>();
//		// 判断文件是否为空
//		if (!file.isEmpty()) {
//			try {
//				// 文件保存路径
//				String filePath = request.getSession().getServletContext().getRealPath("/") + "upload/avatar/" + file.getOriginalFilename();
//				File newfile = new File(filePath);
//				if(!newfile.exists()){
//					newfile.mkdirs();
//				}
//				// 转存文件
//				file.transferTo(new File(filePath));
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		result.put("result","success");
//		result.put("imgUrl","/upload/avatar/"+file.getOriginalFilename());
//		return result;
//	}

	/**
	 * 保存用户个人信息
	 * @param params
	 * @return
	 */
	@RequestMapping("userInfoForm")
	@ResponseBody
	public Map<String,Object> userInfoForm(@RequestParam Map<String,Object> params){
		Map<String,Object> result = new HashMap<>();
		System.out.println(params);
		try {
			userService.updateUserInfo(params);
		}catch (Exception e){
			e.printStackTrace();
			result.put("result","error");
		}
		result.put("result","success");
		return result;
	}


	/**
	 * 跳到修改密码的页面
	 * @param params
	 * @return
	 */
	@RequestMapping("modifyPage")
	public ModelAndView getModifyPage(@RequestParam Map<String,Object> params){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/modifyPassword");
		modelAndView.addObject("userInfo",params);
		return modelAndView;
	}

	/**
	 * 验证密码是否正确
	 * @param params
	 * @return
	 */
	@RequestMapping("validatePassword")
	@ResponseBody
	public Map<String,Object> validatePassword(@RequestParam Map<String,Object> params){
		return userService.validatePassword(params);
	}

	/**
	 * 跳到设置新密码页面
	 * @param params
	 * @return
	 */
	@RequestMapping("newPassword")
	public ModelAndView newPassword(@RequestParam Map<String,Object> params){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/setNewPassword");
		modelAndView.addObject("userInfo",params);
		return modelAndView;
	}

	/**
	 * 验证确定密码修改成新密码
	 * @param params
	 * @return
	 */
	@RequestMapping("setNewPassword")
	@ResponseBody
	public Map<String,Object> setNewPassword(@RequestParam Map<String,Object> params){
		return userService.validateDifferent(params);
	}
}
