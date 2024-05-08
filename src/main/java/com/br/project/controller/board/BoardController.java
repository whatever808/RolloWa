package com.br.project.controller.board;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.board.BoardDto;
import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.common.PageInfoDto;
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
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	private final FileController attachmentController;
	
	private final DepartmentService departmentService;
	
	/**
	 * @method : 게시글 목록조회
	 */
	@RequestMapping(value="/list.do")
	public ModelAndView selectBoardList(@RequestParam(value="page", defaultValue="1") int currentPage
									   ,@RequestParam Map<String, String> filter
									   ,ModelAndView mv) {
		// 게시글 페이징바 생성
		PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(filter), currentPage, 5, 10);
		
		// 응답페이지 지정 및 응답데이터 반환
		mv.addObject("boardList", boardService.selectBoardList(pageInfo, filter));		// 게시글 목록
		mv.addObject("pageInfo", pageInfo);
		mv.addObject("departmentList", departmentService.selectDepartmentList());		// 부서 목록
		mv.addObject("filter", filter);
		mv.setViewName("/board/list");
		
		return mv;
	}
	
	/**
	 * @method : 게시글 등록페이지 반환
	 */
	@RequestMapping(value="/post.page")
	public String showBoardPostForm() {
		return "board/post";
	}
	
	/**
	 * @param board
	 * @param uploadFiles
	 
	@PostMapping(value="/post.do")
	public void postBoard(BoardDto board
						 ,List<MultipartFile> uploadFiles) {
		// 첨부파일 업로드
		List<AttachmentDto> attachmentList = attachmentController.uploadFiles(uploadFiles);
		
		// 등록할 게시글 정보 (작성자, 수정자, 제목, 내용, 카테고리)
	
		
		
	}
	*/
	
	

	
}
