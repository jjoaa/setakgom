<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*, com.spring.community.QnaVO, com.spring.order.OrderVO" %>   
<%
	int memberCnt= (int)request.getAttribute("memberCnt"); 
	int orderSum= (int)request.getAttribute("orderSum"); 
	int subPercent= (int)request.getAttribute("subPercent"); 
	int orderAllPrice = (int)request.getAttribute("orderAllPrice"); 

	String temp = (String)request.getAttribute("temp");
	String tempText = (String)request.getAttribute("tempText");
	
	int[] subArr = (int[])request.getAttribute("subArr");
	int[] sub2Arr = (int[])request.getAttribute("sub2Arr"); 
	
	int[] washArr = (int[])request.getAttribute("washArr");
	int[] repairArr = (int[])request.getAttribute("repairArr");
	int[] keepArr = (int[])request.getAttribute("keepArr");
	
	ArrayList<QnaVO> qnaList = (ArrayList<QnaVO>)request.getAttribute("qnaList");
	ArrayList<HashMap<String, Object>> subList = (ArrayList<HashMap<String, Object>>)request.getAttribute("subList");
	
	ArrayList<OrderVO> orderList = (ArrayList<OrderVO>)request.getAttribute("orderList");
	int orderCnt = (int)request.getAttribute("orderCnt");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>세탁곰 관리자페이지</title>
	<link rel = "shortcut icon" href = "../favicon.ico">
	<link rel="stylesheet" type="text/css" href="../css/admin.css"/>
	<link rel="stylesheet" type="text/css" href="../css/admin_main.css"/><!-- 여기 본인이 지정한 css로 바꿔야함 -->

	<!-- toast ui -->
    <link rel="stylesheet" type="text/css" href="./chart/tui-chart.css" />
    <link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/lint/lint.css'/>
    <link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/theme/neo.css'/>

    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/core-js/2.5.7/core.js'></script>
	<script type='text/javascript' src='https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.min.js'></script>
	<script type='text/javascript' src='https://uicdn.toast.com/tui.chart/latest/raphael.js'></script>
	<script src='./chart/tui-chart.js'></script>
	
	<!-- Chart.js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js" integrity="sha256-nZaxPHA2uAaquixjSDX19TmIlbRNCOrf5HO1oHl5p70=" crossorigin="anonymous"></script>
	<script src="./utils.js"></script>
	
	<!-- fullCallender -->
	<link href='./chart/core/main.css' rel='stylesheet' />
	<link href='./chart/list/main.css' rel='stylesheet' />
	<script src='./chart/core/main.js'></script>
	<script src='./chart/list/main.js'></script>
	<script src='./chart/locales/ko.js'></script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script type="text/javascript" class='code-js' id='code-js'>
		$(document).ready(function() {
			
			//헤더, 푸터연결
			$("#admin").load("./admin.jsp")
			
			var allPrice = <%=orderAllPrice%>;
			$('#price-span').text(numberFormat(allPrice));
			

			// 정기구독 차트 연결 부분
			var container = document.getElementById('chart-area');
			var data = {
			    categories: ['정기구독유형'],
			    seriesAlias: {
			        pie1: 'pie',
			        pie2: 'pie'
			    },
			    series: {
			        pie1: [
			            {
			                name: '올인원',
			                data: <%=subArr[0]%>
			            },
			            {
			                name: '와이셔츠',
			                data: <%=subArr[1]%>
			            },
			            {
			                name: '드라이',
			                data: <%=subArr[2]%>
			            },
			            {
			                name: '물빨래',
			                data: <%=subArr[3]%>
			            },
			            {
			                name: '물빨래&드라이',
			                data: <%=subArr[4]%>
			            }
			        ],
			        pie2: [
			            {
			                name: '올인원59',
			                data: <%=sub2Arr[0]%>
			            },
			            {
			                name: '올인원74',
			                data: <%=sub2Arr[1]%>
			            },
			            {
			                name: '올인원89',
			                data: <%=sub2Arr[2]%>
			            },
			            {
			                name: '올인원104',
			                data: <%=sub2Arr[3]%>
			            }, {
			                name: '올인원119',
			                data: <%=sub2Arr[4]%>
			            },
			            {
			                name: '올인원134',
			                data: <%=sub2Arr[5]%>
			            },
			            {
			                name: '와이29',
			                data: <%=sub2Arr[6]%>
			            },
			            {
			                name: '와이44',
			                data: <%=sub2Arr[7]%>
			            },
			            {
			                name: '와이55',
			                data: <%=sub2Arr[8]%>
			            },
			            {
			                name: '드라이44',
			                data: <%=sub2Arr[9]%>
			            },
			            {
			                name: '드라이59',
			                data: <%=sub2Arr[10]%>
			            },
			            {
			                name: '드라이74',
			                data: <%=sub2Arr[11]%>
			            },
			            {
			                name: '물빨래34',
			                data: <%=sub2Arr[12]%>
			            },
			            {
			                name: '물빨래49',
			                data: <%=sub2Arr[13]%>
			            },
			            {
			                name: '물빨래64',
			                data: <%=sub2Arr[14]%>
			            },
			            {
			                name: '물빨래79',
			                data: <%=sub2Arr[15]%>
			            },
			            {
			                name: '물빨래84',
			                data: <%=sub2Arr[16]%>
			            },
			            {
			                name: '물빨래99',
			                data: <%=sub2Arr[17]%>
			            },
			            {
			                name: '물드44',
			                data: <%=sub2Arr[18]%>
			            },
			            {
			                name: '물드59',
			                data: <%=sub2Arr[19]%>
			            },
			            {
			                name: '물드74',
			                data: <%=sub2Arr[20]%>
			            },
			            {
			                name: '물드89',
			                data: <%=sub2Arr[21]%>
			            }
			        ]
			    }
			};
			var options = {
			    chart: {
			        width: 200,
			        height: 270,
			    },
			    series: {
			        pie1: {
			            radiusRange: ['57%'],
			            labelAlign: 'center',
			            showLegend: false
			        },
			        pie2: {
			            radiusRange: ['70%', '100%'],
			            labelAlign: 'outer',
			            showLegend: false
			        }
			    },
			    legend: {
			        visible: false
			    },
			    tooltip: {
			        suffix: '%'
			    },
			    theme: 'newTheme'
			};

			tui.chart.registerTheme('newTheme', {
			    series: {
			        pie1: {
			            colors: ['#00a9ff', '#ffb840', '#ff5a46', '#00bd9f', '#785fff', '#f28b8c', '#989486', '#516f7d', '#29dbe3', '#dddddd'],
			            label: {
			                color: '#fff',
			                fontFamily: 'sans-serif'
			            }
			        },
			        pie2: {
			            colors: [
			                '#33baff', '#66ccff','#81BEF7', '#2E9AFE','#0080FF', '#81DAF5',
			                '#ffc666', '#ffd48c', '#FFDB9F',
			                '#ff7b6b', '#ff9c90','#F5A9A9',
			                '#33cab2', '#72CD8F', '#66BE8B', '#419B66', '#198D49', '#75B791',
			                '#937fff', '#B669DF', '#CEB2DE','#BC8ED5'
			                ],
			            label: {
			                color: '#fff',
			                fontFamily: 'sans-serif'
			            }
			        }
			    }
			});

			tui.chart.comboChart(container, data, options);	
									
		});

		// 주희언니 세수보 차트
		var today = new Date();
		var yesterday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		var dayago2 = new Date(Date.parse(today) - 2 * 1000 * 60 * 60 * 24);
		var dayago3 = new Date(Date.parse(today) - 3 * 1000 * 60 * 60 * 24);
		var dayago4 = new Date(Date.parse(today) - 4 * 1000 * 60 * 60 * 24); 
		
		/*데이터*/
		var config = {
			type: 'bar',
			data: {
				labels: [timeSt(dayago4), timeSt(dayago3), timeSt(dayago2), timeSt(yesterday), timeSt(today)],
				datasets: [{
					label: '세탁량',
					fill: false,
					backgroundColor: window.chartColors.red,
					borderColor: window.chartColors.red,
					data: [<%=washArr[4]%>,<%=washArr[3]%>,<%=washArr[2]%>,<%=washArr[1]%>,<%=washArr[0]%>],
				}, {
					label: '수선량',
					fill: false,
					backgroundColor: window.chartColors.blue,
					borderColor: window.chartColors.blue,
					data: [<%=repairArr[4]%>,<%=repairArr[3]%>,<%=repairArr[2]%>,<%=repairArr[1]%>,<%=repairArr[0]%>],
				}, {
					label: '보관량',
					fill: false,
					backgroundColor: window.chartColors.yellow,
					borderColor: window.chartColors.yellow,
					data: [<%=keepArr[4]%>,<%=keepArr[3]%>,<%=keepArr[2]%>,<%=keepArr[1]%>,<%=keepArr[0]%>],
				}]
			},
			options: {
				responsive: true,
				title: {
					display: true,
					text: '일별 주문 상태 변화'
				},
				tooltips: {
					mode: 'index',
					intersect: false,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					x: {
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Month'
						}
					},
					y: {
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Value'
						}
					}
				}
			}
		};
		
		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
		};
		
		   
		// 콤마      
		function numberFormat(inputNumber) {
			return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		      
		
		//Date 개체를 입력받아 yyyy-MM-dd 형식으로 반환
		function timeSt(dt) {
		    var d = new Date(dt);
		    var MM = d.getMonth()+1;
		    var dd = d.getDate();

		    return (addzero(MM) + '/' + addzero(dd));
		}
		
		//10보다 작으면 앞에 0을 붙임
		function addzero(n) {
		    return n < 10 ? "0" + n : n;
		}
		
		// fullCalender 
		  document.addEventListener('DOMContentLoaded', function() {
		    var calendarEl = document.getElementById('calendar');
		
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		      plugins: [ 'list' ],
		
		      header: {
		        left: 'prev,next today',
		        center: 'title',
		        right: 'listDay,listWeek,dayGridMonth'
		      },
		
		      // customize the button names,
		      // otherwise they'd all just say "list"
		      views: {
		        listDay: { buttonText: '일' },
		        listWeek: { buttonText: '주' }
		      },
		      locale: 'ko',		
		      defaultView: 'listWeek',
		      defaultDate: '2019-08-12',
		      navLinks: true, // can click day/week names to navigate views
		      editable: true,
		      eventLimit: true, // allow "more" link when too many events
		      events: [
		        {
		          title: 'All Day Event',
		          start: '2019-08-01'
		        },
		        {
		          title: 'Long Event',
		          start: '2019-08-07',
		          end: '2019-08-10'
		        },
		        {
		          groupId: 999,
		          title: 'Repeating Event',
		          start: '2019-08-09T16:00:00'
		        },
		        {
		          groupId: 999,
		          title: 'Repeating Event',
		          start: '2019-08-16T16:00:00'
		        },
		        {
		          title: 'Conference',
		          start: '2019-08-11',
		          end: '2019-08-13'
		        },
		        {
		          title: 'Meeting',
		          start: '2019-08-12T10:30:00',
		          end: '2019-08-12T12:30:00'
		        },
		        {
		          title: 'Lunch',
		          start: '2019-08-12T12:00:00'
		        },
		        {
		          title: 'Meeting',
		          start: '2019-08-12T14:30:00'
		        },
		        {
		          title: 'Happy Hour',
		          start: '2019-08-12T17:30:00'
		        },
		        {
		          title: 'Dinner',
		          start: '2019-08-12T20:00:00'
		        },
		        {
		          title: 'Birthday Party',
		          start: '2019-08-13T07:00:00'
		        },
		        {
		          title: 'Click for Google',
		          url: 'http://google.com/',
		          start: '2019-08-28'
		        }
		      ]
		    });
		
		    calendar.render();
		  });
		
	</script>
