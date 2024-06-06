<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	/* Basic Container Styles */
.containeres {
    display: flex;
    flex-direction: column;
    background-color: #f9f9f9;
    padding: 20px;
    font-family: Arial, sans-serif;
    max-width: 1400px;
}

/* Top Menu */
.top-menu {
    display: flex;
    justify-content: space-between;
    margin-bottom: 34px;
    
}

.top-menu-item {
   	padding: 10px 20px;
    border: 4px solid #e0e0e0;
    border-radius: 26px;
    margin-right: 10px;
    cursor: pointer;
    text-align: center;
    font-size: 14px;
    color: #555555;
    width: 200px;
    height: 100px;
    text-align: center;
    align-content: space-around;
    justify-content: space-around;
    align-items: center;
    background-color: #dc4c7387;
    font-size: 16px;
    display: flex;
    flex-wrap: nowrap;
    flex-direction: column;
    justify-content: space-evenly;
}
.top-menu-item:hover{background-color: rgb(255, 236, 241);}

/* Highlighted Boxes */
.highlight-boxes {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.highlight-box {
  	flex: 1;
    padding: 21px;
    margin: 10px;
    background-color: #ffffff;
    border: 3px solid #e0e0e0;
    border-radius: 22px;
    text-align: center;
    font-size: 14px;
    color: #555555;
    cursor: pointer;
    /* display: flex; */
    flex-direction: column;
    height: 157px;
    align-items: center;
    justify-content: space-evenly;
    align-content: space-around;
}

.highlight-box:last-child {
    margin-right: 0;
}

.highlight-box .title {
    font-size: 14px;
    margin-bottom: 10px;
}

.highlight-box .count {
  font-size: 24px;
    color: #F44336;
    display: flex;
    flex-direction: column;
    align-content: stretch;
    flex-wrap: wrap;
}

/* List of Requests */
.requests-list {
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 5px;
    padding: 20px;
    height: 856px;
}

.request-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 15px 0;
    border-bottom: 1px solid #e0e0e0;
    height: 800px;
}

.request-item:last-child {
    border-bottom: none;
}

.request-details {
    flex: 1;
}

.request-title {
    font-size: 16px;
    color: #333333;
    margin-bottom: 5px;
}

.request-meta {
    font-size: 12px;
    color: #777777;
}

.request-avatar {
    margin-right: 15px;
}

.request-avatar img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
}

.request-status {
    display: flex;
    align-items: center;
}

.request-status-icon {
    margin-right: 10px;
    color: #007bff;
}

.request-actions {
    display: flex;
    align-items: center;
}

.request-action {
    margin-right: 10px;
    color: #007bff;
    cursor: pointer;
    font-size: 14px;
}

