package com.spring.board.service;

import com.spring.board.vo.User_infoVo;

public interface loginService {

	User_infoVo loginChk(User_infoVo res) throws Exception;
	
}
