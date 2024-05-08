package com.br.project.dao.pay;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.pay.PayDto;

import lombok.RequiredArgsConstructor;


@Repository
@RequiredArgsConstructor
public class PayDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	
	public int selectListCount() {
		return sqlSessionTemplate.selectOne("payMapper.selectListCount");
	}
	
	
	public List<PayDto> paymainPage(PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.paymainPage", null, rowBounds);
	}
	
	public int moreDateCount() {
		return sqlSessionTemplate.selectOne("payMapper.moreDateCount");
	}
	
	public int successListCount() {
		return sqlSessionTemplate.selectOne("payMapper.successListCount");
	}
	
	public int searchListCount(Map<String, String> map) {
		return sqlSessionTemplate.selectOne("payMapper.searchListCount", map);
	}
	
	public List<PayDto> searchList(PageInfoDto pi, Map<String, String> search){
		
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.searchList", search, rowBounds);
	}
	
	public int slistCount(Map<String, Object> params) {
		return sqlSessionTemplate.selectOne("payMapper.slistCount", params);
		
	}
	
	public int statusCount(String status) {
		return sqlSessionTemplate.selectOne("payMapper.slistCount", status);
		
	}
	
	public List<PayDto> categoryList(String conditions, PageInfoDto pi){
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.categoryList", conditions, rowBounds);
	}
	
	public List<PayDto> statusList(String status, PageInfoDto pi){
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.categoryList", status, rowBounds);
	}
	
	
	public PayDto mdetail(PayDto pDto) {
		return sqlSessionTemplate.selectOne("payMapper.mdetail", pDto);
	}
	
	public PayDto bdetail(PayDto pDto) {
		return sqlSessionTemplate.selectOne("payMapper.bdetail", pDto);
	}
	
	public PayDto jdetail(PayDto pDto) {
		return sqlSessionTemplate.selectOne("payMapper.jdetail", pDto);
	}
	
	public PayDto gdetail(PayDto pDto) {
		return sqlSessionTemplate.selectOne("payMapper.gdetail", pDto);
	}
	
	public PayDto vdetail(PayDto pDto) {
		return sqlSessionTemplate.selectOne("payMapper.vdetail", pDto);
	}
	
	public PayDto hdetail(PayDto pDto) {
		return sqlSessionTemplate.selectOne("payMapper.hdetail", pDto);
	}
	
	public PayDto cdetail(PayDto pDto) {
		return sqlSessionTemplate.selectOne("payMapper.cdetail", pDto);
	}
	
	public int allUserCount(String userName) {
		return sqlSessionTemplate.selectOne("payMapper.allUserCount",userName);
	}
	
	public List<PayDto> allUserList(String userName, PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.allUserList", userName, rowBounds);
	}
	
	
	
}
