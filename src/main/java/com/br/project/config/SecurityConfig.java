package com.br.project.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	/*@Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{

        http
        .authorizeHttpRequests((auth) -> auth
                .requestMatchers("/", "/login").permitAll() // 모든 사용자가 접근 가능
                .requestMatchers("/admin").hasRole("ADMIN") // ADMIN만 접근 가능
                .requestMatchers("/my/**").hasAnyRole("ADMIN", "USER") // ADMIN, USER만 접근 가능
                .anyRequest().authenticated() // 로그인한 사용자만 접근 가능
                // anyRequest() 나머지 경로에 대해 모두 처리 
        );
        
        

        return http.build();
    }*/
	
}
