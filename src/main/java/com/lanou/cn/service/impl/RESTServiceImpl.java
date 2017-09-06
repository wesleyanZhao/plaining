package com.lanou.cn.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.lanou.cn.Utils.calculateUtils;
import com.lanou.cn.mapper.RESTMapper;
import com.lanou.cn.service.RESTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
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
public class RESTServiceImpl implements RESTService {

    public static final String HOST_URL_PRD = "http://192.168.2.9:8888";

    @Resource
    private RESTMapper restMapper;

    @Autowired
    @Qualifier("planRedis")
    private RedisTemplate planRedis;

    //如果限额类型为毛利，计算优惠之后的毛利是否大于设定毛利率
    private boolean get(Double price,List<Map<String,Object>> saleWay,List<Map<String,Object>> plan,Map<String,Object> params,int j){
        if(price>(Double.parseDouble((String)saleWay.get(0).get("conValue")))){
            String disNo = (String)plan.get(j).get("disNo");
            List<Map<String,Object>> disInfo = restMapper.getPre(disNo);//优惠信息
            double disValue = (int)disInfo.get(0).get("disValue");//优惠值
            Double temp = price;
            temp = calculateUtils.sub(temp,disValue);
            double iptPrice = (int)params.get("prdDtlIptPrice");//明细价格
            double num = Integer.parseInt((String)params.get("num"));
            double ctrlRate = (double)params.get("ctrlRate");//毛利率
            if(calculateUtils.div(calculateUtils.sub(temp,calculateUtils.mul(iptPrice,num)),iptPrice)>=ctrlRate){
                return true;
            }
        }
        return false;
    }

    //参数：价格price 商品数量num 企划编号spNo
    @Override
    public Map<String, Object> getGifts(Map<String, Object> params) {
        String pro = (String) params.get("product");
        Map<String,Object> product  = ((List<Map<String,Object>>) JSONArray.parse(pro)).get(0);
        List<Map<String,Object>> plan = restMapper.getSaleWay(product);//获得对应企划信息（促销 优惠 买赠）
        Double price = Double.parseDouble(product.get("price").toString());
        Map<String,Object> result = new HashMap<>();
        List<Map<String,Object>> gifts = new ArrayList<>();//声明用于保存赠品商品信息的集合
        String conNo = (String)plan.get(0).get("conNo");
        List<Map<String,Object>> saleWay = restMapper.getCon(conNo);//获得促销条件的信息
        if("10".equals((String)saleWay.get(0).get("conType"))){
            String disNo = (String)plan.get(0).get("disNo");//优惠编号
            List<Map<String,Object>> disInfo = restMapper.getPre(disNo);//优惠信息

//            if(null != plan.get(0).get("lmtNo") && (!"".equals(plan.get(0).get("lmtNo")))){
//                String lmtNo = (String)plan.get(0).get("lmtNo");
//                List<Map<String,Object>> lmtInfo = restMapper.getLmt(lmtNo);
//                String lmtType = (String)lmtInfo.get(0).get("lmtNo");
//                if("10".equals(lmtType)){
//
//                }
//            }

            double disValue = (double)disInfo.get(0).get("disValue");
            price = calculateUtils.sub(price,disValue);
            result.put("conType","10");
            result.put("price",price);
        }
        if("20".equals((String)saleWay.get(0).get("conType"))){
            String gNo = (String)plan.get(0).get("gNo");
            List<Map<String,Object>> prdNo = restMapper.getGiftsNo(gNo);//获得赠品商品的编号
            RestTemplate restTemplate = new RestTemplate();
            MultiValueMap<String,Object> bodyMap = new LinkedMultiValueMap<>();
            bodyMap.add("prdNo",prdNo.get(0).get("gPrdNo"));
            Map<String,Object> prdInfo = restTemplate.postForObject(HOST_URL_PRD + "/rest/getPrd.do",bodyMap,Map.class);//调用接口获得对应商品编号的商品信息
            if(null != plan.get(0).get("lmtNo") && (!"".equals(plan.get(0).get("lmtNo")))){//判断是否有限额
                String lmtNo = (String)plan.get(0).get("lmtNo");
                List<Map<String,Object>> lmtInfo = restMapper.getLmt(lmtNo);//获得限额信息
                String lmtType = (String)lmtInfo.get(0).get("lmtType");//限额类型
                if("10".equals(lmtType)){
                    Integer num = (Integer) lmtInfo.get(0).get("lmtCount");//获得限额数量
                    int buyNum = Integer.parseInt((String)product.get("num"));
                    if(num >= buyNum){
                        for(int i = 0 ; i < buyNum ; i ++){
                            gifts.add(prdInfo);//同一个商品的赠品应该相同
                        }
                    }else{
                        for(int i = 0 ; i < 10 ; i ++){
                            gifts.add(prdInfo);
                        }
                    }
                }
            }else{
                for(int i = 0 ; i < Integer.parseInt((String)product.get("num")) ; i ++){
                    gifts.add(prdInfo);
                }
            }
            result.put("conType","20");
            result.put("gifts",gifts);
        }
        if("30".equals((String)saleWay.get(0).get("conType"))){
            String disNo = (String)plan.get(0).get("disNo");//优惠编号
            List<Map<String,Object>> disInfo = restMapper.getPre(disNo);//优惠信息
            result.put("conType","30");
            result.put("backMoney",disInfo.get(0).get("disValue"));
        }
        if("40".equals((String)saleWay.get(0).get("conType"))){
            String disNo = (String)plan.get(0).get("disNo");
            List<Map<String,Object>> disInfo = restMapper.getPre(disNo);
            double disValue = (double)disInfo.get(0).get("disValue");
            price = calculateUtils.sub(price,disValue);
            result.put("conType","40");
            result.put("price",price);
        }
        if("50".equals((String)saleWay.get(0).get("conType"))){
            String disNo = (String) plan.get(0).get("disNo");
            List<Map<String,Object>> disInfo = restMapper.getPre(disNo);
            double disValue = (double)disInfo.get(0).get("disValue");
            price = calculateUtils.mul(price,disValue);
            result.put("conType","50");
            result.put("price",price);
        }
        if("60".equals((String)saleWay.get(0).get("conType"))){
            String disNo = (String)plan.get(0).get("disNo");
            List<Map<String,Object>> disValue = restMapper.getPre(disNo);
            result.put("conType","60");
            result.put("doubleIntegral",disValue.get(0).get("disValue"));
        }
        return result;
    }

