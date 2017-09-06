package com.lanou.cn.service.impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lanou.cn.mapper.PerferentialMapper;
import com.lanou.cn.service.PerferentialService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 28/6/17.
 */
@Service
public class PerferentialServiceImpl implements PerferentialService {

	@Resource
	private PerferentialMapper perferentialMapper;

	/**
     * 查询优惠类型
     */
	@Override
	public List<Map<String,Object>> getContype() {
		return perferentialMapper.getContype();
	}
	/**
	 * 查询条件名称
	 * @return
	 */
	@Override
	public List<Map<String,Object>> getConditionName(Map<String,Object> params) {
		return perferentialMapper.getConditionName(params);
	}

	/**
	 * 添加优惠信息
	 */
	@Override
	public void addPerferential(Map<String, Object> params) {
		perferentialMapper.addPerferential(params);
	}

	/**
	 * 优惠分页查询
	 */
	@Override
	public PageInfo<Map<String,Object>> findPerferential(Map<String, Object> params){
		Integer currentPage = null == params.get("currentPage") ? 1 : Integer.parseInt((String) params.get("currentPage"));
		PageHelper.startPage(currentPage,5);
		List<Map<String,Object>> list =perferentialMapper.findPerferential(params);

		PageInfo<Map<String,Object>> pageInfo = new PageInfo<>(list);

		return pageInfo;
}
	/**
	 * 优惠条件查询
	 */
	@Override
	public List<Map<String,Object>> findConditionsName(Map<String, Object> params){
		return perferentialMapper.findConditionsName(params);
	}

	/**
	 * 优惠条件名称查询
	 */
	@Override
	public List<Map<String, Object>> getConName(Map<String, Object> params){

		return perferentialMapper.getConName(params);
	}

	/**
	 * 优惠信息修改
	 */
	public void preferentialUpdateFrom(Map<String, Object> params){
		perferentialMapper.perferentialUpdate(params);
	}
}