.request-action:last-child {
    margin-right: 0;
}




 body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f8;
    }
    
    .content2 {
       padding: 20px;
    	 margin: auto;
    	 width: 100%;
    	 height: auto;
    }
    .task-table th, .task-table td {
        text-align: center;
        vertical-align: middle;
    }
    .badge {
        padding: 5px 10px;
        border-radius: 12px;
    }
    
   
    
   .filter-buttons button {
          margin-right: 10px;
          border: none;
          background-color: #f8f9fa;
          color: #007bff;
          border-radius: 20px;
          padding: 5px 10px;
    }
    
    .filter-buttons button.active {
        background-color: #007bff;
        color: white;
    }
    
    .filter-buttons button:hover {
        background-color: #007bff;
        color: white;
    }
    .search-bar {
        border: none;
        background-color: #f8f9fa;
        border-radius: 20px;
        padding: 5px 15px;
    }
    .btn-task {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 20px;
        padding: 5px 15px;
    }
    .btn-task:hover {
        background-color: #0056b3;
    }
    
    .pending {
        background-color: #e91e6387;
    }
    .completes {
        background-color: #F44336;
    }
    .progresses {
        background-color: #3F51B5;;
    }
    /* 추가적인 배지 상태에 대한 스타일 */
    .rejected {
        background-color: #FF9800;;
    }
    
    #cen_bottom_pagging{
    	display: flex;
    	justify-content: center;
    	margin: 13px;
    }
    #svg{
      width: 49px;
    	color: #007bff;
    	height: 21px;
    }
    #tStatus td:hover{cursor: pointer;}
    .pagination2 li:hover {
			cursor: pointer;
		}
		.pagination li:hover {
			cursor: pointer;
		}
		.pagination li{padding: 6px 12px;}
	
		/* 기본 스타일 설정 */
		.custom-select {
		    width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		}
		
		/* 옵션 스타일 설정 */
		.custom-select option {
		    padding: 10px; /* 내측 여백 */
		    background-color: #fff; /* 배경 색상 */
		    color: #333; /* 글꼴 색상 */
		}
		
		/* 포커스 및 호버 스타일 설정 */
		.custom-select:focus {
		    border-color: #007bff; /* 포커스 시 테두리 색상 */
		    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 그림자 */
		    outline: none; /* 포커스 시 외곽선 제거 */
		}
		
		.custom-select option:hover {
		    background-color: #007bff; /* 호버 시 배경 색상 */
		    color: #fff; /* 호버 시 글꼴 색상 */
		}
		
		/* 화살표 추가를 위한 스타일 설정 */
		.custom-select-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.custom-select::after {
		    content: '▼'; /* 화살표 모양 (유니코드 화살표 사용) */
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		    pointer-events: none; /* 화살표 클릭 불가능하게 설정 */
		    color: #333; /* 화살표 색상 */
		}
		.search-container {
		    display: flex;
		    align-items: center;
		}
		
		.search-input {
		    width: 300px;
		    padding: 10px;
		    font-size: 16px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 4px 0 0 4px;
		    outline: none;
		}
		
		.search-input:focus {
		    border-color: #007BFF;
		}
		
		.search-button {
		    padding: 11px 20px;
		    font-size: 11px;
		    color: #fff;
		    background-color: #007BFF;
		    border: 2px solid #007BFF;
		    border-radius: 0 4px 4px 0;
		    cursor: pointer;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease;
		}
		
		.search-button:hover {
		    background-color: #0056b3;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		.search-button:active {
		    background-color: #003f7f;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		.custom-select2{
		width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		 }
		
		/* 일주일*/
		
		/* 기본 스타일 설정 */
		.custom-select7 {
		    width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		}
		
		/* 옵션 스타일 설정 */
		.custom-select7 option {
		    padding: 10px; /* 내측 여백 */
		    background-color: #fff; /* 배경 색상 */
		    color: #333; /* 글꼴 색상 */
		}
		
		/* 포커스 및 호버 스타일 설정 */
		.custom-select7:focus {
		    border-color: #007bff; /* 포커스 시 테두리 색상 */
		    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 그림자 */
		    outline: none; /* 포커스 시 외곽선 제거 */
		}
		
		.custom-select7 option:hover {
		    background-color: #007bff; /* 호버 시 배경 색상 */
		    color: #fff; /* 호버 시 글꼴 색상 */
		}
		
		/* 화살표 추가를 위한 스타일 설정 */
		.custom-select7-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.custom-select7:: after {
		    content: '▼'; /* 화살표 모양 (유니코드 화살표 사용) */
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		    pointer-events: none; /* 화살표 클릭 불가능하게 설정 */
		    color: #333; /* 화살표 색상 */
		}
		.search-container {
		    display: flex;
		    align-items: center;
		}
		
		.search-input {
		    width: 300px;
		    padding: 10px;
		    font-size: 16px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 4px 0 0 4px;
		    outline: none;
		}
		
		.search-input: focus {
		    border-color: #007BFF;
		}
		
		.search-button {
		    padding: 11px 20px;
		    font-size: 11px;
		    color: #fff;
		    background-color: #007BFF;
		    border: 2px solid #007BFF;
		    border-radius: 0 4px 4px 0;
		    cursor: pointer;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease;
		}
		
		.search-button: hover {
		    background-color: #0056b3;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		.search-button: active {
		    background-color: #003f7f;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.custom-select7{
				width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		 }
		
		
		/*------*/
		
		/* 승인자 결재전체함 */
		
		/* 기본 스타일 설정 */
		.custom-selectu {
		    width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		}
		
		/* 옵션 스타일 설정 */
		.custom-selectu option {
		    padding: 10px; /* 내측 여백 */
		    background-color: #fff; /* 배경 색상 */
		    color: #333; /* 글꼴 색상 */
		}
		
		/* 포커스 및 호버 스타일 설정 */
		.custom-selectu: focus {
		    border-color: #007bff; /* 포커스 시 테두리 색상 */
		    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 그림자 */
		    outline: none; /* 포커스 시 외곽선 제거 */
		}
		
		.custom-selectu option: hover {
		    background-color: #007bff; /* 호버 시 배경 색상 */
		    color: #fff; /* 호버 시 글꼴 색상 */
		}
		
		/* 화살표 추가를 위한 스타일 설정 */
		.custom-selectu-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.custom-selectu:: after {
		    content: '▼'; /* 화살표 모양 (유니코드 화살표 사용) */
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		    pointer-events: none; /* 화살표 클릭 불가능하게 설정 */
		    color: #333; /* 화살표 색상 */
		}
		.search-container {
		    display: flex;
		    align-items: center;
		}
		
		.search-input {
		    width: 300px;
		    padding: 10px;
		    font-size: 16px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 4px 0 0 4px;
		    outline: none;
		}
		
		.search-input: focus {
		    border-color: #007BFF;
		}
		
		.search-button {
		    padding: 11px 20px;
		    font-size: 11px;
		    color: #fff;
		    background-color: #007BFF;
		    border: 2px solid #007BFF;
		    border-radius: 0 4px 4px 0;
		    cursor: pointer;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease;
		}
		
		.search-button: hover {
		    background-color: #0056b3;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		.search-button: active {
		    background-color: #003f7f;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.custom-selectu{
				width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		 }
		
		
		/*------*/
		
	/* 승인자 결재완료함 */
		
		/* 기본 스타일 설정 */
		.custom-selectua{
		    width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		}
		
		/* 옵션 스타일 설정 */
		.custom-selectua option {
		    padding: 10px; /* 내측 여백 */
		    background-color: #fff; /* 배경 색상 */
		    color: #333; /* 글꼴 색상 */
		}
		
		/* 포커스 및 호버 스타일 설정 */
		.custom-selectua : focus {
		    border-color: #007bff; /* 포커스 시 테두리 색상 */
		    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 그림자 */
		    outline: none; /* 포커스 시 외곽선 제거 */
		}
		
		.custom-selectua option: hover {
		    background-color: #007bff; /* 호버 시 배경 색상 */
		    color: #fff; /* 호버 시 글꼴 색상 */
		}
		
		/* 화살표 추가를 위한 스타일 설정 */
		.custom-selectua-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.custom-selectua {
    position: relative; /* 상대 위치 지정 */
    display: inline-block; /* 또는 block */
		}
		
		.custom-selectua::after {
		    content: '▼'; /* 화살표 모양 (유니코드 화살표 사용) */
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		    pointer-events: none; /* 화살표 클릭 불가능하게 설정 */
		    color: #333; /* 화살표 색상 */
		}
		.search-container {
		    display: flex;
		    align-items: center;
		}
		
		.search-input {
		    width: 300px;
		    padding: 10px;
		    font-size: 16px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 4px 0 0 4px;
		    outline: none;
		}
		
		.search-input: focus {
		    border-color: #007BFF;
		}
		
		.search-button {
		    padding: 11px 20px;
		    font-size: 11px;
		    color: #fff;
		    background-color: #007BFF;
		    border: 2px solid #007BFF;
		    border-radius: 0 4px 4px 0;
		    cursor: pointer;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease;
		}
		
		.search-button: hover {
		    background-color: #0056b3;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		.search-button: active {
		    background-color: #003f7f;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.custom-selectua{
				width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		 }
		
		
		/*------*/
		
			/* 기본 스타일 설정 */
		.custom-selectn {
		    width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		}
		
		/* 옵션 스타일 설정 */
		.custom-selectn option {
		    padding: 10px; /* 내측 여백 */
		    background-color: #fff; /* 배경 색상 */
		    color: #333; /* 글꼴 색상 */
		}
		
		/* 포커스 및 호버 스타일 설정 */
		.custom-selectn:focus {
		    border-color: #007bff; /* 포커스 시 테두리 색상 */
		    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 그림자 */
		    outline: none; /* 포커스 시 외곽선 제거 */
		}
		
		.custom-selectn option:hover {
		    background-color: #007bff; /* 호버 시 배경 색상 */
		    color: #fff; /* 호버 시 글꼴 색상 */
		}
		
		/* 화살표 추가를 위한 스타일 설정 */
		.custom-selectn-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.custom-selectn:: after {
		    content: '▼'; /* 화살표 모양 (유니코드 화살표 사용) */
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		    pointer-events: none; /* 화살표 클릭 불가능하게 설정 */
		    color: #333; /* 화살표 색상 */
		}
		.search-container {
		    display: flex;
		    align-items: center;
		}
		
		.search-input {
		    width: 300px;
		    padding: 10px;
		    font-size: 16px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 4px 0 0 4px;
		    outline: none;
		}
		
		.search-input: focus {
		    border-color: #007BFF;
		}
		
		.search-button {
		    padding: 11px 20px;
		    font-size: 11px;
		    color: #fff;
		    background-color: #007BFF;
		    border: 2px solid #007BFF;
		    border-radius: 0 4px 4px 0;
		    cursor: pointer;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease;
		}
		
		.search-button: hover {
		    background-color: #0056b3;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		.search-button: active {
		    background-color: #003f7f;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.custom-selectn{
				width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		 }
	<!----------->	
	
	
		/* 기본 스타일 설정 */
		.custom-selectall {
		    width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		}
		
		/* 옵션 스타일 설정 */
		.custom-selectall option {
		    padding: 10px; /* 내측 여백 */
		    background-color: #fff; /* 배경 색상 */
		    color: #333; /* 글꼴 색상 */
		}
		
		/* 포커스 및 호버 스타일 설정 */
		.custom-selectall:focus {
		    border-color: #007bff; /* 포커스 시 테두리 색상 */
		    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 그림자 */
		    outline: none; /* 포커스 시 외곽선 제거 */
		}
		
		.custom-selectall option:hover {
		    background-color: #007bff; /* 호버 시 배경 색상 */
		    color: #fff; /* 호버 시 글꼴 색상 */
		}
		
		/* 화살표 추가를 위한 스타일 설정 */
		.custom-selectall-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.custom-selectall:: after {
		    content: '▼'; /* 화살표 모양 (유니코드 화살표 사용) */
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		    pointer-events: none; /* 화살표 클릭 불가능하게 설정 */
		    color: #333; /* 화살표 색상 */
		}
		.search-container {
		    display: flex;
		    align-items: center;
		}
		
		.search-input {
		    width: 300px;
		    padding: 10px;
		    font-size: 16px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 4px 0 0 4px;
		    outline: none;
		}
		
		.search-input: focus {
		    border-color: #007BFF;
		}
		
		.search-button {
		    padding: 11px 20px;
		    font-size: 11px;
		    color: #fff;
		    background-color: #007BFF;
		    border: 2px solid #007BFF;
		    border-radius: 0 4px 4px 0;
		    cursor: pointer;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease;
		}
		
		.search-button: hover {
		    background-color: #0056b3;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		.search-button: active {
		    background-color: #003f7f;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.custom-selectall{
				width: 124px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		 }
		 
		 #svgContent{    
			 display: flex;
	    justify-content: flex-end;
     }
     
     #round-button {
		      background-color: #e99db2;
			    border: none;
			    color: white;
			    padding: 2px 12px;
			    text-align: center;
			    text-decoration: none;
			    display: inline-block;
			    font-size: 16px;
			    margin: 4px 2px;
			    cursor: pointer;
			    border-radius: 65px;
		  }
			<!----------->	
			#svgContent{display: flex;
    justify-content: space-around;}
