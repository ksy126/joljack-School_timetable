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

<script type="text/javascript">
//학과 소개 이동
function move_school_introduce(){
	location.href="<%=cp%>/cmd/move_school_introduce.do";
}
//교수님 소개 이동
function school_professor_info(){
	location.href="<%=cp%>/cmd/school_professor_info.do";
}
//학생회 조직도 이동
function organization_chart(){
	location.href="<%=cp%>/cmd/organization_chart.do";
} 
//학과 일정 이동
function department_schedule(){
	location.href="<%=cp%>/cmd/department_schedule.do";
}
//학교 공지 이동 
function school_notice(){
	location.href="<%=cp%>/cmd/school_notice.do";
}

//게시판 이동
function school_board(){
	location.href="<%=cp%>/cmd/school_board.do";
}
//학과 공지 이동
function move_department_notice(){	
	location.href="<%=cp%>/cmd/move_department_notice.do";
}

//개인 정보 이동  
function school_personal_information(){
	var member_no = $("#member_no").val();	
	location.href="<%=cp%>/cmd/school_personal_information.do?member_no="+member_no;
}

</script>
<title>시간표</title>
</head>
<body>
<div data-role="page" style=" background-color: #ffffff;">

  <input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no">

  <div data-role="main" class="ui-content">
  
  	<div align="center" style="margin-top: 3em; margin-bottom: 3em;">
  		<img src="../img/ayu_logo.jpg" style="width: 90%;">
  		<p>컴퓨터 공학과</p>
  	</div>
  
	<div class="ui-grid-c" align="center" style="font-size: 12px;">
		<div class="ui-block-a">
			<img src="../img/1.png" onclick="move_school_introduce()">
			<p><strong>학과 소개</strong></p>
		</div>
		<div class="ui-block-b">
			<img src="../img/2.png" onclick="school_professor_info()">
			<p><strong>교수님 소개</strong></p>
		</div>
		<div class="ui-block-c">
			<img src="../img/3.png" onclick="organization_chart()">
			<p><strong>학생회 조직도</strong></p>
		</div>
		<div class="ui-block-d">
			<img src="../img/4.png" onclick="department_schedule()">
			<p><strong>학사 일정</strong></p>
		</div>	
	</div>
	<div class="ui-grid-c" align="center" style="font-size: 12px; margin-top: 1em;">
		<div class="ui-block-a">
			<img src="../img/5.png" onclick="school_notice()">
			<p><strong>학교 공지</strong></p>
		</div>
		<div class="ui-block-b">
			<img src="../img/6.png" onclick="move_department_notice()">
			<p><strong>학과 공지</strong></p>
		</div>
		<div class="ui-block-c">
			<img src="../img/7.png" onclick="school_board()">
			<p><strong>게시판</strong></p>
		</div>
		<div class="ui-block-d">
			<img src="../img/8.png" onclick="school_personal_information()">
			<p><strong>개인 정보</strong></p>
		</div>	
	</div>
  </div>

  <div data-role="footer" data-position="fixed">

  </div>
</div> 

</body>
</html>