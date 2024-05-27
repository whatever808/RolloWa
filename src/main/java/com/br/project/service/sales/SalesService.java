package com.br.project.service.sales;

import org.springframework.stereotype.Service;

import com.br.project.dao.sales.SalesDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SalesService {

	private final SalesDao salesDao;
}
