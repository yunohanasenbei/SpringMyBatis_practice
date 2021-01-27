package com.example.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.domain.NewsForm;
import com.example.service.MemberService;
import com.example.service.NewsService;

@Controller
@RequestMapping("/news")
public class NewsController {

	@Autowired
	NewsService newsService;

	@Autowired
	MemberService memberService;

	@InitBinder
	public void InitBinderForm(WebDataBinder binder) {
		var dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	@GetMapping("/show")
	public String list(
						@RequestParam(name = "status", defaultValue = "") String status,
						Model model) throws Exception {
		if(status.equals("add")) {
			model.addAttribute("statusMessage","お知らせを追加しました");
		}
		model.addAttribute("newsList", newsService.getNewsList());
		return "news/list";
	}

	@GetMapping("/show/{id}")
	public String detail(@PathVariable Integer id,
						Model model) throws Exception {
		model.addAttribute("news",newsService.getNewsById(id));
		return "news/detail";
	}

	@GetMapping("/add")
	public String addGet(Model model) throws Exception {
		model.addAttribute("memberTypeList", memberService.getTypeList());
		model.addAttribute("newsForm", new NewsForm());
		return "news/add";
	}


	@PostMapping("/add")
	public String addPost(	HttpServletRequest request,
							HttpSession session,
							@Valid NewsForm newsForm,
							Errors errors,
							Model model) throws Exception {
		//ファイルのバリデーション
		MultipartFile upfile = newsForm.getUpfile();
		if(!upfile.isEmpty()) {
			//ファイルが選択されている場合は画像か否か判定する
			String type = upfile.getContentType();
			if(type.equals("image/jpeg")
				|| type.equals("image/png")
				|| type.equals("image/gif")) {
				//画像の場合、保存先をセットする
				newsForm.setUploadDirectory(
						request.getServletContext().getRealPath("/images") + "/");
			}
			else {
				//画像ではない場合、エラーメッセージを表示
				errors.rejectValue("upfile", "error.not_image_file");
			}
		}

		//バリデーション
		if(errors.hasErrors()) {
			model.addAttribute("memberTypeList",memberService.getTypeList());
			return "news/add";
		}

		//投稿者名は管理者のログインIDとする
		newsForm.setAuthor((String) session.getAttribute("loginId"));

		//データベースへ追加
		newsService.addNews(newsForm);
		return "redirect:/news/show?status=add";
	}

}
