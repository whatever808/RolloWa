<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
 		<!-- 사인관련 스크립트 -->
		<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
		<!-- ------------ -->
    <link href="${contextPath}/resources/css/mainPage/mainPage.css" rel="stylesheet">

    <!-- 모달 관련 -->
    <script src="${contextPath}/resources/js/iziModal.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/iziModal.min.css">

   	
<style>
/* Container styling */
.container {
    width: 90%;
    margin: 0 auto;
    font-family: Arial, sans-serif;
}

/* Header styling */
header {
    text-align: center;
    margin-bottom: 20px;
}

header h1 {
    font-size: 2em;
    margin: 0;
}

/* Date and people selection section */
.date-people-selection {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #ddd;
}

.date-people-selection .date-picker,
.date-people-selection .people-counter {
    display: flex;
    align-items: center;
}

.date-people-selection .date-picker input,
.date-people-selection .people-counter input {
    width: 50px;
    text-align: center;
    margin: 0 5px;
}

.date-people-selection .people-counter {
    display: flex;
    align-items: center;
}

.date-people-selection .people-counter div {
    margin-right: 10px;
}

.date-people-selection .people-counter button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
}

.date-people-selection .people-counter button:disabled {
    background-color: #ccc;
}

/* Benefit section */
.benefit-section {
    padding: 20px 0;
    border-bottom: 1px solid #ddd;
}

.benefit-section h2 {
    margin-bottom: 10px;
}

.benefit-section .benefit-tabs {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}

.benefit-section .benefit-tabs div {
    flex: 1;
    text-align: center;
    padding: 10px;
    cursor: pointer;
    border: 1px solid #ddd;
}

.benefit-section .benefit-tabs div.active {
    background-color: #feefad;
    color: black;
    border-color: #ddd;
}

.benefit-section .benefit-details {
    padding: 10px;
    border: 1px solid #ddd;
}

.benefit-section .benefit-details img {
    width: 50px;
    height: auto;
}

/* Summary section */
.summary-section {
    padding: 20px 0;
}

.summary-section table {
    width: 100%;
    border-collapse: collapse;
}

.summary-section table th,
.summary-section table td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.summary-section .total {
    font-size: 1.5em;
    text-align: right;
    margin-top: 20px;
}

.summary-section .total .amount {
    color: #007bff;
}

/* Button styling */
button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 1em;
    cursor: pointer;
    display: block;
    margin: 0 auto;
}

button:disabled {
    background-color: #ccc;
}
/* Container styling */
.container {
    width: 90%;
    margin: 0 auto;
    font-family: Arial, sans-serif;
}

/* Header styling */
header {
    text-align: center;
    margin-bottom: 20px;
}

header h1 {
    font-size: 2em;
    margin: 0;
    color: #333;
}

/* Date and people selection section */
.date-people-selection {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #ddd;
}

.date-people-selection .date-picker {
    display: flex;
    align-items: center;
}

.date-people-selection .date-picker label {
    margin-right: 10px;
    font-weight: bold;
}

.date-people-selection .date-picker input {
    width: 100px;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
    text-align: center;
}

.date-people-selection .people-counter {
    display: flex;
    justify-content: space-around;
    width: 100%;
}

.people-counter .counter-group {
    text-align: center;
    margin: 0 10px;
}

.people-counter .counter-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

.people-counter .counter-group span {
    display: block;
    font-size: 0.8em;
    color: #888;
    margin-top: 3px;
}

.people-counter .counter-controls {
    display: flex;
    align-items: center;
    justify-content: space-evenly;
}

.people-counter .counter-controls button {
   	background-color: #feefad;
    color: black;
    border: none;
    padding: 5px 10px;
    cursor: pointer;
    border-radius: 4px;
    font-size: 1.2em;
    line-height: 1;
}

.people-counter .counter-controls button:disabled {
    background-color: #ccc;
}

.people-counter .counter-controls input {
    width: 40px;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin: 0 5px;
    padding: 5px;
    font-size: 1em;
}

/* Container styling */
.quantity-container {
    display: flex;
    justify-content: space-around;
    align-items: center;
    padding: 20px;
    border-radius: 10px;
    background-color: #feefad;
    font-family: Arial, sans-serif;
}

/* Individual quantity group styling */
.quantity-group {
    text-align: center;
    margin: 0 20px;
}

.quantity-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
    color: #333;
}

.quantity-group span {
    display: block;
    font-size: 0.8em;
    color: #888;
    margin-top: 3px;
}

