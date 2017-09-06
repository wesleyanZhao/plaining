package com.lanou.cn.controller;

import com.github.pagehelper.PageInfo;
import com.lanou.cn.service.PlanInfoService;
import org.apache.shiro.util.CollectionUtils;
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
import java.util.List;
import java.util.Map;

/**
 * Created by zhaoce on 17/7/25.
 */
@Controller
@RequestMapping("/plan")
public class PlanInfoController {

    public static final String HOST_URL_PRD = "http://192.168.2.9:8888";
    public static final String HOST_URL_PRD_TYPE = "http://192.168.2.1:8180";
    public static final String HOST_URL_CPN = "http://192.168.2.25:8888";

    @Resource
    private PlanInfoService planInfoService;

    /**
     * 添加企划信息页面
     */
    @RequestMapping("addPlanInfo")
    public ModelAndView addPlanInfo(@RequestParam Map<String,Object> params) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("planning/addPlanInfo");
        List<Map<String,Object>> resultConNo = planInfoService.findConNo();
        List<Map<String,Object>> resultLmtNo = planInfoService.findLmtNo();

        RestTemplate restTemplate=new RestTemplate();
        MultiValueMap<String,String> bodyMap=new LinkedMultiValueMap<>();
        List<Map<String,Object>> resultPrdType = restTemplate.postForObject(HOST_URL_PRD + "/rest/getType.do",bodyMap,List.class);

