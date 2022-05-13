package com.spring.board.dao;

import com.spring.board.vo.User_infoVo;

public interface loginDao {

	User_infoVo loginChk(User_infoVo res) throws Exception;

}
