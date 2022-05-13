package com.spring.board.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.loginDao;
import com.spring.board.vo.User_infoVo;

@Repository
public class loginDaoImpl implements loginDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public User_infoVo loginChk(User_infoVo res) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("loginChk", res);
	}
	
	
}
