package com.project02.world42.DAO;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.MainDTO;
import com.project02.world42.DTO.MiniroomDTO;

@Repository
public class MiniroomDAO {

	@Autowired
	SqlSessionTemplate mybatis;
	
	public void miniCreate() {
		
	}
	
	public MiniroomDTO miniRead(MainDTO mainDTO) {
		MiniroomDTO dto = mybatis.selectOne("mini.readRoom", mainDTO);
		return dto;
	}
	
	public void miniUpdate(MiniroomDTO miniroomDTO) {
		mybatis.update("mini.update", miniroomDTO);
	}
	
}
