package com.spring.board.controller;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.board.HomeController;
import com.spring.board.service.loginService;
import com.spring.board.vo.User_infoVo;

@Controller
public class LoginController {
	
	@Autowired
	loginService loginService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/login/Login.do", method = RequestMethod.GET) 
	public String login(Model model)throws Exception{
		
		return "board/login";
	}
	
	@RequestMapping(value = "/login/loginAction.do", method = RequestMethod.POST)
	public String loginDupChk(User_infoVo res, HttpSession session) throws Exception {
		
		res = loginService.loginChk(res);
		
		if(res != null){
			session.setAttribute("user_id", res.getUser_id());
			session.setAttribute("user_name",res.getUser_name());
			return "redirect:/board/boardList.do";
		}else {
			return "redirect:/login/Login.do";
		}
	} 
	
	@RequestMapping(value = "/login/Logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/board/boardList.do";
	}
	
}
