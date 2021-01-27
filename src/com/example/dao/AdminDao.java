package com.example.dao;

import com.example.domain.Admin;

public interface AdminDao {

	Admin selectByLoginId(String loginId) throws Exception;
}
