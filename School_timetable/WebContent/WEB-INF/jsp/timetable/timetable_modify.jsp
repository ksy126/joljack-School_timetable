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
<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/cmd/main.do";
		alert("로그인 후 이용해 주세요.");
	</script>
</c:if>
<script type="text/javascript">

	$(document).ready(function(){
		
		load_timetable();
		
		$("#modify_button").click(function(){
			document.modify_timeTable.action = '<%=cp%>/timeTable/modify_timeTable.do';
		    document.modify_timeTable.submit();
		});
		
	});
	
	function load_timetable(){
		for(var i = 1; i<= 60; i++){
			var content_i = $("#content_"+i).val();
			if(content_i == "undefined" || content_i == null || content_i == ''){
				
			} else {
				
				var data = content_i.split(",");
				
				document.getElementById(i).innerHTML=data[2];
				document.getElementById(i).style.backgroundColor = data[1];				
			}
		}
	}
	
	function insert_data(){
		
		var start_num = $("#start_num").val();
		var class_color = $("#class_color").val();
		var class_name = $("#class_name").val();
		var class_num = $("#class_num").val();
		var class_time = $("#class_time").val();
		
		$("#popup").popup("close");
		
		for (var i = 1; i<=parseInt(class_time); i++){
			document.getElementById(start_num).innerHTML=class_name;
			document.getElementById(start_num).style.backgroundColor = class_color;
			
			$("#content_"+start_num).val(start_num+","+class_color+","+class_name+","+class_num);
			start_num = parseInt(start_num)+6;
			
			if(parseInt(start_num) > 60){
				//값 초기화
				$("#start_num").val("");
				$("#class_name").val("");
				$("#class_num").val("");
				break;
			}
		}	
		
		//값 초기화
		$("#start_num").val("");
		$("#class_name").val("");
		$("#class_num").val("");
	}
	
	function popup_open(num){
		$("#start_num").val(num);
		$("#popup").popup("open");
	}
	
	function popup_close(){
		$("#popup").popup("close");
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
</script>

<title>시간표</title>
</head>
<body>
<div data-role="page">
<div data-role="header" style="background-color: #6d92c6; color: #fff; margin-bottom: 1em;">
		<i class="fa fa-angle-double-left" style="position: absolute; font-size:24px; color: #fff; margin-left:0.5em; margin-top: 0.3em;" onclick="call_back()"></i>	
		<h3>시간표</h3>
	</div>
  <div data-role="main" style="max-height: 100%;">  	
  
    <div align="center" class="ui-grid-a" style="border-top: 1px solid #6d92c6; border-bottom: 1px solid #6d92c6; margin-bottom: 1em; background-color: #fff;">
		<div class="ui-block-a" style="border-right: 2px solid #6d92c6;" onclick="move_change_pwd()"><h4>비밀번호 변경</h4></div>
		<div class="ui-block-b" style="background-color: #e5e8ed;" onclick="move_timetable()"><h4>시간표</h4></div>
	</div>	
  
    <table border="1" style="width: 100%; height: 600px; text-align: center; table-layout: fixed;">
	    <tr style="background-color: #5586EB; color: #fff;">
	    	<td style="width: 50px;;"></td>
	    	<td>월</td>
	    	<td>화</td>
	    	<td>수</td>
	    	<td>목</td>
	    	<td>금</td>
	    	<td>토</td>
	    </tr>
	    <tr>    
	    	<td style="width: 50px; height: 50px; background-color: #FFBB00; color: #fff; table-layout: fixed;">1교시</td>
	    	<td id="1" onclick="popup_open('1')"></td>
	    	<td id="2" onclick="popup_open('2')"></td>
	    	<td id="3" onclick="popup_open('3')"></td>
	    	<td id="4" onclick="popup_open('4')"></td>
	    	<td id="5" onclick="popup_open('5')"></td>
	    	<td id="6" onclick="popup_open('6')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff; table-layout: fixed;">2교시</td>
	    	<td id="7" onclick="popup_open('7')"></td>
	    	<td id="8" onclick="popup_open('8')"></td>
	    	<td id="9" onclick="popup_open('9')"></td>
	    	<td id="10" onclick="popup_open('10')"></td>
	    	<td id="11" onclick="popup_open('11')"></td>
	    	<td id="12" onclick="popup_open('12')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff;">3교시</td>
	    	<td id="13" onclick="popup_open('13')"></td>
	    	<td id="14" onclick="popup_open('14')"></td>
	    	<td id="15" onclick="popup_open('15')"></td>
	    	<td id="16" onclick="popup_open('16')"></td>
	    	<td id="17" onclick="popup_open('17')"></td>
	    	<td id="18" onclick="popup_open('18')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff;">4교시</td>
	    	<td id="19" onclick="popup_open('19')"></td>
	    	<td id="20" onclick="popup_open('20')"></td>
	    	<td id="21" onclick="popup_open('21')"></td>
	    	<td id="22" onclick="popup_open('22')"></td>
	    	<td id="23" onclick="popup_open('23')"></td>
	    	<td id="24" onclick="popup_open('24')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff;">5교시</td>
	    	<td id="25" onclick="popup_open('25')"></td>
	    	<td id="26" onclick="popup_open('26')"></td>
	    	<td id="27" onclick="popup_open('27')"></td>
	    	<td id="28" onclick="popup_open('28')"></td>
	    	<td id="29" onclick="popup_open('29')"></td>
	    	<td id="30" onclick="popup_open('30')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff;">6교시</td>
	    	<td id="31" onclick="popup_open('31')"></td>
	    	<td id="32" onclick="popup_open('32')"></td>
	    	<td id="33" onclick="popup_open('33')"></td>
	    	<td id="34" onclick="popup_open('34')"></td>
	    	<td id="35" onclick="popup_open('35')"></td>
	    	<td id="36" onclick="popup_open('36')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff;">7교시</td>
	    	<td id="37" onclick="popup_open('37')"></td>
	    	<td id="38" onclick="popup_open('38')"></td>
	    	<td id="39" onclick="popup_open('39')"></td>
	    	<td id="40" onclick="popup_open('40')"></td>
	    	<td id="41" onclick="popup_open('41')"></td>
	    	<td id="42" onclick="popup_open('42')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff;">8교시</td>
	    	<td id="43" onclick="popup_open('43')"></td>
	    	<td id="44" onclick="popup_open('44')"></td>
	    	<td id="45" onclick="popup_open('45')"></td>
	    	<td id="46" onclick="popup_open('46')"></td>
	    	<td id="47" onclick="popup_open('47')"></td>
	    	<td id="48" onclick="popup_open('48')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff;">9교시</td>
	    	<td id="49" onclick="popup_open('49')"></td>
	    	<td id="50" onclick="popup_open('50')"></td>
	    	<td id="51" onclick="popup_open('51')"></td>
	    	<td id="52" onclick="popup_open('52')"></td>
	    	<td id="53" onclick="popup_open('53')"></td>
	    	<td id="54" onclick="popup_open('54')"></td>
	    </tr>
	    <tr>
	    	<td style="width: 50px; background-color: #FFBB00; color: #fff;">10교시</td>
	    	<td id="55" onclick="popup_open('55')"></td>
	    	<td id="56" onclick="popup_open('56')"></td>
	    	<td id="57" onclick="popup_open('57')"></td>
	    	<td id="58" onclick="popup_open('58')"></td>
	    	<td id="59" onclick="popup_open('59')"></td>
	    	<td id="60" onclick="popup_open('60')"></td>
	    </tr>
    </table>
  </div>
  
  <div data-role="footer" data-position="fixed" style="text-align: center;">
	  <input type="button" value="수정완료" id="modify_button">
  </div>
  
	<div id="popup"style="max-width: 300px; text-align: center;" data-role="popup" data-dismissible="false" data-overlay-theme="b">
      <div role="main" style="background-color: #fff;">
      	<input type="hidden" id="start_num">
      	<div class="ui-grid-a">
  			<div class="ui-block-a" style="width: 30%; margin-top: 1.2em;">색상</div>
  			<div class="ui-block-b" style="width: 65%">
  				<select id="class_color">
  					<option value="">취소</option>
  					<option value="#FFA7A7">빨강색</option>
  					<option value="#FFBA85">주황색</option>
  					<option value="#FFE08C">노랑색</option>
  					<option value="#CEF279">초록색</option>
  					<option value="#B2CCFF">파란색</option>
  					<option value="#D1B2FF">보라색</option>
  				</select>
			</div>
		</div>
      	<div class="ui-grid-a">
  			<div class="ui-block-a" style="width: 30%; margin-top: 0.9em;">강의명</div>
  			<div class="ui-block-b" style="width: 65%"><input type="text" id="class_name"></div>
		</div>
		<div class="ui-grid-a">
  			<div class="ui-block-a" style="width: 30%; margin-top: 0.9em;">강의실</div>
  			<div class="ui-block-b" style="width: 65%"><input type="text" id="class_num"></div>
		</div>
		<div class="ui-grid-a">
  			<div class="ui-block-a" style="width: 30%; margin-top: 1.2em;">시  간</div>  			
  			<div class="ui-block-b" style="width: 65%">
  				<select id="class_time">
  					<option value="1">1시간</option>
  					<option value="2">2시간</option>
  					<option value="3">3시간</option>
  					<option value="4">4시간</option>
  					<option value="5">5시간</option>
  					<option value="6">6시간</option>
  					<option value="7">7시간</option>
  					<option value="8">8시간</option>
  					<option value="9">9시간</option>
  					<option value="10">10시간</option>
  				</select>
  			</div>
		</div>
		<div class="ui-grid-a">
  			<div class="ui-block-a"><input type="button" value="입력" onclick="insert_data()"></div>
  			<div class="ui-block-b"><input type="button" value="취소" onclick="popup_close()"></div>
		</div>      	
      </div>
	</div>
	
	<form role="form" method="post" id="modify_timeTable" name="modify_timeTable">
		
	  <input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" name="member_no" id="member_no">  	
  	
	  <input type="hidden" value="${timetable.content_1}" id="content_1" name="content_1">
	  <input type="hidden" value="${timetable.content_2}" id="content_2" name="content_2">
	  <input type="hidden" value="${timetable.content_3}" id="content_3" name="content_3">
	  <input type="hidden" value="${timetable.content_4}" id="content_4" name="content_4">
	  <input type="hidden" value="${timetable.content_5}" id="content_5" name="content_5">
	  <input type="hidden" value="${timetable.content_6}" id="content_6" name="content_6">
	  <input type="hidden" value="${timetable.content_7}" id="content_7" name="content_7">
	  <input type="hidden" value="${timetable.content_8}" id="content_8" name="content_8">
	  <input type="hidden" value="${timetable.content_9}" id="content_9" name="content_9">
	  
	  <input type="hidden" value="${timetable.content_10}" id="content_10" name="content_10">
	  <input type="hidden" value="${timetable.content_11}" id="content_11" name="content_11">
	  <input type="hidden" value="${timetable.content_12}" id="content_12" name="content_12">
	  <input type="hidden" value="${timetable.content_13}" id="content_13" name="content_13">
	  <input type="hidden" value="${timetable.content_14}" id="content_14" name="content_14">
	  <input type="hidden" value="${timetable.content_15}" id="content_15" name="content_15">
	  <input type="hidden" value="${timetable.content_16}" id="content_16" name="content_16">
	  <input type="hidden" value="${timetable.content_17}" id="content_17" name="content_17">
	  <input type="hidden" value="${timetable.content_18}" id="content_18" name="content_18">
	  <input type="hidden" value="${timetable.content_19}" id="content_19" name="content_19">
	  
	  <input type="hidden" value="${timetable.content_20}" id="content_20" name="content_20">
	  <input type="hidden" value="${timetable.content_21}" id="content_21" name="content_21">
	  <input type="hidden" value="${timetable.content_22}" id="content_22" name="content_22">
	  <input type="hidden" value="${timetable.content_23}" id="content_23" name="content_23">
	  <input type="hidden" value="${timetable.content_24}" id="content_24" name="content_24">
	  <input type="hidden" value="${timetable.content_25}" id="content_25" name="content_25">
	  <input type="hidden" value="${timetable.content_26}" id="content_26" name="content_26">
	  <input type="hidden" value="${timetable.content_27}" id="content_27" name="content_27">
	  <input type="hidden" value="${timetable.content_28}" id="content_28" name="content_28">
	  <input type="hidden" value="${timetable.content_29}" id="content_29" name="content_29">
	  
	  <input type="hidden" value="${timetable.content_30}" id="content_30" name="content_30">
	  <input type="hidden" value="${timetable.content_31}" id="content_31" name="content_31">
	  <input type="hidden" value="${timetable.content_32}" id="content_32" name="content_32">
	  <input type="hidden" value="${timetable.content_33}" id="content_33" name="content_33">
	  <input type="hidden" value="${timetable.content_34}" id="content_34" name="content_34">
	  <input type="hidden" value="${timetable.content_35}" id="content_35" name="content_35">
	  <input type="hidden" value="${timetable.content_36}" id="content_36" name="content_36">
	  <input type="hidden" value="${timetable.content_37}" id="content_37" name="content_37">
	  <input type="hidden" value="${timetable.content_38}" id="content_38" name="content_38">
	  <input type="hidden" value="${timetable.content_39}" id="content_39" name="content_39">
		  
	  <input type="hidden" value="${timetable.content_40}" id="content_40" name="content_40">
	  <input type="hidden" value="${timetable.content_41}" id="content_41" name="content_41">
	  <input type="hidden" value="${timetable.content_42}" id="content_42" name="content_42">
	  <input type="hidden" value="${timetable.content_43}" id="content_43" name="content_43">
	  <input type="hidden" value="${timetable.content_44}" id="content_44" name="content_44">
	  <input type="hidden" value="${timetable.content_45}" id="content_45" name="content_45">
	  <input type="hidden" value="${timetable.content_46}" id="content_46" name="content_46">
	  <input type="hidden" value="${timetable.content_47}" id="content_47" name="content_47">
	  <input type="hidden" value="${timetable.content_48}" id="content_48" name="content_48">
	  <input type="hidden" value="${timetable.content_49}" id="content_49" name="content_49">
	  
	  <input type="hidden" value="${timetable.content_50}" id="content_50" name="content_50">
	  <input type="hidden" value="${timetable.content_51}" id="content_51" name="content_51">
	  <input type="hidden" value="${timetable.content_52}" id="content_52" name="content_52">
	  <input type="hidden" value="${timetable.content_53}" id="content_53" name="content_53">
	  <input type="hidden" value="${timetable.content_54}" id="content_54" name="content_54">
	  <input type="hidden" value="${timetable.content_55}" id="content_55" name="content_55">
	  <input type="hidden" value="${timetable.content_56}" id="content_56" name="content_56">
	  <input type="hidden" value="${timetable.content_57}" id="content_57" name="content_57">
	  <input type="hidden" value="${timetable.content_58}" id="content_58" name="content_58">
	  <input type="hidden" value="${timetable.content_59}" id="content_59" name="content_59">
	  <input type="hidden" value="${timetable.content_60}" id="content_60" name="content_60">
  </form>
</div> 

</body>
</html>