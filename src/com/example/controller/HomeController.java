package com.example.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.domain.Admin;
import com.example.service.AdminService;

@Controller
public class HomeController {

	@Autowired
	AdminService service;

	@GetMapping({"/","/home"})
	public String showHome(Model model) {
		model.addAttribute("admin",new Admin());
		return "home";
	}

	@PostMapping({"/","/home"})
	public String login(@Valid Admin admin,
						Errors errors,
						HttpSession session) throws Exception {
		//入力に不備がある
		if(errors.hasErrors()) {
			return "home";
		}
		// パスワードが正しくない
		if(!service.isCorrectIdAndPassword(admin.getLoginId(), admin.getLoginPass())) {
			errors.rejectValue("loginId","error.incorrect_id_password");
			return "home";
		}
		//正しいログインIDとパスワード
		//⇒セッションにログインIDを格納し、リダイレクト
		session.setAttribute("loginId", admin.getLoginId());
		System.out.println(admin.getLoginId());
		return "redirect:/";
	}

	@GetMapping("logout")
	public String Logout(HttpSession session) {
		//セッションを破棄し、トップページへ移動
		session.invalidate();
		return "redirect:/";
	}
}
