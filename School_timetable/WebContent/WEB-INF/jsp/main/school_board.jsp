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
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	board_list();
	
    //---------------------------------------
    // 폼 전송후 콜백함수 호출
    //---------------------------------------  
    var options = {
        dataType : "json",
    	contentType : "application/x-www-form-urlencoded;charset=UTF-8" ,
        success : function(data){
        
                    if(data.resultCode == '1') {
                    	$( "#fileUploadPath" ).val(data.fileUploadPath);
                        $( "#fileNewName").val(data.fileName);
                        $( "#destination").val(data.destination);
                        saveCompanyFile();
                   } else{
                	   alert( "첨부파일 등록에 실패하였습니다.");
                       
                   }
        },
        error : function(xhr, error, data) {
            alert( "파일 업로드에 실패하였습니다.");
        }
   };

   $("#file_upload").ajaxForm(options);
	
	
});//end document

function move_write(){
	document.getElementById("write_form").style.display='';
}

function write_close(){
	document.getElementById("write_form").style.display='none';
	$("#title").val("");
	$("#content").val("");
}

//글등록
function board_write(){
	var member_no = $("#member_no").val();
	var title = $("#title").val();
	var content = $("#content").val();
	var file = $("#file").val();
	
	if (title == '' || title == null){
		alert("제목을 입력 하세요.")
		return false;
	}
	if (content == '' || content == null){
		alert("내용을 입력 하세요.")
		return false;
	}
	if (file == ''){
		
	} else {
		var frm = $("#file_upload");
		save_file(frm);
		return false;
	}
	board_write_go();
}

function save_file(frm){
	frm.submit();
}

function board_write_go(){
	var member_no = $("#member_no").val();
	var title = $("#title").val();
	var content = $("#content").val();
	var img_Name = $("#fileNewName").val();
	var img_Path = $("#fileUploadPath").val();
	
	var params = "member_no="+member_no+"&title="+title+"&content="+content+"&img_Name="+img_Name+"&img_Path="+img_Path;
	
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/insert_boardList.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
    	  write_close();
      }
	});
}

//댓글 등록
function board_replay_write(board_no){
	var member_no = $("#member_no").val();
	var content = $("#re_content_"+board_no).val();
	if (content == '' || content == null){
		alert("내용을 입력 하세요.")
		return false;
	}
	var params = "member_no="+member_no+"&board_no="+board_no+"&content="+content;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/insert_board_replay.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
    	  write_close();
      }
	});
}
//리스트 가져오기
function board_list(){
	var params = "";
	
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/select_boardList.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  var html = "";
    	  var member_no = $("#member_no").val();
    	  
    	  $.each(data.list, function (index, list) {

    		  html += "<div style='background-color: #fff; margin-bottom: 2em;'>";
    		  html += "<p style='border-bottom: 0.5px solid #ececec; color: #386994; font-weight: bold !important; margin-left: 0.5em;'>"+list.title+"</p>";
    		  html += "<p style='color: #a5a5a5; margin-left: 0.5em; font-size: 12px;'>"+list.member_name;
    		  html += " | "+list.insertDate+"</p>";
    		  html += "<p style='color: #323232; font-weight: bold !important; margin-left: 0.5em;'>"+list.content+"</p>";
    		  
    		  
    		  if(member_no == list.member_no){
        		  html += "<div class='ui-grid-a'>";
        		  
        		  html += "<div class='ui-block-a'>";
        		  html += "<input type='hidden' value='"+list.title+"' id='title_"+list.board_no+"'>";
        		  html += "<input type='hidden' value='"+list.content+"' id='content_"+list.board_no+"'>";
        		  html += "<input type='button' value='수정' onclick='update_board("+list.board_no+")'>";
        		  html += "</div>";
        		  html += "<div class='ui-block-b'>";
        		  html += "<input type='button' value='삭제' onclick='delete_board("+list.board_no+")'>";
        		  html += "</div>";
        		  
        		  html += "</div>";
    		  }
    		  
    		  if(list.img_Name == null || list.img_Name == ''){ 
    			  
    		  } else {
    			  html += "<div onclick='img_expand("+list.board_no+")'>";
    			  html += "<input type='hidden' value='/upload/img/school/"+list.img_Name+"' id='img_src_"+list.board_no+"'>"
        		  html += "<img src='/upload/img/school/"+list.img_Name+"' style='width: 90%; height: 100px;'>"
        		  html += "</div>";
    		  }
    		  html += "<div style='background-color: #e5e8ed;'>";
    		  html += "<div class='ui-grid-b'>";
    		  html += "<div class='ui-block-a' style='width: 3%;'></div>";
    		  html += "<div class='ui-block-b' style='width: 65%;'>";
    		  html += "<input type='text' placeholder='댓글을 입력 하세요.' id='re_content_"+list.board_no+"'>"
    		  html += "</div>";
    		  html += "<div class='ui-block-c' style='width: 30%;'>";
    		  html += "<input type='button' value='등록' onclick='board_replay_write("+list.board_no+")'>";
    		  html += "</div>";
    		  html += "</div>";
    		  html += "</div>";    		  
    		  
    		  $.each(data.replay_list, function (index, replay_list) {
    			  if(list.board_no == replay_list.board_no){
    				  html += "<div style='background-color: #e5e8ed; font-size: 14px; margin-bottom: 0.1em;'>";
    				  html += "&nbsp&nbsp"+replay_list.member_name+"&nbsp:&nbsp"+replay_list.content;
    				  
    				  
    	    		  if(member_no == replay_list.member_no){
    	        		  html += "<div class='ui-grid-a' style='background-color: #e5e8ed;'>";
    	        		  
    	        		  html += "<div align='center' class='ui-block-a'>";
    	        		  html += "<input type='hidden' value='"+replay_list.content+"' id='re_content_"+replay_list.replay_no+"'>";
    	        		  html += "<a href='#' class='ui-btn ui-btn-inline ui-mini' onclick='update_replay("+replay_list.replay_no+")' style='width: 60%;'>수정</a>";
    	        		  html += "</div>";
    	        		  html += "<div class='ui-block-b'>";
    	        		  html += "<a href='#' class='ui-btn ui-btn-inline ui-mini' onclick='delete_replay("+replay_list.replay_no+")' style='width: 60%;'>삭제</a>";
    	        		  html += "</div>";
    	        		  
    	        		  html += "</div>";
    	    		  }
    	    		  html += "</div>";
    			  }    			  
    		  });    		  
    		  
    		  html += "</div>";
    		  html += "</div>";
    		  
    	  });
    	  
    	  $( "#board_list").html(html).trigger("create");
    	      	  
      }
	});
}