</style>
</head>
<body>
<script>
$(document).ready(function(){
    $(".badge").each(function(){
        var text = $(this).text().trim();
        if(text == "반려"){
            $(this).addClass("rejected");
        } else if(text == "완료"){ 
            $(this).addClass("completes");
        } else if(text == "진행"){
            $(this).addClass("progresses");
        } else if(text == "대기"){
            $(this).addClass("pending");
        } 
    });
});
</script>


<!----------------------------- 전체 결재함 (카테고리) ------------------------------->
<script>
//카테고리체인지이벤트발생시
$(document).on('change', '.custom-select', function() {
		var keyword = $("#search_input").val("");
    var conditions = $("#selects").val();
    var status = $("#statusSelect").val();
    loadTableData(1, conditions, status);
});

//페이징클릭시
$(document).on('click', '.page-linkc', function(event) {
    event.preventDefault();
    var page = $(this).data('page');
    if (page) {
        var conditions = $("#selects").val();
        var status = $("#statusSelect").val();
        loadTableData(page, conditions, status);
    }
});


</script>

 <script>

   function loadTableData(page, conditions, status) {
   	
       $.ajax({
           url: "${contextPath}/pay/selectList.do",
           data: {
               conditions: conditions,
               status: status,
               page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       
                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       
                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : "-") + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       tbody.append(row);
								       });
										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkc" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkc" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkc" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
							}
           }
               
       });
   }
  </script>
  
<!-- 전체 결재함 (카테고리 + 검색) -->
<script> 
	
	$(document).on('keyup', '#search_input', function(ev) {
	    if(ev.key === "Enter") {
	        var condition = $("#select_search").val();
	        var keyword = $("#search_input").val();
	        loadSearchTableData(1, condition, keyword);
	    }
	});
	
	$(document).on('click', '.page-links', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	        var condition = $("#select_search").val();
	        var keyword = $("#search_input").val();
	        loadSearchTableData(page, condition, keyword);
	    }
	});
	

</script>

 <script>

   function loadSearchTableData(page, condition, keyword) {
   	
       $.ajax({
           url:  "${contextPath}/pay/search.do",
           data: {
        	   	condition: condition,
        	   	keyword: keyword,
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-links" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-links" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-links" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
							}
           }
               
       });
   }
  </script>
  
  
  
<!-- ----------------------일주일이상 지난 결재함------------------------- -->
<script> 
	
	$(document).on('click', '#7daysOuterList', function() {
			$(".highlight-box").css("background-color", "rgb(255 236 241)");

	    $(".highlight-box").not(this).css("background-color", "#ffffff");
        load7DaysTableData(1);
	});
	
	$(document).on('click', '.page-link7', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	        load7DaysTableData(page);
	    }
	});
	

</script>

 <script>

   function load7DaysTableData(page) {
   	
       $.ajax({
           url: "${contextPath}/pay/delayDateList.do",
           data: {
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let status = response.status;
               let conditions = response.conditions;
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelect7" class="custom-select7">' + 
											         '<option value="전체" ' + (status == '전체' ? 'selected': '') + '>전체</option>' + 
											         '<option value="보통" ' + (status == '보통' ? 'selected': '') + '>보통</option>' +
											         '<option value="긴급" ' + (status == '긴급' ? 'selected': '') + '>긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="select7" class="custom-select7">' + 
											                '<option value="전체" ' + (conditions == '전체' ? 'selected': '') + '>전체</option>' +  
											                '<option value="B" ' + (conditions == 'B' ? 'selected': '') + '>비품신청서</option>' + 
											                '<option value="M" ' + (conditions == 'M' ? 'selected': '') + '>매출보고서</option>' + 
											                '<option value="J" ' + (conditions == 'J' ? 'selected': '') + '>지출결의서</option>' + 
											                '<option value="G" ' + (conditions == 'G' ? 'selected': '') + '>기안서</option>' + 
											                '<option value="H" ' + (conditions == 'H' ? 'selected': '') + '>휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_search7" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_input7" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);
               

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       
                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-link7" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-link7" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-link7" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
							}
           }
               
       });
   }
  </script>
  
<!-------------------------------------- 일주일이상 지난 결재함 (카테고리)----------------------------- -->
<script> 
	
		$(document).on('change', '.custom-select7', function() {
			
			var keyword = $("#search_input7").val("");
			var conditions = $("#select7").val();
			var status = $("#statusSelect7").val();
			load7DaySelectTableData(1, conditions, status);
		});
		
		//페이징클릭시
		$(document).on('click', '.page-link7c', function(event) {
			event.preventDefault();
			var page = $(this).data('page');
			if (page) {
			    var conditions = $("#select7").val();
			    var status = $("#statusSelect7").val();
			    load7DaySelectTableData(page, conditions, status);
			}
		});

</script>

 <script>

   function load7DaySelectTableData(page, conditions, status) {
   	
       $.ajax({
           url: "${contextPath}/pay/delayDateSelectList.do",
           data: {
        	   conditions:conditions,
        	   status:status,
             page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let conditions = response.conditions;
               let status = response.status;
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelect7" class="custom-select7">' + 
											         '<option value="전체"' + (status === '전체' ? ' selected' : '') + '>전체</option>' + 
											         '<option value="보통"' + (status === '보통' ? ' selected' : '') + '>보통</option>' +
											         '<option value="긴급"' + (status === '긴급' ? ' selected' : '') + '>긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="select7" class="custom-select7">' + 
											                '<option value="전체"' + (conditions === '전체' ? ' selected' : '') + '>전체</option>' + 
											                '<option value="B"' + (conditions === 'B' ? ' selected' : '') + '>비품신청서</option>' + 
											                '<option value="M"' + (conditions === 'M' ? ' selected' : '') + '>매출보고서</option>' + 
											                '<option value="J"' + (conditions === 'J' ? ' selected' : '') + '>지출결의서</option>' + 
											                '<option value="G"' + (conditions === 'G' ? ' selected' : '') + '>기안서</option>' + 
											                '<option value="H"' + (conditions === 'H' ? ' selected' : '') + '>휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_search7" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_input7" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-link7c" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-link7c" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-link7c" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
										
										 $('#search_input7').focus();
										
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
								 $('#search_input7').focus();
								 
							}
           }
               
       });
   }
  </script>
  
  
