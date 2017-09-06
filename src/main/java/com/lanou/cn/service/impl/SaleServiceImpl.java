package com.lanou.cn.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.lanou.cn.mapper.SaleMapper;
import com.lanou.cn.service.SaleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by admin on 28/6/17.
 */
@Service
public class SaleServiceImpl implements SaleService{
	@Resource
	private SaleMapper saleMapper;

	@Override
	public List<Map<String, Object>> selectSup() {
		List<Map<String,Object>> result=saleMapper.selectSup();
		return result;
	}

	@Override
	public void insertSaleValue(Map<String, Object> params) {
		saleMapper.insertSaleValue(params);
	}

	@Override
	public PageInfo<Map<String, Object>> saleManagePage(Map<String, Object> params) {
		Integer currentPage = params.get("currentPage") == null ? 1:Integer.parseInt((String)params.get("currentPage"));
		//Integer size = params.get("size") == null ? 5:Integer.parseInt((String)params.get("size"));
		PageHelper.startPage(currentPage, 5);
		List<Map<String,Object>> list = saleMapper.saleManagePage(params);
		//用PageInfo对结果进行包装
		PageInfo<Map<String,Object>> page = new PageInfo<Map<String,Object>>(list);
		return page;
	}

	@Override
	public Map<String, Object> saleSelectUpdata(int id) {
		Map<String,Object>	params=saleMapper.saleSelectUpdata(id);
		return params;
	}

	@Override
	public void saleUpdata(Map<String, Object> params) {
		saleMapper.saleUpdata(params);
	}
}
