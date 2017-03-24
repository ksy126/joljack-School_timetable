<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
		<h3>학생회 조직도</h3>
	</div>	

	<div data-role="main" class="ui-content" align="center" onclick="img_expand()">
		<input type="hidden" value="/upload/img/school/${img.img_Name}" id="img_src">
		<img src="/upload/img/school/${img.img_Name}" style="width: 90%;">
	</div> 
</div>
</body>
</html>