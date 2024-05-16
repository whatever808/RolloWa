package com.br.project.controller.board;

import static com.br.project.controller.common.CommonController.getParameterMap;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.board.BoardDto;
import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.board.BoardAttachmentService;
import com.br.project.service.board.BoardService;
import com.br.project.service.common.department.DepartmentService;
import com.br.project.util.FileUtil;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="board")
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	private final BoardService boardService;
	private final BoardAttachmentService boardAttachmentService;
	private final DepartmentService departmentService;
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	
	/**
	 * @method : 공지사항 목록조회(페이지별)
	 */
	@RequestMapping(value="/list.do")
	public String selectBoardList(@RequestParam(value="page", defaultValue="1") int currentPage
								 ,@RequestParam HashMap<String, Object> filter
								 ,Model model
								 ,HttpServletRequest request
								 ,RedirectAttributes redirectAttributes) {
		try {
			filter.put("status", "Y");	// 조회할 공지사항의 상태값
			
			// 게시글 페이징바 생성
			PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(filter), currentPage, 5, 10);
			
			// 응답페이지 지정 및 응답데이터 반환
			model.addAttribute("boardList", boardService.selectBoardList(pageInfo, filter));				// 게시글 목록
			model.addAttribute("pageInfo", pageInfo);
			model.addAttribute("departmentList", departmentService.selectDepartmentList("DEPT01"));		// 부서 목록
			model.addAttribute("filter", filter);
			
			return "/board/list";
			
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 목록서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "공지사항 목록조회 요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
		
	}
	
	/**
	 * @method : 공지사항 목록조회(페이지별) (AJAX)
	 */
	@RequestMapping(value={"/list.ajax", "/publisher/list.ajax", "/temp/list.ajax"})
	@ResponseBody
	public Map<String, Object> ajaxSelectBoardList(@RequestParam HashMap<String, Object> filter
											      ,HttpServletRequest request){
		
		StringBuffer requestURL = request.getRequestURL();
		
		if(requestURL.indexOf("temp") != -1) {
			// 임시저장 공지 목록조회 요청일 경우 조회할 공지사항 상태값
			filter.put("status", "T");
		}else {
			// 전체공지 or 내가 쓴 공지 목록조회 요청일 경우 조회할 공지사항 상태값
			filter.put("status", "Y");
		}
		
		// 내가 쓴 공지 or 임시저장 공지 목록조회 요청일 경우
		if(requestURL.indexOf("publisher") != -1 || requestURL.indexOf("temp") != -1) {
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			filter.put("userNo", loginMember.getUserNo());
		}
		
		// 게시글 페이징바 생성
		PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(filter), 
														 Integer.parseInt(filter.get("page").toString()), 5, 10);
		
		// 응답데이터 반환 (게시글목록)
		Map<String, Object> response = new HashMap<>();

		response.put("boardList", boardService.selectBoardList(pageInfo, filter));
		response.put("pageInfo", pageInfo);
		
		return response;
	}
	
	/**
	 * @method : 공지사항 목록조회(전체)(AJAX)
	 */
	@RequestMapping(value={"/detail/list.ajax", "/publisher/detail/list.ajax", "/temp/detail/list.ajax"})
	@ResponseBody
	public List<BoardDto> ajaxSelectBoardList(HttpServletRequest request){
		
		HashMap<String, Object> params = getParameterMap(request);
		
		if(request.getRequestURL().indexOf("temp") != -1) {
			// 임시보관 공지사항 목록조회시 조회할 공지사항 상태값
			params.put("status", "T");	
		}else {
			// 내가 쓴 글 or 단순 목록조회시 조회할 공지사항 상태값
			params.put("status", "Y");
		}
		// 내가 쓴 공지 or 임시저장 공지 목록조회 요청시
		if(request.getRequestURL().indexOf("publisher") != -1 || request.getRequestURL().indexOf("temp") != -1) {
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			params.put("userNo", loginMember.getUserNo());
		}
		
		return boardService.selectBoardList(params);
	}
	
	/**
	 * @method : 내가 쓴 공지 or 임시공지 목록조회
	 */
	@RequestMapping(value={"/publisher/list.do", "/temp/list.do"})
	public String showBoardList(@RequestParam(value="page", defaultValue="1") int currentPage
							   ,HttpServletRequest request
							   ,Model model
							   ,RedirectAttributes redirectAttributes) {
		try {
			MemberDto loginMember = (MemberDto)(request.getSession().getAttribute("loginMember"));

			// 회원 소속 부서조회
			HashMap<String, Object> deptParams = new HashMap<>();
			deptParams.put("upperGroupCode", "DEPT%");
			deptParams.put("groupCode", "TEAM%");
			deptParams.put("code", loginMember.getTeamCode());
			GroupDto loginMemberDepartment = departmentService.selectUppderCode(deptParams);
			
			// 파라미터
			HashMap<String, Object> params = getParameterMap(request);
			if(params.get("category") == null) {
				params.put("category", "normal");
			}
			params.put("userNo", loginMember.getUserNo());
			params.put("department", loginMemberDepartment.getCode());
			if(request.getRequestURL().indexOf("temp") != -1) {
				// 임시저장 공지사항 목록조회 요청일 경우
				params.put("status", "T");
			}else if(request.getRequestURL().indexOf("publisher") != -1) {
				// 내가 쓴 공지사항 목록조회 요청일 경우
				params.put("status", "Y");
			}
			
			// 페이징바
			PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(params), currentPage, 5, 10);
			
			// 응답페이지 지정 및 응답데이터 반환
			model.addAttribute("boardList", boardService.selectBoardList(pageInfo, params));				// 게시글 목록
			model.addAttribute("pageInfo", pageInfo);
			model.addAttribute("filter", params);
			
			if(request.getRequestURL().indexOf("temp") != -1) {
				// 임시저장 공지사항 목록조회 요청일 경우
				return "board/temp/list";				
			}else {
				// 내가 쓴 공지사항 목록조회 요청일 경우
				return "board/publisher/list";
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 목록서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "공지사항 목록조회 요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}

	}
	
	/**
	 * @method : 공지사항 조회수 증가 (로그인사용자 != 작성자)
	 */
	@RequestMapping(value="/reader/detail.do")
	public String increaseReadCount(HttpServletRequest request
								   ,RedirectAttributes redirectAttributes) {

		try {
			// 파라미터값
			HashMap<String, Object> params = getParameterMap(request);
			String category = params.get("category").toString();
			String department = params.get("department").toString();
			String condition = params.get("condition").toString();
			String keyword = params.get("keyword").toString();
			String no = params.get("no").toString();
			
			// 공지사항 조회수 증가
			boardService.updateReadCount(no);
			
			return "redirect:/board/detail.do?" + "category=" + category + "&"
												+ "department=" + department + "&"
												+ "condition=" + condition + "&"
												+ "keyword=" + keyword + "&"
												+ "no=" + no;
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 상세서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "공지사항 상세페이지 요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
		
	}
	
	/**
	 * @method : 공지사항 상세조회
	 */
	@RequestMapping(value={"/detail.do", "/publisher/detail.do", "/temp/detail.do"})
	public String showBoardDetail(HttpServletRequest request
								 ,Model model
								 ,RedirectAttributes redirectAttributes) {
		try {
			HashMap<String, Object> params = getParameterMap(request);
			// 조회할 공지사항 상태값
			params.put("status", request.getRequestURL().indexOf("temp") != -1 ? "T" : "Y");
			
			BoardDto board = boardService.selectBoard(params);
			
			if(board != null) {
				// 조회된 공지사항이 있을경우(유효한 공지사항)
				model.addAttribute("board", board);
				if(request.getRequestURL().indexOf("publisher") != -1) {
					// 등록공지보관함에서 공지사항 상세요청시(작성자)
					return "board/publisher/detail";
				}else if(request.getRequestURL().indexOf("temp") != -1) {
					// 임시공지보관함에서 공지시항 상세요청시(작성자)
					return "board/temp/detail";
				}else {
					// 공지목록페이지에서 공지사항 상세요청시(전체사용자)
					return "board/detail";
				}
				
			}else {
				// 조회된 공지사항이 없을경우
				redirectAttributes.addFlashAttribute("alertTitle", "공지사항 상세조회");
				redirectAttributes.addFlashAttribute("alertMsg", "유효하지 않은 공지사항입니다.");
				return "redirect:" + request.getHeader("Referer");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			return "redirect:" + request.getDateHeader("Referer");
		}

	}
	
	/**
	 * @method : 공지사항 등록페이지 반환
	 */
	@RequestMapping(value="/post.page")
	public String showBoardPostForm() {
		return "board/post";
	}
	
	/**
	 * @method : 공지사항 등록
	*/ 
	@RequestMapping(value="/post.do")
	public String postBoard(BoardDto board
						   ,List<MultipartFile> uploadFiles
						   ,HttpServletRequest request
						   ,RedirectAttributes redirectAttributes) {
		try {
			// 등록할 첨부파일 리스트
			HashMap<String, Object> fileInfo = new HashMap<>();
			fileInfo.put("category", "board");
			fileInfo.put("refType", "BD");
			fileInfo.put("refNo", board.getBoardNo());
			fileInfo.put("status", board.getStatus());
			List<AttachmentDto> attachmentList = fileUtil.getAttachmentList(uploadFiles, fileInfo);

			// 공지사항 등록
			String writerNo = String.valueOf(((MemberDto)(request.getSession().getAttribute("loginMember"))).getUserNo());
			board.setRegistEmp(writerNo);
			board.setModifyEmp(writerNo);
			board.setAttachmentList(attachmentList);
			
			int result = boardService.insertBoard(board);
			
			String status = board.getStatus().equals("Y") ? "등록" : "저장";
			String alertMsg = "";
			if(result > 0) {
				// 공지사항 등록 성공
				alertMsg = "공지사항이 " + status + " 되었습니다.";
			}else {
				// 공지사항 등록 실패
				alertMsg = "공지사항 " + status + " 이 정상적으로 처리되지 않았습니다.";
			}
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 등록서비스");
			redirectAttributes.addFlashAttribute("alertMsg", alertMsg);
		}catch(Exception e) {
			e.printStackTrace();
			return "redirect:" + request.getDateHeader("Referer");
		}
		return "redirect:/board/list.do";
	}
	
	/**
	 * @method : 공지사항 수정페이지 이동
	 */
	@RequestMapping(value={"/modify.page", "/publisher/modify.page", "/temp/modify.page"})
	public String showBoardModifyPage(HttpServletRequest request
									 ,Model model) {
		try {
			String teamCode = ((MemberDto)request.getSession().getAttribute("loginMember")).getTeamCode();
			
			HashMap<String, Object> params = new HashMap<>();
			params.put("upperGroupCode", "DEPT01");
			params.put("groupCode", "TEAM01");
			params.put("code", teamCode);
			model.addAttribute("department", departmentService.selectUppderCode(params));
			
			HashMap<String, Object> parameterMap = getParameterMap(request);
			parameterMap.put("status", request.getRequestURL().indexOf("temp") != -1 ? "T" : "Y");;
			model.addAttribute("board", boardService.selectBoard(parameterMap));
			
			if(request.getRequestURL().indexOf("publisher") != -1) {
				return "board/publisher/modify";
			}else if(request.getRequestURL().indexOf("temp") != -1) {
				return "board/temp/modify";
			}else {
				return "board/modify";				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 공지사항 수정
	 */
	@RequestMapping(value={"/modify.do", "/publisher/modify.do", "/temp/modify.do"})
	public String modifyBoard(BoardDto board
						     ,List<MultipartFile> uploadFiles
						     ,String[] delFileNoArr
						     ,HttpServletRequest request
						     ,RedirectAttributes redirectAttributes) {
		
		String alertMsg = "";
		
		try {
			HashMap<String, Object> params = new HashMap<>();
			
			// 삭제할 첨부파일 정보
			List<AttachmentDto> delAttachmentList = new ArrayList<>();
			if(delFileNoArr != null) {
				params.put("delFileNoArr", delFileNoArr);
				delAttachmentList = boardAttachmentService.selectAttachmentList(delFileNoArr);
			}
			
			// 등록할 공지사항 정보
			HashMap<String, Object> fileInfo = new HashMap<>();
			fileInfo.put("category", "board");
			fileInfo.put("refType", "BD");
			fileInfo.put("refNo", board.getBoardNo());
			fileInfo.put("status", board.getStatus());
			board.setAttachmentList(fileUtil.getAttachmentList(uploadFiles, fileInfo));
			params.put("board", board);
			
			// 공지사항 수정요청
			int result = boardService.updateBoard(params);
			
			// 처리결과에 따른 응답페이지
			String status = board.getStatus() == "Y" ? "등록" : "저장";
			if(result > 0) {
				alertMsg = "공지사항 수정이 완료되었습니다.";
				
				// 삭제할 첨부파일이 있었을 경우, 로컬저장소에서 업로드된 파일삭제
				if(!delAttachmentList.isEmpty()) {
					for(AttachmentDto attachment : delAttachmentList) {
						new File(attachment.getAttachPath(), attachment.getModifyName()).delete();
					}
				}
			}else {
				alertMsg = "공지사항 수정이 정상적으로 처리되지 않았습니다.";
				
				// 업로드한 첨부파일이 있었을 경우, 로컬저장소에서 등록실패한 파일삭제
				if(!board.getAttachmentList().isEmpty()) {
					for(AttachmentDto attachment : board.getAttachmentList()) {
						new File(attachment.getAttachPath(), attachment.getModifyName()).delete();
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
			alertMsg = "공지사항 수정서비스 요청에 실패했습니다.";
			return "redirect:" + request.getHeader("Referer");
		}finally {
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 수정서비스");
			redirectAttributes.addFlashAttribute("alertMsg", alertMsg);
		}
		
		if(request.getRequestURL().indexOf("publisher") != -1) {
			return "redirect:/board/publisher/list.do";
		}else if(request.getRequestURL().indexOf("temp") != -1) {
			return "redirect:/board/temp/list.do";
		}else {
			return "redirect:/board/list.do";
		}
		
	}
	
	/**
	 * @method
	 * 	  ㄴ case 01) 게시된 공지사항 상태 임시저장으로 수정
	 *    ㄴ case 02) 게시된 공지사항 삭제
	 *    ㄴ case 03) 임시저장 공지사항 등록
	 */
	@RequestMapping(value={"/status/modify.do", 
						   "/delete.do", 
						   "/publisher/status/modify.do", 
						   "/publisher/delete.do",
						   "/temp/post.do",
						   "/temp/delete.do"})
	public String modifyBoardStatus(HttpServletRequest request
								   ,RedirectAttributes redirectAttributes) {
		
		StringBuffer requestURL = request.getRequestURL();
		String status = "";
		if(requestURL.indexOf("delete") != -1) {
			// 공지사항 삭제요청시 상태값
			status = "N";
		}else if(requestURL.indexOf("post") != -1) {
			// 임시공지 등록요청시 상태값
			status = "Y";
		}else {
			// 임시저장 공지사항으로 변경요청시 상태값
			status = "T";
		}
		
		String statusMsg = "";
		if(status.equals("N")) {
			statusMsg = "삭제";
		}else if (status.equals("Y")) {
			statusMsg = "등록";
		}else {
			statusMsg = "수정";
		}
		String alertMsg = "";
		String pageURL = "";
		
		try {
			// 파라미터 : {"boardNo" : "공지사항번호", "fyn" : "첨부파일유무(Y|N)"}
			HashMap<String, Object> params = getParameterMap(request);
			params.put("refType", "BD");	// 해당첨부파일에 첨부파일이 있을경우, 첨부파일 첨조유형
			params.put("status", status);	// 변경할 상태값
			
			// 공지사항 및 공지사항 첨부파일 상태값 수정
			if(boardService.updateBoardStatus(params) > 0) {
				alertMsg = "공지사항이 " + statusMsg + "되었습니다.";
				if(requestURL.indexOf("publisher") != -1) {
					pageURL = "/board/publisher/list.do";
				}else if(requestURL.indexOf("temp") != -1) {
					pageURL = "/board/temp/list.do";
				}else {
					pageURL = "/board/list.do";
				}
				
				redirectAttributes.addFlashAttribute("alertTitle", "공지사항 상태변경서비스");
				redirectAttributes.addFlashAttribute("alertMsg", alertMsg);
				return "redirect:" + pageURL;
				
			}else {
				alertMsg = "공지사항 " + statusMsg + "이(가) 정상적으로 처리되지 않았습니다.";
				return "redirect:" + request.getHeader("Referer");
			}
		}catch(Exception e) {
			e.printStackTrace();
			alertMsg = "공지사항 " + statusMsg + "요청이 실패되었습니다.";
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 상태변경서비스");
			redirectAttributes.addFlashAttribute("alertMsg", alertMsg);
			return "redirect:" + request.getHeader("Referer");
		}
	
	}
	
	
}
