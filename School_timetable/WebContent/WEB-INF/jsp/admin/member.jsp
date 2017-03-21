<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  /* Note: Try to remove the following lines to see the effect of CSS positioning */
  .affix {
      top: 0;
      width: 100%;
  }

  .affix + .container-fluid {
      padding-top: 70px;
  }
  </style>
  
  <script type="text/javascript">
  $(document).ready(function(){
		var check = $("#check").val();
		if(check == 'yes'){
			alert("등록 완료");
		}
  });//end document
  
	function move_menu(data){
  		if(data == '01'){
  			location.href="<%=cp%>/admin/main.do";
  		} else if (data == '02'){
  			location.href="<%=cp%>/admin/notice.do";
  		} else if (data == '03'){
  			location.href="<%=cp%>/admin/member.do";
  		} else if (data == '04'){
  			location.href="<%=cp%>/admin/img_orgaization.do";
  		} else if (data == '05'){
  			location.href="<%=cp%>/admin/img_schedule.do";
  		} else if (data == '06'){
  			location.href="<%=cp%>/admin/notice_list.do";
  		}
  	}
  	
  	function member_join(){
  		document.insert_member.action = '<%=cp%>/cmd/insert_member.do';
  	    document.insert_member.submit();
  	}
  </script>
  
</head>
<body>

<div class="container-fluid" style="background-color:#23429c;color:#fff;height:100px;">
  <h1>관리자</h1>
</div>

<input type="hidden" value="${check}" id="check">

<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
  <ul class="nav navbar-nav">
    <li onclick="move_menu(01)"><a href="#">Main</a></li>
    <li onclick="move_menu(02)"><a href="#">학교 공지 관리</a></li>
    <li onclick="move_menu(06)"><a href="#">학교 공지 수정/삭제</a></li>
    <li class="active" onclick="move_menu(03)"><a href="#">회원 관리</a></li>
    <li onclick="move_menu(04)"><a href="#">학생회 조직도 관리</a></li>
    <li onclick="move_menu(05)"><a href="#">학사 일정 관리</a></li>
  </ul>
</nav>

<div class="container-fluid" style="background-color: #fff; margin-left: 7em; margin-right: 7em;">
	<form role="form" method="post" id="insert_member" name="insert_member" style="margin-top: 2em; margin-left: 1em; margin-right: 1em;">
		<div class="form-group">
		  <label for="usr">아이디(메일주소)</label>
		  <input type="text" class="form-control" id="member_id" name="member_id">
		</div>
		<div class="form-group">
		  <label for="usr">이름</label>
		  <input type="text" class="form-control" id="member_name" name="member_name">
		</div>
		<div class="form-group">
		  <label for="usr">학번</label>
		  <input type="text" class="form-control" id="member_code" name="member_code">
		</div>
		<div class="form-group">
		  <label for="usr">비밀번호</label>
		  <input type="password" class="form-control" id="member_pwd" name="member_pwd">
		</div>
	</form>
	
	<div align="right">
		<input class="btn btn-primary" type="button" value="가입" onclick="member_join()">
		<input class="btn btn-default" type="button" value="취소" onclick="call_back()">
	</div>
</div>

</body>
</html>
