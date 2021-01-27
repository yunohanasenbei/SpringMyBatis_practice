package com.example.domain;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class Admin {

	private Integer id;

	@NotBlank
	private String loginId;
	private String loginPass;

}
