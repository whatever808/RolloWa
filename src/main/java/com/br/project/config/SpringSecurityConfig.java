package com.br.project.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SpringSecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
			.authorizeHttpRequests()
	        .mvcMatchers("/admin").hasRole("ADMIN")
	        .anyRequest().authenticated();

        return http.build();
    }
}
