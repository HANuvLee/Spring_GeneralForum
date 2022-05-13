package com.spring.board.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.loginDao;
import com.spring.board.service.loginService;
import com.spring.board.vo.User_infoVo;

@Service
public class loginServiceImpl implements loginService {

	@Autowired
	loginDao loginDao;
	
	@Override
	public User_infoVo loginChk(User_infoVo res) throws Exception {
		// TODO Auto-generated method stub
		return loginDao.loginChk(res);
	}

}
