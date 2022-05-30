package com.spring.board.dao;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.Come_codeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.ReplyVo;
import com.spring.board.vo.User_infoVo;

public interface BoardDao {

	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	public int selectBoardCnt(PageVo pageVo) throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;

	public List<Come_codeVo> phoneNumSelect() throws Exception;

	public int idDupChk(String user_id) throws Exception;

	public int join(User_infoVo user_infoVo) throws Exception;

	public List<ReplyVo> replyList(Map<String, String> param);

	public int replyInsert(Map<String, String> param);

	public int replyUpdate(Map<String, String> param);

	public int replyDelete(Map<String, String> param);

	public int rereplyInsert(Map<String, String> param);

}
