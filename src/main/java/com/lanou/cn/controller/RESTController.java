package com.lanou.cn.controller;

import com.lanou.cn.service.RESTService;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
@RestController
@RequestMapping("/rest")
public class RESTController {

    private static final String HOST_URL_PRD = "http://192.168.2.9:8888";
    private static final String HOST_URL_VIP = "http://192.168.2.25:8888";
    @Resource
    private RESTService restService;

    @RequestMapping("getGifts")
    public Map<String,Object> getGifts(@RequestParam Map<String,Object> params){
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap<>();
//        bodyMap.add("product",params);
        bodyMap.setAll(params);
        Map<String,Object> result = restTemplate.postForObject(HOST_URL_PRD + "/rest/getDetailedPrdForPlan.do",bodyMap,Map.class);
        List<Map<String,Object>> product = (List<Map<String,Object>>) result.get("product");
        params.put("prdNo",product.get(0).get("prdNo"));
        return restService.getGifts(params);
    }

    @RequestMapping("getPlanning")
    public Map<String,Object> getPlanning(@RequestParam Map<String,Object> params, HttpServletRequest request){
        //需要调用商品系统的接口获得商品的信息（至少包含毛利率 商品编号 明细成本）   提供明细编号

        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap<>();
        bodyMap.add("product",params.get("product"));
        Map<String,Object> product = restTemplate.postForObject(HOST_URL_PRD + "/rest/getDetailedPrdForPlan.do",bodyMap,Map.class);//调用查询商品信息的接口
        params.put("product",product.get("product"));
        RestTemplate restTemplateVip = new RestTemplate();
        MultiValueMap<String,Object> vipMap = new LinkedMultiValueMap<>();
        Map<String,Object> vipInfo = (Map<String, Object>) request.getSession().getAttribute("vipInfo");//获得保存在作用域中的会员信息
//        Map<String,Object> paramsVip = new HashMap<>();
//        paramsVip.put("id",);
//        vipMap.add("id",vipInfo.get("vipId"));
//        vipMap.add("vipNoHave",vipInfo.get("vipNo"));
        vipMap.add("id",params.get("vipId"));
        vipMap.add("vipNoHave",params.get("vipNo"));
        List<Map<String,Object>> result = restTemplateVip.postForObject(HOST_URL_VIP + "/rest/findVipInfo.do",vipMap,List.class);//调用接口查询会员的详细信息
        List<Map<String,Object>> vipCpn = restTemplateVip.postForObject(HOST_URL_VIP + "/rest/findCpnInfo.do",vipMap,List.class);
        params.put("level",result.get(0).get("vipLevel"));
        params.put("vipCpn",vipCpn);
        System.out.println("result::::::success");
        return restService.getPlanning(params);
    }

}
