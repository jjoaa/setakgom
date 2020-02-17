package com.spring.mypage;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.Admin_C_M_Mapper;
import com.spring.member.CouponVO;

@Service("admin_C_M_Service")
public class Admin_C_M_ServiceImpl implements Admin_C_M_Service {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<Object> Admin_CouponList(){
		ArrayList<Object> list = null;
		Admin_C_M_Mapper mapper = sqlSession.getMapper(Admin_C_M_Mapper.class);
		
		list = mapper.Admin_CouponList();
		
		return list;
	}
	
	@Override
	public ArrayList<Object> couponSerach (HashMap<String, Object> map){
	
		ArrayList<Object> couponlist = null;
		Admin_C_M_Mapper mapper = sqlSession.getMapper(Admin_C_M_Mapper.class);
		
		couponlist = mapper.couponSerach(map);
		System.out.println("couponlist.size() = "+couponlist.size());
		return couponlist;
	}
	
	@Override
	public int getCouponCount() {
		int count = 0;
		Admin_C_M_Mapper mapper = sqlSession.getMapper(Admin_C_M_Mapper.class);
		count = mapper.getCouponCount();
		
		return count;
	}
	
	@Override
	public int updateCoupon(CouponVO params) {
		int res = 0;
		Admin_C_M_Mapper mapper = sqlSession.getMapper(Admin_C_M_Mapper.class);
		System.out.println("왜 값이 안넘어가냐" + params.getCoupon_seq());
		System.out.println("왜 값이 안넘어가냐" + params.getCoupon_name());
		System.out.println("왜 값이 안넘어가냐" + params.getCoupon_end());
		
		res = mapper.updateCoupon(params);
		
		return res;
	}
	
	@Override
	public int insertCoupon(CouponVO cvo) {
		int res = 0;
		
		Admin_C_M_Mapper mapper = sqlSession.getMapper(Admin_C_M_Mapper.class);
		
		res = mapper.insertCoupon(cvo);
		
		return res;
	}
	
	@Override
	public int deleteCoupon(int coupon) {
		int res = 0;
		Admin_C_M_Mapper mapper = sqlSession.getMapper(Admin_C_M_Mapper.class);
		
		res = mapper.deleteCoupon(coupon);
		
		return res;
		
		
	}
	
}
