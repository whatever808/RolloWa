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
	
	//회원정보조회
	public String loginUserMember(int userNo){
		return sqlSessionTemplate.selectOne("payMapper.loginUserMember", userNo);
	}
	
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
		return sqlSessionTemplate.selectOne("payMapper.allUserCount", userName);
	}
	
	
	public int userSelectListCount(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("payMapper.userSelectListCount", map);
	}
	
	public List<PayDto> allUserList(String userName, PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.allUserList", userName, rowBounds);
	}
	
	public List<MemberDeptDto> selectDepartment(){
		return sqlSessionTemplate.selectList("payMapper.selectDepartment");
	}
	
	//동적쿼리 재사용
	public List<MemberDeptDto> selectloginUserDept(Map<String, Object> mapUserMember) {
		return sqlSessionTemplate.selectList("payMapper.selectDepartment", mapUserMember);
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
		return sqlSessionTemplate.selectList("payMapper.userSelectList", map, rowBounds);
	}
	
	public int userSearchCount(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("payMapper.userSearchCount", map);
	}
	
	public List<PayDto> userSearchList(Map<String, Object> map, PageInfoDto pi){
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage() - 1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("payMapper.userSearchList", map, rowBounds);
	}
	
	public int mReportUpdate(Map<String, Object> map) {
		return sqlSessionTemplate.update("payMapper.mReportUpdate", map);
	}
	
	public int updateMreport(Map<String, Object> map) {
		return sqlSessionTemplate.update("payMapper.updateMreport", map);
	}
	
	//아이템품목 지우고 = > insert
	public int deleteReport(Map<String, Object> map) {
		return sqlSessionTemplate.delete("payMapper.deleteReport", map);
	}
	//insert
	public int updateInsertItems(Map<String, Object> item) {
		return sqlSessionTemplate.update("payMapper.updateInsertItems", item);
	}
	
	public int updateApproval(Map<String, Object> map) {
		return sqlSessionTemplate.update("payMapper.updateApproval", map);
	}
	
	//기안서 sales_report insert
	public int gReportInsert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.gReportInsert", map);
	}
	
	//기안서 첨부파일 insert
	public int gReportAttachInsert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.gReportAttachInsert", map);
	}
	
	//기안서 공동테이블 (approval)
	public int gReportApprovalInsert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.gReportApprovalInsert", map);
	}
	
	//기안서 상세페이지
	public List<Map<String, Object>> salesDetail(Map<String, Object> map){
		return sqlSessionTemplate.selectList("payMapper.salesDetail", map);
	}
	
	//로그인한 사용자의 완료함갯수
	public List<PayDto> ApprovedList(PageInfoDto pi, String userName){
		RowBounds rowBounds = new RowBounds( (pi.getCurrentPage() -1) * pi.getListLimit(), pi.getListLimit() ); 
		return sqlSessionTemplate.selectList("payMapper.paymainPage" , userName, rowBounds);
	}
	
	//1_1)비품신청서 등록
	public int insertBreport(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.insertBreport", map);
	}
		
	//1_2)비품 아이템 등록
	public int insertItemsB(Map<String, Object> item) {
		return sqlSessionTemplate.insert("payMapper.insertItemsB", item);
	}
	
	//1_3)공통테이블 등록 (코드재활용)
	public int bReportApprovalInsert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.bReportApprovalInsert", map);
	}
	
	// 비품신청서 상세페이지
	public List<Map<String, Object>> fixDetail(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("payMapper.fixDetail", map);
	}
	
	
	//1_1) 휴가신청서 등록
	public int hReportInsert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.hReportInsert", map);
	}
	
	//1_2) 결재공동테이블 등록
	public int hReportApprovalInsert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.hReportApprovalInsert", map);
	}
	
	
	// 휴가신청서 상세페이지
	public List<Map<String, Object>> retireDetail(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("payMapper.retireDetail", map);
	}
	
	//1_1)지출결의서 등록
	public int insertJreport(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.insertJreport", map);

	}
	
	//1_2)지출결의서 item테이블 등록
	public int insertItemsJ(Map<String, Object> item) {
		return sqlSessionTemplate.insert("payMapper.insertItemsJ", item);
	}
	
	//1_3)지출결의서 결재이력공동테이블 등록
	public int jReportApprovalInsert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.jReportApprovalInsert", map);
	}
	
	//1_4)지출결의서 파일 등록하기
	public int jReportAttachInsert(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.jReportAttachInsert", map);
	}
	
	//1.지출결의서 리스트 불러오기
	public List<Map<String, Object>> draftDetail(Map<String, Object> map){
		return sqlSessionTemplate.selectList("payMapper.draftDetail", map);
	}
	
	
	//지출결의서 수정하기페이지 (리스트불러오기)
	public List<Map<String, Object>> draftModify(Map<String, Object> map){
		return sqlSessionTemplate.selectList("payMapper.draftDetail", map);
	}
	
	//-------------------
	//지출결의서 업데이트
	public int updateJReport(Map<String, Object> map) {
		return sqlSessionTemplate.update("payMapper.updateJReport", map);
	}
	
	//지출결의서 아이템 품목 등록하기전에 삭제하기
	public int deleteJItem(Map<String, Object> map) {
		return sqlSessionTemplate.delete("payMapper.deleteJItem", map);
	}
	
	//지출결의서 아이템품목 등록 재사용
	
	//파일등록하기전에 기존파일 삭제한거있으면 삭제
	public int deleteAttachment(String[] delFileNo) {
		return sqlSessionTemplate.delete("payMapper.deleteAttachment", delFileNo);
	}
	
	//새로운 파일 등록하기
	public int insertAttachment(Map<String, Object> map) {
		return sqlSessionTemplate.insert("payMapper.insertAttachment", map);
	}
	//-------------------
	
}
