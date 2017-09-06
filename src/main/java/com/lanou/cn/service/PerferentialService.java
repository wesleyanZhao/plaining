package com.lanou.cn.service;

import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;


/**
 * Created by admin on 28/6/17.
 */
public interface PerferentialService {

	/**
	 * 查询优惠类型
	 */
	List<Map<String,Object>> getContype();
	/**
	 * 查询条件名称
	 * @return
	 */
	List<Map<String,Object>> getConditionName(Map<String,Object> params);
	/**
	 * 添加优惠信息
	 */
	void addPerferential(Map<String,Object> params);

	/**
	 * 优惠分页查询
	 */
	PageInfo<Map<String,Object>> findPerferential(Map<String,Object> params);

	/**
	 * 优惠条件查询
	 */
	List<Map<String,Object>> findConditionsName(Map<String,Object> params);

	/**
	 * 优惠条件名称
	 */
	List<Map<String,Object>> getConName(Map<String,Object> params);
	/**
	 * 优惠信息修改
	 */
	void preferentialUpdateFrom(Map<String,Object> params);
}
