package com.hmall.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hmall.domain.CartVO;
import com.hmall.domain.CartVOList;
import com.hmall.dto.TotalProductDTO;
import com.hmall.mapper.CartMapper;

import lombok.Setter;

@Service
public class CartServiceImpl implements CartService {

	@Setter(onMethod_ = @Autowired)
	private CartMapper cartMapper;

	
	// 장바구니
	@Override
	public void add_cart(CartVO vo) throws Exception {
		
		cartMapper.add_cart(vo);
		
	}

	// 장바구니 리스트
	@Override
	public List<CartVOList> list_cart(String mb_id) throws Exception {
		
		return cartMapper.list_cart(mb_id);
	}

	@Override
	public void cart_delete(long cart_code) throws Exception {
		
		cartMapper.cart_delete(cart_code);
	}

	// 수량변경
	@Override
	public void cart_count_update(long cart_code, int cart_count_buy) throws Exception {
		
		cartMapper.cart_count_update(cart_code, cart_count_buy);
	}

	// 장바구니 비우기
	@Override
	public void cart_Alldelete(String mb_id) throws Exception {
		
		cartMapper.cart_Alldelete(mb_id);		
	}

	@Override
	public void cart_check_delete(List<Integer> checkArr) throws Exception {
		
		cartMapper.cart_check_delete(checkArr);
	}

	
	@Override
	public JSONObject total_product() throws Exception {
		
		List<TotalProductDTO> items = cartMapper.total_product();
		
		JSONObject data = new JSONObject(); //{}
	        
        //json의 칼럼 객체
        JSONObject col1 = new JSONObject();
        JSONObject col2 = new JSONObject();
        
        //json 배열 객체, 배열에 저장할때는 JSONArray()를 사용.ArrayList 클래스 상속
        JSONArray title = new JSONArray();
        col1.put("label","상품명"); //col1에 자료를 저장 ("필드이름","자료형")
        col1.put("type", "string");
        col2.put("label", "금액");
        col2.put("type", "number");
        
        //테이블행에 컬럼 추가
        title.add(col1);
        title.add(col2);
        
        //json 객체에 타이틀행 추가
        data.put("cols", title);//제이슨을 넘김
        //이런형식으로 추가가된다. {"cols" : [{"label" : "상품명","type":"string"}
        //,{"label" : "금액", "type" : "number"}]}
        
        JSONArray body = new JSONArray(); //json 배열을 사용하기 위해 객체를 생성
        for (TotalProductDTO dto : items) { //items에 저장된 값을 dto로 반복문을 돌려서 하나씩 저장한다.
            
            JSONObject name = new JSONObject(); //json오브젝트 객체를 생성
            name.put("v", dto.getPdt_num()); //name변수에 dto에 저장된 상품의 이름을 v라고 저장한다.
            
            JSONObject money = new JSONObject(); //json오브젝트 객체를 생성
            money.put("v", dto.getTotal()); //name변수에 dto에 저장된 금액을 v라고 저장한다.          
            
            JSONArray row = new JSONArray(); //json 배열 객체 생성 (위에서 저장한 변수를 칼럼에 저장하기위해)
            row.add(name); //name을 row에 저장 (테이블의 행)
            row.add(money); //name을 row에 저장 (테이블의 행)          
            
            JSONObject cell = new JSONObject(); 
            cell.put("c", row); //cell 2개를 합쳐서 "c"라는 이름으로 추가
            body.add(cell); //레코드 1개 추가
                
        }
        data.put("rows", body); //data에 body를 저장하고 이름을 rows라고 한다.
        
        return data; //이 데이터가 넘어가면 json형식으로 넘어가게되서 json이 만들어지게 된다.
	}

	
	
	
	
		
}
