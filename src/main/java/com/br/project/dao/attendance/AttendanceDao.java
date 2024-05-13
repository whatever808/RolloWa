package com.br.project.dao.attendance;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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


	public List<MemberDto> selectAttendanceList(PageInfoDto pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSessionTemplate.selectList("attendanceMapper.selectAttendanceList", null, rowBounds);
		
	}
	
}
