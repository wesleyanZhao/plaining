package com.lanou.cn.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * Created by admin on 28/6/17.
 */
public interface SaleMapper {
	/**
	 * 查询数据库
	 * 返回页面所需数据
	 * @return
	 */
	@Select("select id supId,sup_name supName from sup_info_syn")
	List<Map<String,Object>> selectSup();

	/**
	 * 添加数据入数据库
	 * @param params
	 */
	void insertSaleValue(@Param("params") Map<String,Object> params);

	/**
	 * 分页数据
	 * @param params
	 * @return
	 */
	List<Map<String,Object>> saleManagePage(@Param("params") Map<String,Object> params);

	/**
	 * 查询
	 * 修改页面所需数据
	 * @param id
	 * @return
	 */
	Map<String,Object> saleSelectUpdata(@Param("id") int id);

	/**
	 * 更新数据库
	 * @param params
	 */
	void saleUpdata(@Param("params") Map<String,Object> params);
}
