package com.spring.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.member.MemberVO;
import com.spring.order.*;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private OrderService orderService; 

	    
	// 회원가입 클릭 (메인, 로그인페이지)
	@RequestMapping(value = "/join.do", produces = "application/json; charset=utf-8")
	public String join() {
		return "joinform";
	}

	
	  //아이디 중복확인
	  
	  @RequestMapping(value="/chk_id.do", produces = "application/json; charset=utf-8")
	  @ResponseBody 
	  public Map<String, Object> check_id(HttpServletRequest request,MemberVO mo) {
	  //System.out.println("컨트롤러mo="+mo.getMember_id());
	  Map<String,Object> result = new HashMap<String, Object>(); 

		  int res = memberservice.member_id(mo);
		 
		  if (res == 1) {
				result.put("res", "OK");
			} else {
				result.put("res", "FAIL");
				result.put("message", "Failure");

			}
			return result;
		}
	 
	
	// 멤버 추가
	@RequestMapping(value = "/insertMember.do", produces = "application/json; charset=utf-8")
	@ResponseBody // 데이터를 전송(view가 아니다)
	public Map<String, Object> insertMember(MemberVO mo) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			int res = memberservice.member_insert(mo);
			System.out.println("회원가입성공 id="+mo.getMember_id());
			result.put("res", "OK");
		} catch (Exception e) {
			result.put("res", "FAIL");
			result.put("message", "Failure");
		}
		return result;
	}

	
	// 개인정보 수정 클릭시 비밀번호 입력페이지로 이동
	@RequestMapping(value = "/profile1.do", produces = "application/json; charset=utf-8", method = { RequestMethod.GET, RequestMethod.POST })
	public String password(Model model, HttpSession session) {
		
		String str=(String)session.getAttribute("member_id");
		String last = str.substring(str.length() - 1);
		
		MemberVO memberVO = orderService.getMemberInfo(str);
		// 멤버 아이디 구분해서 member_name, phone, loc 값 공백 
		
		//다른 서비스 계정으로 로그인 할때
		if(last.equals( "K")|| last.equals("N")||last.equals("G")) {
			
			String member_name = memberVO.getMember_name();
			
			String member_phone = " ";
				if(memberVO.getMember_phone() != null) {
   		 		
   		 			member_phone = memberVO.getMember_phone();
				}
				
			String member_email = memberVO.getMember_email();
			
			String member_addr1 = " ";
			String member_addr2 = " ";
   		 	if(memberVO.getMember_loc() != null) {
   		 		String addr = memberVO.getMember_loc();
   		 		
   		 		String[] locArr = addr.split("!");
   		 		member_addr1 = locArr[0];
   		 		
   		 		if(locArr.length == 2) {
   		 		member_addr2 = locArr[1];	
   		 		}
   		 	}
   		 	
   		 	String zipcode = " ";
   		 		if(memberVO.getMember_zipcode() != null) {
   		 			zipcode = memberVO.getMember_zipcode();
   		 		}
   		 	
   		 	model.addAttribute("member_name", member_name); 
			model.addAttribute("member_phone", member_phone);
			model.addAttribute("member_email", member_email);
			model.addAttribute("member_addr1", member_addr1);
			model.addAttribute("member_addr2", member_addr2);
			model.addAttribute("zipcode", zipcode);

   		 	
   		 	return "profile";
		
		//일반 로그인시	
		} else {
			System.out.println("id="+str);
			return "password";
		}
	}

	// 비밀번호 확인
	@RequestMapping(value = "/chk_pw.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> chk_password(HttpServletRequest request, MemberVO mo) {
		Map<String, Object> result = new HashMap<String, Object>();

		int res = memberservice.member_password(mo);

		if (res == 1) {
			result.put("res", "OK");
		} else {
			result.put("res", "FAIL");
			result.put("message", "Failure");

		}
		return result;
	}

	// 일반로그인시 비밀번호 입력후 개인정보수정 페이지로 이동
	@RequestMapping(value = "/profile2.do", produces = "application/json; charset=utf-8")
	public String profile(HttpServletRequest request, Model model, HttpSession session) {

		String ids = (String) session.getAttribute("member_id");
		 System.out.println("session="+ids);

		MemberVO memberVO = orderService.getMemberInfo(ids);
	
			String member_name = memberVO.getMember_name();
			String member_phone = memberVO.getMember_phone();
			String member_email = memberVO.getMember_email();

   		 	String addr = memberVO.getMember_loc();
   		 	
   		 	String[] locArr = addr.split("!");
   		 	
   		 	String member_addr1 = locArr[0];
   		 	String member_addr2 = " ";
   		 	if(locArr.length == 2) {
   		 		member_addr2 = locArr[1];	
   		 	}
   		 	
   		 	String zipcode = memberVO.getMember_zipcode();

   		 	
   		 	model.addAttribute("member_name", member_name); 
			model.addAttribute("member_phone", member_phone);
			model.addAttribute("member_email", member_email);
			model.addAttribute("member_addr1", member_addr1);
			model.addAttribute("member_addr2", member_addr2);
			model.addAttribute("zipcode", zipcode);

			return "profile";
	}

	// 멤버 수정
	@RequestMapping(value = "/updateMember.do", produces = "application/json; charset=utf-8")
	@ResponseBody // 데이터를 전송(view가 아니다)
	public Map<String, Object> updateMember(MemberVO mo) {
		System.out.println("여긴 오니?");
		Map<String, Object> result = new HashMap<String, Object>();
		int res = memberservice.member_update(mo);
		System.out.println("res="+res);	
		if(res==1) {
			result.put("res", "OK");
		} else {
			result.put("res", "FAIL");
			result.put("message", "Failure");
		}
		return result;
	}


	// 회원탈퇴 클릭시
	@RequestMapping(value = "/withdraw.do", produces = "application/json; charset=utf-8")
	public String withdraw() {
		return "withdraw";
	}

	// 탈퇴시 비밀번호 입력
	 @RequestMapping(value="/withdraw_pass.do", produces = "application/json; charset=utf-8")
	 @ResponseBody 
	 public Map<String, Object> withdraw(HttpServletRequest request,MemberVO mo) {
	  //System.out.println("컨트롤러mo="+mo.getMember_password()); Map<String, Object>
	  Map<String, Object> result = new HashMap<String, Object>();
	  
	  int res = memberservice.member_password(mo);
	  
	  if(res == 1) { 
		  result.put("res", "OK"); 
	  } else { 
		  result.put("res", "FAIL");
		  result.put("message", "Failure");
	  
	  	} 
	  return result; 
	  }
	 
	 //비밀번호 일치하면 탈퇴 페이지로 이동
	 @RequestMapping(value = "/withdrawform.do", produces = "application/json; charset=utf-8")
		public String withdrawform() {
			return "withdrawform";
	 }

	 
	/*
	 * //회원삭제
	 * 
	 * @RequestMapping(value = "deleteMember.do", produces =
	 * "application/json; charset=utf-8")
	 * 
	 * @ResponseBody public Map<String, Object> deleteMember(MemberVO mo) { //
	 * System.out.println("컨트롤러mo="+mo.getMember_password()); Map<String, Object>
	 * result = new HashMap<String, Object>();
	 * 
	 * int res = memberservice.member_delete(mo.getMember_id());
	 * 
	 * if (res == 1) { result.put("res", "OK"); } else { result.put("res", "FAIL");
	 * result.put("message", "Failure");
	 * 
	 * } return result; }
	 */
	 
}
