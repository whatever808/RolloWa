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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.board.BoardDto;
import com.br.project.dto.common.AttachmentDto;
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
	public ModelAndView selectBoardList(@RequestParam(value="page", defaultValue="1") int currentPage
									   ,@RequestParam Map<String, String> filter
									   ,ModelAndView mv) {
		// 게시글 페이징바 생성
		PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(filter), currentPage, 5, 10);
		
		// 응답페이지 지정 및 응답데이터 반환
		mv.addObject("boardList", boardService.selectBoardList(pageInfo, filter));				// 게시글 목록
		mv.addObject("pageInfo", pageInfo);
		mv.addObject("departmentList", departmentService.selectDepartmentList("DEPT01"));		// 부서 목록
		mv.addObject("filter", filter);
		mv.setViewName("/board/list");
		
		return mv;
	}
	
	/**
	 * @method : 공지사항 목록조회(페이지별) (AJAX)
	 */
	@RequestMapping(value="/list.ajax")
	@ResponseBody
	public Map<String, Object> ajaxSelectBoardList(@RequestParam HashMap<String, String> filter){
		
		// 게시글 페이징바 생성
		PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(filter), 
														 Integer.parseInt(filter.get("page")), 5, 10);
		
		// 응답데이터 반환 (게시글목록)
		Map<String, Object> response = new HashMap<>();

		response.put("boardList", boardService.selectBoardList(pageInfo, filter));
		response.put("pageInfo", pageInfo);
		
		return response;
	}
	
	/**
	 * @method : 공지사항 목록조회(전체)(AJAX)
	 */
	@RequestMapping(value="/detail/list.ajax")
	@ResponseBody
	public List<BoardDto> ajaxSelectBoardList(HttpServletRequest request){
		HashMap<String, Object> params = getParameterMap(request);
		return boardService.selectBoardList(params);
	}
	
	
	/**
	 * @method : 공지사항 조회수 증가 (로그인사용자 != 작성자)
	 */
	@RequestMapping(value="/reader/detail.do")
	public String increaseReadCount(HttpServletRequest request) {
		
		HashMap<String, Object> params = getParameterMap(request);
		
		String category = params.get("category").toString();
		String department = params.get("department").toString();
		String condition = params.get("condition").toString();
		String keyword = params.get("keyword").toString();
		String no = params.get("no").toString();
		
		try {
			boardService.updateReadCount(no);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/board/detail.do?" + "category=" + category + "&"
											+ "department=" + department + "&"
											+ "condition=" + condition + "&"
											+ "keyword=" + keyword + "&"
											+ "no=" + no;
	}
	
	/**
	 * @method : 공지사항 상세조회
	 */
	@RequestMapping(value="/detail.do")
	public String showBoardDetail(HttpServletRequest request
								 ,Model model
								 ,RedirectAttributes redirectAttributes) {
		try {
			HashMap<String, Object> params = getParameterMap(request);
			
			BoardDto board = boardService.selectBoard(params);
			
			if(board != null) {
				// 조회된 공지사항이 있을경우(유효한 공지사항)
				model.addAttribute("board", board);
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
		
		return "board/detail";
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
			
			String status = board.getStatus() == "Y" ? "등록" : "저장";
			String alertMsg = "";
			if(result > 0) {
				// 공지사항 등록 성공
				alertMsg = "공지사항이 " + status + " 되었습니다.";
			}else {
				// 공지사항 등록 실패
				alertMsg = "공지사항 " + status + " 이 정상적으로 처리되지 못했습니다.";
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
	@RequestMapping(value="/modify.page")
	public String showBoardModifyPage(HttpServletRequest request
									 ,Model model) {
		try {
			String teamCode = ((MemberDto)request.getSession().getAttribute("loginMember")).getTeamCode();
			
			Map<String, String> params = new HashMap<>();
			params.put("upperGroupCode", "DEPT01");
			params.put("groupCode", "TEAM01");
			params.put("code", teamCode);
			
			model.addAttribute("department", departmentService.selectUppderCode(params));
			model.addAttribute("board", boardService.selectBoard(getParameterMap(request)));
			return "board/modify";
		}catch(Exception e) {
			e.printStackTrace();
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 공지사항 수정
	 */
	@RequestMapping(value="/modify.do")
	public String modifyBoard(BoardDto board
						     ,List<MultipartFile> uploadFiles
						     ,String[] delFileNoArr
						     ,HttpServletRequest request
						     ,RedirectAttributes redirectAttributes) {
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
			String alertMsg = "";
			if(result > 0) {
				alertMsg = "공지사항 수정이 완료되었습니다.";
				
				// 삭제할 첨부파일이 있었을 경우, 로컬저장소에서 업로드된 파일삭제
				if(!delAttachmentList.isEmpty()) {
					for(AttachmentDto attachment : delAttachmentList) {
						new File(attachment.getAttachPath(), attachment.getModifyName()).delete();
					}
				}
			}else {
				alertMsg = "공지사항 수정이 정상적으로 처리되지 못했습니다.";
				
				// 업로드한 첨부파일이 있었을 경우, 로컬저장소에서 등록실패한 파일삭제
				if(!board.getAttachmentList().isEmpty()) {
					for(AttachmentDto attachment : board.getAttachmentList()) {
						new File(attachment.getAttachPath(), attachment.getModifyName()).delete();
					}
				}
			}
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 수정서비스");
			redirectAttributes.addFlashAttribute("alertMsg", alertMsg);
			
			
		}catch(Exception e) {
			e.printStackTrace();
			/*
			redirectAttributes.addFlashAttribute("alertTitle", "공지사항 수정서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "공지사항 수정서비스 요청에 실패했습니다.");
			
			return "redirect:" + request.getHeader("Referer");
			*/
		}
		
		return "redirect:/board/list.do";
	}
	

	
}
