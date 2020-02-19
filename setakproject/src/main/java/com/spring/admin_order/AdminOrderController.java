 package com.spring.admin_order;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.admin_chart.AdminChartService;
import com.spring.community.QnaVO;
import com.spring.member.MemberSubVO;
import com.spring.order.OrderVO;

@Controller
public class AdminOrderController {
	
	@Autowired
	private AdminOrderService adminOrderService; 
	@Autowired
	private AdminSubscribeService adminMemberSubService; 
	@Autowired
	private AdminChartService adminchartService; 
	
	//관리자 페이지 메인 > 대시보드
	@RequestMapping(value ="/admin/")
	public String home(Model model){
		
		String[] planArr = {"올인원", "와이", "드라이", "물빨래", "물드"};
		String[] plan2Arr = {"올인원59", "올인원74", "올인원89", "올인원104", "올인원119", "올인원134", "와이29", "와이44", "와이55", "드라이44", "드라이59", "드라이74",
				"물빨래34", "물빨래49", "물빨래64", "물빨래79", "물빨래84", "물빨래99", "물드44", "물드59", "물드74", "물드89"}; 
			
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		
		String today = sdf.format(cal.getTime());
		String[] dateArr = new String[5];
		dateArr[0] = today; 
		for(int i = 1; i < 5; i++) {
			cal.add(Calendar.DATE, -1);
			dateArr[i] = sdf.format(cal.getTime());
		}
				
		int[] subArr = new int[5]; 
		int[] sub2Arr = new int[22];
	
		int[] allArr = new int[5];
		int[] shirtsArr = new int[5];
		int[] dryArr = new int[5];
		int[] washArr = new int[5];
		int[] washDryArr = new int[5];
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		for(int i = 0; i < planArr.length; i++) {
			int cnt = adminMemberSubService.getMemberSubCnt(planArr[i]);
			subArr[i] = cnt;
			
			map.put("subsname", planArr[i]); 
			for(int j = 0; j < dateArr.length; j++) {
				map.put("subs_start", dateArr[j]);
				
				int result = adminMemberSubService.getMemberDailySubCnt(map);

				switch(i) {
				case 0 :
					allArr[j] = result; 
					break;
				case 1 :
					shirtsArr[j] = result; 
					break;
				case 2 :
					dryArr[j] = result; 
					break;
				case 3 :
					washArr[j] = result; 
					break;
				case 4 :
					washDryArr[j] = result; 
					break;
				}
			}
		}
		
		for(int i = 0; i < plan2Arr.length; i++) {
			int cnt = adminMemberSubService.getMemberSubCnt2(plan2Arr[i]);
			sub2Arr[i] = cnt;
		}
		
		HashMap<String, Object> map2 = new HashMap<String, Object>();

		// 하루당 기간별 배열 : 세탁
		int[] wash2Arr = new int[5];
		int wash_dailyResult = 0; 
		
		// 하루당 기간별 배열 : 수선
		int[]repairArr = new int[5];
		int repair_dailyResult = 0;
		
		// 하루당 기간별 배열 : 보관
		int[] keepArr = new int[5];
		int keep_dailyResult = 0; 
		
		for(int j = 0;  j < dateArr.length; j++) {
			map2.put("order_date", dateArr[j]);
									
			// 하루당 주문량 계산 : 세탁
			wash_dailyResult = adminchartService.wash_count(map2);
			wash2Arr[j] += wash_dailyResult; 
			
			// 하루당 주문량 계산 : 수선
			repair_dailyResult = adminchartService.repair_count(map2);
			repairArr[j] += repair_dailyResult; 
			
			// 하루당 주문량 계산 : 보관
			keep_dailyResult = adminchartService.keep_count(map2);
			keepArr[j] += keep_dailyResult; 
				
		}
		
		// qna 미답변 게시판 부분
		ArrayList<QnaVO> qnaList = adminOrderService.getQnAList();
		
		// 정기구독 차트 부분
		model.addAttribute("subArr", subArr); 
		model.addAttribute("sub2Arr", sub2Arr); 
		
		// 주희언니 차트 부분
		model.addAttribute("washArr", wash2Arr);
		model.addAttribute("repairArr", repairArr);
		model.addAttribute("keepArr", keepArr);
		
		// qna 미답변 게시판 부분
		model.addAttribute("qnaList", qnaList);
		
		return "/admin/admin_main";
		
	}
	
	//전체 주문 관리자 페이지
	@RequestMapping(value = "/admin/order.do")
	public String adminOrder(Model model, HttpServletRequest request) {
		
		// 전체 주문 개수
		ArrayList<OrderVO> orderList = adminOrderService.getOrderList();
		int orderCount = adminOrderService.getOrderCount();
		
		model.addAttribute("orderCount", orderCount);
		model.addAttribute("orderList", orderList);
		
		return "/admin/order";
	}
	
