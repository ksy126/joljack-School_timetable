<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.mySlides {display:none}
.w3-left, .w3-right, .w3-badge {cursor:pointer}
.w3-badge {height:13px;width:13px;padding:0}
</style>
<script type="text/javascript">
function move_timetable(){
	
	var member_no = $("#member_no").val();
	
	location.href="<%=cp%>/timeTable/main.do?member_no="+member_no;
}

function call_back(){
	history.go(-1);
}
function img_expand(){
	var img_src = $("#img_src").val();
	location.href="<%=cp%>/cmd/img_expand.do?img_src="+img_src;
}
</script>
</head>
<body>
<div data-role="page" style=" background-color: #fff;">

	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no">

	<div data-role="header" style="background-color: #6d92c6; color: #fff;">
		<i class="fa fa-angle-double-left" style="position: absolute; font-size:24px; color: #fff; margin-left:0.5em; margin-top: 0.3em;" onclick="call_back()"></i>	
		<h3>학사 일정</h3>
	</div>
	

	<div class="w3-content w3-display-container" style="max-width:800px">
		<c:forEach var="row" items="${imgList}">	           
	  		<img class="mySlides" src="/upload/img/school/${row.img_Name}" style="width:100%">
        </c:forEach>
	  <div class="w3-center w3-container w3-section w3-large w3-text-white" style="width:100%;position: fixed;background: cadetblue; margin-bottom: 0;">
	    <div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)">&#10094;</div>
	    <div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)">&#10095;</div>
	    <c:forEach var="row" items="${imgList}">	           
	  		<span class="w3-badge demo w3-border w3-transparent w3-hover-white"></span>
        </c:forEach>
	  </div>
	</div>
</div>
<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
     dots[i].className = dots[i].className.replace(" w3-white", "");
  }
  x[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " w3-white";
}
</script>
</body>
</html>