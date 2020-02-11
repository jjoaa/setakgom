<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*, com.spring.order.*" %>
<%@ page import="com.spring.setak.*" %>
<%@ page import="java.util.*, com.spring.setak.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
	List<OrderVO> orderlist = (ArrayList<OrderVO>)request.getAttribute("orderlist");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-d");
	int listcount = ((Integer)request.getAttribute("listcount")).intValue();
	int nowpage = ((Integer)request.getAttribute("page")).intValue();
	int maxpage = ((Integer)request.getAttribute("maxpage")).intValue();
	int startpage = ((Integer)request.getAttribute("startpage")).intValue();
	int endpage = ((Integer)request.getAttribute("endpage")).intValue();
	int limit = ((Integer)request.getAttribute("limit")).intValue();
	
	WashingVO washVO = (WashingVO)request.getAttribute("washVO");
	MendingVO mendVO = (MendingVO)request.getAttribute("mendingVO");
	KeepVO keepVO = (KeepVO)request.getAttribute("keepVO");

	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>세탁곰</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="./css/default.css"/>
<link rel="stylesheet" type="text/css" href="./css/orderview.css"/><!-- 여기 본인이 지정한 css로 바꿔야함 -->
<link rel="stylesheet" type="text/css" href="./css/review.css"/><!-- 여기 본인이 지정한 css로 바꿔야함 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		var member_id = "<%=session.getAttribute("member_id")%>";
		$("#header").load("./header.jsp");
		$("#footer").load("./footer.jsp");  
		
		//모달팝업 오픈
	    $(".open").on('click', function(){
	    	$("#re_layer").show();	
	    	$(".dim").show();	
		});
	    $(".close").on('click', function(){
	    	$(this).parent().hide();	
	    	$(".dim").hide();
	    	location.href='./orderview.do';
		});
		
	  //별점 구동	
		$('.r_content a').click(function () {
		$(this).parent().children('a').removeClass('on');
	    $(this).addClass('on').prevAll('a').addClass('on');      
	    $('#Review_star').val($(this).attr("value"));
	    return false;
		});	
		
		//입력받을곳 확인체크 + 값 컨트롤러로 전달
		function rwchk(){	

			if (document.getElementById('Review_content').value=="") 
			{
				alert("리뷰의 내용을 작성하세요.(최대 300자)");
		        document.getElementById('Review_content').focus();
		        return false;
		        
		    }
			else if (document.getElementById('Review_star').value=="") 
			{
		    	alert("별점을 눌러주세요");
		        document.getElementById('Review_star').focus();
		        return false;
		    }
			else if (document.getElementById('Review_kind').value=="") 
			{
		    	alert("이용하신 서비스를 선택해주세요");
		        document.getElementById('Review_kind').focus();
		        return false;
		    }
			return true;
		}
		
		//취소
		function rwcancel(){
			  var check = confirm("작성을 취소하시겠습니까");
			  if(check)
			  { 
				  location.href='./orderview.do';
			  }
			  else
			  { 
				  return false;
			  }
		}

	  
	   
		jQuery(".accordion-content").hide();
		//content 클래스를 가진 div를 표시/숨김(토글)
		$(".accordion-header").click(function(){
			$except = $(this).closest("div");
			$except.toggleClass("active");
			$(".accordion-content")
				.not($(this).next(".accordion-content").slideToggle(500)).slideUp();
			$('.mypage_content_cover').find('.accordion>.accordion-header').not($except).removeClass("active");
		});
		
		// 결제 취소		
		$(document).on('click', '#order_false', function(event) {
			var btn = $(this); 
			var order_muid = btn.attr('name');
			
			alert(order_muid); 
			
			if(confirm("선택된 주문을 취소하시겠습니까?")) {
			    jQuery.ajax({
				      "url": "/setak/cancelPay.do",
				      "type": "POST",
				      "contentType": "application/x-www-form-urlencoded; charset=UTF-8",
				      "data": {
				        "order_muid" : order_muid
				      },
				      "dataType": "json"
				    }).done(function(result) { // 환불 성공시 로직 
				        alert("주문이 성공적으로 취소 되었습니다.");
				    }).fail(function(result) { // 환불 실패시 로직
				      	alert("주문 취소가 실패했습니다. 고객센터로 연락주세요.");
				    });	
			}		    
		}); 
	    
	});


    
