<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

추가할 내용 - 제품 수정시 카테고리 변경도 가능하게.. select로 @@@@@@@@@@@@@@@@@

시간있으면 할 내용 - 좋아요, 댓글


공통   - 메인화면 O
		 로그인, 회원가입 폼 O
		 회원가입시 아이디 중복확인 추가하기 @@@@@@@@@@@@@@@@@
		 비밀번호 재입력도 추가하기			 @@@@@@@@@@@@@@@@@
		 샵, 상품 상세보기 폼 O
		 
		 페이징 O
		 검색	O


사용자 - 장바구니 폼 O
		 장바구니 구매 처리 O
		 	재고 차감 O
		 구매하기 폼(구매시 배송지 정보 기입) O
		 	장바구니 전체, O
		 	단품 바로 구매 O
		 개인정보 수정 폼 O 
		 구매내역 폼 O


관리자 - 카테고리 전체보기 O
		 카테고리별 제품보기 O
		 
		 카테고리 등록 폼 O
		 제품 등록 폼 O
		 
		 카테고리 수정 O
		 제품 수정 폼 O
		 
		 제품 카테고리 삭제 O
		 제품 삭제 O
		 
		 회원 주문내역 전체보기 폼 O
		
==================================================================		
https://wisefour.github.io/gabe-manual/ko/manual/admin/order
==================================================================
insert all

into tbl_buy(buy_num, user_id, product_num, product_count, 
             buy_date, user_address, user_tel, buy_receiver) 
values(seq_buy_num.nextval, 'hong', 1, 2, sysdate, '울산 남구', '0102222222', '뭉치')

into tbl_buy(buy_num, user_id, product_num, product_count, 
             buy_date, user_address, user_tel, buy_receiver) 
values(seq_buy_num.nextval, 'hong', 2, 5, sysdate, '울산 남구', '0102222222', '뭉치')

select * from dual;

==================================================================
select B.* from 
(select rownum rnum, A.* from
(select  
p.product_num, p.product_name, c.category_code, c.category_name, 
p.product_content, p.product_price, p.product_img, p.product_stock, 
p.product_reg_date
from tbl_product p inner join tbl_category c on(p.category_code = c.category_code)
order by p.product_num desc, p.product_reg_date desc) A)B
where rnum between 1 and 10;	
==================================================================
검색
select B.* from 
(select rownum rnum, A.* from
(select  
p.product_num, p.product_name, c.category_code, c.category_name, 
p.product_content, p.product_price, p.product_img, p.product_stock, 
p.product_reg_date
from tbl_product p inner join tbl_category c on(p.category_code = c.category_code)
where UPPER(p.product_name) like UPPER('%card%')
order by p.product_num desc, p.product_reg_date desc) A)B
where rnum between 1 and 10;	 
