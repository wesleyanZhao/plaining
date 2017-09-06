package com.lanou.cn;

import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by landfash on 2017/7/13.
 */
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = { "classpath*:spring/spring-context.xml" })
public class Test {

    public static void getGifts() {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        List<Map<String,Object>> list = new ArrayList<>();
        Map<String,Object> map = new HashMap<>();
        map.put("prdDtlNo","15038110");
        map.put("spNo","10026");
        map.put("price","4444");
        map.put("num","4");
//        bodyMap.add("spNo",1001);
//        bodyMap.add("price",4444);
//        bodyMap.add("prdDtlNo","10011");params.get("level")
//        bodyMap.add("spNo","1002");
        //level
//        bodyMap.add("salePriceEnd",5000);
//        bodyMap.add("ip","192.168.2.2 ");
        list.add(map);
        bodyMap.add("product",list);
        Map<String,Object> result = restTemplate.postForObject("http://localhost:8088/rest/getGifts.do",bodyMap, Map.class);
        System.out.println(result);
    }
    public static void getPlanning() {
        RestTemplate restTemplate = new RestTemplate();
        MultiValueMap<String, Object> bodyMap = new LinkedMultiValueMap<String, Object>();
        List<Map<String,Object>> list = new ArrayList<>();
        Map<String,Object> product = new HashMap<>();
        product.put("prdDtlNo","10011");
        product.put("price","4444");
        list.add(product);
        bodyMap.add("product",list);
        bodyMap.add("level",4);
//        bodyMap.add("spNo",3);
//        bodyMap.add("price",4444);
//        bodyMap.add("prdDtlNo","10011");
//        bodyMap.add("salePriceEnd",5000);
//        bodyMap.add("ip","192.168.2.2 ");
        Map<String,Object> result = restTemplate.postForObject("http://localhost:8088/rest/getPlanning.do",bodyMap, Map.class);
        System.out.println(result);
    }



    public static void main(String[] args){
      getGifts();
//        getPlanning();

    }
}
