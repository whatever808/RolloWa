package com.br.project.service.pay;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.br.project.dao.pay.PayDao;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.pay.MemberDeptDto;
import com.br.project.dto.pay.PayDto;
import com.br.project.dto.pay.SignDto;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class PayService {
	
	private final PayDao payDao;
	
	//회원정보조회
	public String loginUserMember(int userNo){
		return payDao.loginUserMember(userNo);
	}
	
	
	//결재메인페이지 목록갯수조회용
	public int selectListCount() {
		return payDao.selectListCount();
	}
	
	//결재메인페이지 리스트조회용
	public List<PayDto> paymainPage(PageInfoDto pi){
		return payDao.paymainPage(pi);
	}
	
	
	//일주일이상승인완료가 안된 게시글총갯수
	public int moreDateCount(String userName) {
		return payDao.moreDateCount(userName);
	}
	
	// 결재완료된 목록갯수
	public int successListCount(String userName) {
		return payDao.successListCount(userName);
	}
	
	// 카테고리별 '검색한' 총리스트갯수
	public int searchListCount(Map<String, String> map) {
		return payDao.searchListCount(map);
	}
	// 카테고리별 '검색한' 리스트
	public List<PayDto> searchList(PageInfoDto pi, Map<String, String> search){
		return payDao.searchList(pi, search);
	}
	
	//카테고리별 총리스트갯수(문서)
	public int slistCount(Map<String, Object> params) {
		return payDao.slistCount(params);
	}
	
	//카테고리별 리스트(문서)
	public List<PayDto> categoryList(Map<String, Object> params, PageInfoDto pi) {
		return payDao.categoryList(params, pi);
	}
	
	
	//결재메인페이지 조회(매출보고서)
	public List<Map<String, Object>> expendDetail(Map<String, Object> map) {	
		return payDao.expendDetail(map);	
	}
	
	//결재메인페이지 조회(비품신청서)
	public PayDto bdetail(PayDto pDto) {		
		return payDao.bdetail(pDto);
	}
	
	//결재메인페이지 조회(지출결의서)
	public PayDto jdetail(PayDto pDto) {	
		return payDao.jdetail(pDto);	
	}
	
	//결재메인페이지 조회(기안서)
	public PayDto gdetail(PayDto pDto) {	
		return payDao.gdetail(pDto);	
	}
		
	//결재메인페이지 조회(휴가신청서)
	public PayDto vdetail(PayDto pDto) {	
		return payDao.vdetail(pDto);	
	}
	
	//결재메인페이지 조회(휴직신청서)
	public PayDto hdetail(PayDto pDto) {	
		return payDao.hdetail(pDto);	
	}
	
	//결재메인페이지 조회(출장보고서)
	public PayDto cdetail(PayDto pDto) {	
		return payDao.cdetail(pDto);	
	}
	
	//결재메인페이지 사용자 결재리스트갯수
	public int allUserCount(String userName) {
		return payDao.allUserCount(userName);
	}
	
	//결재메인페이지 전체수신결재함-카테고리선택 갯수
	public int userSelectListCount(Map<String, Object> map) {
		return payDao.userSelectListCount(map);
	}
	//결재메인페이지 사용자 결재리스트
	public List<PayDto> allUserList(String userName, PageInfoDto pi) {
		return payDao.allUserList(userName, pi);
	}
	
	//결재 작성 페이지 부서 리스트
	public List<MemberDeptDto> selectDepartment(){
		return payDao.selectDepartment();
	}
	//보고서작성시 로그인한 회원의 부서, 번호, 이름, 팀이름, 직급이 담겨있음
	public List<MemberDeptDto> selectloginUserDept(Map<String, Object> mapUserMember) {
		return payDao.selectloginUserDept(mapUserMember);
	}
	
	
	//매출보고서 등록
	public int mReportInsert(Map<String, Object> map, List<Map<String, Object>> list) {
		
		//1.매출보고서테이블 등록
		int result2 = payDao.insertMreport(map);
		//2.품목공동테이블 등록
		int result1 = 1;
			if(!list.isEmpty()) {
				result1 = 0;
				for (Map<String, Object> item : list) { 

					result1 += payDao.insertItems(item);
				}				
			}
		//3.결재이력공동테이블 등록
	    int result3 = payDao.insertApproval(map);
			
		return result1 * result2 * result3;
	}
	
	//반려하기------
	public int ajaxUpdateReject(Map<String, Object> map) {
		return payDao.ajaxUpdateReject(map);		
	}
	
	
	//상세페이지 수정하기-----(첫번째 승인자의 승인날짜값이 null일때 수정가능)
	public List<Map<String, Object>> expendModify(Map<String, Object> map){
		return payDao.expendModify(map);
	}
	
	//로그인한 유저가 승인자일때 전체결재리스트
	public List<PayDto> userSelectList(Map<String, Object> map, PageInfoDto pi){
		return payDao.userSelectList(map, pi);
	}
	
	//ㅇㅇ님의 전체수신함 - 키워드검색시 갯수
	public int userSearchCount(Map<String, Object> map) {
		return payDao.userSearchCount(map);
	}
	
	public List<PayDto> userSearchList(Map<String, Object> map, PageInfoDto pi){
		return payDao.userSearchList(map, pi);
	}
	
	/*
	public int mReportUpdate(Map<String, Object> map) {
		return payDao.mReportUpdate(map);
	}
	*/
	
	public int mReportUpdate(Map<String, Object> map, List<Map<String, Object>> list){
		
		//1.매출보고서테이블 등록
		int result2 = payDao.updateMreport(map);
		//2-1.아이템품목 등록하기전에 삭제하기..
		int result4 = payDao.deleteReport(map);
		
		//2-2.품목공동테이블 등록
		int result1 = 1;
			if(!list.isEmpty() || list != null) {
				result1 = 0;
				for (Map<String, Object> item : list) { 
					result1 += payDao.updateInsertItems(item);
				}				
			}
		//3.결재이력공동테이블 등록
	    int result3 = payDao.updateApproval(map);
			
		return result1;
	}
	
	
	public int gReportInsert(Map<String, Object> map, List<Map<String, Object>> attachList, List<Map<String, Object>> referrerList) {
		//1.기안서테이블 등록
		int result1 = payDao.gReportInsert(map);
		//2. 파일등록
		int result2 = 1;
		if(attachList != null && !attachList.isEmpty()) {
			result2 = 0;
			for(Map<String, Object> list : attachList) {
				result2 = payDao.gReportAttachInsert(list);
			}
		}
		//3.결재이력공동테이블 등록
		int result3 = payDao.gReportApprovalInsert(map);
		
		int result4 = 1;
		if(referrerList != null && !referrerList.isEmpty()) {
			result4 = 0;
			for(Map<String, Object> refNo : referrerList) {
				result4 = payDao.insertRefNo(refNo);
			}
		}
			
		
		return result1 * result2 * result3;
	}
	
	public List<Map<String, Object>> salesDetail(Map<String, Object> map){
		
		return payDao.salesDetail(map);
		
		
	}
	
	public List<PayDto> ApprovedList(PageInfoDto pi, String userName){
		return payDao.ApprovedList(pi, userName);
	}
	
	public int bReportInsert(Map<String, Object> map, List<Map<String, Object>> list, List<Map<String, Object>> referrerList) {
		
		
		//1.비품신청서테이블 등록
		int result2 = payDao.insertBreport(map);
		//2.품목공동테이블 등록
		int result1 = 1;
			if(!list.isEmpty()) {
				result1 = 0;
				for (Map<String, Object> item : list) { 	
					result1 += payDao.insertItemsB(item);
				}				
			}
		//3.결재이력공동테이블 등록
	    int result3 = payDao.bReportApprovalInsert(map);
	    
	    int result4 = 1;
		if(referrerList != null && !referrerList.isEmpty()) {
			result4 = 0;
			for(Map<String, Object> refNo : referrerList) {
				result4 = payDao.insertRefNo(refNo);
			}
		}
					
		return result1 * result2 * result3;
	} 
	
	// 비품상세 데이터값 불러오기
	public List<Map<String, Object>> fixDetail(Map<String, Object> map){
		return payDao.fixDetail(map);
	}
	// 휴가신청서 등록하기
	public int hReportInsert(Map<String, Object> map) {
		
		int result1 = payDao.hReportInsert(map);
		int result2 = payDao.hReportApprovalInsert(map);
		
		return result1 + result2;
		
	}
	
	// 휴가신청서 데이터값 불러오기
	public List<Map<String, Object>> retireDetail(Map<String, Object> map){
		return payDao.retireDetail(map);
	}
	
	//지출결의서 등록
	public int jReportInsert(Map<String, Object> map, List<Map<String, Object>> itemList
							, List<Map<String, Object>> attachList) {
		
		//1.지출결의서테이블 등록
		int result1 = payDao.insertJreport(map);
		
		
		//2.품목공동테이블 등록
		int result2 = 1;
			if(itemList != null && !itemList.isEmpty()) {
				result2 = 0;
				for (Map<String, Object> item : itemList) { 	
					result2 += payDao.insertItemsJ(item);
				}				
			}
		//3.결재이력공동테이블 등록
	    int result3 = payDao.jReportApprovalInsert(map);
	    
	    //4.지출결의서 공동파일저장하기
	    int result4 = 1;
	    if(attachList != null && !attachList.isEmpty()) {
			result4 = 0;
			for(Map<String, Object> at : attachList) {
				result4 += payDao.jReportAttachInsert(at);
			}
		}
	    
		return result1 * result2 * result3 * result4;
		
	}
	
	public List<Map<String, Object>> draftDetail(Map<String, Object> map){
		
		return payDao.draftDetail(map);
	}
	
	public List<Map<String, Object>> fileDraftDetail(Map<String, Object> map){
		return payDao.fileDraftDetail(map);
	}
	
	//지출결의서 수정페이지 =>리스트 불러오기
	public List<Map<String, Object>> draftModify(Map<String, Object> map) {
		return payDao.draftModify(map);
	}
	
	//지출결의서 수정하기
	public int jReportUpdate(Map<String, Object> map, List<Map<String, Object>> list 
							,List<Map<String, Object>> fileList, String[] delFileNo) {
		
		//1.매출보고서테이블 업데이트
		int result1 = payDao.updateJReport(map);
		
		//2_1.아이템품목 업데이트하기전 삭제
		int result2 = payDao.deleteJItem(map);
		
		//2_2.품목공동테이블 업데이트
		int result3 = 1;
		if(!list.isEmpty()) {
			result3 = 0;
			for (Map<String, Object> item : list) { 
				result3 += payDao.updateInsertItemsJ(item); // insert재사용
			}				
		}
		//3.결재이력공동테이블 업데이트
	    int result4 = payDao.updateApproval(map);
	    
	    //4_1. 파일 등록하기전에 기존파일삭제하는데 기존파일이 넘어올경우 먼저 삭제하고
	    int result5 = 1;
	    if(delFileNo != null) {
	    	result5 = payDao.deleteAttachment(delFileNo);
	    }
	    
	    //4_2. 파일 새로추가한거 등록하기
	    int result6 = 1;
	    for(Map<String, Object> uploadFile : fileList) {
	    	if(!uploadFile.isEmpty() && uploadFile != null) {
	    		result6 = 0;
	    		result6 = payDao.insertAttachment(uploadFile);
	    	}
	    }
	    
			
		return result1 * result3 *  result6;
		
	}
	
	//일주일이상처리가 지연된 목록리스트조회
	public List<PayDto> delayDateList(String userName, PageInfoDto pi){
		return payDao.delayDateList(userName, pi);
	}
	
	public int moreDateSelectCount(Map<String, Object> map) {
		return payDao.moreDateSelectCount(map);
	}
	
	public List<PayDto> delayDateSelectList(Map<String, Object> userMap, PageInfoDto pi) {
		return payDao.delayDateSelectList(userMap, pi);
	}
	
	public int moreDateSearchCount(Map<String, Object> userMap) {
		return payDao.moreDateSearchCount(userMap);
	}
	
	public List<PayDto> delayDateSearchList(Map<String, Object> userMap, PageInfoDto pi){
		return payDao.delayDateSearchList(userMap, pi);
	}
	
	
	public List<Map<String, Object>> retireModify(Map<String, Object> map){
		return payDao.retireModify(map);
	}
	
	
	public int hReportUpdate(Map<String, Object> map){
		
		//1.휴가보고서테이블 업데이트
		int result1 = payDao.updateHreport(map);
		
		//2.공동테이블 업데이트
		int result2 = payDao.updateApproval(map);
		
		return result1 + result2;
	}
	
	public int bReportUpdate(Map<String, Object> map, List<Map<String, Object>> itemList, List<Map<String, Object>> referrerList, String approvalNo) {
		
		//1.비품신청서 업데이트
		int result1 = payDao.updateBReport(map);
		
		int result2 = 1;
		//2.아이템등록하기전 삭제
		if(!itemList.isEmpty() && itemList != null) {
			result2 = payDao.deleteBItem(map);
		}
		//3.아이템업데이트
		int result3 = 1;
		for(Map<String, Object> item : itemList) {
			if( item != null && !item.isEmpty() ) {
				result3 = 0;
				result3 = payDao. updateInsertItemsB(item);								
			}
		}
		//4.결재공동테이블 업데이트 approval
		int result4 = payDao.updateApproval(map);
		//수신참조자 삭제 후
		int result5 = 1;
		if(approvalNo != null || !approvalNo.equals("")) {
			result5 = payDao.deleteRefNo(approvalNo);			
		}
		// insert (update과정)
		int result6 = 1;
		if(referrerList != null && !referrerList.isEmpty()) {
			result6 = 0;
			for(Map<String, Object> refNo : referrerList) {
				result6 = payDao.updateInsertRefNo(refNo);
			}
		}
		
		return result3;
	}
	
	
	public int ajaxSign(Map<String, Object> map) {
		return payDao.ajaxSign(map);
	}
	
	public List<Map<String, Object>> teamNameList(){
		return payDao.teamNameList();
	}
	
	public List<Map<String, Object>> ajaxTeamSearch(String name){
		return payDao.ajaxTeamSearch(name);
	}
	
	public List<Map<String, Object>> ajaxSearchName(String name){
		return payDao.ajaxSearchName(name);
	}
	
	
	public int ajaxSignUpdate(Map<String, Object> map){
		return payDao.ajaxSignUpdate(map);
	}
	
	public List<SignDto> ajaxSignSelect(Map<String, Object> map) {
		return payDao.ajaxSignSelect(map);
	}
	
	
	public int approvalSearchCount(Map<String, Object> map){
		return payDao.approvalSearchCount(map);
	}
	
	
	public List<PayDto> approvalSearchList(Map<String, Object> map, PageInfoDto pi){
		return payDao.approvalSearchList(map, pi);
	}
	
	
	public int approvalSelectCount(Map<String, Object> map){
		return payDao.approvalSelectCount(map);
	}
	
	public List<PayDto> approvalSelectList(Map<String, Object> map, PageInfoDto pi){
		return payDao.approvalSelectList(map, pi);
	}
	
	public int myAllApCount(Map<String, Object> map) {
		return payDao.myAllApCount(map);
	}
	
	public List<Map<String, Object>> myAllApproval(Map<String, Object> map, PageInfoDto pi){
		return payDao.myAllApproval(map, pi);
	}
	
	
	public int ajaxAppprovaldelete(String no){
		return payDao.ajaxAppprovaldelete(no);
	}
	
	public int mySearchApCount(Map<String, Object> map){
		return payDao.mySearchApCount(map);
	}
	
	public List<Map<String, Object>> mySearchApList(Map<String, Object> map, PageInfoDto pi){
		return payDao.mySearchApList(map, pi);
	}
	
	public String contentSelect(Map<String, Object> map) {
		return payDao.contentSelect(map);
	}
	
	
	
	public int noApprovalSignCount(String userName) {
		return payDao.noApprovalSignCount(userName);
	}
	
	public List<PayDto> noApprovalSign(String userName, PageInfoDto pi){
		return payDao.noApprovalSign(userName, pi);
	}
	
	public int noApprovalSignSelectCount(Map<String, Object> map) {
		return payDao.noApprovalSignSelectCount(map);
	}
	
	
	public List<PayDto> noApprovalSignSelectList(Map<String, Object> map, PageInfoDto pi){
		return payDao.noApprovalSignSelectList(map, pi);
	}
	
	public int noApprovalSignSearchCount(Map<String, Object> map) {
		return payDao.noApprovalSignSearchCount(map);
	}
	
	public List<PayDto> noApprovalSignSearchList(Map<String, Object> map, PageInfoDto pi){
		return payDao.noApprovalSignSearchList(map, pi);
	}
	
	
	
	public int myRejectApCount(Map<String, Object> map) {
		return payDao.myRejectApCount(map);
	}
	public List<Map<String, Object>> myRejectApList(Map<String, Object> map, PageInfoDto pi){
		return payDao.myRejectApList(map, pi);
	}
	
	public int myFinishApCount(Map<String, Object> map) {
		return payDao.myFinishApCount(map);
	}
	public List<Map<String, Object>> myFinishApList(Map<String, Object> map, PageInfoDto pi){
		return payDao.myFinishApList(map, pi);
	}
	
	public List<Map<String, Object>> noApprovalSignRe(Map<String, Object> map, PageInfoDto pi){
		return payDao.noApprovalSignRe(map, pi);
	}
	
	
	//비품신청서 승인완료되면 비품테이블에 등록하기
	public int fixInsert(List<Map<String, Object>> list) {
		
		int result = 1;
		if(list != null && list.size() > 0) {
			result = 0;
			for(Map<String, Object> map : list) {
				result += payDao.fixInsert(map);
			}
		}
		
		return result;
	}
	
	public int noApprovalkeywordSignCount(Map<String, Object> map) {
		return payDao.noApprovalkeywordSignCount(map);
	}
	
	public int noApprovalSignCountToday(String userName) {
		return payDao.noApprovalSignCountToday(userName);
	}
	
	
	//기안서 업데이트
	public int gReportUpdate(Map<String, Object> map, List<Map<String, Object>> attachList, String[] delFileNo, List<Map<String, Object>> referrerList, String approvalNo) {
		
		int result1 = payDao.updateApproval(map);
		
		//수신참조자 삭제 후
		int result7 = 1;
		if(approvalNo != null || !approvalNo.equals("")) {
			result7 = payDao.deleteRefNo(approvalNo);			
		}
		// insert (update과정)
		int result6 = 1;
		if(referrerList != null && !referrerList.isEmpty()) {
			result6 = 0;
			for(Map<String, Object> refNo : referrerList) {
				result6 = payDao.updateInsertRefNo(refNo);
			}
		}
		
		int result2 = 1;
		if(delFileNo != null) {
			result2 = payDao.deleteAttachment(delFileNo);
		}
		
		int result3 = 1;
		if(attachList != null || !attachList.isEmpty()) {
			result3 = 0;
			for(Map<String, Object> at : attachList) {
				result3 += payDao.gReportAttachUpdate(at);
			}
		}
		
		int result4 = payDao.fileStatus(map);
		
		int result5 = 1;
		if(result4 > 0) {
			map.put("fileStatus", "Y");
			result5 = payDao.updateGReport(map);
		}else {
			map.put("fileStatus", "N");
			result5 = payDao.updateGReport(map);
		}
		
		return result1 * result2 * result3 * result5;
	}
	
	//최종승인완료
	public int ajaxApprovalprocessing(Map<String, Object> map) {
		return payDao.ajaxApprovalprocessing(map);
	}
	
	//비품 최종승인 되면 비품등록
	public int ajaxFix(List<Map<String, Object>> list) {
		
		int result = 1;
		if(list != null && !list.isEmpty()) {
			result = 0;
			for(Map<String, Object> fixItem : list) {
				result = payDao.ajaxFix(fixItem);
			}
		} 
		return result;
	}
	
	public List<Map<String, Object>> laterSearchDept(String keyword){
		return payDao.laterSearchDept(keyword);
	}
	
	public List<Map<String, Object>> myReferrer(int userNo){
		return payDao.myReferrer(userNo);
	}
	
	
	public List<Map<String, Object>> refList(String approvalNo){
		return payDao.refList(approvalNo);
	}
	
	
}