        //List<Map<String,Object>> resultPrdType = planInfoService.findTpCd();
        modelAndView.addObject("resultConNo",resultConNo);
        modelAndView.addObject("resultLmtNo",resultLmtNo);
        modelAndView.addObject("resultPrdType",resultPrdType);
        return modelAndView;
    }

    /**
     * 添加关系表数据
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("addPlanInfoCpn")
    @ResponseBody
    public List<Map<String,Object>> addPlanInfoCpn(@RequestParam Map<String,Object> params,HttpServletRequest request){
        RestTemplate restTemplate=new RestTemplate();
        MultiValueMap<String,String> bodyMap=new LinkedMultiValueMap<>();
        bodyMap.add("cpnTypeNo",(String) params.get("cpnTypeNo"));
        bodyMap.add("tpCd",(String) params.get("tpCd"));
        List<Map<String,Object>> resultCpn= restTemplate.postForObject(HOST_URL_CPN + "/rest/findCpnInfo.do",bodyMap,List.class);
        request.getSession().setAttribute("resultCpn",resultCpn);
        return resultCpn;
    }

    /**
     * 提交企划信息
     */
    @RequestMapping("addPlanInfoForm")
    @ResponseBody
    public Map<String,Object> addPlanInfoForm(@RequestParam Map<String,Object> params, HttpServletRequest request) {
        System.out.println("******  "+params);
        Map<String,Object> result = new HashMap<>();
        int uId = (int) request.getSession().getAttribute("uId");
        System.out.println(uId);
        List<Map<String,Object>> resultCpn= (List<Map<String, Object>>) request.getSession().getAttribute("resultCpn");
        if(!CollectionUtils.isEmpty(resultCpn) && resultCpn.size()>0){
            for(int i=0;i<resultCpn.size();i++) {
                if (resultCpn.get(i).get("cpnContent").equals(params.get("cpnContent"))) {
                    params.put("cpnNo", resultCpn.get(i).get("cpnNo"));
                    params.put("useDateBegin",resultCpn.get(i).get("activeDate"));
                    params.put("useDateEnd",resultCpn.get(i).get("expireDate"));
                }
            }
        }
        params.put("uId",uId);
        planInfoService.addPlanInfoForm(params);
        result.put("result","success");
        return result;
    }

    /**
     * 根据conNO查询con_type
     * @param conNo
     * @return
     */
    @RequestMapping("findConType")
    @ResponseBody
    public Map<String,Object> findConType(String conNo){
        Map<String,Object> resultConType = planInfoService.findConType(conNo);
        return resultConType;
    }

    /**
     * 根据con_no获dis_no
     * @param conNo
     * @return
     */
    @RequestMapping("findDisNo")
    @ResponseBody
    public List<Map<String,Object>> findDisNo(String conNo) {
        List<Map<String,Object>> resultDisNo = planInfoService.findDisNo(conNo);
        return resultDisNo;
    }

    /**
     * 根据con_no获取g_no
     * @param conNo
     * @return
     */
    @RequestMapping("findGNo")
    @ResponseBody
    public List<Map<String,Object>> findGNo(String conNo) {
        List<Map<String,Object>> resultGNo = planInfoService.findGNo(conNo);
        return resultGNo;
    }

    /**
     * 查询分页
     * @param params
     * @return
     */
    @RequestMapping("planInfoPage")
    public ModelAndView planInfoPage(@RequestParam Map<String,Object> params) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/planning/planInfoPage");
        PageInfo<Map<String, Object>> pageInfo = planInfoService.planInfoPage(params);
        List<Map<String,Object>> resultConNo = planInfoService.findConNo();
        List<Map<String,Object>> resultCpnNo = planInfoService.findCpnNo();
        modelAndView.addObject("resultConNo",resultConNo);
        modelAndView.addObject("resultCpnNo",resultCpnNo);
        modelAndView.addObject("page",pageInfo);
        modelAndView.addObject("list",pageInfo.getList());
        modelAndView.addObject("params",params);//将检索条件返回到页面
        String conNo = (String) params.get("conNo");
        String cpnNo = (String) params.get("cpnNo");
        modelAndView.addObject("conNo",conNo);
        modelAndView.addObject("cpnNo",cpnNo);
        return modelAndView;
    }

    /**
     * 管理修改信息页面
     * @return
     */
    @RequestMapping("updatePlanInfo")
    public ModelAndView updatePlanInfo(String pbId,HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/planning/updatePlanInfo");
        Map<String,Object> result = planInfoService.findPlanInfoById(pbId);
        RestTemplate restTemplate=new RestTemplate();
        MultiValueMap<String,String> bodyMap=new LinkedMultiValueMap<>();
        List<Map<String,Object>> allCpnInfo= restTemplate.postForObject(HOST_URL_CPN + "/rest/findCpnInfo.do",bodyMap,List.class);
        modelAndView.addObject("resultCpnNo",allCpnInfo);
        String conNo = (String) result.get("conNo");
        String lmtNo = (String) result.get("lmtNo");
        String cpnNo = (String) result.get("cpnNo");
        List<Map<String,Object>> resultConNo = planInfoService.findConNo();
        List<Map<String,Object>> resultLmtNo = planInfoService.findLmtNo();
        modelAndView.addObject("resultConNo",resultConNo);
        modelAndView.addObject("resultLmtNo",resultLmtNo);
        modelAndView.addObject("result",result);
        modelAndView.addObject("conNo",conNo);
        modelAndView.addObject("lmtNo",lmtNo);
        modelAndView.addObject("cpnNo",cpnNo);
        request.getSession().setAttribute("allCpnInfo",allCpnInfo);
        return modelAndView;
    }

    /**
     * 将数据更新到数据库
     * @param params
     * @param request
     * @return
     */
    @RequestMapping("updatePlanInfoForm")
    @ResponseBody
    public Map<String,Object> updatePlanInfoForm(@RequestParam Map<String,Object> params,HttpServletRequest request){
        Map<String,Object> result = new HashMap<>();
        int uId = (int) request.getSession().getAttribute("uId");
        String cpnNo = (String) params.get("cpnNo");
        List<Map<String,Object>> allCpnInfo = (List<Map<String, Object>>) request.getSession().getAttribute("allCpnInfo");
        System.out.println(allCpnInfo);
        for(int i = 0;i <allCpnInfo.size();i++) {
            if(allCpnInfo.get(i).get("cpnNo").equals(cpnNo)) {
                String cpnContent = (String) allCpnInfo.get(i).get("cpnContent");
                System.out.println(cpnContent);
                String useDateBegin = (String) allCpnInfo.get(i).get("activeDate");
                String useDateEnd = (String) allCpnInfo.get(i).get("expireDate");
                params.put("cpnContent",cpnContent);
                params.put("useDateBegin",useDateBegin);
                params.put("useDateEnd",useDateEnd);
                break;
            }
        }
        params.put("uId",uId);
        planInfoService.updatePlanInfoForm(params);
        result.put("result","success");
        return result;
    }

}
