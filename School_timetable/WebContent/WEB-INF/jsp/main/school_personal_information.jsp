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

function move_change_pwd(){
	var member_no = $("#member_no").val();	
	location.href="<%=cp%>/cmd/school_personal_information.do?member_no="+member_no;
}
function move_timetable(){
	var member_no = $("#member_no").val();	
	location.href="<%=cp%>/timeTable/main.do?member_no="+member_no;
}
function modify_pwd(){
	var member_no = $("#member_no").val();
	var member_pwd = $("#member_pwd").val();
	var params = "member_no="+member_no+"&member_pwd="+member_pwd;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/update_member_pwd.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  alert("변경 완료");
    	  location.reload();
      }
	});
}

</script>
</head>
<body>
<div data-role="page" style=" background-color: #fff;">

	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no">

	<div data-role="header" style="background-color: #6d92c6; color: #fff;">
		<i class="fa fa-angle-double-left" style="position: absolute; font-size:24px; color: #fff; margin-left:0.5em; margin-top: 0.3em;" onclick="call_back()"></i>	
		<h3>개인 정보</h3>
	</div>	

	<div data-role="main" class="ui-content">
	
	<div align="center" class="ui-grid-a" style="border-top: 1px solid #6d92c6; border-bottom: 1px solid #6d92c6; margin-bottom: 1em; background-color: #fff;">
		<div class="ui-block-a" style="background-color: #e5e8ed; border-right: 2px solid #6d92c6;" onclick="move_change_pwd()"><h4>비밀번호 변경</h4></div>
		<div class="ui-block-b" style="" onclick="move_timetable()"><h4>시간표</h4></div>
	</div>	
	
		<p>아이디</p>
		<input type="text" id="" name="" value="${memberVo.member_id}" readonly="readonly">
		
		<p>이름</p>
		<input type="text" id="" name="" value="${memberVo.member_name}" readonly="readonly">
		
		<p>학번</p>
		<input type="text" id="" name="" value="${memberVo.member_code}" readonly="readonly">
		
		<p>기존 비밀번호</p>
		<input type="text" id="" name="" value="${memberVo.member_pwd}" readonly="readonly">
		
		<p>변경할 비밀번호</p>
		<input type="text" id="member_pwd" name="" value="">
		
		<div  style="margin-top: 1em; margin-left: 1em; margin-right: 1em;">
			<input type="button" value="수정" onclick="modify_pwd()">
		</div>
	</div> 
</div>
</body>
</html>