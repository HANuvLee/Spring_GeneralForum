package com.spring.board.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.Come_codeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.ReplyVo;
import com.spring.board.vo.User_infoVo;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		String a = sqlSession.selectOne("board.boardList");

		return a;
	}

	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
	
		return sqlSession.selectList("board.boardList", pageVo);
	}

	@Override
	public int selectBoardCnt(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal", pageVo);
	}

	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}

	
	 @Override 
	 public int boardInsert(BoardVo boardVo) throws Exception { 
		 // TODO Auto-generated method stub
		 return sqlSession.insert("board.boardInsert", boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("board.boardUpdate", boardVo);
	}

	@Override
	public List<Come_codeVo> phoneNumSelect() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.phoneNumSelect");
	}

	@Override
	public int idDupChk(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.idDupChk", user_id);
	}

	@Override
	public int join(User_infoVo user_infoVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("join", user_infoVo);
	}

	@Override
	public List<ReplyVo> replyList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.replyList", param);
	}

	@Override
	public int repChildCnt(int reply_num) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.repChildCnt", reply_num);
	}

	@Override
	public int replyInsert(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.replyInsert", param);
	}

	@Override
	public List<ReplyVo> rereplyList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.rereplyList", param);
	}

	@Override
	public int replyUpdate(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.update("board.replyUpdate", param);
	}

}
