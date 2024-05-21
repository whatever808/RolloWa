package com.br.project.service.facility.store;

import org.springframework.stereotype.Service;

import com.br.project.dao.facility.store.StoreDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StoreService {

	private final StoreDao storeDao;
	
}
