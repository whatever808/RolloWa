package com.br.project.dao.attendance;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.attendance.AttendanceDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class AttendanceDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	public int selectAttendanceListCount() {
		return sqlSessionTemplate.selectOne("attendanceMapper.selectAttendanceListCount");
	}


	public List<HashMap<String, String>> selectAttendanceList(PageInfoDto pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSessionTemplate.selectList("attendanceMapper.selectAttendanceList", null, rowBounds);
		
	}

	public List<AttendanceDto> SelectAttendanceCount() {
		return sqlSessionTemplate.selectList("attendanceMapper.SelectAttendanceCount");
	}

	// 아이디 중복체크
	public int selectUserIdCount(String checkId) {
		return sqlSessionTemplate.selectOne("attendanceMapper.selectUserIdCount", checkId);
	}

	// 회원가입
	public int insertMember(MemberDto member) {
		return sqlSessionTemplate.insert("attendanceMapper.insertMember", member);
	}

	
}