<!-- -----------------------------------일주일 이상 지난 결재함 (카테고리 + 검색)--------------------------- -->
<script> 
	
	$(document).on('keyup', '#search_input7', function(ev) {
	    if(ev.key === "Enter") {
	        var condition = $("#select_search7").val();
	        var keyword = $("#search_input7").val();
	        load7DaysSearchTableData(1, condition, keyword);
	    }
	});
	
	$(document).on('click', '.page-link7s', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	        var condition = $("#select_search7").val();
	        var keyword = $("#search_input7").val();
	        load7DaysSearchTableData(page, condition, keyword);
	    }
	});
	

</script>

<!-- 일주일이상 지난 결재함 -->
 <script>

   function load7DaysSearchTableData(page, condition, keyword) {
   	
       $.ajax({
           url: "${contextPath}/pay/delayDateSearch.do",
           data: {
        	   	condition: condition,
        	   	keyword: keyword,
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let condition = response.condition;
               let keyword = response.keyword;
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelect7" class="custom-select7">' + 
											         '<option value="전체">전체</option>' + 
											         '<option value="보통">보통</option>' +
											         '<option value="긴급">긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="select7" class="custom-select7">' + 
											                '<option value="전체">전체</option>' +  
											                '<option value="B">비품신청서</option>' + 
											                '<option value="M">매출보고서</option>' + 
											                '<option value="J">지출결의서</option>' + 
											                '<option value="G">기안서</option>' + 
											                '<option value="H">휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_search7" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER"' + (condition === 'PAYMENT_WRITER' ? 'selected' : '') + '>기안자</option>' + 
											            '<option value="DEPARTMENT"' + (condition === 'DEPARTMENT' ? 'selected' : '') + '>부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_input7" placeholder="검색어를 입력하세요" class="search-input" value="' + (keyword || '') + '">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-link7s" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-link7s" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-link7s" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
										
										 $('#search_input7').focus();
										 
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
								 $('#search_input7').focus();
								 
							}
           }
               
       });
   }
  </script>
  
<!----------------------------------- 전체수신함(ajax로 다시) ------------------------------------------>
<script> 
	
	$(document).on('click', '#AllList', function() {
		
			 $(".highlight-box").css("background-color", "rgb(255 236 241)");
		   $(".highlight-box").not(this).css("background-color", "#ffffff");
		   $(".custom-selectall").val("전체");
			 $(".custom-selectall2").val("기안자");
        loadAllTableData(1);
	});
	
	$(document).on('click', '.page-linkd', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	    	loadAllTableData(page);
	    }
	});
	

</script>

 <script>

   function loadAllTableData(page) {
   	
       $.ajax({
           url: "${contextPath}/pay/ajaxapprovalMain.do",
           data: {
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               
               var search = $(".selectContent");
               search.empty();
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelect" class="custom-select">' + 
											         '<option value="전체">전체</option>' + 
											         '<option value="보통">보통</option>' +
											         '<option value="긴급">긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selects" class="custom-select">' + 
											                '<option value="전체">전체</option>' +  
											                '<option value="B">비품신청서</option>' + 
											                '<option value="M">매출보고서</option>' + 
											                '<option value="J">지출결의서</option>' + 
											                '<option value="G">기안서</option>' + 
											                '<option value="H">휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_search" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_input" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);
               
               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkd" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkd" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkd" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
							}
           }
               
       });
   }
  </script>
 <!-- 승인자의 전체결재요청함 -->
  <script> 
	
	$(document).on('click', '#UserAllList', function() {
			 $(".highlight-box").css("background-color", "rgb(255 236 241)");
		   $(".highlight-box").not(this).css("background-color", "#ffffff");
		   $(".custom-selectall").val("전체");
			 $(".custom-selectall2").val("기안자");
        loadAllUserTableData(1);
	});
	
	$(document).on('click', '.page-linkall', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	    	loadAllUserTableData(page);
	    }
	});
	

</script>

 <script>

   function loadAllUserTableData(page) {
   	
       $.ajax({
           url:"${contextPath}/pay/allUserlist.do",
           data: {
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelectall" class="custom-selectall">' + 
											         '<option value="전체">전체</option>' + 
											         '<option value="보통">보통</option>' +
											         '<option value="긴급">긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selectall" class="custom-selectall">' + 
											                '<option value="전체">전체</option>' + 
											                '<option value="B">비품신청서</option>' + 
											                '<option value="M">매출보고서</option>' + 
											                '<option value="J">지출결의서</option>' + 
											                '<option value="G">기안서</option>' + 
											                '<option value="H">휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_searchall" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_inputall" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);
               
               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkall" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkall" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkall" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
							}
           }
               
       });
   }
  </script>
  
<!-- -------------------------------------- 승인자의 전체결재수신함(카테고리)------------------------------- -->
<script> 
	
		$(document).on('change', '.custom-selectall', function() {
			var keyword = $("#search_inputall").val("");
			var conditions = $("#selectall").val();
			var status = $("#statusSelectall").val();
			loadAllSelectUserTableData(1, conditions, status);
		});
		
		//페이징클릭시
		$(document).on('click', '.page-linkallc', function(event) {
			event.preventDefault();
			var page = $(this).data('page');
			if (page) {
			    var conditions = $("#selectall").val();
			    var status = $("#statusSelectall").val();
			    loadAllSelectUserTableData(page, conditions, status);
			}
		});

</script>

 <script>

   function loadAllSelectUserTableData(page, conditions, status) {
   	
       $.ajax({
           url: "${contextPath}/pay/userSelectList.do",
           data: {
        	   conditions:conditions,
        	   status:status,
             page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let conditions = response.conditions;
               let status = response.status;
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelectall" class="custom-selectall">' + 
											         '<option value="전체"' + (status === '전체' ? 'selected' : '') + '>전체</option>' + 
											         '<option value="보통"' + (status === '보통' ? 'selected' : '') + '>보통</option>' +
											         '<option value="긴급"' + (status === '긴급' ? 'selected' : '') + '>긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selectall" class="custom-selectall">' + 
											                '<option value="전체"' + (conditions === '전체' ? 'selected' : '') + '>전체</option>' + 
											                '<option value="B"' + (conditions === 'B' ? 'selected' : '') + '>비품신청서</option>' + 
											                '<option value="M"' + (conditions === 'M' ? 'selected' : '') + '>매출보고서</option>' + 
											                '<option value="J"' + (conditions === 'J' ? 'selected' : '') + '>지출결의서</option>' + 
											                '<option value="G"' + (conditions === 'G' ? 'selected' : '') + '>기안서</option>' + 
											                '<option value="H"' + (conditions === 'H' ? 'selected' : '') + '>휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_searchall" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_inputall" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkallc" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkallc" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkallc" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
										
										 $('#search_inputu').focus();
										
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
								 $('#search_inputu').focus();
								 
							}
           }
               
       });
   }
  </script>
  
  
