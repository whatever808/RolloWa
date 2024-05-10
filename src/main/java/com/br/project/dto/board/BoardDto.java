package com.br.project.dto.board;

import java.util.List;

import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.common.GroupDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class BoardDto {

	private String boardNo;
	private String registEmp;
	private String modifyEmp;
	private String registDate;
	private String modifyDate;
	private String title;
	private String content;
	private String profileURL;
	private int readCount;
	private String status;
	private String category;
	private int attachmentYN;
	private List<AttachmentDto> attachmentList;
	private List<GroupDto> departmentList;
	
}
