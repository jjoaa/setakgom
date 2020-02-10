package com.spring.setak;

import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.order.KeepCartVO;
import com.spring.order.MendingCartVO;
import com.spring.order.WashingCartVO;

@Controller
public class MendingKeepController {
	
	@Autowired()//required = false
	private MendingKeepService mendingKeepService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "main";
	}
	
	@RequestMapping("/history.do")
	public String history() {
		
		return "history";
	}

	@RequestMapping("/mendingform.do")
	public String mendingform() {

		return "mending";
	}
	
	@RequestMapping("/mending.do")
	public String insertMending(MultipartHttpServletRequest request, HttpSession session) throws Exception{
		String repair_cate[] = request.getParameterValues("repair_cate");
		String repair_kind[] = request.getParameterValues("repair_kind");
		String repair_var1[] = request.getParameterValues("repair_var1");
		String repair_var2[] = request.getParameterValues("repair_var2");
		String repair_var3[] = request.getParameterValues("repair_var3");
		String repair_content[] = request.getParameterValues("repair_content");
		String repair_code[] = request.getParameterValues("repair_code");
		String repair_count[] = request.getParameterValues("repair_count");
		String repair_price[] = request.getParameterValues("repair_price");
		
		MendingVO mending = new MendingVO();
		MendingCartVO mendingcart = new MendingCartVO();
		for(int i =0; i<repair_cate.length; i++) {
			String kind[] = repair_kind[i].split(",");
			for(String ki : kind) {
				mending.setRepair_kind(ki);
				mending.setRepair_cate(repair_cate[i]);
				mending.setRepair_var1(Integer.parseInt(repair_var1[i]));
				mending.setRepair_var2(Integer.parseInt(repair_var2[i]));
				mending.setRepair_var3(Integer.parseInt(repair_var3[i]));
				mending.setRepair_content(repair_content[i]);
				mending.setRepair_code(repair_code[i]);
				mending.setRepair_count(Integer.parseInt(repair_count[i]));
				mending.setRepair_price(Integer.parseInt(repair_price[i]));
				mending.setRepair_wash(0);
					
				mendingKeepService.insertMending(mending);

				mendingcart.setMember_id((String)session.getAttribute("member_id"));
				mendingcart.setRepair_seq(mending.getRepair_seq());
				
				mendingKeepService.insertMendingCart(mendingcart);
			}		
		}
		
		return "redirect:/order.do";
	}
	
	@RequestMapping("/keepform.do")
	public String keepform(HttpSession session) {
		
		session.setAttribute("member_id", "bit");//지워야함.
		return "keep";
	}
	
	@RequestMapping("/keep.do")
	public String insertkeep(HttpServletRequest request, HttpSession session) throws Exception{
		String keep_cate[] = request.getParameterValues("keep_cate");
		String keep_kind[] = request.getParameterValues("keep_kind");
		String keep_count[] = request.getParameterValues("keep_count");
		String keep_month = request.getParameter("keep_month");
		String keep_box = request.getParameter("keep_box");
		String keep_price = request.getParameter("keep_price");
		
		KeepVO keep = new KeepVO();
		KeepCartVO keepcart = new KeepCartVO();
		for(int i = 0; i<keep_cate.length; i++) {
			keep.setKeep_cate(keep_cate[i]);
			keep.setKeep_kind(keep_kind[i]);
			keep.setKeep_count(Integer.parseInt(keep_count[i]));
			keep.setKeep_month(Integer.parseInt(keep_month));
			keep.setKeep_box(Integer.parseInt(keep_box));
			keep.setKeep_price(Integer.parseInt(keep_price));
			keep.setKeep_wash(0);
			
			mendingKeepService.insertKeep(keep);
			
			keepcart.setMember_id((String)session.getAttribute("member_id"));
			keepcart.setKeep_seq(keep.getKeep_seq());
			
			mendingKeepService.insertKeepCart(keepcart);
		}
		return "redirect:/order.do";
	}
	
	@RequestMapping(value = "/washingKeepform.do")
	public String washingKeepform(MultipartHttpServletRequest request, Model model) throws Exception{
		ArrayList<WashingVO> wlist = new ArrayList<WashingVO>();
		ArrayList<MendingVO> mlist = new ArrayList<MendingVO>();
		
		String wash_tprice = request.getParameter("wash_tprice");
		String mending_tprice = request.getParameter("mending_tprice");
		
		String cate[] = request.getParameterValues("wash_cate");
		String kind[] = request.getParameterValues("wash_kind");
		String method[] = request.getParameterValues("wash_method");
		String count[] = request.getParameterValues("wash_count");
		String price[] = request.getParameterValues("wash_price");
		
		for(int i = 0; i<cate.length; i++) {
			WashingVO washing = new WashingVO();
			washing.setWash_cate(cate[i]);
			washing.setWash_kind(kind[i]);
			washing.setWash_method(method[i]);
			washing.setWash_count(Integer.parseInt(count[i]));
			washing.setWash_price(Integer.parseInt(price[i]));
			
			wlist.add(washing);
		}		

		String repair_cate[] = request.getParameterValues("repair_cate");
		String repair_kind[] = request.getParameterValues("repair_kind");
		String repair_var1[] = request.getParameterValues("repair_var1");
		String repair_var2[] = request.getParameterValues("repair_var2");
		String repair_var3[] = request.getParameterValues("repair_var3");
		String repair_content[] = request.getParameterValues("repair_content");
		String repair_code[] = request.getParameterValues("repair_code");
		String repair_count[] = request.getParameterValues("repair_count");
		String repair_price[] = request.getParameterValues("repair_price");

		if(request.getParameter("repair_cate")!=null) {
			for(int i =0; i<repair_cate.length; i++) {
				MendingVO mending = new MendingVO();
				String kind1[] = repair_kind[i].split(",");
				for(String ki : kind1) {
					mending.setRepair_kind(ki);
					mending.setRepair_cate(repair_cate[i]);
					mending.setRepair_var1(Integer.parseInt(repair_var1[i]));
					mending.setRepair_var2(Integer.parseInt(repair_var2[i]));
					mending.setRepair_var3(Integer.parseInt(repair_var3[i]));
					mending.setRepair_content(repair_content[i]);
					mending.setRepair_code(repair_code[i]);
					mending.setRepair_count(Integer.parseInt(repair_count[i]));
					mending.setRepair_price(Integer.parseInt(repair_price[i]));
					
					mlist.add(mending);
				}
			}
			model.addAttribute("mlist", mlist);
		} else {
			model.addAttribute("mlist",null);
		}
		model.addAttribute("wlist", wlist);
		model.addAttribute("wash_tprice", wash_tprice);
		model.addAttribute("mending_tprice", mending_tprice);

		return "washingKeep";
	}
	
	@RequestMapping("/washingKeep.do")
	public String washingKeep(MultipartHttpServletRequest request, HttpSession session)throws Exception{
		String cate[] = request.getParameterValues("wash_cate");
		String kind[] = request.getParameterValues("wash_kind");
		String method[] = request.getParameterValues("wash_method");
		String count[] = request.getParameterValues("wash_count");
		String price[] = request.getParameterValues("wash_price");
		
		for(int i = 0; i<cate.length; i++) {
			WashingVO washing = new WashingVO();
			WashingCartVO washingcart = new WashingCartVO();
			washing.setWash_cate(cate[i]);
			washing.setWash_kind(kind[i]);
			washing.setWash_method(method[i]);
			washing.setWash_count(Integer.parseInt(count[i]));
			washing.setWash_price(Integer.parseInt(price[i]));
			
			mendingKeepService.insertWash(washing);
			
			washingcart.setMember_id((String)session.getAttribute("member_id"));
			washingcart.setWash_seq(washing.getWash_seq());
			
			mendingKeepService.insertWashingCart(washingcart);
		}		
		if(request.getParameter("repair_cate")!=null) {
			String repair_cate[] = request.getParameterValues("repair_cate");
			String repair_kind[] = request.getParameterValues("repair_kind");
			String repair_var1[] = request.getParameterValues("repair_var1");
			String repair_var2[] = request.getParameterValues("repair_var2");
			String repair_var3[] = request.getParameterValues("repair_var3");
			String repair_content[] = request.getParameterValues("repair_content");
			String repair_code[] = request.getParameterValues("repair_code");
			String repair_count[] = request.getParameterValues("repair_count");
			String repair_price[] = request.getParameterValues("repair_price");
			
			for(int i =0; i<repair_cate.length; i++) {
				MendingVO mending = new MendingVO();
				MendingCartVO mendingcart = new MendingCartVO();
		
				mending.setRepair_kind(repair_kind[i]);
				mending.setRepair_cate(repair_cate[i]);
				mending.setRepair_var1(Integer.parseInt(repair_var1[i]));
				mending.setRepair_var2(Integer.parseInt(repair_var2[i]));
				mending.setRepair_var3(Integer.parseInt(repair_var3[i]));
				mending.setRepair_content(repair_content[i]);
				mending.setRepair_code(repair_code[i]);
				mending.setRepair_count(Integer.parseInt(repair_count[i]));
				mending.setRepair_price(Integer.parseInt(repair_price[i]));
				mending.setRepair_wash(1);
				
				mendingKeepService.insertMending(mending);
	
				mendingcart.setMember_id((String)session.getAttribute("member_id"));
				mendingcart.setRepair_seq(mending.getRepair_seq());
				
				mendingKeepService.insertMendingCart(mendingcart);
			}
		}
		
		if(!(request.getParameter("keep_month").equals("0"))) {
			String keep_cate[] = request.getParameterValues("keep_cate");
			String keep_kind[] = request.getParameterValues("keep_kind");
			String keep_count[] = request.getParameterValues("keep_count");
			String keep_month = request.getParameter("keep_month");
			String keep_box = request.getParameter("keep_box");
			String keep_price = request.getParameter("keep_price");
			
			KeepVO keep = new KeepVO();
			KeepCartVO keepcart = new KeepCartVO();
			for(int i = 0; i<keep_cate.length; i++) {
				keep.setKeep_cate(keep_cate[i]);
				keep.setKeep_kind(keep_kind[i]);
				keep.setKeep_count(Integer.parseInt(keep_count[i]));
				keep.setKeep_month(Integer.parseInt(keep_month));
				keep.setKeep_box(Integer.parseInt(keep_box));
				keep.setKeep_price(Integer.parseInt(keep_price));
				keep.setKeep_wash(1);
				
				mendingKeepService.insertKeep(keep);
				
				keepcart.setMember_id((String)session.getAttribute("member_id"));
				keepcart.setKeep_seq(keep.getKeep_seq());
				
				mendingKeepService.insertKeepCart(keepcart);
			}
		}
		
		return "redirect:/order.do";
	}
}