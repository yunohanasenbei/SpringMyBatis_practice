package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.dao.MemberDao;
import com.example.dao.MemberTypeDao;
import com.example.domain.Member;
import com.example.domain.MemberType;

@Service
@Transactional(rollbackFor = Exception.class)
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberDao memberDao;

	@Autowired
	MemberTypeDao memberTypeDao;

	@Override
	public List<Member> getMemberList() throws Exception {
		// TODO 自動生成されたメソッド・スタブ
		return memberDao.selectAll();
	}

	@Override
	public Member getMemberById(Integer id) throws Exception {
		// TODO 自動生成されたメソッド・スタブ
		return memberDao.selectById(id);
	}

	@Override
	public void addMember(Member member) throws Exception {

		memberDao.insert(member);
	}

	@Override
	public void editMember(Member member) throws Exception {

		memberDao.update(member);
	}

	@Override
	public void deleteMember(Integer id) throws Exception {

		memberDao.delete(id);
	}

	@Override
	public List<MemberType> getTypeList() throws Exception {
		// TODO 自動生成されたメソッド・スタブ
		return memberTypeDao.selectAll();
	}

	@Override
	public int getTotalPages(int numPerPage) throws Exception {
		double totalNum = (double) memberDao.count();
		return (int) Math.ceil(totalNum / numPerPage);
	}

	@Override
	public List<Member> getMemberListByPage(int page, int numPerPage) throws Exception {
		int offset = numPerPage * (page - 1);
		return memberDao.selectLimited(offset, numPerPage);
	}


}
