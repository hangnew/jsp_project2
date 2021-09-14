package com.project02.world42;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project02.world42.DAO.MainDAO;
import com.project02.world42.DAO.MiniroomDAO;
import com.project02.world42.DTO.MainDTO;
import com.project02.world42.DTO.MiniroomDTO;
import com.project02.world42.module.MainCookie;

@Controller
public class MainController {

	@Autowired
	MainDAO mainDao;
	@Autowired
	MiniroomDAO miniDao;
	@Autowired
	MainCookie cookie;
	@Autowired
	HttpServletResponse response;
	@Autowired
	HttpServletRequest request;

	@RequestMapping("main.logout")
	public String mainLogout(HttpSession session) {
		session.invalidate();
		cookie.crushCookie(response);
		return "redirect:index.jsp";
	}

	@RequestMapping("main.home")
	public void mainRead(MainDTO mainDTO, Model model, HttpSession session) {
		MainDTO dto = mainDao.mainReadAll(mainDTO);
		List<Map<String, String>> list = mainDao.mainRead1Chon(mainDTO);
		MiniroomDTO dto2 = miniDao.miniRead(dto);
		session.setAttribute("sessionId", dto.getMemid());
		session.setAttribute("sessionAcorn", dto.getMacorn());
		session.setAttribute("session1chonSize", dto.getM1chonSize());
		if (cookie.bakeCookie(dto.getmIdx(), request, response)) {
			mainDao.mainTodayUp(dto);
		};
		model.addAttribute("main", dto);
		model.addAttribute("m1chon", list);
		model.addAttribute("miniroom", dto2);
	}

	@RequestMapping("main.others")
	public void mainReadOther(MainDTO mainDTO, Model model, HttpSession session) {
		MainDTO dto = mainDao.mainReadAll(mainDTO);
		List<Map<String, String>> list = mainDao.mainRead1Chon(mainDTO);
		MiniroomDTO dto2 = miniDao.miniRead(dto);
		if (cookie.bakeCookie(dto.getmIdx(), request, response)) {
			mainDao.mainTodayUp(dto);
		}
		;
		model.addAttribute("main", dto);
		model.addAttribute("m1chon", list);
		model.addAttribute("miniroom", dto2);
	}
	
	@RequestMapping(value = "main.readTitle", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public MainDTO mainReadTitle(@ModelAttribute MainDTO mainDTO) {
		MainDTO dto = mainDao.readTitle(mainDTO);
		return dto;
	}
	
	@RequestMapping(value = "main.updateTitle", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void mainUpdateTitle(@ModelAttribute MainDTO mainDTO) {
		mainDao.updateTitle(mainDTO);
	}
	
	@RequestMapping(value = "main.readProfile", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public MainDTO mainReadProfile(@ModelAttribute MainDTO mainDTO) {
		MainDTO dto = mainDao.readProfile(mainDTO);
		return dto;
	}

	@RequestMapping(value = "main.updateProfile", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public void mainUpdateProfile(@ModelAttribute MainDTO mainDTO) {
		mainDao.updateProfile(mainDTO);
	}
	
}
