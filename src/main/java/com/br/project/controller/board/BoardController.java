package com.br.project.controller.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.service.board.BoardService;
import com.br.project.service.common.department.DepartmentService;
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
	private final DepartmentService departmentService;
	
	/**
	 * @method : 게시글 목록조회
	 */
	@GetMapping(value="/list.do")
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
	 * @method : 카테고리별 게시글 목록조회
	 */
	@RequestMapping(value="/list.filter")
	@ResponseBody
	public Map<String, Object> ajaxSelectBoardListByCategory(@RequestParam(value="page", defaultValue="1") int currentPage
										  					,@RequestParam Map<String, String> request) {
		// 게시글 페이징바 생성
		PageInfoDto pageInfo = pagingUtil.getPageInfoDto(boardService.selectTotalBoardCount(request), currentPage, 5, 10);
		
		// 응답데이터 변환
		Map<String, Object> result = new HashMap<>();
		result.put("boardList", boardService.selectBoardList(pageInfo, request));
		result.put("pageInfo", pageInfo);
		
		return result;
	}
	
	/**
	 * 게시글 등록페이지 반환
	 */
	@GetMapping(value="/postForm.page")
	public String showBoardPostForm() {
		return "board/postForm";
	}
	
	
	

	
}