/* Quantity controls styling */
.quantity-controls {
    display: flex;
    align-items: center;
    justify-content: center;
}

.quantity-controls button {
    background-color: white;
    color: black;
    border: none;
    padding: 10px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 1.5em;
    line-height: 1;
    margin: 0 5px;
    width: 40px;
    height: 40px;
}

.quantity-controls button:disabled {
    background-color: #ccc;
}

.quantity-controls input {
   width: 60px;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    font-size: 1.2em;
    margin: 0 5px;
    background-color: white;
    height: 39px;
}

body {
    font-family: Arial, sans-serif;
    margin: 20px;
    background-color: #f9f9f9;
}

.ticket-container {
    width: 100%;
    max-width: 1293px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    padding: 20px;
    margin-top: 50px;
}

.ticket-table {
    width: 100%;
    border-collapse: collapse;
}

.ticket-table th, .ticket-table td {
    padding: 15px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

.ticket-table th {
    background-color: #feefad;
    font-weight: bold;
}

.quantity-controls {
    display: flex;
    align-items: center;
    justify-content: center;
}

.quantity-btn {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px;
    cursor: pointer;
    font-size: 16px;
    border-radius: 4px;
}

.quantity-btn:disabled {
    background-color: #ccc;
    cursor: not-allowed;
}

.quantity-controls input {
    width: 50px;
    text-align: center;
    border: none;
    font-size: 16px;
    margin: 0 5px;
}

#adult-own-price, #adult-companion-price {
    font-weight: bold;
}
.total-amount {
    font-size: 20px;
    font-weight: bold;
    text-align: right;
    margin-top: 20px;
}

#total-price {
    color: #007bff;
}

#total {
    color: #007bff;
}

.purchase-button {
    display: flex;
    width: 10%;
    padding: 15px;
    background-color: #feefad;
    color: black;
    border: none;
    border-radius: 8px;
    font-size: 18px;
    cursor: pointer;
    text-align: center;
    margin-top: 20px;
    text-decoration: none;
    justify-content: space-around;
    height: 50px;
}

.purchase-button:hover {
    background-color: #feefad87;
}
input{
    margin-bottom: 10px;
}
img{
    width: 100%;
}
.deatil_pay{
		padding: 10px;
    position: absolute;
    top: 1px;
    backdrop-filter: blur(10px);
}
</style>

</head>
<body>

<script>
$(document).ready(function() {
    let sum1 = 0;
    let sum2 = 0;

    function updateTotal() {
        let price1 = parseInt($("#adult-own-price1 span").text()) || 0;
        let price2 = parseInt($("#adult-own-price2 span").text()) || 0;
        let total = price1 + price2;
        $("#total").text(total + "원");
    }

    // 청소년 티켓 증가 버튼 클릭
    $("#teen-increase").on("click", function() {
        sum1 += 1;
        $("#teens").val(sum1);
        let found = false;
        $(".ticket-table tr").each(function() {
            if ($(this).find("td#ticketName").text() == "일반 이용권") {
                found = true;
                let newQuantity = sum1;
                $(this).find("#adult-companion").val(newQuantity);
                $(this).find("#adult-own-price1 span").text(newQuantity * 21000);
                updateTotal();
            }
        });

        if (!found) {
            let tr = "<tr>" +
                     "<td id='ticketName'>일반 이용권</td>" +
                     "<td>" +
                         "<div class='quantity-controls'>" +
                             "<input type='number' id='adult-companion' value='1' min='0' readonly>" +
                         "</div>" +
                     "</td>" +
                     "<td id='adult-own-price1'><span>21000</span>원</td>" +
                     "</tr>";
            $(".ticket-table").append(tr);
            updateTotal();
        }
    });

    // 청소년 티켓 감소 버튼 클릭
    $("#teen-decrease").on("click", function() {
        if (sum1 > 0) {
            sum1 -= 1;
            $("#teens").val(sum1);
            $(".ticket-table tr").each(function() {
                if ($(this).find("td#ticketName").text() == "일반 이용권") {
                    let newQuantity = sum1;
                    if (newQuantity > 0) {
                        $(this).find("#adult-companion").val(newQuantity);
                        $(this).find("#adult-own-price1 span").text(newQuantity * 21000);
                    } else {
                        $(this).remove();
                    }
                    updateTotal();
                }
            });
        }
    });

    // 어린이 티켓 증가 버튼 클릭
    $("#child-increase").on("click", function() {
        sum2 += 1;
        $("#children").val(sum2);
        let found = false;
        $(".ticket-table tr").each(function() {
            if ($(this).find("td#ticketName2").text() == "정기 이용권") {
                found = true;
                let newQuantity = sum2;
                $(this).find("#adult-own").val(newQuantity);
                $(this).find("#adult-own-price2 span").text(newQuantity * 21000);
                updateTotal();
            }
        });

        if (!found) {
            let tr = "<tr>" +
                     "<td id='ticketName2'>정기 이용권</td>" +
                     "<td>" +
                         "<div class='quantity-controls'>" +
                             "<input type='number' id='adult-own' value='1' min='0' readonly>" +
                         "</div>" +
                     "</td>" +
                     "<td id='adult-own-price2'><span>21000</span>원</td>" +
                     "</tr>";
            $(".ticket-table").append(tr);
            updateTotal();
        }
    });

    // 어린이 티켓 감소 버튼 클릭
    $("#child-decrease").on("click", function() {
        if (sum2 > 0) {
            sum2 -= 1;
            $("#children").val(sum2);
            $(".ticket-table tr").each(function() {
                if ($(this).find("td#ticketName2").text() == "정기 이용권") {
                    let newQuantity = sum2;
                    if (newQuantity > 0) {
                        $(this).find("#adult-own").val(newQuantity);
                        $(this).find("#adult-own-price2 span").text(newQuantity * 21000);
                    } else {
                        $(this).remove();
                    }
                    updateTotal();
                }
            });
        }
    });

    // 페이지 로드 시 총 금액 업데이트
    updateTotal();
});

