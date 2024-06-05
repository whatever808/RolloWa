package com.br.project.service.pay;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.common.attachment.AttachmentDao;
import com.br.project.dao.pay.VacationDao;
import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.pay.VacationDto;

import lombok.RequiredArgsConstructor;

/**
 * @author GD
 *
 */
@Service
@RequiredArgsConstructor
public class VacationService {
	private final VacationDao vacationDao;
	private final AttachmentDao attachDao;

	/**
	 * 일정에 휴가를 조회하는 문
	 * 
	 * @author dpcks
	 * @return
	 */
	public List<VacationDto> ajaxSelectVacation(Object request) {
		return vacationDao.ajaxSelectVacation(request);
	}

	/**
	 * 휴가 등록 매서드
	 * 
	 * @param vacation
	 * @param files
	 * @return
	 */
	public int insertVacation(Map<String, Object> map) {

		int result = vacationDao.insertVacation((VacationDto) map.get("vacation"));

		List<AttachmentDto> uploadFile = (List<AttachmentDto>) map.get("uploadFile");

		if (uploadFile != null && !uploadFile.isEmpty()) {
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

	/**
	 * @param userNo
	 * @return
	 */
	public int selectVacarionCount(VacationDto vacation) {
		return vacationDao.selectVacarionCount(vacation);
	}

	/**
	 * @param vacation
	 * @return
	 */
	public int requestUpdate(Map<String, Object> map) {

		int result = vacationDao.updateVacation((VacationDto) map.get("vacation"));

		List<AttachmentDto> uploadFile = (List<AttachmentDto>) map.get("uploadFile");

		if (uploadFile != null && !uploadFile.isEmpty()) {
			for (AttachmentDto att : uploadFile) {
				result *= attachDao.insertBoardAttachment(att);
			}
		}
		return result;
	}

	/**
	 * @param fileInfo
	 * @return
	 */
	public List<AttachmentDto> selectOriginAtt(HashMap<String, Object> fileInfo) {
		return attachDao.selectBoardAttachmentList(fileInfo);
	}

	/**
	 * @param fileNo
	 */
	public void deleteRequest(String fileNo) {
		attachDao.deleteBoardAttachment(fileNo);
	}

	/**
	 * @param vacaNo
	 * @return
	 */
	public int deleteRcequest(String vacaNo) {
		return vacationDao.deleteRcequest(vacaNo);
	}

	/**
	 * @param vacation
	 * @return
	 */
	public List<VacationDto> searchOld(Map<String, Object> map) {
		return vacationDao.searchOld(map);
	}

	/**
	 * @param vacation
	 * @return
	 */
	public int RRequest(VacationDto vacation) {
		return vacationDao.RRequest(vacation);
	}

	/**
	 * @return
	 */
	public int updateYearLabor() {
		return vacationDao.updateYearLabor();
	}

	/**
	 * 전체 결제 요청 갯수
	 * @param vacation
	 * @return
	 */
	public int selectRefuseRequest(VacationDto vacation) {
		return vacationDao.selectRefuseRequest(vacation);
	}

	/**
	 * 페이징 정보를 가지고 결재게시글 조회
	 * @param map
	 * @return
	 */
	public List<VacationDto> searchreQuest(Map<String, Object> map) {
		return vacationDao.searchreQuest(map);
	}

	/**
	 * 휴가신청 및 휴가 철회 반려
	 * @param vacation
	 * @return
	 */
	public int singRefuse(VacationDto vacation) {
		return vacationDao.singRefuse(vacation);
	}

	public int singConfirm(VacationDto vacation) {
		return vacationDao.singConfirm(vacation);
	}

	public int requestRefuse(VacationDto vacation) {
		return vacationDao.requestRefuse(vacation);
	}
	public int requestConfine(VacationDto vacation) {
		return vacationDao.requestConfine(vacation);
	}

	public String selectUpperMember(int emp) {
		return vacationDao.selectUpperMember(emp);
	}
	public int vacationExpire(VacationDto vacation) {
		return vacationDao.vacationExpire(vacation);
	}

}
