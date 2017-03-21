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

<script type="text/javascript">
$(document).ready(function(){
	
});//end document

function call_back(){
	history.go(-1);
}

function delete_notice_department(notice_no){
	location.href="<%=cp%>/cmd/delete_notice_department.do?notice_no="+notice_no;
}

</script>
</head>
<body>
<div data-role="page" style=" background-color: #fff;">

	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no">

	<div data-role="header" style="background-color: #6d92c6; color: #fff;">
		<i class="fa fa-angle-double-left" style="position: absolute; font-size:24px; color: #fff; margin-left:0.5em; margin-top: 0.3em;" onclick="call_back()"></i>
		<c:if test="${noticeVo.category == '01' }"><h3>전체 공지</h3></c:if>
		<c:if test="${noticeVo.category == '02' }"><h3>학년별 공지</h3></c:if>		
	</div>	

	<div data-role="main" class="ui-content">
		<p>작성자 &nbsp; : &nbsp; ${noticeVo.member_name}</p>		
		<input type="text" value="${noticeVo.title}" readonly="readonly">
		<textarea readonly="readonly" style="resize: none;">${noticeVo.content }</textarea>
		<div class="ui-grid-a">
		<div class="ui-block-a"><input type="button" value="확인" onclick="call_back()"></div>
		<div class="ui-block-b"><input type="button" value="삭제" onclick="delete_notice_department('${noticeVo.notice_no}')"></div>
		</div>
	</div> 
</div>
</body>
</html>