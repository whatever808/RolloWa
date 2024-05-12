package com.br.project.dao.pay;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.pay.MemberDeptDto;
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
	
	
	public int moreDateCount(String userName) {
		return sqlSessionTemplate.selectOne("payMapper.moreDateCount", userName);
	}
	
	public int successListCount(String userName) {
		return sqlSessionTemplate.selectOne("payMapper.successListCount", userName);
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
	
	public List<PayDto> categoryList(Map<String, Object> params, PageInfoDto pi){
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.categoryList", params, rowBounds);
	}
	
	
	public List<Map<String, Object>> expendDetail(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("payMapper.expendDetail", map);
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
	
	public List<MemberDeptDto> selectDepartment(){
		return sqlSessionTemplate.selectList("payMapper.selectDepartment");
	}
	
	//동적쿼리 재사용
	public List<MemberDeptDto> selectloginUserDept(MemberDto loginMember) {
		return sqlSessionTemplate.selectList("payMapper.selectDepartment", loginMember);
	}
	
	//1.매출보고서 등록
	public int insertMreport(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.insertMreport", map);
	}
	
	//2.품목공동테이블 등록
	public int insertItems(Map<String, Object> item) {
		return sqlSessionTemplate.insert("payMapper.insertItems", item);
	}
	
	//3.결재공동테이블 등록
	public int insertApproval(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.insertApproval", map);
	}
	
	
	//반려
	public int updateReject(Map<String, Object> map) {
		return sqlSessionTemplate.update("payMapper.updateReject", map);
	}
	
	//수정하기(매출)
	public List<Map<String, Object>> expendModify(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("payMapper.expendDetail", map);
	}
	
	//로그인한 유저가 승인자일때 전체결재리스트
	public List<PayDto> userSelectList(Map<String, Object> map, PageInfoDto pi){
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.allUserList", map, rowBounds);
	}
	
}