	// 주문 검색 
	@RequestMapping(value = "/admin/orderSearch.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public Map<String, Object> orderSearch(@RequestParam(value="searchType") String searchType, @RequestParam(value="keyword") String keyword,
			String[] statusArr, @RequestParam(value="startDate") String startDate, @RequestParam(value="endDate") String endDate, 
			@RequestParam(value="orderBy") String orderBy) {
		
		String start = startDate.replace("-", "/").substring(2, startDate.length());
		String end = endDate.replace("-", "/").substring(2, endDate.length());

		// 검색어 설정 
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("startDate", start);
		map.put("endDate", end);
		map.put("statusArr", statusArr);
		map.put("orderBy", orderBy);
		
		int orderSearchCount = adminOrderService.orderSearchCount(map);
		ArrayList<OrderVO> orderSearchList = adminOrderService.orderSearch(map);
		
		Map<String, Object> retVal = new HashMap<String, Object>();

	    retVal.put("orderSearchCount", orderSearchCount);
		retVal.put("orderSearchList", orderSearchList);

		return retVal;
		
	}
	
	// 주문 상세보기
	@RequestMapping(value = "/admin/orderSelect.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public OrderVO orderSelect(OrderVO ovo) {
		
		OrderVO orderVO = adminOrderService.getOrderInfo(ovo);		
		return orderVO; 
	}
	
	// 주문 상세정보 수정
	@RequestMapping(value = "/admin/orderUpdate.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public OrderVO orderUpdate(OrderVO ovo) {
		
		adminOrderService.updateOrderInfo(ovo);
		OrderVO orderVO = adminOrderService.getOrderInfo(ovo);

		return orderVO; 
	}
	
	// 주문 상태 수정 
	@RequestMapping(value = "/admin/statusUpdate.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public OrderVO statusUpdate(String[] orderNumArr, OrderVO ovo) {
		
		String order_status = ovo.getOrder_status();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderNumArr", orderNumArr);
		map.put("order_status", order_status);
		
		int res = adminOrderService.statusUpdate(map);

		return ovo; 
	}
	
	// 기타 주문관리
	@RequestMapping(value = "/admin/orderChart.do")
	public String adminOrder(Model model) {
		
		String[] statusArr = {"결제완료", "수거중", "서비스중", "배송중", "배송완료", "주문취소"};
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		
		String today = sdf.format(cal.getTime());
		String[] dateArr = new String[5];
		dateArr[0] = today; 
		for(int i = 1; i < 5; i++) {
			cal.add(Calendar.DATE, -1);
			dateArr[i] = sdf.format(cal.getTime());
		}
				
		String[] weekArr = new String[10]; 
		weekArr[0] = today;
		cal = Calendar.getInstance();
		for(int i = 1; i < 10; i++) {
			if(i%2 == 0) {
				cal.add(Calendar.DATE, -1);
			}else {
				cal.add(Calendar.DATE, -6);
			}
			weekArr[i] = sdf.format(cal.getTime());
		}

		HashMap<String, Object> map = new HashMap<String, Object>();

		// 상태별 배열 
		int[] payArr = new int[5]; 
		int[] pickArr = new int[5]; 
		int[] serviceArr = new int[5]; 
		int[] deliveryArr = new int[5]; 
		int[] completeArr = new int[5]; 
		int[] cancleArr = new int[5]; 
		
		// 기간별 배열 : 일별, 주별 
		int[] dailyArr = new int[5];
		int[] weeklyArr = new int[5];
		
		int dailySum = 0; 
		int weeklySum = 0; 
		
		for(int i = 0; i < statusArr.length; i++) {
			String status = statusArr[i]; 
			map.put("order_status", status);
			int daily = 0; 
			
			for(int j = 0;  j < dateArr.length; j++) {
				map.put("order_date", dateArr[j]);
				int dailyResult = 0; 
				int result = adminOrderService.recentOrderStatusCnt(map);

				// 상태별 총 주문량 계산
				switch(i) {
				case 0 :
					payArr[j] = result; 
					break;
				case 1 :
					pickArr[j] = result; 
					break;
				case 2 :
					serviceArr[j] = result; 
					break;
				case 3 :
					deliveryArr[j] = result; 
					break;
				case 4 :
					completeArr[j] = result; 
					break;
				case 5 :
					cancleArr[j] = result; 
					break;
				}
				
				// 일별 총 주문량 계산
				if(i == statusArr.length - 1) {
					dailyResult = adminOrderService.recentOrderCnt(map);
					dailyArr[j] = dailyResult; 
					dailySum += dailyResult;
				}
			}
			
		}
				
		// 주별 총 주문량 계산 
		for(int i = 0; i < weekArr.length; i+=2) {
			String end = weekArr[i];
			String start = weekArr[i+1];

			map.put("startDate", start);
			map.put("endDate", end);
			
			int result = adminOrderService.recentOrderWeeklyCnt(map);
			weeklyArr[i/2] = result; 
			weeklySum += result;
		}

		model.addAttribute("payArr", payArr);
		model.addAttribute("pickArr", pickArr);
		model.addAttribute("serviceArr", serviceArr);
		model.addAttribute("deliveryArr", deliveryArr);
		model.addAttribute("completeArr", completeArr);
		model.addAttribute("cancleArr", cancleArr);
		
		model.addAttribute("dailyArr", dailyArr);
		model.addAttribute("weeklyArr", weeklyArr);
		model.addAttribute("dailySum", dailySum);
		model.addAttribute("weeklySum", weeklySum);
		
		return "/admin/order_chart";
	}
	
