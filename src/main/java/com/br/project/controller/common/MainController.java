package com.br.project.controller.common;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.member.MemberDto;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.UserRecord;
import com.google.firebase.auth.UserRecord.CreateRequest;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {
	// 메인페이지
	@RequestMapping("/")
	public String mainPage(@SessionAttribute(value="loginMember", required=false) MemberDto loginMember,
					HttpServletRequest request) {
		
		if(loginMember != null) {		
			return "mainpage/mainpage";
		}
		
		return "main";
	}
}

