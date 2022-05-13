package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.Come_codeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.User_infoVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String board_type, int board_num) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		if (board_type.equals("일반") ) {
			boardVo.setBoard_type("a01");
		}
		else if(board_type.equals("Q&A")) {
			boardVo.setBoard_type("a02");
		}
		else if(board_type.equals("익명")) {
			boardVo.setBoard_type("a03");
		}
		else if(board_type.equals("자유")) {
			boardVo.setBoard_type("a04");
		}
		else if(board_type.equals("010")) {
			boardVo.setBoard_type("1");
		}
		else if(board_type.equals("011")) {
			boardVo.setBoard_type("2");
		}
		else if(board_type.equals("016")) {
			boardVo.setBoard_type("3");
		}
		else if(board_type.equals("017")) {
			boardVo.setBoard_type("4");
		}
		else if(board_type.equals("019")) {
			boardVo.setBoard_type("5");
		}
		else {
			boardVo.setBoard_type(board_type);
		}
		
		boardVo.setBoard_num(board_num);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardInsert(boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception{
		// TODO Auto-generated method stub
		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public List<Come_codeVo> phoneNumSelect() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.phoneNumSelect();
	}

	@Override
	public int idDupChk(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.idDupChk(user_id);
	}

	@Override
	public int join(User_infoVo user_infoVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.join(user_infoVo);
	}

}
