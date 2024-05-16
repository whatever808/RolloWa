package com.br.project.controller.common;




import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.pay.PayDto;
import com.br.project.service.pay.PayService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
public class CommonController {
	
	public static HashMap<String, Object> getParameterMap(HttpServletRequest request) {

        HashMap<String, Object> parameterMap = new HashMap<String, Object>();

        Enumeration<String> enums = request.getParameterNames();

        while (enums.hasMoreElements()) {
            String paramName = (String)enums.nextElement();
            String[] parameters = request.getParameterValues(paramName);

            if (parameters.length > 1) {
                parameterMap.put(paramName, parameters);
            } else {
                parameterMap.put(paramName, parameters[0]);
            }
        }

        return parameterMap;
    }
}
