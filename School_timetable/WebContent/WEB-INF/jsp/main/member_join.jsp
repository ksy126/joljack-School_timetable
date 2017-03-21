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

<script type="text/javascript">
function member_join(){
	document.insert_member.action = '<%=cp%>/cmd/insert_member.do';
    document.insert_member.submit();
}

function call_back(){
	history.go(-1);
}
</script>

<title>시간표</title>
</head>
<body>
<div data-role="page">
  <div data-role="main" style="max-height: 100%;">
	<div class="ui-grid-solo">
		<form role="form" method="post" id="insert_member" name="insert_member" style="margin-top: 2em; margin-left: 1em; margin-right: 1em;">
			아이디 <input type="text" value="" id="member_id" name="member_id">
			비밀번호 <input type="password" value="" id="member_pwd" name="member_pwd">
			이름 <input type="text" value="" id="member_name" name="member_name">
			연락처 <input type="text" value="" id="member_phone" name="member_phone">
			주소 <input type="text" value="" id="member_address" name="member_address">
		</form>
	</div>
  </div>
  
  <div data-role="footer" data-position="fixed" style="text-align: center;" class="ui-grid-a">
  	<div class="ui-block-a">
  		<input type="button" data-theme="b" value="가 입" onclick="member_join()">
  	</div>
  	<div class="ui-block-b">
  		<input type="button" data-theme="a" value="취 소" onclick="call_back()">
  	</div>
	  
  </div>
  	
</div> 

</body>
</html>