function update_replay(replay_no){
	var content = $("#re_content_"+replay_no).val();
	$("#modify_re_content").val(content);
	$("#modify_replay_no").val(replay_no);
	
	$("#popupModify_re").popup("open");
}

function update_board(board_no){
	var title = $("#title_"+board_no).val();
	var content = $("#content_"+board_no).val();
	
	$("#modify_title").val(title);
	$("#modify_content").val(content);
	$("#modify_board_no").val(board_no);
	
	$("#popupModify").popup("open");
}

function delete_board(board_no){
	var params = "board_no="+board_no;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/delete_board.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
      }
	});
}

function delete_replay(replay_no){
	var params = "replay_no="+replay_no;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/delete_replay.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
      }
	});
}

function popupConfirm(){
	var board_no = $("#modify_board_no").val();
	var title = $("#modify_title").val();
	var content = $("#modify_content").val();
	
	var params = "board_no="+board_no+"&title="+title+"&content="+content;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/update_board.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
    	  popupClose();
      }
	});
}

function popupConfirm2(){
	var replay_no = $("#modify_replay_no").val();
	var content = $("#modify_re_content").val();
	
	var params = "replay_no="+replay_no+"&content="+content;
    $.ajax({
        type        : "POST" 
      , async       : true
      , url         : "/cmd/update_replay.do"
      , data        : params
      , dataType    : "json"
      , timeout     : 30000  
      , cache       : false    
      //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
         alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
      }
      , success     : function(data) {
    	  board_list();
    	  popupClose2();
      }
	});
}

function popupClose(){
	$("#popupModify").popup("close");
}

function popupClose2(){
	$("#popupModify_re").popup("close");
}


function img_expand(board_no){
	var img_src = $("#img_src_"+board_no).val();
	location.href="<%=cp%>/cmd/img_expand.do?img_src="+img_src;
}

