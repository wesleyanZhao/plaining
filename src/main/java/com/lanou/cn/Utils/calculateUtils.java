package com.lanou.cn.Utils;

import java.math.BigDecimal;

/**
 * Created by lanou on 2017/7/26.
 */
public class calculateUtils {

    public static Double mul(Double num1,Double num2){
        BigDecimal a = new BigDecimal(num1.toString());
        BigDecimal b = new BigDecimal(num2.toString());
        return a.multiply(b).doubleValue();
    }

    public static Double sub(Double num1,Double num2){
        BigDecimal a = new BigDecimal(num1.toString());
        BigDecimal b = new BigDecimal(num2.toString());
        return a.subtract(b).doubleValue();
    }

    public static Double add(Double num1,Double num2){
        BigDecimal a = new BigDecimal(num1.toString());
        BigDecimal b = new BigDecimal(num2.toString());
        return a.add(b).doubleValue();
    }

    public static Double div(Double num1,Double num2){
        BigDecimal a = new BigDecimal(num1.toString());
        BigDecimal b = new BigDecimal(num2.toString());
        return a.divide(b,2,BigDecimal.ROUND_HALF_EVEN).doubleValue();
    }
}