	// 정기구독 관리자 페이지
	@RequestMapping(value = "/admin/subscribe.do")
	public String subscribe() {
		
		return "/admin/subscribe";
		
	}
	
	// 정기구독 관리자 리스트 띄우기
	@RequestMapping(value = "/admin/getMemberSubList.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public List<Object> getMemberSubList() {
		
		List<Object> memberSubList = adminMemberSubService.getMemberSubList();
		return memberSubList;
		
	}
	
	// 정기구독 관리자 검색 
	@RequestMapping(value = "/admin/subMemberSearch.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public List<Object> subMemberSearch(@RequestParam(value="keyword") String keyword, String[] planArr, @RequestParam(value="orderBy") String orderBy) {
				
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderBy", orderBy);
		map.put("keyword", keyword);
		map.put("planArr", planArr);
		
		List<Object> memberSubList = adminMemberSubService.subMemberSearch(map);
		
		return memberSubList;
		
	}
	
	// 정기구독 관리자 수정 
	@RequestMapping(value = "/admin/updateMemberSubList.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public Map<String, String> updateMemberSubList(MemberSubVO msv) {
		
		int res = adminMemberSubService.updateMemberSubList(msv);
		Map<String, String> retVal = new HashMap<String, String>();
		if(res == 1) {
			retVal.put("res", "OK");
		}else {
			retVal.put("res", "fail");
		}
		
		return retVal;
	}
		
	// 정기구독 관리자 삭제
	@RequestMapping(value = "/admin/deleteMemberSubList.do", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	@ResponseBody 
	public Map<String, String> deleteMemberSubList(String member_id) {

		// member_subs table update 
		int res = adminMemberSubService.deleteMemberSubList(member_id);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		Integer subs_num = null; 
		map.put("subs_num", subs_num);
		map.put("member_id", member_id); 
		// member table update
		adminMemberSubService.updateSubNum(map); 
		
		Map<String, String> retVal = new HashMap<String, String>();
		if(res == 1) {
			retVal.put("res", "OK");
		}else {
			retVal.put("res", "fail");
		}
		
		return retVal;
	}
	
	// 기타 정기구독 관리 > 차트
	@RequestMapping(value = "/admin/subscribeChart.do")
	public String subscribeChart(Model model) {
		
		String[] planArr = {"올인원", "와이", "드라이", "물빨래", "물드"};
		String[] plan2Arr = {"올인원59", "올인원74", "올인원89", "올인원104", "올인원119", "올인원134", "와이29", "와이44", "와이55", "드라이44", "드라이59", "드라이74",
				"물빨래34", "물빨래49", "물빨래64", "물빨래79", "물빨래84", "물빨래99", "물드44", "물드59", "물드74", "물드89"}; 
			
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		
		String today = sdf.format(cal.getTime());
		String[] dateArr = new String[5];
		dateArr[0] = today; 
		for(int i = 1; i < 5; i++) {
			cal.add(Calendar.DATE, -1);
			dateArr[i] = sdf.format(cal.getTime());
		}
				
		int[] subArr = new int[5]; 
		int[] sub2Arr = new int[22];
	
		int[] allArr = new int[5];
		int[] shirtsArr = new int[5];
		int[] dryArr = new int[5];
		int[] washArr = new int[5];
		int[] washDryArr = new int[5];
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		for(int i = 0; i < planArr.length; i++) {
			int cnt = adminMemberSubService.getMemberSubCnt(planArr[i]);
			subArr[i] = cnt;
			
			map.put("subsname", planArr[i]); 
			for(int j = 0; j < dateArr.length; j++) {
				map.put("subs_start", dateArr[j]);
				
				int result = adminMemberSubService.getMemberDailySubCnt(map);

				switch(i) {
				case 0 :
					allArr[j] = result; 
					break;
				case 1 :
					shirtsArr[j] = result; 
					break;
				case 2 :
					dryArr[j] = result; 
					break;
				case 3 :
					washArr[j] = result; 
					break;
				case 4 :
					washDryArr[j] = result; 
					break;
				}
			}
		}
		
		for(int i = 0; i < plan2Arr.length; i++) {
			int cnt = adminMemberSubService.getMemberSubCnt2(plan2Arr[i]);
			sub2Arr[i] = cnt;
		}
		
		model.addAttribute("subArr", subArr); 
		model.addAttribute("sub2Arr", sub2Arr); 
		
		model.addAttribute("allArr", allArr); 
		model.addAttribute("shirtsArr", shirtsArr); 
		model.addAttribute("dryArr", dryArr); 
		model.addAttribute("washArr", washArr); 
		model.addAttribute("washDryArr", washDryArr); 
		
		return "/admin/subscribe_chart";
	}
		
}
