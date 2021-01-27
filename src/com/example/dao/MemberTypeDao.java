package com.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.domain.MemberType;

@Mapper
public interface MemberTypeDao {

	List<MemberType> selectAll() throws Exception;
}
