package com.br.project.controller.board;

import static com.br.project.controller.common.CommonController.getParameterMap;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
	 * @method : 공지사항 목록조회
	 */
	@RequestMapping(value={"/list.do", "/publisher/list.do", "/temp/list.do"})
	public String selectBoardList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			StringBuffer requestURL = request.getRequestURL();
			HashMap<String, Object> params = getParameterMap(request);
			if(params.get("page") == null || ((String)params.get("page")).equals("")) {
				params.put("page", "1");
			}
			
			// 내가 작성한 공지사항 or 임시저장 공지사항 목록조회 요청일 경우 =============================================================
			if(requestURL.indexOf("publisher") != -1 || requestURL.indexOf("temp") != -1) {
				
				MemberDto loginMember = (MemberDto)(request.getSession().getAttribute("loginMember"));
				
				// 회원 소속 부서조회
				HashMap<String, Object> deptParams = new HashMap<>();
				deptParams.put("upperGroupCode", "DEPT%");
				deptParams.put("groupCode", "TEAM%");
				deptParams.put("code", loginMember.getTeamCode());
				GroupDto loginMemberDepartment = departmentService.selectUppderCode(deptParams);

				
				if(params.get("category") == null) {
					params.put("category", "normal");
				}
				params.put("userNo", loginMember.getUserNo());
				params.put("department", loginMemberDepartment.getCode());
			}
			// 내가 작성한 공지사항 or 임시저장 공지사항 목록조회 요청일 경우 =============================================================
			
			// 조회할 공지사항 상태값 지정
			params.put("status", requestURL.indexOf("temp") != -1 ? "T" : "Y");

			// 게시글 페이징바 생성
			PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(params), 
															 Integer.parseInt(params.get("page").toString()), 5, 10);
			
			// 반환데이터
			if(requestURL.indexOf("publisher") == -1 || requestURL.indexOf("temp") == -1) {
				Map<String, String> map = new HashMap<>();
				map.put("code", "DEPT01");
				request.setAttribute("departmentList", departmentService.selectDepartmentList(map));	// 부서 목록조회
			}
			request.setAttribute("boardList", boardService.selectBoardList(pageInfo, params));
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("filter", params);
			
			// 반환페이지
			if(requestURL.indexOf("temp") != -1) {
				return "board/temp/temp_board_list";				
			}else if(requestURL.indexOf("publisher") != -1){
				return "board/publisher/publisher_board_list";
			}else {
				return "board/board_list";
			}
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 목록서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "공지사항 목록조회 요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 공지사항 목록조회 (AJAX)
	 */
	@RequestMapping(value={"/list.ajax", "/publisher/list.ajax", "/temp/list.ajax",
						   "/detail/list.ajax", "/publisher/detail/list.ajax", "/temp/detail/list.ajax"})
	@ResponseBody
	public Object ajaxSelectBoardList(HttpServletRequest request){
		StringBuffer requestURL = request.getRequestURL();
		
		// 조회할 공지사항 상태값 지정
		HashMap<String, Object> params = getParameterMap(request);
		if(requestURL.indexOf("temp") != -1) {
			params.put("status", "T");
		}else {
			params.put("status", "Y");
		}
		
		// 내가 작성한 공지사항(등록 | 임시저장) 목록조회 요청했을 경우
		if(requestURL.indexOf("publisher") != -1 || requestURL.indexOf("temp") != -1) {
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			params.put("userNo", loginMember.getUserNo());
		}
		
		// 리스트 페이징처리 유무
		if(requestURL.indexOf("detail") == -1) {
			// 게시글 페이징바 생성
			PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(params), 
															 Integer.parseInt(params.get("page").toString()), 5, 10);
			
			// 공지사항 리스트 및 페이징바 반환
			Map<String, Object> response = new HashMap<>();
			response.put("boardList", boardService.selectBoardList(pageInfo, params));
			response.put("pageInfo", pageInfo);
			
			return response;
		}else {
			// 공지사항 전체 리스트 반환
			return boardService.selectBoardList(params);
		}
	}
	
	/**
	 * @method : 공지사항 조회수 증가 (로그인사용자 != 작성자)
	 */
	@RequestMapping(value="/reader/detail.do")
	public String increaseReadCount(HttpServletRequest request ,RedirectAttributes redirectAttributes) {
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
	public String showBoardDetail(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			HashMap<String, Object> params = getParameterMap(request);
			params.put("status", request.getRequestURL().indexOf("temp") != -1 ? "T" : "Y");	// 등록상태
			
			// 공지사항 상세조회
			BoardDto board = boardService.selectBoard(params);
			if(board != null) {
				request.setAttribute("board", board);
				
				if(request.getRequestURL().indexOf("publisher") != -1) {
					return "board/publisher/publisher_board_detail";
				}else if(request.getRequestURL().indexOf("temp") != -1) {
					return "board/temp/temp_board_detail";
				}else {
					return "board/board_detail";
				}
			}else {
				redirectAttributes.addFlashAttribute("alertTitle", "공지사항 상세조회");
				redirectAttributes.addFlashAttribute("alertMsg", "유효하지 않은 공지사항입니다.");
				return "redirect:" + request.getHeader("Referer");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 상세조회");
			redirectAttributes.addFlashAttribute("alertMsg", "유효하지 않은 공지사항입니다.");
			return "redirect:" + request.getDateHeader("Referer");
		}
	}
	
	/**
	 * @method : 공지사항 등록페이지 반환
	 */
	@RequestMapping(value="/post.page")
	public String showBoardPostForm() {
		return "board/board_post";
	}
	
	/**
	 * @method : 공지사항 등록 (AJAX)
	*/ 
	@RequestMapping(value="/post.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> ajaxPostBoard(MultipartHttpServletRequest multiRequest) {
		// 첨부파일 업로드
		HashMap<String, Object> fileInfo = new HashMap<>();
		fileInfo.put("category", "board");
		fileInfo.put("refType", "BD");
		fileInfo.put("status", multiRequest.getParameter("status"));
		List<AttachmentDto> uploadFileList = fileUtil.getAttachmentList(multiRequest.getFiles("uploadFiles"), fileInfo);
		
		// 공지사항 등록 & 첨부파일 등록
		HashMap<String, Object> params = getParameterMap(multiRequest);
		String writerNo = String.valueOf(((MemberDto)(multiRequest.getSession().getAttribute("loginMember"))).getUserNo());
		params.put("registEmp", writerNo);
		params.put("modifyEmp", writerNo);
		params.put("attachmentList", uploadFileList);
		
		// 처리결과에 따른 반환값 설정
		Map<String, Object> response = new HashMap<>(); 
		if(boardService.insertBoard(params) > 0) {
			// 공지사항 등록 성공했을 경우
			response.put("result", "SUCCESS");
			response.put("boardNo", boardService.selectPostedBoardNo());
		}else {
			// 공지사항 등록 실패했을 경우
			response.put("result", "FAIL");
			
			if(!uploadFileList.isEmpty()) {
				for(AttachmentDto delFile : uploadFileList) {
					new File(delFile.getAttachPath(), delFile.getModifyName()).delete();
				}
			}
		}
		
		return response;
	}
	
	/**
	 * @method : 공지사항 수정페이지 이동
	 */
	@RequestMapping(value={"/modify.page", "/publisher/modify.page", "/temp/modify.page"})
	public String showBoardModifyPage(HttpServletRequest request) {
		try {
			// 수정자 소속부서 조회
			String teamCode = ((MemberDto)request.getSession().getAttribute("loginMember")).getTeamCode();
			HashMap<String, Object> params = new HashMap<>();
			params.put("code", teamCode);
			params.put("groupCode", "TEAM01");
			params.put("upperGroupCode", "DEPT01");
			request.setAttribute("department", departmentService.selectUppderCode(params));
			
			// 공지사항 수정
			HashMap<String, Object> parameterMap = getParameterMap(request);
			parameterMap.put("status", request.getRequestURL().indexOf("temp") != -1 ? "T" : "Y");;
			request.setAttribute("board", boardService.selectBoard(parameterMap));
			
			// 응답페이지 반환
			if(request.getRequestURL().indexOf("publisher") != -1) {
				return "board/publisher/publisher_board_modify";
			}else if(request.getRequestURL().indexOf("temp") != -1) {
				return "board/temp/temp_board_modify";
			}else {
				return "board/board_modify";				
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
	public String modifyBoard(MultipartHttpServletRequest multiRequest,  RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("alertTitle", "공지사항 수정서비스");
		try {
			HashMap<String, Object> params = getParameterMap(multiRequest);
				
			// 삭제할 첨부파일 정보조회
			List<AttachmentDto> delAttachmentList = new ArrayList<>();
			String[] delFileNoArr = (String[])params.get("delFileNoArr");
			if(delFileNoArr != null && delFileNoArr.length != 0) {
				params.put("delFileNoArr", delFileNoArr);
				delAttachmentList = boardAttachmentService.selectAttachmentList(delFileNoArr);
			}
			
			// 첨부파일 업로드
			HashMap<String, Object> fileInfo = new HashMap<>();
			fileInfo.put("category", "board");
			fileInfo.put("refType", "BD");
			fileInfo.put("refNo", multiRequest.getParameter("boardNo"));
			fileInfo.put("status", multiRequest.getParameter("status"));
			
			List<AttachmentDto> uploadFileList = fileUtil.getAttachmentList(multiRequest.getFiles("uploadFiles"), fileInfo);
			params.put("uploadFileList", uploadFileList);
			
			// 공지사항 수정자 설정
			MemberDto loginMember = (MemberDto)multiRequest.getSession().getAttribute("loginMember");
			params.put("modifyEmp", loginMember.getUserNo());
			
			
			// 공지사항 수정
			if(boardService.updateBoard(params) > 0) {
				redirectAttributes.addFlashAttribute("alertMsg", "공지사항이 수정되었습니다.");
				
				// 삭제할 첨부파일이 있었을 경우, 로컬저장소에서 업로드된 파일삭제
				if(!delAttachmentList.isEmpty()) {
					for(AttachmentDto attachment : delAttachmentList) {
						new File(attachment.getAttachPath(), attachment.getModifyName()).delete();
					}
				}
			}else {
				redirectAttributes.addFlashAttribute("alertMsg", "공지사항 수정에 실패했습니다.");
				
				// 업로드한 첨부파일이 있었을 경우, 로컬저장소에서 등록실패한 파일삭제
				if(!uploadFileList.isEmpty()) {
					for(AttachmentDto attachment : uploadFileList) {
						new File(attachment.getAttachPath(), attachment.getModifyName()).delete();
					}
				}
			}
			
			// 반환페이지 설정
			String boardNo = multiRequest.getParameter("boardNo");
			
			if(multiRequest.getRequestURL().indexOf("publisher") != -1) {
				return "redirect:/board/publisher/detail.do?no=" + boardNo;
			}else if(multiRequest.getRequestURL().indexOf("temp") != -1) {
				if(multiRequest.getParameter("status").equals("T")) {
					return "redirect:/board/temp/detail.do?no=" + boardNo;					
				}else {
					return "redirect:/board/publisher/detail.do?no=" + boardNo;
				}
			}else {
				return "redirect:/board/detail.do?no=" + boardNo;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertMsg", "공지사항 수정서비스 요청에 실패했습니다.");
			return "redirect:" + multiRequest.getHeader("Referer");
		}
	}
	
	/**
	 * @method
	 * 	  ㄴ case 01) 게시된 공지사항 상태 임시저장으로 수정
	 *    ㄴ case 02) 게시된 공지사항 삭제
	 *    ㄴ case 03) 임시저장 공지사항 등록
	 */
	@RequestMapping(value={"/status/modify.do", "/delete.do",
						   "/publisher/status/modify.do", "/publisher/delete.do", 
						   "/temp/post.do", "/temp/delete.do"})
	public String modifyBoardStatus(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		try {
			StringBuffer requestURL = request.getRequestURL();
			String pageURL = "";
			String alertMsg = "";
			
			// 파라미터
			HashMap<String, Object> params = getParameterMap(request);
			params.put("refType", "BD");	// 첨부파일 참조유형
			if(requestURL.indexOf("delete") != -1) {
				params.put("status", "N");
				alertMsg = "공지사항이 삭제 되었습니다.";
			}else if(requestURL.indexOf("post") != -1) {
				params.put("status", "Y");
				alertMsg = "공지사항이 등록 되었습니다.";
			}else {
				params.put("status", "T");
				alertMsg = "공지사항이 임시저장함으로 이동되었습니다.";
			}
	
			// 공지사항 & 첨부파일 상태값 수정
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 상태변경서비스");
			if(boardService.updateBoardStatus(params) > 0) {
				if(requestURL.indexOf("publisher") != -1) {
					pageURL = "/board/publisher/list.do";
				}else if(requestURL.indexOf("temp") != -1) {
					pageURL = "/board/temp/list.do";
				}else {
					pageURL = "/board/list.do";
				}
				redirectAttributes.addFlashAttribute("alertMsg", alertMsg);
				return "redirect:" + pageURL;
			}else {
				redirectAttributes.addFlashAttribute("alertMsg", "공지사항 상태변경에 실패했습니다.");
				return "redirect:" + request.getHeader("Referer");
			}
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 상태변경서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "공지사항 상태변경 요청이 실패되었습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	
	}
	
	
}
