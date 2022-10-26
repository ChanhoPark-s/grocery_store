package my.shop.mall;
import java.util.ArrayList;
import java.util.Vector;

import my.shop.ProductBean;
import my.shop.ProductDao;

public class CartBean { // ��ǰ�� ���� ��ٱ���
	// List �������̽� : �ߺ�O , ����O

	Vector<ProductBean> lists; // ��ٱ���!

	public CartBean() { // public ���� ���� : �ٸ� ��Ű������ �ٸ���ġ������ ����ϱ�����
		lists = new Vector<ProductBean>();
	}

	
	
//=========================================================================================
	
	public Vector<ProductBean> getAllProducts() {
			return lists; // lists �� ���°��� �� ��������.
	}//getAllProducts
	
	
//=========================================================================================
	
	public void setEdit(String pnum,String oqty) {
	
		for(ProductBean pb : lists) {
			
			if(pb.getPnum()==Integer.parseInt(pnum)) {
				pb.setPqty(Integer.parseInt(oqty));
				pb.setTotalPrice( Integer.parseInt(oqty) * pb.getPrice());
				pb.setTotalPoint( Integer.parseInt(oqty) * pb.getPoint());
				break; // ���� pnum�� ���� ����. �ߺ��Ǵ°Ű� ���.
			}
		}//for
		
	}//setEdit
	
	public void removeProduct(String pnum) {
		
		for(ProductBean pb : lists ) {
			if(pb.getPnum() == Integer.parseInt(pnum)) {
				lists.removeElement(pb); // ���ݺ����ִ� pb��ü�� �����ض�.
			break;
			}//if
		}
	}//removeProduct
	public void removeAllProduct(){
		lists.removeAllElements();
	}//removeAllProduct
}