</head>
<body>
<div id="admin"></div>
<div class="content">
	<!-- 여기서부터 작업하세요. -->
	<!-- 대시보드 타이틀 Div 시작 -->
	<div id = "title-div">
		<div class = "title-num">
			<div class = "title-icon">
				<img src="https://img.icons8.com/dusk/50/000000/groups.png">
			</div>
			<div class = "title-content">
				<strong>신규 가입자</strong>
				<span>최근 1주일</span>
				<div class = "count-number-div">
					<span class = "count-number"><%=memberCnt %></span>
					<span class = "count-txt">명</span>
				</div>
			</div>
		</div>
		<div class = "title-num">
			<div class = "title-icon">
				<img src="https://img.icons8.com/dusk/50/000000/purchase-order.png">
			</div>
			<div class = "title-content">
				<strong>신규 주문</strong>
				<span>최근 5일</span>
				<div class = "ccount-number-div">
					<span class = "count-number"><%=orderSum %></span>
					<span class = "count-txt">건</span>
				</div>
			</div>
		</div>
		<div class = "title-num">
			<div class = "title-icon">
				<img src="https://img.icons8.com/dusk/50/000000/discount-ticket.png">
			</div>
			<div class = "title-content">
				<strong>정기구독 회원</strong>
				<span>전체 회원 수 대비</span>
				<div class = "count-number-div">
					<span class = "count-number"><%=subPercent %></span>
					<span class = "count-txt">%</span>
				</div>
			</div>
		</div>
		<div class = "title-num">
			<div class = "title-icon">
				<img src="https://img.icons8.com/dusk/50/000000/receive-cash.png">
			</div>
			<div class = "title-content">
				<strong>오늘 매출액</strong>
				<span>단일 서비스 합산</span>
				<div class = "count-number-div">
					<span id = "price-span" class = "count-number" style = "font-size : 2.5rem;"></span>
					<span class = "count-txt">원</span>
				</div>
			</div>
		</div>
	</div>
	<!-- 대시보드 타이틀 Div 끝 -->

	<!-- 대시보드 내용 Div 시작 -->
	<div id = "content-div">	
		<!-- 대시보드 상단 3개 ul 시작 -->	
		<ul class = "body-ul">
			<li>
				<div class = "body-header">
					<h3>오늘의 날씨</h3>
				</div>
				<div class = "body-content">
					<div class = "today-div">
						<div class = "today-weather">
							<% 
								String[] weatherArr = tempText.split(",");
								String weather = weatherArr[0];
								
								if(weather.equals("맑음")) {
							%>
							<img src="https://img.icons8.com/dusk/100/000000/sun.png">
							<%} else { %>
							<img src="https://img.icons8.com/dusk/100/000000/rain.png">
							<% } %>
						</div>
						<div class = "today-content">
							<p class = "temp"><%=temp %>℃</p>
							<p class = "tempText"><%=tempText %></p>
						</div>
					</div>
					<p class = "tempExp">서울특별시 강남구 역삼동 기준 </p>
				</div>
			</li>
			<li>
				<div class = "body-header">
					<h3>정기구독</h3>
					<div class = "body-tool">
					<span><img src="https://img.icons8.com/small/16/000000/questions.png"></span>
					<p class="arrow_box">
						회원들에게 인기 있는 정기구독 유형을 확인 할 수 있습니다. 정기구독관리 - 차트 메뉴에서 더 자세한 내용을 확인 할 수 있습니다. 
					</p>
					<a href = "./subscribeChart.do"><img src="https://img.icons8.com/small/16/000000/poll-topic.png"></a>
					</div>
				</div>
				<div class = "body-content">
				<ul style = "width : 100%;">
					<li style = "width : 50%">
					<div id = "chart-area"></div>
					</li>
					<li style="float: right;margin-right: 0px;width: 50%;">
					<div id = "top-sub">
						<p>TOP5</p>
						<table id = "top-table">
							<tbody>
								<%for(int i = 0; i < subList.size(); i++) { %>
									<tr>
										<td><%=subList.get(i).get("SUBRANK") %></td>
										<td><%=subList.get(i).get("SUBSNAME") %></td>
										<td><%=subList.get(i).get("SUBSCNT") %>명</td>
									</tr>
								<%} %>
							</tbody>
						</table>
					</div>
					</li>
				</ul>
				</div>
			</li>
			<li>
				<div class = "body-header">
					<h3>세수보</h3>
					<div class = "body-tool">
					<span><img src="https://img.icons8.com/small/16/000000/questions.png"></span>
					<p class="arrow_box">
						최근 5일간의 세탁, 수선, 보관양을 확인 하실 수 있습니다. 주문관리 - 차트 메뉴에서 더 자세한 내용을 확인 할 수 있습니다. 
					</p>
					<a href = "./adminChart.do"><img src="https://img.icons8.com/small/16/000000/poll-topic.png"></a>
					</div>
				</div>
				<div class = "body-content">
					<div style="width:100%;">
						<canvas id="canvas"></canvas>
					</div>
				</div>
			</li>
		</ul>
		<!-- 대시보드 상단 3개 ul 끝 -->
		
		<!-- 대시보드 하단 3개 ul 시작 -->
		<ul class = "body-ul">
			<li>
				<div class = "body-header">
					<h3>미답변 Q&A</h3>
					<div class = "body-tool">
					</div>
				</div>
				<div class = "body-content">
					<table id = "qnaTable">
						<tbody>
								<%for(int i = 0; i < qnaList.size(); i ++) { 
									QnaVO qvo = qnaList.get(i);
									String qnaDate = qvo.getQna_date(); 
									String[] dateArr = qnaDate.split(" ");
									String date = dateArr[0].replace("-","/").substring(2, dateArr[0].length());
								%>
							<tr>
								<td><span class = "qnaKind"><%=qvo.getQna_type() %></span></td>
								<td><span class = "qnaTitle"><a href = "./admin_qna.do"><%=qvo.getQna_title() %></a></span></td>
								<td><span class = "qnaDate"><%=date %></span></td>
							</tr>
								<%} %>
						</tbody>
					</table>
				</div>
			</li>
			<li>
				<div class = "body-header">
					<h3>매출</h3>
					<div class = "body-tool">
					<span><img src="https://img.icons8.com/small/16/000000/questions.png"></span>
					<a href = "./adminChart.do"><img src="https://img.icons8.com/small/16/000000/poll-topic.png"></a>
					</div>
				</div>
				<div class = "body-content">
					<div id="calendar"></div>
				</div>
			</li>
			<li>
				<div class = "body-header">
					<h3>주문관리</h3>
					<div class = "body-tool">
					<span><img src="https://img.icons8.com/small/16/000000/questions.png"></span>
					<p class="arrow_box">
						결제완료 상태의 주문을 확인 할 수 있습니다. 주문관리 - 전체 메뉴에서 더 자세한 내용 확인 및 수정이 가능합니다. 
					</p>
					<a href = "./order.do"><img src="https://img.icons8.com/windows/16/000000/web.png"></a>
					</div>
				</div>
				<div class = "body-content">
					<div id = "order-text-div">
						<p class = "order-text">현재 처리해야 할 주문이 <span><%=orderCnt %></span>건 있습니다.</p>
					</div>
					<div id = "order-table-div">
						<table id = "order-table">
							<thead>
								<tr>
									<th>주문번호</th>
									<th>결제금액</th>
									<th>주문날짜</th>
								</tr>
							</thead>
							<tbody>
								<%for(int i = 0; i < orderList.size(); i ++) {
									OrderVO ovo = orderList.get(i); 
									String[] dateArr = ovo.getOrder_date().split(" ");
									String date = dateArr[0]; %>
								<tr class = "orderTable" onClick = "location.href='./order.do'">
									<td><%=ovo.getOrder_num() %></td>
									<td><%=ovo.getOrder_price() %>원</td>
									<td><%=date %></td>
								</tr>
								<%} %>
							</tbody>
						</table>
					</div>
				</div>
			</li>
		</ul>
		<!-- 대시보드 하단 3개 ul 끝-->


	</div>
	<!-- 대시보드 내용 Div 끝 -->
</div><!-- 지우지마세요 -->
</body>
</html>
