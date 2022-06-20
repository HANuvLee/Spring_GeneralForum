package com.spring.board.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
import com.spring.board.vo.ReplyVo;
import com.spring.board.vo.User_infoVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String boardList(Model model, PageVo pageVo, HttpSession session) throws Exception{
		System.out.println("PageVo pageVo currentPage value => " + pageVo.getCurrentPage());
		System.out.println("PageVo pageVo currentPage value => " + pageVo.getCurrentPage());
		
		int totalCnt = 0;
		
		String user_id = (String)session.getAttribute("user_id");
		String user_name = (String)session.getAttribute("user_name");
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		
		/*if (pageVo.getCurrentPage() == 0){
			pageVo.setCurrentPage(1);
		}else {
			pageVo.setCurrentPage(1);
		}*/
		
		boardList = boardService.SelectBoardList(pageVo);
		totalCnt = boardService.selectBoardCnt(pageVo);
		PagingVo pg = new PagingVo(totalCnt, pageVo);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pg", pg);
		model.addAttribute("chkList",pageVo.getChk());

//		if(user_id == null) {
//			return "redirect:/login/Login.do";
//		}else {
		return "board/boardList";
	}

	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Model model, HttpSession session
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{	
		BoardVo boardVo = new BoardVo();
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		boardService.viewsUpdate(boardVo);
	
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Model model, HttpSession session)throws Exception{
		String user_id = (String)session.getAttribute("user_id");
		String user_name = (String)session.getAttribute("user_name");
		
		
		if(user_id == null) { return "redirect:/login/Login.do"; }
		 
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
		
		String user_id = (String)session.getAttribute("user_id");
		String user_name = (String)session.getAttribute("user_name");
		
		
		 if(user_id == null) { return "redirect:/login/Login.do"; }
		 
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
	
	@ResponseBody
	@RequestMapping(value = "/board/replyList.do", method = RequestMethod.GET)
	public List<ReplyVo> replyList(@RequestParam Map<String, String> param) throws Exception {
		List<ReplyVo> replyList = boardService.replyList(param);
		
		for(int i = 0; i<replyList.size(); i++) {
			int childCnt = boardService.repChildCnt(replyList.get(i).getReply_num());
			replyList.get(i).setChildCnt(childCnt);
		}
		return replyList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/replyInsert.do", method = RequestMethod.POST)
	public int replyInsert(@RequestParam Map<String, String> param, HttpSession session) throws Exception {
		String user_name = (String)session.getAttribute("user_name");
		param.put("creator", user_name);
		System.out.println(param);
		int chk = boardService.replyInsert(param);
		return chk;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/replyUpdate.do", method = RequestMethod.POST)
	public int replyUpdate(@RequestParam Map<String, String> param, HttpSession session) throws Exception {
		System.out.println(param);
		int replyUpdateChk = boardService.replyUpdate(param);

		return replyUpdateChk;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/replyDelete.do", method = RequestMethod.POST)
	public int replyDelete(@RequestParam Map<String, String> param, HttpSession session) throws Exception {
		System.out.println(param);
		int replyDeleteChk = boardService.replyDelete(param);

		return replyDeleteChk;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/rereplyInsert.do", method = RequestMethod.POST)
	public int rereplyInsert(@RequestParam Map<String, String> param, HttpSession session) throws Exception {
		String user_name = (String)session.getAttribute("user_name");
		param.put("creator", user_name);
		System.out.println(param);
		int rereplyList = boardService.rereplyInsert(param);
		
		return rereplyList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/rereplyList.do", method = RequestMethod.GET)
	public List<ReplyVo> rereplyList(@RequestParam Map<String, String> param, HttpSession session) throws Exception {
		System.out.println(param);
		List<ReplyVo> rereplyList = boardService.rereplyList(param);
		
		return rereplyList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/rereplyUpdate.do", method = RequestMethod.POST)
	public int rereplyUpdate(@RequestParam Map<String, String> param, HttpSession session) throws Exception {
		System.out.println(param);
		int rereplyUpdateChk = boardService.rereplyUpdate(param);

		return rereplyUpdateChk;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/board/rereplyDelete.do", method = RequestMethod.POST)
	public int rereplyDelete(@RequestParam Map<String, String> param, HttpSession session) throws Exception {
		System.out.println(param);
		int rereplyDeleteChk = boardService.rereplyDelete(param);

		return rereplyDeleteChk;
	}
}
