package com.br.project.config;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SpringSecurityConfig {
	@Autowired
	private HttpSession session;
	String contextPath = session.getServletContext().getContextPath();
	
	
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {    	
        http
			.authorizeHttpRequests()
	        .mvcMatchers(contextPath).hasRole("ADMIN")
	        .anyRequest().authenticated();

        return http.build();
    }
}
