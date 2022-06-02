package com.spring.board.service;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.Come_codeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.ReplyVo;
import com.spring.board.vo.User_infoVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(String board_type, int board_num) throws Exception;

	public int selectBoardCnt(PageVo pageVo) throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;

	public int boardUpdate(BoardVo boardVo) throws Exception;

	public List<Come_codeVo> phoneNumSelect() throws Exception;

	public int idDupChk(String user_id) throws Exception;

	public int join(User_infoVo user_infoVo) throws Exception;

	public List<ReplyVo> replyList(Map<String, String> param);

	public int repChildCnt(int reply_num);

}