<!-- ---------------------------------------- 승인자의 전체결재함 (카테고리 + 검색)------------------------------- -->
<script> 
	
	$(document).on('keyup', '#search_inputall', function(ev) {
	    if(ev.key === "Enter") {
	        var condition = $("#select_searchall").val();
	        var keyword = $("#search_inputall").val();
	        loadAllSearchUserTableData(1, condition, keyword);
	    }
	});
	
	$(document).on('click', '.page-linkalls', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	        var condition = $("#select_searchall").val();
	        var keyword = $("#search_inputall").val();
	        loadAllSearchUserTableData(page, condition, keyword);
	    }
	});
	

</script>

 <script>

   function loadAllSearchUserTableData(page, condition, keyword) {
   	
       $.ajax({
           url: "${contextPath}/pay/userSearch.do",
           data: {
        	   	condition: condition,
        	   	keyword: keyword,
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let condition = response.condition;
               let keyword = response.keyword;
               
               var formHTML = '<div><div>' +
										         '<select name="status" id="statusSelectall" class="custom-selectall">' + 
										         '<option value="전체">전체</option>' + 
										         '<option value="보통">보통</option>' +
										         '<option value="긴급">긴급</option>' + 
										         '</select>' + 
										         '<select name="conditions" id="selectall" class="custom-selectall">' + 
										                '<option value="전체">전체</option>' + 
										                '<option value="B">비품신청서</option>' + 
										                '<option value="M">매출보고서</option>' + 
										                '<option value="J">지출결의서</option>' + 
										                '<option value="G">기안서</option>' + 
										                '<option value="H">휴직신청서</option>' + 
										            '</select>' + 
										        '</div>' + 
										    '</div>' + 
										    '<div class="search-container">' + 
										        '<select name="condition" id="select_searchall" class="custom-select2">' + 
										            '<option value="PAYMENT_WRITER"' + (condition === 'PAYMENT_WRITER' ? 'selected' : '') + '>기안자</option>' + 
										            '<option value="DEPARTMENT"' + (condition === 'DEPARTMENT' ? 'selected' : '') + '>부서</option>' + 
										        '</select>' + 
										        '<input type="text" id="search_inputall" placeholder="검색어를 입력하세요" class="search-input" value="' + (keyword || '') + '">' + 
										    '</div>';
								
										
										$('.selectContent').append(formHTML);

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       		tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkalls" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkalls" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkalls" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
										
										 $('#search_inputu').focus();
										
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 $('#search_inputu').focus();
								 
							}
           }
               
       });
   }
  </script>
  
  
<!------------------------------------------------ 승인자의 결재완료함---------------------------------- -->
  <script> 
	
	$(document).on('click', '#UserApprovalList', function() {
				$(".custom-selectall").val("전체");
				$(".custom-selectall2").val("기안자");
		 		$(".highlight-box").css("background-color", "rgb(255 236 241)");
		  	$(".highlight-box").not(this).css("background-color", "#ffffff");
        loadUserApprovalTableData(1);
	});
	
	$(document).on('click', '.page-linku', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	    	loadUserApprovalTableData(page);
	    }
	});
	

</script>

 <script>

   function loadUserApprovalTableData(page) {
   	
       $.ajax({
           url:"${contextPath}/pay/approvedList.do",
           data: {
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelectu" class="custom-selectu">' + 
											         '<option value="전체">전체</option>' + 
											         '<option value="보통">보통</option>' +
											         '<option value="긴급">긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selectu" class="custom-selectu">' + 
											                '<option value="전체">전체</option>' + 
											                '<option value="B">비품신청서</option>' + 
											                '<option value="M">매출보고서</option>' + 
											                '<option value="J">지출결의서</option>' + 
											                '<option value="G">기안서</option>' + 
											                '<option value="H">휴직신청서</option>' +  
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_searchu" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_inputu" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);
               
               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       	tbody.append(row);
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linku" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linku" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linku" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
										
										$('#search_inputua').focus();
										
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
                 $('#search_inputua').focus();
								 
							}
           }
               
       });
   }
  </script>
 <!------------------------------------------- 승인자의 결재승인완료함(카테고리)------------------------------- -->
<script> 
	
		$(document).on('change', '.custom-selectu', function() {
			var keyword = $("#search_inputu").val("");
			var conditions = $("#selectu").val();
			var status = $("#statusSelectu").val();
			loadUserSelectApprovalTableData(1, conditions, status);
		});
		
		//페이징클릭시
		$(document).on('click', '.page-linkuc', function(event) {
			event.preventDefault();
			var page = $(this).data('page');
			if (page) {
			    var conditions = $("#selectu").val();
			    var status = $("#statusSelectu").val();
			    loadUserSelectApprovalTableData(page, conditions, status);
			}
		});

</script>

 <script>

   function loadUserSelectApprovalTableData(page, conditions, status) {
   	
       $.ajax({
           url: "${contextPath}/pay/approvalSelectList.do",
           data: {
        	   conditions:conditions,
        	   status:status,
             page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let conditions = response.conditions;
               let status = response.status;
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelectu" class="custom-selectu">' + 
											         '<option value="전체" ' + (status == '전체' ? 'selected': '') + '>전체</option>' + 
											         '<option value="보통" ' + (status == '보통' ? 'selected': '') + '>보통</option>' +
											         '<option value="긴급" ' + (status == '긴급' ? 'selected': '') + '>긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selectu" class="custom-selectu">' + 
											                '<option value="전체" ' + (conditions == '전체' ? 'selected': '') +'>전체</option>' + 
											                '<option value="B" ' + (conditions == 'B' ? 'selected': '') +'>비품신청서</option>' + 
											                '<option value="M" ' + (conditions == 'M' ? 'selected': '') +'>매출보고서</option>' + 
											                '<option value="J" ' + (conditions == 'J' ? 'selected': '') +'>지출결의서</option>' + 
											                '<option value="G" ' + (conditions == 'G' ? 'selected': '') +'>기안서</option>' + 
											                '<option value="H" ' + (conditions == 'H' ? 'selected': '') +'>휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_searchu" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_inputu" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       	tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkuc" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkuc" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkuc" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
							}
           }
               
       });
   }
  </script>
  
  
  <!-- 승인자의 승인완료함 (카테고리 + 검색) -->
<script> 
	
	$(document).on('keyup', '#search_inputu', function(ev) {
	    if(ev.key === "Enter") {
	        var condition = $("#select_searchu").val();
	        var keyword = $("#search_inputu").val();
	        loadUserSearchApprovalTableData(1, condition, keyword);
	    }
	});
	
	$(document).on('click', '.page-linkus', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	        var condition = $("#select_searchu").val();
	        var keyword = $("#search_inputu").val();
	        loadUserSearchApprovalTableData(page, condition, keyword);
	    }
	});
	

