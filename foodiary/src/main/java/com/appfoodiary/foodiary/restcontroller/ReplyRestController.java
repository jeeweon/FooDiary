package com.appfoodiary.foodiary.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.appfoodiary.foodiary.entity.ReplyDto;
import com.appfoodiary.foodiary.repository.ReplyDao;
import com.appfoodiary.foodiary.vo.ReplyListVO;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@CrossOrigin(origins = "http://127.0.0.1:5500/")
@Tag(name = "reply controller", description = "댓글")
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	
	@Autowired
	ReplyDao replyDao;
	
	@GetMapping("/list/{reviewNo}")
	@Operation(summary = "댓글목록 조회", description = "reviewNo 리뷰의 댓글목록을 조회합니다.")
	public List<ReplyListVO> list(@PathVariable int reviewNo) {
		return replyDao.list(reviewNo);
	}
	
	@PostMapping("/insert")
	@Operation(summary = "댓글 추가", description = "reviewNo 리뷰에 댓글을 추가합니다.")
	public boolean insert(@RequestBody ReplyDto dto) {
		int replyNo = replyDao.newReplyNo();
		dto.setReplyNo(replyNo);
		
		replyDao.write(dto);
		return true;
	}
	

}
