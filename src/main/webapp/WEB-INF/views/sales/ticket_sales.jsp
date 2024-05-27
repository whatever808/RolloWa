<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이용권 매출관리</title>
	
	<!-- 이용권 매출관리 스타일 -->
	<link href="${ contextPath }/resources/css/sales/ticket_sales.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
    <div class="content p-5">

        <!-- management page start -->
        <div class="sales-management-page">

            <h1 class="page-title">이용권 매출관리</h1>

            <!-- main top start(filter) -->
            <div class="main-top">

                <!-- year filter area start -->
                <div class="filter-div year-filter-div">

                    <!-- year select -->
                    <select class="filter-select form-control py-2">
                        <option>2018년</option>
                        <option>2018년</option>
                        <option>2018년</option>
                    </select> 

                    <!-- year sales info -->
                    <div class="filter-table">
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">총 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">평균 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최고 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최저 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        
                        
                    </div>

                </div>
                <!-- year filter area end -->

                <!-- month filter area start -->
                <div class="filter-div year-filter-div">

                    <!-- year select -->
                    <select class="filter-select form-control py-2">
                        <option>2018년</option>
                        <option>2018년</option>
                        <option>2018년</option>
                    </select> 

                    <!-- year sales info -->
                    <div class="filter-table">
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">총 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">평균 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최고 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최저 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        
                        
                    </div>

                </div>
                <!-- month filter area end -->

                <!-- day filter area start -->
                <div class="filter-div day-filter-div">

                    <!-- day select -->
                    <select class="filter-select form-control py-2">
                        <option>2018년</option>
                        <option>2018년</option>
                        <option>2018년</option>
                    </select> 

                    <!-- day sales info -->
                    <div class="filter-table">
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">총 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">평균 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최고 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최저 매출액</b>
                            <span class="filter-table-content">2000</span>
                        </div>
                        
                        
                    </div>

                </div>
                <!-- day filter area end -->

            </div>
            <!-- main top end(filter) -->

            <div class="chart-filter-div d-flex">
                <span class="chart-filter btn btn-secondary-outline">총 매출액</span>
                <span class="chart-filter btn btn-secondary-outline">평균 매출액</span>
            </div>

            <!-- main bottom start (chart) -->
            <div class="main-bottom">
                <div class="chart-left h-5 w-5" style="border: 1px solid tomato; height: 100px;">

                </div>

                <div class="chart-right h-5 w-5" style="border: 1px solid tomato; height: 100px;">

                </div>
                    

            </div>
            <!-- main bottom end (chart) -->
        
        </div>
        <!-- mangement page end -->
    
    </div>
    <!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
	
</body>
</html>