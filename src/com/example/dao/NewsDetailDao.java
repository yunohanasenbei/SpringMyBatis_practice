package com.example.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.domain.NewsDetail;

@Mapper
public interface NewsDetailDao {

	void insert(NewsDetail detail);

}
