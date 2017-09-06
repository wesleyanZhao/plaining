package com.lanou.cn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lanou.cn.mapper.PresentMapper;
import com.lanou.cn.service.PresentService;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lanou on 2017/7/25.
 */
@Service
public class PresentServicelmpl implements PresentService{

    public static final String HOST_URL_PRD = "http://192.168.2.9:8888";

    @Resource
    private PresentMapper presentMapper;
    @Override
    public Map<String, List<Map<String, Object>>> saleConAndPrdBscPage() {
        List<Map<String, Object>> conNo=presentMapper.getSaleCon();
        Map<String,List<Map<String,Object>>> saleConAndPrdBsc = new HashMap<>();
        saleConAndPrdBsc.put("conNo",conNo);
        return saleConAndPrdBsc;
    }
    @Override
    public void addPresent(Map<String, Object> params) throws Exception {
        presentMapper.addPresent(params);
    }
    @Override
    public List<Map<String, Object>> findZenglist(String tpCd) {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        bodyMap.add("tpCd",tpCd);
        bodyMap.add("isGifts","Yes");
        List<Map<String, Object>> list = restTemplate.postForObject(HOST_URL_PRD + "/rest/getGifts.do",bodyMap, List.class);
//        List<Map<String, Object>> list=presentMapper.findZenglist(tpCd);
        return list;
    }
    @Override
    public Map<String, List<Map<String, Object>>> findZengPage() {
        List<Map<String, Object>> conNo=presentMapper.getSaleCon();
//        List<Map<String, Object>> getCdName=presentMapper.getCdName();
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        List<Map<String, Object>> getCdName= restTemplate.postForObject(HOST_URL_PRD + "/rest/getType.do",bodyMap, List.class);
        Map<String,List<Map<String,Object>>> findBuyPresent = new HashMap<>();
        findBuyPresent.put("conNo",conNo);
        findBuyPresent.put("tpCd",getCdName);
        return findBuyPresent;
    }
    @Override
    public PageInfo<Map<String, Object>> getBuyZengPageList(Map<String, Object> params) {
            Integer currentPage = params.get("currentPage") == null ? 1 : Integer.parseInt((String) params.get("currentPage"));
            PageHelper.startPage(currentPage, 3);
            System.out.println(params);
            List<Map<String, Object>> list1=new ArrayList<>();
            if(params.get("tpCd")==null||params.get("prdNo")==null) {
               List<Map<String, Object>> list = presentMapper.getBuyZeng(params);
                System.out.println(list);
               for (int i = 0; i < list.size(); i++) {
                   String gPrdNo = (String) (list.get(i).get("gPrdNo"));
                   if (gPrdNo == null) {
                       break;
                   }
                   RestTemplate restTemplate = new RestTemplate();
                   MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
                   bodyMap.add("prdNo", gPrdNo);
                   Map<String, Object> p = restTemplate.postForObject(HOST_URL_PRD + "/rest/getPrd.do", bodyMap, Map.class);
                   System.out.println(p);
                   String prdName = (String) p.get("prdName");
                   System.out.println(prdName);
                   String tpCd = (String) p.get("tpCd");
                   MultiValueMap<String, Object> bodyMap1 = new LinkedMultiValueMap<String, Object>();
                   bodyMap1.add("tpCd", tpCd);
                   List<Map<String, Object>> t = restTemplate.postForObject(HOST_URL_PRD + "/rest/getType.do", bodyMap1, List.class);
                   String tpName = (String) t.get(0).get("tpNm");
//                    Map<String, Object> pp = new HashMap<>();
//                   pp.put("prdName", prdName);
//                    pp.put("tpName", tpName);
                   list.get(i).put("prdName", prdName);
                   list.get(i).put("tpName", tpName);
                   list1=list;
               }
           }
        if(params.get("tpCd")!=null && params.get("prdNo")!=null) {
            List<Map<String, Object>> list2 = presentMapper.getBuyZeng(params);
            for (int i = 0; i < list2.size(); i++) {
                String gPrdNo = (String) (list2.get(i).get("gPrdNo"));
                if (gPrdNo == null) {
                    break;
                }
                RestTemplate restTemplate = new RestTemplate();
                MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
                bodyMap.add("prdNo", gPrdNo);
                Map<String, Object> p = restTemplate.postForObject(HOST_URL_PRD + "/rest/getPrd.do", bodyMap, Map.class);
                String prdName = (String) p.get("prdName");
                System.out.println(prdName);
                String tpCd = (String) p.get("tpCd");
                MultiValueMap<String, Object> bodyMap1 = new LinkedMultiValueMap<String, Object>();
                bodyMap1.add("tpCd", tpCd);
                List<Map<String, Object>> t = restTemplate.postForObject(HOST_URL_PRD + "/rest/getType.do", bodyMap1, List.class);
                String tpName = (String) t.get(0).get("tpNm");
//                    Map<String, Object> pp = new HashMap<>();
//                   pp.put("prdName", prdName);
//                    pp.put("tpName", tpName);
                list2.get(i).put("prdName", prdName);
                list2.get(i).put("tpName", tpName);
                list1 = list2;
            }
        }
        if(params.get("tpCd")!=null && params.get("prdNo")==null) {
            RestTemplate restTemplate = new RestTemplate();
            MultiValueMap<String, Object> bodyMap2 = new LinkedMultiValueMap<String, Object>();
            bodyMap2.add("tpCd",params.get("tpCd"));
            bodyMap2.add("isGifts","Yes");
            List<Map<String, Object>> list = restTemplate.postForObject(HOST_URL_PRD + "/rest/getGifts.do",bodyMap2, List.class);
            params.put("prdNo",list.get(0).get("prdNo"));
            List<Map<String, Object>> list3 = presentMapper.getBuyZeng(params);
            for (int i = 0; i < list3.size(); i++) {
                String gPrdNo = (String) (list3.get(i).get("gPrdNo"));
                if (gPrdNo == null) {
                    break;
                }
                MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
                bodyMap.add("prdNo", gPrdNo);
                Map<String, Object> p = restTemplate.postForObject(HOST_URL_PRD + "/rest/getPrd.do", bodyMap, Map.class);
                String prdName = (String) p.get("prdName");
                System.out.println(prdName);
                String tpCd = (String) p.get("tpCd");
                MultiValueMap<String, Object> bodyMap1 = new LinkedMultiValueMap<String, Object>();
                bodyMap1.add("tpCd", tpCd);
                List<Map<String, Object>> t = restTemplate.postForObject(HOST_URL_PRD + "/rest/getType.do", bodyMap1, List.class);
                String tpName = (String) t.get(0).get("tpNm");
                list3.get(i).put("prdName", prdName);
                list3.get(i).put("tpName", tpName);
                list1 = list3;
            }
        }
            PageInfo<Map<String,Object>> pageInfo =new PageInfo<Map<String,Object>>(list1);
            return pageInfo;
    }

    @Override
    public void updateBuy(Map<String, Object> params) throws Exception {
        presentMapper.updateBuy(params);
    }
}
