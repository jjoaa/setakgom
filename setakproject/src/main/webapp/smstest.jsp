<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.spring.setak.*" %>
<%response.setHeader("Access-Control-Allow-Origin","*"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/sha256.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript">
	$(document).ready(function(){
		$("#header").load("./header.jsp")
		$("#footer").load("./footer.jsp")     
		
		
		var fileEleCnt = $("input[type=file]").length;
		console.log(fileEleCnt);

		
		randomnum = function() {
			var array = new Uint32Array(1);
			window.crypto.getRandomValues(array);
			var num = array[0] + "";
			var rnum = num.substring(0,6);
			console.log(rnum);

			/* for (var i = 0; i < array.length; i++) {
			    console.log(array[i]);
			} */
			
			return rnum;
		}
		
		
		$("#btnSubmit").click(function (event) {
			var random = randomnum();
			event.preventDefault();
			
			// Get form
            var form = $('#fileUploadForm')[0];

            // Create an FormData object
            //var data = new FormData(form);
            var data = new FormData();
			console.log($("#filetest")[0].files.length);
			
			for(var i = 0; i < $("#filetest")[0].files.length; i++){
				data.append("files", $("#filetest")[0].files[i]);
			}

			$("#filetest")[0].files[0].name("test.jpg");
			var ab = $("#filetest")[0].files[0].name;
			console.log(ab);
			
         	/* $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/setak/testImage.do",
                data: data2,
                processData: false,
                contentType: false,
                cache: false,
                dataType: 'json',

                success: function (data) {
                	
                },
                error: function (e) {

				}
			}); */
			
   	     });
	});
	 
	
      
    </script>
</head>
<body>
	<form method="POST" enctype="multipart/form-data" id="fileUploadForm">
        <input type="file" name="files" id="filetest" accept="image/*" multiple/><br/><br/>
        <input type="submit" value="Submit" id="btnSubmit"/>
    </form>
</body>
</html> 