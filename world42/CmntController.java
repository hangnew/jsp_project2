package com.project02.world42;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project02.world42.DAO.CmntDAO;
import com.project02.world42.DTO.CmntDTO;

@Controller
public class CmntController {

	@Autowired
	CmntDAO dao;
	
	@RequestMapping(value = "cmnt.readAll", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public List<CmntDTO> read(@ModelAttribute CmntDTO cmntDTO) {
		List<CmntDTO> list = dao.cmntRead(cmntDTO);
		return list;
	}
	
	@RequestMapping(value = "cmnt.insert", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void insert(@ModelAttribute CmntDTO cmntDTO) {
		dao.cmntCreate(cmntDTO);
	}
	
	@RequestMapping(value = "cmnt.delete", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void delete(@ModelAttribute CmntDTO cmntDTO) {
		dao.cmntDelete(cmntDTO);
	}
	
}