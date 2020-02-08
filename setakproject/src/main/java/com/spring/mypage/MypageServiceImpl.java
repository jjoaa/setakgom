package com.spring.mypage;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.MypageMapper;
import com.spring.mapper.OrderMapper;
import com.spring.member.MemberVO;
import com.spring.order.OrderListVO;
import com.spring.order.OrderVO;
import com.spring.setak.KeepVO;
import com.spring.setak.MendingVO;
import com.spring.setak.WashingVO;

@Service("mypageService")
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<OrderVO> getOrderlist(HashMap<String, Object> map){
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		ArrayList<OrderVO> orderlist = new ArrayList<OrderVO>();
		
		orderlist = mypageMapper.getOrderlist(map);

		return orderlist;
	}
	
	
	@Override
	public ArrayList<OrderListVO> getOrdernumlist(String member_id){
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		ArrayList<OrderListVO> ordernumlist = new ArrayList<OrderListVO>();
		
		ordernumlist = mypageMapper.getOrdernumlist(member_id);
		System.out.println("service" + ordernumlist);
		return ordernumlist;
	}
	
	@Override
	public ArrayList<KeepVO> selectMykeeplist(long order_num) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		ArrayList<KeepVO> keeplist = new ArrayList<KeepVO>();
		
		keeplist = mypageMapper.selectMykeeplist(order_num);
		System.out.println(keeplist + "킵");
		return keeplist;
	}
	
	@Override
	public int selectMykeep(long order_num) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int keepVO = 0;
		
		
		keepVO = mypageMapper.selectMykeep(order_num);
		
		return keepVO;
	}
	
	@Override
	public KeepVO getKeepSeq(int keep_seq) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		KeepVO keepVO = new KeepVO();
		keepVO = mypageMapper.getKeepSeq(keep_seq);
		
		return keepVO;
	}
	
	
	@Override
	public int getOrdercount() {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int orderVO = mypageMapper.getOrdercount();
		
		return orderVO;
	}
	
	@Override
	public int getKeepcount() {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int keepVO = mypageMapper.getKeepcount();
		
		return keepVO;
	}
	
	
	@Override
	public String selectOrderId(String member_id) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		String orderVO = mypageMapper.selectOrderId(member_id);
		
		return orderVO;
	}
	
	@Override
	public MendingVO selectMending(int repair_seq) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		MendingVO mendingVO = new MendingVO();
		
		mendingVO = mypageMapper.selectMending(repair_seq);
		
		return mendingVO;
	}
	
	@Override
	public OrderVO selectOrder(long order_num) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		OrderVO orderVO = new OrderVO();
		
		orderVO = mypageMapper.selectOrder(order_num);
		
		return orderVO;
	}
	
	@Override
	public KeepVO selectKeep(int keep_seq) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		KeepVO keepVO = new KeepVO();
			
		keepVO = mypageMapper.selectKeep(keep_seq);
		
		return keepVO;
	}
	
	@Override
	public WashingVO selectWashing(int wash_seq) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		WashingVO washVO = new WashingVO();
		
		washVO = mypageMapper.selectWashing(wash_seq);
		
		return washVO;
	}
	
	//보관연장
	public int updateKeepMonth(HashMap<String, Object> map) {
		int res = 0;
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		
		res = mypageMapper.updateKeepMonth(map);
	
		return res;
	}
	
	public int all_Return(HashMap<String, Object> map) {
		int res = 0;
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		
		res = mypageMapper.all_Return(map);
		
		return res;
	}
	
	

	//리턴
	public int part_Return(KeepReturnVO krvo) {
		int res = 0;
		try {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		res = mypageMapper.part_Return(krvo);
		
		}catch(Exception e) {
			System.out.println("반환입력 실패" + e.getMessage());
		}
		return res;
	}
	
	
	public MemberVO getMember(String member_id) {
		MemberVO mvo = null; 
		try {
			MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
			mvo = mypageMapper.getMember(member_id);
		} catch(Exception e) {
			System.out.println("멤버 정보 검색 실패 " + e.getMessage());
		}
		
		return mvo; 		
		
	}

}

