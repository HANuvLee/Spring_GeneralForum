package com.spring.board.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.Come_codeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.PagingVo;
import com.spring.board.vo.User_infoVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Model model, String currentPage, PageVo pageVo, HttpSession session) throws Exception{
		
		int totalCnt = 0;
		
		User_infoVo res = (User_infoVo)session.getAttribute("res");
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		if (currentPage == null){
			currentPage = "1";
			pageVo.setPageNo(Integer.parseInt(currentPage));
		}else {
			pageVo.setPageNo(Integer.parseInt(currentPage));
		}
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(pageVo);
		PagingVo pg = new PagingVo(totalCnt, currentPage);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pg", pg);
		model.addAttribute("chkList",pageVo.getChk());

		if(res == null) {
			return "redirect:/login/Login.do";
		}else {
		return "board/boardList";
		}
	}

	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Model model, HttpSession session
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		User_infoVo res = (User_infoVo)session.getAttribute("res");
		if(res == null) {
			return "redirect:/login/Login.do";
		}
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Model model, HttpSession session)throws Exception{
		User_infoVo res = (User_infoVo)session.getAttribute("res");
		if(res == null) {
			return "redirect:/login/Login.do";
		}
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	public String boardWriteAction(BoardVo boardVo) throws Exception{
				
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
	
		String creator = boardVo.getCreator();
		boardVo.setCreator(new String(creator.getBytes("8859_1"),"euc-kr"));
		
		int resultCnt = boardService.boardInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return "redirect:/board/boardList.do";
	}
	
	@RequestMapping(value ="/board/boardUpdate.do" , method = RequestMethod.GET)
	public String boardupdate(Model model, String board_type, int board_num, HttpSession session) throws Exception {
		
		User_infoVo res = (User_infoVo)session.getAttribute("res");
		if(res == null) {
			return "redirect:/login/Login.do";
		}
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(board_type,board_num);
		
		model.addAttribute("boardType", board_type);
		model.addAttribute("boardNum", board_num);
		model.addAttribute("board", boardVo);
		
		return "board/boardUpdate";
	}
	
	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	public String boardUpdateAction(Model model, BoardVo boardVo) throws Exception{
		
		int updateResult = boardService.boardUpdate(boardVo);
		
		return"redirect:/board/boardList.do";
	}
	
	@RequestMapping(value = "/board/Join.do", method = RequestMethod.GET )
	public String join(Locale locale, Model model) throws Exception{
			
		List<Come_codeVo>phoneNum = new ArrayList<Come_codeVo>();
		phoneNum = boardService.phoneNumSelect();
		model.addAttribute("phoneNum", phoneNum);
	
		return"board/join";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/idDupChk.do", method = RequestMethod.POST)
	public int idDupChk(@RequestParam String user_id) throws Exception {

		int idDupRowCnt = boardService.idDupChk(user_id);
		
		return idDupRowCnt;
	}
	
	@RequestMapping(value = "/board/joinAction.do", method = RequestMethod.POST)
	public String joinAction(User_infoVo user_infoVo) throws Exception {
		
		String user_name = user_infoVo.getUser_name();
		user_infoVo.setUser_name(new String(user_name.getBytes("8859_1"),"euc-kr"));
	
		int joinCnt = boardService.join(user_infoVo);
		
		return "redirect:/login/Login.do";
	}
	

}