</script>

 <script>

   function loadUserSearchApprovalTableData(page, condition, keyword) {
   	
       $.ajax({
           url: "${contextPath}/pay/approvalSearch.do",
           data: {
        	   	condition: condition,
        	   	keyword: keyword,
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let condition = response.condition;
               let keyword = response.keyword;
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelectu" class="custom-selectu">' + 
											         '<option value="전체">전체</option>' + 
											         '<option value="보통">보통</option>' +
											         '<option value="긴급">긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selectu" class="custom-selectu">' + 
											                '<option value="전체">전체</option>' +  
											                '<option value="B">비품신청서</option>' + 
											                '<option value="M">매출보고서</option>' + 
											                '<option value="J">지출결의서</option>' + 
											                '<option value="G">기안서</option>' + 
											                '<option value="H">휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_searchu" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER"' + (condition === 'PAYMENT_WRITER' ? 'selected' : '') + '>기안자</option>' + 
											            '<option value="DEPARTMENT"' + (condition === 'DEPARTMENT' ? 'selected' : '') + '>부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_inputu" placeholder="검색어를 입력하세요" class="search-input" value="' + (keyword || '') + '">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                           row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                           				'<td>' + item.approvalNo + '</td>' +
                                  '<td>' + item.title + attachmentIcon + '</td>' +
                                  '<td>' + item.documentType + '</td>' +
                                  '<td>' + item.payWriter + '</td>' +
                                  '<td>' + item.department + '</td>' +
                                  '<td>' + item.registDt + '</td>' +
                                  '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                                  '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                                  '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                                  '</tr>';
                           tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkus" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkus" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkus" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
										
										$('#search_inputua').focus();
										
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
								 $('#search_inputua').focus();
							}
           }
               
       });
   }
  </script>
  
  
 <!----------------------------------------- 승인 미결재함 Click (Start)------------------------------------->
<script> 
	
	$(document).on('click', '#noApprovalSignList', function() {
		 		$(".highlight-box").css("background-color", "rgb(255 236 241)");
		  	$(".highlight-box").not(this).css("background-color", "#ffffff");
		  	$(".custom-selectall").val("전체");
				$(".custom-selectall2").val("기안자");
        loadnoApprovalSignTableData(1);
	});
	
	$(document).on('click', '.page-linkn', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	    	loadnoApprovalSignTableData(page);
	    }
	});
	

</script> 
<script>
  
  function loadnoApprovalSignTableData(page) {
   	
       $.ajax({
           url:"${contextPath}/pay/ajaxNoApprovalSign.do",
           data: {
              page: page
           },
           success: function(response) {

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelectn" class="custom-selectn">' + 
											         '<option value="전체">전체</option>' + 
											         '<option value="보통">보통</option>' +
											         '<option value="긴급">긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selectn" class="custom-selectn">' + 
											                '<option value="전체">전체</option>' + 
											                '<option value="B">비품신청서</option>' + 
											                '<option value="M">매출보고서</option>' + 
											                '<option value="J">지출결의서</option>' + 
											                '<option value="G">기안서</option>' + 
											                '<option value="H">휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_searchn" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_inputn" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);
               
               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       	tbody.append(row);
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkn" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkn" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkn" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
										
										$('#search_inputua').focus();
										
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
                 $('#search_inputua').focus();
								 
							}
           }
               
       });
   }
  </script>
 
<!------------------------------------------ 승인 미결재함 카테고리 (Start)--------------------------------------->
<script> 
	
		$(document).on('change', '.custom-selectn', function() {
			var keyword = $("#search_inputn").val("");
			var conditions = $("#selectn").val();
			var status = $("#statusSelectn").val();
			loadnoApprovalSignSelectTableData(1, conditions, status);
		});
		
		
		$(document).on('click', '.page-linknc', function(event) {
			event.preventDefault();
			var page = $(this).data('page');
			if (page) {
			    var conditions = $("#selectn").val();
			    var status = $("#statusSelectn").val();
			    loadnoApprovalSignSelectTableData(page, conditions, status);
			}
		});

</script>

 <script>

   function loadnoApprovalSignSelectTableData(page, conditions, status) {
   	
       $.ajax({
           url: "${contextPath}/pay/ajaxNoApprovalSignSelectList.do",
           data: {
        	   conditions:conditions,
        	   status:status,
             page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let conditions = response.conditions;
               let status = response.status;
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelectn" class="custom-selectn">' + 
											         '<option value="전체" ' + (status == '전체' ? 'selected': '') + '>전체</option>' + 
											         '<option value="보통" ' + (status == '보통' ? 'selected': '') + '>보통</option>' +
											         '<option value="긴급" ' + (status == '긴급' ? 'selected': '') + '>긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selectn" class="custom-selectn">' + 
											                '<option value="전체" ' + (conditions == '전체' ? 'selected': '') +'>전체</option>' + 
											                '<option value="B" ' + (conditions == 'B' ? 'selected': '') +'>비품신청서</option>' + 
											                '<option value="M" ' + (conditions == 'M' ? 'selected': '') +'>매출보고서</option>' + 
											                '<option value="J" ' + (conditions == 'J' ? 'selected': '') +'>지출결의서</option>' + 
											                '<option value="G" ' + (conditions == 'G' ? 'selected': '') +'>기안서</option>' + 
											                '<option value="H" ' + (conditions == 'H' ? 'selected': '') +'>휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_searchn" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER">기안자</option>' + 
											            '<option value="DEPARTMENT">부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_inputn" placeholder="검색어를 입력하세요" class="search-input">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                       row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                       				'<td>' + item.approvalNo + '</td>' +
                              '<td>' + item.title + attachmentIcon + '</td>' +
                              '<td>' + item.documentType + '</td>' +
                              '<td>' + item.payWriter + '</td>' +
                              '<td>' + item.department + '</td>' +
                              '<td>' + item.registDt + '</td>' +
                              '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                              '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                              '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                              '</tr>';
                       	tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linknc" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linknc" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linknc" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
							}
           }
               
       });
   }
  </script>



<!------------------------------------ 승인자의 미결재함(카테고리 + 검색)-------------------------------- -->
<script> 
	
	$(document).on('keyup', '#search_inputn', function(ev) {
	    if(ev.key === "Enter") {
	        var condition = $("#select_searchn").val();
	        var keyword = $("#search_inputn").val();
	        loadUserSearchApprovalTableData(1, condition, keyword);
	    }
	});
	
	$(document).on('click', '.page-linkns', function(event) {
	    event.preventDefault();
	    var page = $(this).data('page');
	    if (page) {
	        var condition = $("#select_searchn").val();
	        var keyword = $("#search_inputn").val();
	        loadUserSearchApprovalTableData(page, condition, keyword);
	    }
	});
	

