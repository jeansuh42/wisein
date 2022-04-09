package com.wisein.wiselab.controller;

import com.wisein.wiselab.dto.MemberDTO;
import com.wisein.wiselab.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class testController2 {

	@Autowired
	MemberService service;

	@Autowired
	BCryptPasswordEncoder passEncoder;

	@GetMapping(value="/main")
	public String main () throws Exception {
		return "cmn/main";
	}

	@GetMapping(value="/fooddetail")
	public String foodDetail () throws Exception {
		return "cmn/foodDetail";
	}

	@GetMapping(value="/foodlist")
	public String foodList () throws Exception {
		return "cmn/foodList";
	}

	@GetMapping(value="/qalist")
	public String qaList () throws Exception {
		return "cmn/qaList";
	}

	@GetMapping(value="/databoard")
	public String dataBoard () throws Exception {
		return "cmn/dataBoard";
	}

	@GetMapping(value="/reg")
	public String getRegister () throws Exception {
		return "reg";
	}

	@PostMapping(value = "/reg")
	public String postRegister (MemberDTO dto) throws Exception {

		// Password Encoding by BCryptPasswordEncoder
		String inputPw = dto.getPw();
		String passEncd = passEncoder.encode(inputPw);
		dto.setPw(passEncd);

		service.register(dto);
		return "redirect:/reg";
	}


	@GetMapping(value="/login")
	public String getLogin () throws Exception {
		return "login";
	}

	@PostMapping(value = "/login")
	public String postLogin(MemberDTO dto, HttpServletRequest req, RedirectAttributes rttr) throws Exception {

		HttpSession session= req.getSession();
		MemberDTO login = service.login(dto);
		String lgFailMessage; // 로그인 실패 시의 RedirectAttributes

		if (login != null) {
			// 해당 MemberDTO를 받아왔을 때에만 출력
			boolean passMat = passEncoder.matches(dto.getPw(), login.getPw());

			if(passMat) {
				// matches를 통한 패스워드 매칭 시 로그인 성공
				session.setAttribute("member", login);
			} else {
				// login이 null || 패스워드 매칭 실패
				session.setAttribute("member", null);
				lgFailMessage ="로그인에 실패했습니다.";
				rttr.addFlashAttribute("msg", lgFailMessage);
				return "redirect:/login";
			}

		} else {
			//  해당 MemberDTO를 받아오지 못했을 경우 - mem_status = 'N' 등
			lgFailMessage ="로그인에 실패했습니다.";
			rttr.addFlashAttribute("msg", lgFailMessage);
			return "redirect:/login";
		}
		
		return "redirect:/login";
	}

	@GetMapping(value = "/logout")
	public String logout(HttpSession session) throws Exception {
		service.logout(session);
		return "redirect:/";
	}

}