function saveCompanyFile(){
    
    var params = "";
    var file_name = jQuery("#fileNewName" ).val();
		
    var member_no = "school";
		var destination =  jQuery("#destination").val();
		
        params = "fileNewName=" + jQuery("#fileNewName" ).val() + "&fileUploadPath=" + jQuery("#fileUploadPath" ).val() +
        "&member_no=" + member_no+"&destination=" + destination;
  
   
	       $.ajax({
	             type        : "POST" 
	           , async       : true
	           , url         : "/cmd/saveCompanyFile.do"
	           , data        : params
	           , dataType    : "json"
	           , timeout     : 30000  
	           , cache       : false    
	           //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
	           , error       : function(request, status, error) {
	               alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );       
	           }
	           , success     : function(data) {
	             
	          	 $("#fileUploadPath" ).val(data.fileUploadPath);
	          	 $("#fileNewName").val(data.fileNewName);
	
	          	board_write_go();
	
	           }
	 		});
                             
	}

function call_back(){
	history.go(-1);
}
function move_free(){
	location.href="<%=cp%>/cmd/school_board.do";
}
function move_qa(){
	location.href="<%=cp%>/cmd/school_board_qa.do";
}
</script>
</head>
<body>
<div data-role="page" style=" background-color: #fff;">

	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no">

	<div data-role="header" style="background-color: #6d92c6; color: #fff;">
		<i class="fa fa-angle-double-left" style="position: absolute; font-size:24px; color: #fff; margin-left:0.5em; margin-top: 0.3em;" onclick="call_back()"></i>	
		<h3>게시판</h3>
		<i class="fa fa-pencil" style="position: absolute; font-size:26px; color: #fff; margin-left:0.5em; margin-top: 0.3em; right: .5em; top: 0em;" onclick="move_write()"></i>
	</div>	

	<div data-role="main" class="ui-content">
		
		<div align="center" class="ui-grid-a" style="border-top: 1px solid #6d92c6; border-bottom: 1px solid #6d92c6; margin-bottom: 1em; background-color: #fff;">
			<div class="ui-block-a" style="background-color: #e5e8ed; border-right: 2px solid #6d92c6;" onclick="move_free()"><h4>자유 게시판</h4></div>
			<div class="ui-block-b" onclick="move_qa()"><h4>질문/답변 게시판</h4></div>
		</div>
	
		<div id="write_form" style="display: none;">
			<input type="text" value="" id="title" placeholder="제목을 입력 하세요.">
			<textarea rows="" cols="" id="content" placeholder="내용을 입력 하세요." style="resize: none;"></textarea>
			<input type="hidden" id="fileUploadPath" name="fileUploadPath" value="" />
			<input type="hidden" id="fileNewName" name="fileNewName" value="" />
			<input type="hidden" id="destination" name="destination" value="" />
			
			<form id="file_upload" name="file_upload" method="post" accept="image/*;capture=camera" enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=sym">
				<input type="file" name="file" value="" id="file"  style="height: 25px;"/>
			</form>
			
			<div class="ui-grid-a">
				<div class="ui-block-a">
					<input type="button" value="등록" onclick="board_write()">
				</div>
				<div class="ui-block-b">
					<input type="button" value="취소" onclick="write_close()">
				</div>
			</div>
		</div>
	
		<div id="board_list"></div>
	</div>
	
	<!--팝업 -->
	<div id="popupModify" data-overlay-theme="a" style="max-width: 400px; background-color: #dddfe2;" data-role="popup" data-dismissible="false">
	    <div role="main">
	    	<div>
	    		<input type="hidden" value="" id="modify_board_no">
	    		<input type="text" value="" id="modify_title">
				<textarea id="modify_content" style="resize: none;"></textarea>
	    	</div>
	  	</div>
  		<div class="ui-grid-a">
			<div class="ui-block-a">
				<input type="button" value="수정" onclick="popupConfirm()">
			</div>
			<div class="ui-block-b">
				<input type="button" value="취소" onclick="popupClose()">
			</div>
		</div>	  	
	 </div>
	 
	 <!--팝업 -->
	<div id="popupModify_re" data-overlay-theme="a" style="max-width: 400px; background-color: #dddfe2;" data-role="popup" data-dismissible="false">
	    <div role="main" align="center">
	    	<p>댓글 수정</p>
	    	<div>
	    		<input type="hidden" value="" id="modify_replay_no">
				<textarea id="modify_re_content" style="resize: none;"></textarea>
	    	</div>
	  	</div>
  		<div class="ui-grid-a">
			<div class="ui-block-a">
				<input type="button" value="수정" onclick="popupConfirm2()">
			</div>
			<div class="ui-block-b">
				<input type="button" value="취소" onclick="popupClose2()">
			</div>
		</div>	  	
	 </div>
</div>
</body>
</html>