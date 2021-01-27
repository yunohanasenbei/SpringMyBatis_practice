package com.example.service;


import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.dao.NewsDao;
import com.example.dao.NewsDetailDao;
import com.example.dao.NewsTargetDao;
import com.example.domain.News;
import com.example.domain.NewsDetail;
import com.example.domain.NewsForm;

@Service
public class NewsServiceImpl implements NewsService{

	@Autowired
	NewsDao newsDao;

	@Autowired
	NewsDetailDao newsDetailDao;

	@Autowired
	NewsTargetDao newsTargetDao;

	@Override
	public List<News> getNewsList() throws Exception {


		return newsDao.selectAll();
	}

	@Override
	public News getNewsById(Integer id) throws Exception {

		return newsDao.selectById(id);
	}

	@Override
	public void addNews(NewsForm formData) throws Exception {

		//newsテーブルへの追加
		News news = new News();
		news.setTitle(formData.getTitle());
		news.setAuthor(formData.getAuthor());
		news.setPostDate(formData.getPostDate());
		newsDao.insert(news);

		//news_detailsテーブルへの追加
		NewsDetail detail = new NewsDetail();

		//画像があればアップロード
		MultipartFile upfile = formData.getUpfile();
		if(!upfile.isEmpty()) {
			String photo = upfile.getOriginalFilename();
			System.out.println(photo);
			upfile.transferTo(new File(formData.getUploadDirectory() + photo));
			detail.setPhoto(photo);
		}

		detail.setNewsId(news.getId());
		detail.setArticle(formData.getArticle());
		newsDetailDao.insert(detail);

		//news_targetsテーブルへの追加
		for(Integer targetId : formData.getTargetIdList()) {
			newsTargetDao.insert(news.getId(), targetId);
		}
	}


}
