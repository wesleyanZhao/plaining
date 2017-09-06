package com.lanou.cn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lanou.cn.mapper.PlanInfoMapper;
import com.lanou.cn.service.PlanInfoService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by zhaoce on 17/7/25.
 */
@Service
public class PlanInfoServiceImpl implements PlanInfoService{

    public static final String HOST_URL_PRD_NO = "http://192.168.2.1:8180";
    public static final String HOST_URL_PRD = "http://192.168.2.9:8888";

    @Resource
    private PlanInfoMapper planInfoMapper;

    @Override
    public List<Map<String, Object>> findConNo() {
        return planInfoMapper.findConNo();
    }

    @Override
    public List<Map<String, Object>> findDisNo(String conNo) {
        return planInfoMapper.findDisNo(conNo);
    }

    @Override
    public Map<String, Object> findConType(String conNo) {
        return planInfoMapper.findConType(conNo);
    }

    @Override
    public List<Map<String, Object>> findGNo(String conNo) {
        return planInfoMapper.findGNo(conNo);
    }

    @Override
    public List<Map<String, Object>> findTpCd() {
        return planInfoMapper.findTpCd();
    }

    @Override
    public List<Map<String, Object>> findLmtNo() {
        return planInfoMapper.findLmtNo();
    }

    @Override
    @Transactional
    public void addPlanInfoForm(Map<String, Object> params) {
        System.out.println("params:::::"+params);
        planInfoMapper.addPlanInfoForm(params);
        params.put("id",params.get("id"));
        String cpnContent = (String) params.get("cpnContent");
        System.out.println(cpnContent);
        if(null != cpnContent && "" != cpnContent) {
            planInfoMapper.addPlanCpn(params);
        }
        String tpCd = (String) params.get("tpCd");
        //List<Map<String,Object>> resultPrdNo = planInfoMapper.findPrdNo(tpCd);

        RestTemplate restTemplate=new RestTemplate();
        MultiValueMap<String,String> bodyMap=new LinkedMultiValueMap<>();
        bodyMap.add("tpCd",tpCd);
        List<Map<String,Object>> resultPrdNo = restTemplate.postForObject(HOST_URL_PRD + "/rest/getGifts.do",bodyMap,List.class);

        for(int i = 0;i < resultPrdNo.size();i++) {
            String prdNo = (String) resultPrdNo.get(i).get("prdNo");
            params.put("prdNo",prdNo);
            planInfoMapper.addSaleProR(params);
        }
    }

    @Override
    public PageInfo<Map<String, Object>> planInfoPage(Map<String, Object> params) {
        Integer currentPage = params.get("currentPage") == null ? 1:Integer.parseInt((String)params.get("currentPage"));
        PageHelper.startPage(currentPage, 5);
        List<Map<String,Object>> list = planInfoMapper.planInfoPage(params);
        PageInfo<Map<String,Object>> page = new PageInfo<Map<String,Object>>(list);
        return page;
    }

    @Override
    public Map<String, Object> findPlanInfoById(String pbId) {
        return planInfoMapper.findPlanInfoById(pbId);
    }

    @Override
    @Transactional
    public void updatePlanInfoForm(Map<String,Object> params) {
        planInfoMapper.updatePlanInfoForm(params);
        System.out.println("++++++++++++"+params);
        String spNo = (String) params.get("spNo");
        String cpnNo = (String) params.get("cpnNo");
        Map<String,Object> result = planInfoMapper.findSpNoInPCR(spNo);
        if(CollectionUtils.isEmpty(result)){
            if(null != cpnNo && "" != cpnNo) {
                planInfoMapper.addPlaCpnR(params);
            }
        }else {
            planInfoMapper.updatePlaCpnR(params);
        }
    }

    @Override
    public List<Map<String, Object>> findCpnNo() {
        return planInfoMapper.findCpnNo();
    }
}
