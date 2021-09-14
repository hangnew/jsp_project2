package com.project02.world42.DAO;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project02.world42.DTO.MainDTO;

@Repository
public class MainDAO {

	@Autowired
	SqlSessionTemplate mybatis;
	
	public MainDTO mainReadAll(MainDTO mainDTO) {
		MainDTO dto = mybatis.selectOne("main.readAll", mainDTO);
		return dto;
	}
	
	public List<Map<String, String>> mainRead1Chon(MainDTO mainDTO) {
		List<Map<String, String>> list = mybatis.selectList("main.read1chon", mainDTO);
		return list;
	}
	
	public void mainTodayUp(MainDTO mainDTO) {
		mybatis.update("main.visitUp", mainDTO);
	}
	
	public MainDTO readTitle(MainDTO mainDTO) {
		MainDTO dto = mybatis.selectOne("main.readTitle", mainDTO);
		return dto;
	}
	
	public void updateTitle(MainDTO mainDTO) {
		mybatis.update("main.updateTitle", mainDTO);
	}
	
	public MainDTO readProfile(MainDTO mainDTO) {
		MainDTO dto = mybatis.selectOne("main.readProfile", mainDTO);
		return dto;
	}
	
	public void updateProfile(MainDTO mainDTO) {
		mybatis.update("main.updateProfile", mainDTO);
	}
	
}
