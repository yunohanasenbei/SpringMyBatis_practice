package com.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.domain.News;

@Mapper
public interface NewsDao {

	List<News> selectAll() throws Exception;
	News selectById (Integer id) throws Exception;
	void insert(News news) throws Exception;

}
