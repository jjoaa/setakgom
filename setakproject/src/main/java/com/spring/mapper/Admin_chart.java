package com.spring.mapper;

import java.util.HashMap;

public interface Admin_chart {
	/*세탁, 수선, 보관 그래프*/	
	// 세탁건수-하루단위 
	int wash_count(HashMap<String, Object> map);
	
	// 수선건수-하루단위 
	int repair_count(HashMap<String, Object> map);
	
	// 보관건수-하루단위 
	int keep_count(HashMap<String, Object> map);
	
	// 세탁건수-한달단위
	int wash_count_month(HashMap<String, Object> map);

	// 수선건수-한달단위
	int repair_count_month(HashMap<String, Object> map);
	
	// 보관건수-한달단위
	int keep_count_month(HashMap<String, Object> map);	

	/*수익 그래프*/
	//세탁, 수선, 보관 수익금액 
	Integer profit_ssb(HashMap<String, Object> map);	
	
	//정기결제 수익금액 
	Integer profit_sub(HashMap<String, Object> map);	
	
}
