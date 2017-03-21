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
  <script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>
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
	
	//저장전 유효성검사 및 파일업로드
	function Sym_save(){		
		var file = $('#file').val();
		if( file == '' || file == 'undefined'){
			
		} else {
			var frm = $( '#file_upload');
			save_file(frm);
			alert(frm);
			return false;
		}
	}
	
	function save_sympathy(){
		
		var img_Name = $('#fileNewName').val();
		var img_path = $('#fileUploadPath').val();
		var category = "02";
		var check = $('#check').val();
		
		var params = "img_Name="+img_Name+"&img_Path="+img_path+"&category="+category;

        $.ajax({
            type        : "POST" 
          , async       : true
          , url         : "/admin/save_img.do"
          , data        : params
          , dataType    : "json"
          , timeout     : 30000  
          , cache       : false    
          //, contentType : "application/x-www-form- urlencoded;charset=UTF-8"
          , error       : function(request, status, error) {
             alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );    
          }
          , success     : function(data) {
          				alert("이미지 등록이 완료 되었습니다.");
          				location.reload();
          }
  		});	
	}
	
	function save_file(frm){
		frm.submit();       
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
	
	          	save_sympathy();
	
	           }
	 		});
                               
	}
  
  
  
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
  	
  </script>
  
</head>
<body>

<div class="container-fluid" style="background-color:#23429c;color:#fff;height:100px;">
  <h1>관리자</h1>
</div>

<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
  <ul class="nav navbar-nav">
    <li onclick="move_menu(01)"><a href="#">Main</a></li>
    <li onclick="move_menu(02)"><a href="#">학교 공지 관리</a></li>
    <li onclick="move_menu(06)"><a href="#">학교 공지 수정/삭제</a></li>
    <li onclick="move_menu(03)"><a href="#">회원 관리</a></li>
    <li onclick="move_menu(04)"><a href="#">학생회 조직도 관리</a></li>
    <li class="active" onclick="move_menu(05)"><a href="#">학사 일정 관리</a></li>
  </ul>
</nav>

<div class="container-fluid" style="background-color: #fff;">
  <div style="margin-left: 7em; margin-right: 7em;">
  	<h3>학사 일정 등록</h3>
  	
  	<input type="hidden" id="fileUploadPath" name="fileUploadPath" value="" />
	<input type="hidden" id="fileNewName" name="fileNewName" value="" />
	<input type="hidden" id="destination" name="destination" value="" />
	
	<form id="file_upload" name="file_upload" method="post" accept="image/*;capture=camera" enctype="multipart/form-data" action="<%=cp%>/comm/saveFileUpload.do?fileGbn=sym">
		<input type="file" name="file" value="" id="file"  style="height: 25px;"/>
	</form>
	
	<div style="margin-top: 3em;">
  		<input type="button" value="등록" class="btn btn-danger" onclick="Sym_save()">
  	</div>
  </div>
</div>

</body>
</html>