function cancle() {
	confirm("주문을 취소하시겠습니까?");
}
</script>
</head>
<body>
	<div id="header"></div>
	
	<!-- 여기서 부터 작성하세요. 아래는 예시입니다. -->
	<section id="test"> <!-- id 변경해서 사용하세요. -->
		<div class="content"> <!-- 변경하시면 안됩니다. -->
			<div class="mypage_head">
				<ul>
					<li class="mypage-title">마이페이지</li>
					<li>
							<ul class="mypage_list">
							<li>주문관리</li>
							<li><a href="orderview.do">주문/배송현황</a></li>
							<li><a href="mykeep.do">보관현황</a></li>
						</ul>
						<ul class="mypage_list">
							<li>정기구독</li>
							<li><a href="mysub.do">나의 정기구독</a></li>
						</ul>
						<ul class="mypage_list">
							<li>고객문의</li>
							<li><a href="myqna.do">Q&amp;A 문의내역</a></li>
						</ul>
						<ul class="mypage_list">
							<li>정보관리</li>
							<li><a href="profile1.do">개인정보수정</a></li>
							<li><a href="mycoupon.do">쿠폰조회</a></li>
							<li><a href="mysavings.do">적립금 조회</a></li>
							<li><a href="withdraw.do">회원탈퇴</a></li>
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="mypage_content">
				<h2>주문/배송현황</h2>
				<div class="mypage_content_cover">
					<p>
						<font size=2.5rem>※ 취소 버튼은 신청 당일 밤 10시 전까지만 활성화됩니다. 이후 취소는 불가합니다.</font>
					</p>
					<% 
							for (int i = 0; i<orderlist.size(); i++){	
								OrderVO orderVO = (OrderVO)orderlist.get(i);
								
								// 리스트 하고 싶으면 for문을 돌려 힘을내 > keepVO도 리스트일거 아녀.. 
								String start = keepVO.getKeep_start();
								String[] date = start.split(" ");
								String start_date = date[0]; 			
								
								String end = keepVO.getKeep_end();
								String[] date2 = end.split(" ");
								String end_date = date2[0];
							
					%>
					<div class="accordion">
						<div class="accordion-header">주문일자 : <%=orderVO.getOrder_date() %></div>
						<div class="accordion-content">
							<!--snb -->
							<div class="snb">
								<div class="ordernumber">
									<p>주문 번호 :</p>
									<p><%=orderVO.getOrder_num() %></p>
								</div>
								<div class="addr">
									<p>주소 :</p>
									<p><%=orderVO.getOrder_address() %></p>
								</div>
								<br><br><br><br><br>
								
								<div class="order_dateClass">
									
								<a href="#" class="open">리뷰작성</a>
								<div id="re_layer">
								<form action="./reviewInsert.do" method="post" enctype="multipart/form-data" name="reviewform" id ="reviewform">
								<h2>세탁곰 리뷰 작성</h2>
								<div class="r_content">
									<p style="margin-bottom:5px;">사용자 평점</p> 
									<a class="starR1 on" value="1" >별1_왼쪽</a>
								    <a class="starR2" value="2">별1_오른쪽</a>
								    <a class="starR1" value="3">별2_왼쪽</a>
								    <a class="starR2" value="4">별2_오른쪽</a>
								    <a class="starR1" value="5">별3_왼쪽</a>
								    <a class="starR2" value="6">별3_오른쪽</a>
								    <a class="starR1" value="7">별4_왼쪽</a>
								    <a class="starR2" value="8">별4_오른쪽</a>
								    <a class="starR1" value="9">별5_왼쪽</a>
								    <a class="starR2" value="10">별5_오른쪽</a>    
								    <small>&nbsp;별점 :<input type="text" id="Review_star" name="Review_star" value="" readonly="readonly"></small>   
								   	<input type="hidden" id="Review_like" name="Review_like" value="0">  	
								</div>      
								<table class="r_content">
									<tr><td colspan="7" class = "r_notice">&nbsp;REVIEW|&nbsp;<p style="display:inline-block; font-size: 0.8rem; color:#e1e4e4 ;"> 문의글은 무통보 삭제 됩니다</p></td></tr>
								    <tr><td colspan="7"><textarea id="Review_content" name="Review_content" maxlength="300" placeholder="리뷰를 작성해 주세요"></textarea></td></tr>
								    <tr><td width="40px" ><input name="Review_photo" type="file" class="fileupload"/></td>                          
								        <td width="40px">
								        	<select name="Review_kind" id="Review_kind">
								           		<option value="">분류</option>
								                <option value="세탁">세탁</option>
								                <option value="세탁-수선">세탁-수선</option>
								                <option value="세탁-보관">세탁-보관</option>
								                <option value="수선">수선</option>
								                <option value="보관">보관</option>
								                <option value="정기구독">정기구독</option>
								           </select></td>
										<td align="right"  colspan="4">
											<input type="hidden" name = "review_photo" id = "review_photo">
											<input type="submit" name="submit" value="등록" id="reviewsubmit">
											<input id="cbtn" type="button" value="취소" onclick="rwcancel()"/>
										</td> 	
									</tr></table>
								</form>
								<a class="close"><i class="fas fa-times" aria-hidden="true" style="color:#444; font-size:30px;"></i></a>
								</div>
								<div class="dim"></div>    
									
									
									
									<%if (orderVO.getOrder_delete().equals(0)) {%>
									<a href='#' class="button" id="order_false" name="<%=orderVO.getOrder_muid()%>" disabled="true">주문 취소</a>
									<%} else { %>
									<a href='#' class="button" id="order_false" name="<%=orderVO.getOrder_muid()%>" disabled="false">주문 취소</a>
									<%} %>
								</div>
							</div>
							<!--//snb -->
							<!--content -->
							<div class="row_content">
								<div class="row_content2">
								<div class="my_laundry">
									<p>세탁 :</p>
									<p><%=washVO.getWash_cate() %>&nbsp;&nbsp;<%=washVO.getWash_method() %>&nbsp;&nbsp;<%=washVO.getWash_count() %></p>
								</div>
								<div class="my_mending">
									<p>수선 :</p>
									<p><%=mendVO.getRepair_cate() %>&nbsp;&nbsp;<%=mendVO.getRepair_kind() %>&nbsp;&nbsp;<%=mendVO.getRepair_code() %>&nbsp;&nbsp;<%=mendVO.getRepair_count() %></p>
								</div>
								<div class="my_keep">
									<p>보관 :</p>
									<p><%=keepVO.getKeep_cate() %>&nbsp;&nbsp;<%=keepVO.getKeep_kind() %>&nbsp;&nbsp;<%=keepVO.getKeep_count() %>&nbsp;&nbsp;<%=keepVO.getKeep_box() %>&nbsp;&nbsp;<%=start_date %>&nbsp;&nbsp;<%=end_date%></p>
								</div>
								</div>
								<div class="price">
									<p>상태 : <%=orderVO.getOrder_status() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 합계 : <%=orderVO.getOrder_price() %>&nbsp;원</p>
								</div>
							</div>
						</div>
					</div>
					<%
						}
%>
				</div>
				<div class="page1">
				<table class="page">
					<tr align = center height = 20>
              			<td>
              				<%if(nowpage <= 1) {%>
              				<div class="page_a"><a>&#60;</a></div>
              				<%} else {%>
              					<div class="page_a"><a href ="./orderview.do?page=<%=nowpage-1 %>">&#60;</a></div>
              				<%} %>
              				<%for (int a=startpage; a<=endpage; a++) {
              					if(a==nowpage) {
           					%>
           					<div class="page_a"><a><%=a %></a></div>
           					<%} else {%>
           						<div class="page_a"><a href="./orderview.do?page=<%=a %>"><%=a %></a></div>
           					<%} %>
           					<%} %>
           					<%if (nowpage >= maxpage) {%>	
           						<div class="page_a"><a>&#62;</a></div>
           					<%} else { %>	
                  				<div class="page_a"><a href ="./orderview.do?page=<%=nowpage+1 %>">&#62;</a></div>
                  			<%} %>	
                  			</td>
               		</tr>
				</table>
				</div>
			</div>
			
		</div>
	</section>
	<!-- 여기까지 작성하세요. 스크립트는 아래에 더 작성해도 무관함. -->
	
	<div id="footer"></div>
</body>
</html>