package com.lanou.cn.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;


/**
 * Created by admin on 28/6/17.
			*/
	public interface PerferentialMapper {

	/**
     * 查询优惠类型
     */
	@Select("select distinct con_type conType from sale_con")
	List<Map<String,Object>> getContype();
	/**
	 * 查询条件名称
	 * @return
	 */
	List<Map<String,Object>> getConditionName(@Param("params") Map<String,Object> params);
	/**
	 * 添加优惠信息
	 */
	void addPerferential(@Param("params") Map<String,Object> params);

	/**
	 * 优惠分页查询
	 */
	List<Map<String,Object>> findPerferential(@Param("params") Map<String,Object> params);

	/**
	 * 优惠条件查询
	 */
	List<Map<String,Object>> findConditionsName(@Param("params") Map<String,Object> params);

	/**
	 * 优惠条件名称
	 */
	List<Map<String,Object>> getConName(@Param("params") Map<String,Object> params);

	/**
	 * 优惠信息修改
	 */
	void perferentialUpdate(@Param("params") Map<String,Object> params);
}
