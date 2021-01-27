package com.example.service;

import java.util.List;

import com.example.domain.Member;
import com.example.domain.MemberType;

public interface MemberService {

	List<Member> getMemberList() throws Exception;

	Member getMemberById(Integer id) throws Exception;

	void addMember(Member member) throws Exception;

	void editMember(Member member) throws Exception;

	void deleteMember(Integer id) throws Exception;

	List<MemberType> getTypeList() throws Exception;

	//ページ分割機能用
	int getTotalPages(int numPerPage) throws Exception;
	List<Member> getMemberListByPage(int page, int numPerPage) throws Exception;


}
