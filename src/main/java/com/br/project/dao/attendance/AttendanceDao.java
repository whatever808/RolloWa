package com.br.project.dao.attendance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.attendance.AttendanceDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Repository
@Slf4j
public class AttendanceDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	// 출결 조회 dao
	public int selectAttendanceListCount() {
		return sqlSessionTemplate.selectOne("attendanceMapper.selectAttendanceListCount");
	}
	public List<HashMap<String, Object>> selectAttendanceList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("attendanceMapper.selectAttendanceList", paramMap);
	}
	
	/*
	public List<AttendanceDto> SelectAttendanceCount() {
		return sqlSessionTemplate.selectList("attendanceMapper.SelectAttendanceCount");
	}
	*/

	// 아이디 중복체크
	public int selectUserIdCount(String checkId) {
		return sqlSessionTemplate.selectOne("attendanceMapper.selectUserIdCount", checkId);
	}

	// 회원가입
	public int insertMember(MemberDto member) {
		return sqlSessionTemplate.insert("attendanceMapper.insertMember", member);
	}
	public List<AttendanceDto> SelectAttendanceCount() {
		return sqlSessionTemplate.selectList("attendanceMapper.SelectAttendanceCount");
	}

	

	// 출결 상태 조회
	/* 삭제 예정
	public List<GroupDto> selectStatus() {
		return sqlSessionTemplate.selectList("attendanceMapper.selectStatus");
	}
	 */
	
}
