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
<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/cmd/main.do";
		alert("로그인 후 이용해 주세요.");
	</script>
</c:if>

<script type="text/javascript">
function member_join(){
	document.update_member.action = '<%=cp%>/cmd/update_member.do';
    document.update_member.submit();
}

function call_back(){
	history.go(-1);
}

function logout(){
	location.href="<%=cp%>/cmd/user_logout.do";
}
</script>

<title>시간표</title>
</head>
<body>
<div data-role="page">
  <div data-role="main" style="max-height: 100%;">
	<div class="ui-grid-solo">
		<form role="form" method="post" id="update_member" name="update_member" style="margin-top: 2em; margin-left: 1em; margin-right: 1em;">
			<input type="hidden" value="${memberVo.member_no}" id="member_no" name="member_no">
			아이디 <input type="text" value="${memberVo.member_id}" id="member_id" name="member_id">
			비밀번호 <input type="password" value="${memberVo.member_pwd}" id="member_pwd" name="member_pwd">
			이름 <input type="text" value="${memberVo.member_name}" id="member_name" name="member_name">
			연락처 <input type="text" value="${memberVo.member_phone}" id="member_phone" name="member_phone">
			주소 <input type="text" value="${memberVo.member_address}" id="member_address" name="member_address">
		</form>
	</div>
  </div>
  
  <div data-role="footer" data-position="fixed" style="text-align: center;" class="ui-grid-b">
  	<div class="ui-block-a">
  		<input type="button" data-theme="b" value="수 정" onclick="member_join()">
  	</div>
  	<div class="ui-block-b">
  		<input type="button" data-theme="a" value="취 소" onclick="call_back()">
  	</div>
  	<div class="ui-block-c">
  		<input type="button" data-theme="a" value="로그아웃" onclick="logout()">
  	</div>
	  
  </div>
  	
</div> 

</body>
</html>