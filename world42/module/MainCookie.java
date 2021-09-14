package com.project02.world42.module;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

@Service
public class MainCookie {

	public boolean bakeCookie(int midx, HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		Cookie visitCookie = null;
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				// Cookie의 name이 VISITED와 일치하는 쿠키를 viewCookie에 넣어준다
				if (cookies[i].getName().equals("VISITED")) {
					visitCookie = cookies[i];
				}
			}
		}
		// 만일 visitCookie가 없다면
		if (visitCookie == null) {
			// "VIEWCOOKIE"는 name, bbsNo + "," 은 value다
			Cookie newCookie = new Cookie("VISITED", midx + "&");
			newCookie.setMaxAge(60*60*24);
			response.addCookie(newCookie);
			return true;
		} else {
			String value = visitCookie.getValue();
			// 입력한 번호와 일치하는 번호가 없다면 추가해준다
			if (value.indexOf(midx + "&") < 0) {
				value += midx + "&";
				visitCookie.setValue(value);
				visitCookie.setMaxAge(60*60*24);
				response.addCookie(visitCookie);
				return true;
			} else {
				return false;
			}
		}
	}

	public void crushCookie(HttpServletResponse response) {
		Cookie emptyCookie = new Cookie("VISITED", null);
		emptyCookie.setMaxAge(0);
		response.addCookie(emptyCookie);
	}

}
