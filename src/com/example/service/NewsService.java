package com.example.service;

import java.util.List;

import com.example.domain.News;
import com.example.domain.NewsForm;

public interface NewsService {

	List<News> getNewsList() throws Exception;
	News getNewsById(Integer id) throws Exception;
	void addNews(NewsForm formData) throws Exception;




}