</script>

 <script>

   function loadUserSearchApprovalTableData(page, condition, keyword) {
   	
       $.ajax({
           url: "${contextPath}/pay/ajaxNoApprovalSignSearchList.do",
           data: {
        	   	condition: condition,
        	   	keyword: keyword,
              page: page
           },
           success: function(response) {
               console.log(response);

               var tbody = $('#tStatus');
               tbody.empty();
               var search = $(".selectContent");
               search.empty();
               
               let condition = response.condition;
               let keyword = response.keyword;
               
               var formHTML = '<div><div>' +
											         '<select name="status" id="statusSelectn" class="custom-selectn">' + 
											         '<option value="전체">전체</option>' + 
											         '<option value="보통">보통</option>' +
											         '<option value="긴급">긴급</option>' + 
											         '</select>' + 
											         '<select name="conditions" id="selectn" class="custom-selectn">' + 
											                '<option value="전체">전체</option>' +  
											                '<option value="B">비품신청서</option>' + 
											                '<option value="M">매출보고서</option>' + 
											                '<option value="J">지출결의서</option>' + 
											                '<option value="G">기안서</option>' + 
											                '<option value="H">휴직신청서</option>' + 
											            '</select>' + 
											        '</div>' + 
											    '</div>' + 
											    '<div class="search-container">' + 
											        '<select name="condition" id="select_searchn" class="custom-select2">' + 
											            '<option value="PAYMENT_WRITER"' + (condition === 'PAYMENT_WRITER' ? 'selected' : '') + '>기안자</option>' + 
											            '<option value="DEPARTMENT"' + (condition === 'DEPARTMENT' ? 'selected' : '') + '>부서</option>' + 
											        '</select>' + 
											        '<input type="text" id="search_inputn" placeholder="검색어를 입력하세요" class="search-input" value="' + (keyword || '') + '">' + 
											    '</div>';
									
											
											$('.selectContent').append(formHTML);

               if(response.list.length !== 0) {
            	   
                   response.list.forEach(function(item) {
                	   
                       var documentStatusClass = '';
                       if (item.documentStatus === '반려') {
                           documentStatusClass = 'rejected';
                       } else if (item.documentStatus === '완료') {
                           documentStatusClass = 'completes';
                       } else if (item.documentStatus === '진행') {
                           documentStatusClass = 'progresses';
                       } else if (item.documentStatus === '대기') {
                           documentStatusClass = 'pending';
                       }
                       

                       var statusColor = "";
                       if (item.payStatus == "긴급") {
                           statusColor = 'style="color: red;"';
                       } else if (item.payStatus == "보통") {
                           statusColor = 'style="color: rgb(49, 106, 153);"';
                       }
                       

                       var attachmentIcon = '';
                       if (item.salesStatus + item.draftStatus + item.businessStatus > 0) {
                           attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                                            '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                                            '</svg>';
                       }

                       var row = '';
                           row +=	'<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.approvalNo  + '&documentNo=' + item.documentNo + '&documentType=' + item.documentType + '&payWriter=' + item.payWriter + '&payWriterNo=' + item.payWriterNo + '">' +
                           				'<td>' + item.approvalNo + '</td>' +
                                  '<td>' + item.title + attachmentIcon + '</td>' +
                                  '<td>' + item.documentType + '</td>' +
                                  '<td>' + item.payWriter + '</td>' +
                                  '<td>' + item.department + '</td>' +
                                  '<td>' + item.registDt + '</td>' +
                                  '<td><span class="badge ' +  documentStatusClass + '">' + item.documentStatus + '</span></td>' +
                                  '<td>' + (item.documentStatus == '완료' ? item.finalApproDt : '-') + '</td>' +
                                  '<td class="status" ' + statusColor + '>' + item.payStatus + '</td>' +
                                  '</tr>';
                           tbody.append(row);
                           
                           
								       });
                   

										
										var ul = $('.pagination');
										ul.empty(); 
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-linkns" data-page="' + (response.pi.currentPage - 1) + '">◁</a></li>');
					
										for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
										    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-linkns" data-page="' + p + '">' + p + '</a></li>');
										}
					
										ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-linkns" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
										
										$('#search_inputua').focus();
										
							}else {
								 var row = '<tr>' +
					       '<td colspan="9">존재하는 게시글이 없습니다.</td>' +
					       '</tr>';
								 tbody.append(row);
								 var ul = $('.pagination');
								 ul.empty();
								 
								 $('#search_inputua').focus();
							}
           }
               
       });
   }
  </script>  
  
   
  
		
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	        <!-- content 추가 -->
	        <div class="content p-4">
	          <!-- 프로필 영역 -->
	          	<div class="containeres">
						    <!-- Top Menu -->
						    <div class="top-menu">
						        <a href="${contextPath}/pay/writerForm.page?writer=b">
						        <div class="top-menu-item">
						        <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-inboxes" viewBox="0 0 16 16" style="color: black;">
                            <path d="M4.98 1a.5.5 0 0 0-.39.188L1.54 5H6a.5.5 0 0 1 .5.5 1.5 1.5 0 0 0 3 0A.5.5 0 0 1 10 5h4.46l-3.05-3.812A.5.5 0 0 0 11.02 1zm9.954 5H10.45a2.5 2.5 0 0 1-4.9 0H1.066l.32 2.562A.5.5 0 0 0 1.884 9h12.234a.5.5 0 0 0 .496-.438zM3.809.563A1.5 1.5 0 0 1 4.981 0h6.038a1.5 1.5 0 0 1 1.172.563l3.7 4.625a.5.5 0 0 1 .105.374l-.39 3.124A1.5 1.5 0 0 1 14.117 10H1.883A1.5 1.5 0 0 1 .394 8.686l-.39-3.124a.5.5 0 0 1 .106-.374zM.125 11.17A.5.5 0 0 1 .5 11H6a.5.5 0 0 1 .5.5 1.5 1.5 0 0 0 3 0 .5.5 0 0 1 .5-.5h5.5a.5.5 0 0 1 .496.562l-.39 3.124A1.5 1.5 0 0 1 14.117 16H1.883a1.5 1.5 0 0 1-1.489-1.314l-.39-3.124a.5.5 0 0 1 .121-.393zm.941.83.32 2.562a.5.5 0 0 0 .497.438h12.234a.5.5 0 0 0 .496-.438l.32-2.562H10.45a2.5 2.5 0 0 1-4.9 0z"/>
                        </svg>
                    </div>
						        <h6>비품신청서</h6></div>
						        </a>
						        <a href="${contextPath}/pay/writerForm.page?writer=m">
						        <div class="top-menu-item">
						        <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-clipboard-data" viewBox="0 0 16 16" style="color: black;">
                            <path d="M4 11a1 1 0 1 1 2 0v1a1 1 0 1 1-2 0zm6-4a1 1 0 1 1 2 0v5a1 1 0 1 1-2 0zM7 9a1 1 0 0 1 2 0v3a1 1 0 1 1-2 0z"/>
                            <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z"/>
                            <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z"/>
                          </svg>
                    </div>
						        <h6>매출보고서</h6></div>
						        </a>
						        <a href="${contextPath}/pay/writerForm.page?writer=j">
						        <div class="top-menu-item">
						        <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-journals" viewBox="0 0 16 16" style="color: black;">
                            <path d="M5 0h8a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2 2 2 0 0 1-2 2H3a2 2 0 0 1-2-2h1a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1H1a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v9a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H5a1 1 0 0 0-1 1H3a2 2 0 0 1 2-2"/>
                            <path d="M1 6v-.5a.5.5 0 0 1 1 0V6h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V9h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 2.5v.5H.5a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1H2v-.5a.5.5 0 0 0-1 0"/>
                        </svg>
                    </div>
						        <h6>지출결의서</h6></div>
						        </a>
						        <a href="${contextPath}/pay/writerForm.page?writer=g">
						        <div class="top-menu-item">
						        <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-journal-bookmark" viewBox="0 0 16 16" style="color: black;">
                      	<path fill-rule="evenodd" d="M6 8V1h1v6.117L8.743 6.07a.5.5 0 0 1 .514 0L11 7.117V1h1v7a.5.5 0 0 1-.757.429L9 7.083 6.757 8.43A.5.5 0 0 1 6 8"/>
                      	<path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2"/>
                      	<path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1z"/>
                    </svg>
                 	 </div>
						        <h6>기안서</h6></div>
						        </a>
						        <a href="${contextPath}/pay/writerForm.page?writer=h">
						        <div class="top-menu-item">
						        <div>
                       <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-journal-richtext" viewBox="0 0 16 16" style="color: black;">
                           <path d="M7.5 3.75a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0m-.861 1.542 1.33.886 1.854-1.855a.25.25 0 0 1 .289-.047L11 4.75V7a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 7v-.5s1.54-1.274 1.639-1.208M5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/>
                           <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2"/>
                           <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1z"/>
                       </svg>
                   	</div>
						        <h6>휴직신청서</h6></div>
						        </a>
						        <a href="${ contextPath }/vacation/vacation.page">
						        <div class="top-menu-item">
						        <div>
	                     <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-clipboard-heart" viewBox="0 0 16 16" style="color: black;">
	                         <path fill-rule="evenodd" d="M5 1.5A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5v1A1.5 1.5 0 0 1 9.5 4h-3A1.5 1.5 0 0 1 5 2.5zm5 0a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5z"/>
	                         <path d="M3 1.5h1v1H3a1 1 0 0 0-1 1V14a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V3.5a1 1 0 0 0-1-1h-1v-1h1a2 2 0 0 1 2 2V14a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3.5a2 2 0 0 1 2-2"/>
	                         <path d="M8 6.982C9.664 5.309 13.825 8.236 8 12 2.175 8.236 6.336 5.31 8 6.982"/>
	                     </svg>
	                 </div>
						        <h6>휴가신청서</h6></div>
						        </a>
						    </div>
						
						    <!-- Highlighted Boxes -->
						    <div class="highlight-boxes">
						    		<div class="highlight-box" id="noApprovalSignList">
						            <div class="title"><h5>${ userName }님의 결재대기 문서함</h5></div>  
						            <div class="count">
							            <h4>${ noApprovalSignCount }건</h4>
						            </div>
						            <div>
						            <button id="round-button">TODAY ${ noApprovalSignCountToday }건</button>
						            </div>
										</div>
						        <div class="highlight-box" id="7daysOuterList">
						            <div class="title"><h5>${ userName }님의 일주일 이상 <br>지연된 결재 대기함</h5></div>
						            <div class="count">
						            	<h4>${ mdCount }건</h4>
						            </div>
						        </div>
						        <div class="highlight-box" id="UserApprovalList">
						            <div class="title"><h5>${ userName }님의 결재 처리함</h5></div>
						            <div class="count">
						            	<h4>${ slistCount }건</h4>
						            </div>
						        </div>
						        <div class="highlight-box" id="UserAllList">
						            <div class="title"><h5>${ userName }님의 전체 결재함</h5></div>
						            <div class="count">
						            	<h4>${ ulistCount }건</h4>
						            </div>
						        </div>
								    <div class="highlight-box" id="AllList" style="display:none;">
						            <div class="title"><h5>전체 결재함 &nbsp;</h5></div>
						            <div class="count">
						            	<h4>${ listCount }건</h4>
						            </div>
								    </div>
						    </div>
						
						    <!-- List of Requests -->
						    <div class="requests-list">
						        <div class="request-item">
						            <div class="content2">
												    <div class="d-flex justify-content-between align-items-center mb-3 selectContent">
												        <div>
												        		<div>
												        			<select name="status" id="statusSelect" class="custom-select">
																		    <option value="전체">전체</option>
																		    <option value="보통">보통</option>
                                        <option value="긴급">긴급</option>
																			</select>
																	    <select name="conditions" id="selects" class="custom-select">
                                         <option value="전체">전체</option>
                                         <option value="B">비품신청서</option>
                                         <option value="M">매출보고서</option>
                                         <option value="J">지출결의서</option>
                                         <option value="G">기안서</option>
                                         <option value="H">휴직신청서</option>
	                                     </select>
												        		</div>
												        </div>
												        <div class="search-container">
		                          		<select name="condition" id="select_search" class="custom-select2">
															    	<option value="PAYMENT_WRITER">기안자</option>
                                      <option value="DEPARTMENT">부서</option>
																	</select>
													        <input type="text" id="search_input" placeholder="검색어를 입력하세요" class="search-input">
																</div>
												    </div>
												    <div style="height: 700px;">
												    <table class="table table-striped task-table" id="data-table">
												        <thead>
												            <tr>
											                 <th>번호</th>
											                 <th>제목</th>
                                        <th>문서</th>
                                        <th>기안자</th>
                                        <th>부서</th>
                                        <th>기안일</th>
                                        <th>승인여부</th>
                                        <th>승인날짜</th>
                                        <th>상태</th>
												            </tr>
												        </thead>
												        <tbody id="tStatus">
												        <c:choose>
												        	<c:when test="${ not empty list }">
												        		<c:forEach var="l" items="${ list }">
                                     		<tr onclick="location.href='${contextPath}/pay/detail.do?approvalNo=${ l.approvalNo }&documentNo=${ l.documentNo }&documentType=${ l.documentType }&payWriter=${ l.payWriter }&payWriterNo=${ l.payWriterNo }';">
                                            <td>${ l.approvalNo }</td>
                                            <td>${ l.title }${ l.salesStatus + l.draftStatus + l.businessStatus == 1 ? '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">
				                                        <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
				                                        </svg>' : ""}
                                            </td>
                                            <td>${ l.documentType }</td>
                                            <td>${ l.payWriter }</td>
                                            <td>${ l.department }</td>
                                            <td>${ l.registDt }</td>
                                            <td><span class="badge">${ l.documentStatus }</span></td>
                                            <td>${ l.documentStatus == '완료'  ?  l.finalApproDt : "-" }</td>
                                    				<td class="status">${ l.payStatus }</td>
                                        </tr>
                                    	</c:forEach>
                                    </c:when>
                                    <c:otherwise>
	                                     <tr>
																		       <td colspan="9">존재하는 게시글이 없습니다.</td>
																		   </tr>
                                    </c:otherwise>
                                  </c:choose>
												        </tbody>
												    </table>
												    
														    	<div id="cen_bottom_pagging">
																			<div id="pagin_form">
																				<ul class="pagination">
												        					<c:if test="${ list != null && !list.isEmpty()}">
														               	<li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a href="${ contextPath }/pay/noApprovalListMain.page?page=${pi.currentPage-1}">◁</a></li>
														      
																			      <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
																			       	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a href="${ contextPath }/pay/noApprovalListMain.page?page=${p}">${ p }</a></li>
																			      </c:forEach>
														      
																			      <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a href="${ contextPath }/pay/noApprovalListMain.page?page=${pi.currentPage+1}">▷</a></li>
																		   		</c:if>
																		   	</ul>
														          </div>
													        </div>
										         </div>
										     </div>
						        </div>
						    </div>
						</div>
<script>
    $(document).ready(function(){
       
        $("#tStatus .status").each(function(){
            var text = $(this).text();
            if(text == '긴급'){
                $(this).css("color", "red");
            } else if(text == '보통'){
                $(this).css("color", "rgb(49, 106, 153)");
            } 
        });
        
       if("${userNo}" == 1){
    	   $("#AllList").css("display", "block");
       }
        
    });
    
</script>
	          
	          
	          
		        </div>
					</div>
	        <!-- content 끝 -->
        <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
    
</body>
</html>