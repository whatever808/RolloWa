package com.br.project.dto.pay;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
@Getter
@Setter
public class PayDto {
	
	private int paymentNo; //결재번호
	private int documentNo; //문서번호
	private String documentType; //문서
	private String department; // 부서
	private String payWriter; // 기안자
	private int payWriterNo; // 기안자번호
	private String payStatus; // 상태 (긴급  보통)
	private String documentStatus; // 문서상태(진행중 : I , 승인완료 : Y, 저장 : C , 반려 : N) 
	private String cancellContent; // 반려사유
	private String firstApproval; // 최초승인자
	private String middleApproval; // 중간승인자
	private String finalApproval; // 최종승인자
	private String firstApproDt; // 최초승인일자
	private String middleApproDt; // 중간승인일자
	private String finalApproDt; // 최종승인일자
	private String registDt; // 작성일
	private Date modifyDt; // 수정일
	private String status; // 삭제여부
	private int firstCheck; // 최초승인자열람여부 (로그인한 관리자가 최초승인자일때  + 최초승인날짜가 null일때 확인)
	private int middleCheck;// 중간승인자열람여부
	private int finalCheck;// 최종승인자열람여부
	private int salesStatus; //기안서 파일여부(Y | N) => count 0 or 1
	private int draftStatus; // 지출결의서 파일여부(Y | N)
	private int businessStatus; // 출장보고서 파일여부(Y | N)
	private int moreDate; // 등록날짜로부터 일주일 지난 수신참조(진행중인상태)
	
	private List<ExpenditureDto> expendlist;
	
	

}