    //参数：毛利率ctrlRate 商品编号prdNo 商品价格price 明细商品成本prdDtlIptPrice
    @Override
    public Map<String, Object> getPlanning(Map<String, Object> params) {
        Map<String,Object> allPlaProduct = new HashMap<>();
//        int level = (Integer) params.get("level") ;
        int level = (int)params.get("level");
        List<Map<String,Object>> productInfo = (List<Map<String,Object>>) params.get("product");
        for(int i = 0 ; i < productInfo.size() ; i ++){
            Double price = (double)productInfo.get(i).get("price");
            if(level==2){
                price = calculateUtils.mul(price,0.98);
            }else if(level == 3){
                price = calculateUtils.mul(price,0.96);
            }else if(level == 4){
                price = calculateUtils.mul(price,0.94);
            }else if(level == 5){
                price = calculateUtils.mul(price,0.92);
            }
            productInfo.get(i).put("price",price);
        }

        List<Map<String,Object>> productList = (List<Map<String,Object>>) params.get("product");//获得所有商品相关信息
        List<Map<String,Object>> cpnList = new ArrayList<>();//声明用来放代金券的集合
        List<Map<String,Object>> productPlaList = new ArrayList<>();//声明用来存放商品对应所有企划信息
        outer:for(int i = 0 ; i < productList.size() ; i++){//循环查每个商品对应的企划及代金券
            Map<String,Object> product = productList.get(i);//获得某一个商品详细信息
            product.put("level",level);//商品信息集合中加入会员等级
            String prdNo = (String) product.get("prdNo");
            List<Map<String,Object>> planRedislist = (List<Map<String, Object>>) planRedis.opsForValue().get("plan_"+prdNo);
            List<Map<String,Object>> plan = null;
            if(CollectionUtils.isEmpty(planRedislist)){
                plan = restMapper.getPlan(product);//获得对应商品的所有企划信息
            }else{
                plan = planRedislist;
                planRedis.opsForValue().set("plan_"+prdNo,plan);
            }
//            List<Map<String,Object>>
            List<Map<String,Object>> planList = new ArrayList<>();//声明用来存放对应商品能参加的企划
            Double price = (double)productList.get(i).get("price");
            for(int j = 0 ; j < plan.size() ; j ++){//循环查找每一个企划信息对应的可用代金券
                String conNo = (String)plan.get(j).get("conNo");
                List<Map<String,Object>> saleWay = restMapper.getCon(conNo);//获得促销条件的信息
                if(null != plan.get(j).get("lmtNo") && !("".equals(plan.get(j).get("lmtNo")))){//判断是否有限额
                    String lmtNo = (String)plan.get(j).get("lmtNo");
                    List<Map<String,Object>> lmtInfo = restMapper.getLmt(lmtNo);//获得限额信息
                    String lmtType = (String)lmtInfo.get(0).get("lmtType");//限额类型
                    if("20".equals(lmtType)){//如果限额类型为毛利
                        if("10".equals((String)saleWay.get(0).get("conType"))){
                            if(!get(price,saleWay,plan,product,j)){
                                continue ;
                            }
                        }
                        if("30".equals((String)saleWay.get(0).get("conType"))){
                            if(!get(price,saleWay,plan,product,j)){
                                continue ;
                            }
                        }
                        if("40".equals((String)saleWay.get(0).get("conType"))){
                            if(!get(price,saleWay,plan,product,j)){
                                continue ;
                            }
                        }
                        if("50".equals((String)saleWay.get(0).get("conType"))){
                            if(price>(Double.parseDouble((String)saleWay.get(0).get("conValue")))){
                                String disNo = (String)plan.get(j).get("disNo");
                                List<Map<String,Object>> disInfo = restMapper.getPre(disNo);//优惠信息
                                double disValue = (double)disInfo.get(0).get("disValue");
                                Double temp = price;
                                temp = calculateUtils.mul(temp,disValue);
                                double iptPrice = (double)product.get("prdDtlIptPrice");
                                double num = Integer.parseInt(product.get("num").toString());
                                double ctrlRate = (double)product.get("ctrlRate");
                                if(!(calculateUtils.div(calculateUtils.sub(temp,calculateUtils.mul(iptPrice,num)),iptPrice)>=ctrlRate)){
                                    continue ;
                                }
                            }
                        }
                    }
                }
                if(Integer.parseInt((String)plan.get(j).get("conValue"))<=price){//判断商品价格是否满足企划限制
                    for(Map<String,Object> cpn : restMapper.getCpn(product)){//将企划中的可用代金券都加入集合cpnList中
                        cpnList.add(cpn);
                    }
                    if("n".equals((String)plan.get(j).get("segment"))){//判断此促销条件对应的企划是否与其他企划共存
//                        for(Map<String,Object> cpn : restMapper.getCpn(product)){//将不共存的企划中的可用代金券都加入集合cpnList中
//                            cpnList.add(cpn);
//                        }
                        planList.add(plan.get(j));//将不可共存的企划存入集合
                        product.put("plan",planList);//给对应商品加上对应企划信息
                        productPlaList.add(product);//将此商品的不可共存的企划加入集合
                        continue outer;
                    }else{
                        planList.add(plan.get(j));//将此商品能参加的企划加入集合
                    }
                }
            }
            product.put("plan",planList);//给对应商品加上对应所有企划信息
            productPlaList.add(product);//完成对应商品的企划信息的添加
        }
        List<Map<String,Object>> cpn = new ArrayList<>();//声明用来存放最后确定商品可用的代金券集合
        if(cpnList.size()>0){
            cpn.add(cpnList.get(0));
            outer:for(int i = 1 ; i < cpnList.size() ; i ++){
                for(int j = 0 ; j < cpn.size() ; j ++){
                    if(((String)cpn.get(j).get("cpnNo")).equals((String)cpnList.get(i).get("cpnNo"))){
                        continue outer;
                    }
                }
                cpn.add(cpnList.get(i));
            }
        }
        List<Map<String,Object>> finCpn = new ArrayList<>();
        List<Map<String,Object>> vipCpn = (List<Map<String,Object>>) params.get("vipCpn");//用户可用的代金券
        if(cpn.size()>0){
            outer:for(int i = 0 ; i < cpn.size() ; i ++){
                if(vipCpn.size()>0){
                    for(int j = 0 ; j < vipCpn.size() ; j ++){
                        String cpnStr = (String) cpn.get(i).get("cpnNo");
                        String vipCpnStr = (String) vipCpn.get(j).get("cpnNo");
                        if(cpnStr.equals(vipCpnStr)){
                            break ;
                        }
                    }
                    finCpn.add(cpn.get(i));//保存用户可用的代金券且商品可用的代金券的交集
                }
            }
        }
        double onePrice = 0;
        double number = 0 ;
        for(int i = 0 ; i < productInfo.size() ; i ++){
            double tempPrice = Double.parseDouble(productInfo.get(i).get("salePrice").toString());
            double tempNum = Double.parseDouble(productInfo.get(i).get("num").toString());
            onePrice = calculateUtils.add(onePrice,calculateUtils.mul(tempPrice,tempNum));
        }
        List<Map<String,Object>> cpnCan = new ArrayList<>();
        outer:for(int i = 0 ; i < finCpn.size() ; i++){
            for(int j = 0 ; j < vipCpn.size() ; j++){
                double tempCpnLimit = (double)vipCpn.get(j).get("cpnLimit");
                if(((String)finCpn.get(i).get("cpnNo")).equals((String)vipCpn.get(j).get("cpnNo"))){
                    if(tempCpnLimit<=onePrice){
                        cpnCan.add(vipCpn.get(j));
                        continue outer;
                    }
                }
            }
        }

        allPlaProduct.put("cpn",cpnCan);//装所有代金券信息
        allPlaProduct.put("productPlan",productPlaList);//装所有对应商品对应所有企划信息
        return allPlaProduct;
    }


}
