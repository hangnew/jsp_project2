package com.project02.world42.DAO;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.CmntDTO;

@Repository
public class CmntDAO {

	@Autowired
	SqlSessionTemplate mybatis;
	
	public List<CmntDTO> cmntRead(CmntDTO cmntDTO) {
		List<CmntDTO> list = mybatis.selectList("cmnt.read", cmntDTO);
		return list;
	}
	
	public void cmntCreate(CmntDTO cmntDTO) {
		mybatis.update("cmnt.insert", cmntDTO);
	}
	
	public void cmntDelete(CmntDTO cmntDTO) {
		mybatis.delete("cmnt.delete", cmntDTO);
	}
	
}
