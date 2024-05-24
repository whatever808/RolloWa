package com.br.project.service.pay;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.common.attachment.AttachmentDao;
import com.br.project.dao.pay.VacationDao;
import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.pay.VacationDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VacationService {
	private final VacationDao vacationDao;
	private final AttachmentDao attachDao;

	/**
	 * 일정에 휴가를 조회하는 문
	 * @author dpcks
	 * @return
	 */
	public List<VacationDto> ajaxSelectVacation(Object request) {
		return vacationDao.ajaxSelectVacation(request);
	}

	/**
	 * 휴가 등록 매서드
	 * @param vacation
	 * @param files
	 * @return
	 */
	public int insertVacation(Map<String, Object> map) {
		
		int result = vacationDao.insertVacation((VacationDto)map.get("vacation"));
		
		List<AttachmentDto> uploadFile = (List<AttachmentDto>)map.get("uploadFile");
		
		if(uploadFile != null && !uploadFile.isEmpty()) {
			for (AttachmentDto att : uploadFile) {
				result *= attachDao.insertBoardAttachment(att);
			}
		}
		
		return result;
	}

	/**
	 * @author dpcks
	 * @param userNo
	 * @return
	 */
	public List<VacationDto> selectRequest(int userNo) {
		return vacationDao.selectRequest(userNo);
	}

	public int selectVacarionCount(int userNo) {
		return vacationDao.selectVacarionCount(userNo);
	}

	
}
