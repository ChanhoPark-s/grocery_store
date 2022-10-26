package my.shop.mall;
import java.util.ArrayList;
import java.util.Vector;

import my.shop.ProductBean;
import my.shop.ProductDao;

public class CartBean { // 상품이 담기는 장바구니
	// List 인터페이스 : 중복O , 순서O

	Vector<ProductBean> lists; // 장바구니!

	public CartBean() { // public 쓰는 이유 : 다른 패키지에서 다른위치에서도 사용하기위해
		lists = new Vector<ProductBean>();
	}

	
	
//=========================================================================================
	
	public Vector<ProductBean> getAllProducts() {
			return lists; // lists 에 들어온것을 다 리턴해줌.
	}//getAllProducts
	
	
//=========================================================================================
	
	public void setEdit(String pnum,String oqty) {
	
		for(ProductBean pb : lists) {
			
			if(pb.getPnum()==Integer.parseInt(pnum)) {
				pb.setPqty(Integer.parseInt(oqty));
				pb.setTotalPrice( Integer.parseInt(oqty) * pb.getPrice());
				pb.setTotalPoint( Integer.parseInt(oqty) * pb.getPoint());
				break; // 같은 pnum은 이제 없음. 중복되는거가 없어서.
			}
		}//for
		
	}//setEdit
	
	public void removeProduct(String pnum) {
		
		for(ProductBean pb : lists ) {
			if(pb.getPnum() == Integer.parseInt(pnum)) {
				lists.removeElement(pb); // 지금보고있는 pb객체를 삭제해라.
			break;
			}//if
		}
	}//removeProduct
	public void removeAllProduct(){
		lists.removeAllElements();
	}//removeAllProduct
}