</script>





		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
		
		 <!-- content 추가 -->
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div class="informations">
                <!-- informations left area start -->
                <div class="left_con">
									 <div class="container">
									        <header>
									            <h1>티켓 결제</h1>
									        </header>
									        
									          <div class="quantity-container">
											        <div class="quantity-group">
											            <label for="teens"><h5>일반 이용권</h5></label>
 											            <div style="position: relative;">
											            	<div><img src="${contextPath}/resources/images/rollooo.avif"></div>
											            	<div class="deatil_pay jua-regular">
											            		가격 : <del>25000원</del><br>
											            		가격 : <b>20000원</b><br>
											            		<span style="color:red;">직원 할인가 : 20%</span>
											            	</div>
											            </div>
											            <div style="display: flex;justify-content: space-around;">
													           	<div align="left">
													           		<input style="margin-bottom: 10px;" type="date">
													           	</div>
													           	<div class="quantity-controls">
												                <button class="quantity-btn" id="teen-decrease">−</button>
												                <input type="number" value="0" id="teens" min="0" readonly>
												                <button class="quantity-btn" id="teen-increase">+</button>
													           	</div>
											            </div>
											        </div>
											        <div class="quantity-group">
											            <label for="children"><h5>정기 이용권</h5></label>
											            <div style="position: relative;">
											            	<div><img src="${contextPath}/resources/images/rollooo.avif"></div>
											            	<div class="deatil_pay jua-regular">
											            		가격 : <del>25000원</del><br>
											            		가격 : <b>20000원</b><br>
											            		<span style="color:red;">직원 할인가 : 20%</span>
											            	</div>
											            </div>
											            <div style="display: flex;justify-content: space-around;">
													           	<div align="left">
													           		<input style="margin-bottom: 10px;" type="date">
													           	</div>
													           	
													           	<div class="quantity-controls">
												                <button class="quantity-btn" id="child-decrease">−</button>
												                <input type="number" id="children" value="0" min="0" readonly>
												                <button class="quantity-btn" id="child-increase">+</button>
													           	</div>
											            </div>
											            
											        </div>
											    </div>
										    
												<div class="ticket-container">
										        <table class="ticket-table">
										            <thead>
										                <tr>
										                    <th style="width: 300px;"><h5>입장권</h5></th>
										                    <th style="width: 100px;"><h5>수량</h5></th>
										                    <th style="width: 300px;"><h5>가격</h5></th>
										                </tr>
										            </thead>
													       <tbody>
													       
																 </tbody>
										        </table>
										        <div class="total-amount">
										            <h6>최종결제금액 :<span id="total"></span></h6>
										        </div>
										        <div style="display: flex; justify-content: flex-end;">
										        	<button class="purchase-button"><h5>결제</h5></button>
										        </div>
										    </div>
									    </div>
				    		</div>
				      </div>
				    </div>
				    
				  
   <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
   
    
</body>
</html>