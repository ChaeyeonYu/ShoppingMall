<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header2.jsp"%>

<script>
$(function(){
	//카테고리를 비동기로 조회하기
// 	function getCategoryList(){
// 		$.getJSON("category.ajax-cy", {}, function(rData){
// 			$("#tbl_category > tbody").empty();
			
// 			var index = 0;
// 			$.each(rData, function(){
// 				var tr = "<tr>";
// 				tr += "<td>" + ++index + "</td>";
// 				tr += "<td><a code='"+this.category_code+"' href='#' class='product_a'>" + this.category_code + "</a></td>";
// 				tr += "<td><a code='"+this.category_code+"' href='#' class='product_a'>" + this.category_name + "</a></td>";
// 				tr += "<td><button class='btn_update btn btn-lg btn-outline-secondary'>UPDATE</button></td>";
// 				tr += "<td><button class='btn_delete btn btn-lg btn-outline-secondary'>DELETE</button></td>";
// 				tr += "</tr>";
				
// 				$("#tbl_category > tbody").append(tr);
// 			});
// 		});
// 	}
	
	//getCategoryList()로 생성된 (X) 
	//a링크를 눌렀을 경우
	$("#tbl_category").on("click", ".product_a", function(e){
		e.preventDefault();
		var category_code = $(this).attr("data-category-code");
		location.href = "product.admin-cy?category_code=" + category_code;
	});
	
	//카테고리 추가
	$("#btn_add_category").click(function(){
		location.href = "category-insert.admin-cy";
	});
	
	//카테고리 수정
	$("#tbl_category").on("click", ".btn_update", function(){
		var category_code = $(this).attr("data-category-code");
		var category_name = $(this).attr("data-category-name");
		location.href = "category-update.admin-cy?category_code=" + category_code + "&category_name=" + category_name;
	});
	
	//카테고리 삭제
	$("#tbl_category").on("click", ".btn_delete", function(){
		var that = $(this);
		var category_name = $(this).attr("data-category-name");
		var deleteConfirm = confirm(category_name + ' 카테고리를 삭제하시겠습니까?');
		if(deleteConfirm){
			var category_code = $(this).attr("data-category-code");
			
			var url = "category-delete-pro.ajax-cy";
			var sData = { "category_code" : category_code };
			$.post(url, sData, function(rData){
				if(rData.trim() == 'success'){ 
					that.parent().parent().remove();
					
					var numbering = $(".numbering");
					$.each(numbering, function(index){
						numbering.eq(index).text(index+1);
					});
				}
			});
		}else{
			return;
		}
	});
// 	getCategoryList();
});
</script>

<br><br>

<div class="container-fluid" align="right">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
		<button class="btn btn-lg btn-outline-secondary" id="btn_add_category">ADD CATEGORY</button>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>

<br><br>

<!-- 카테고리 목록 전체 조회 -->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<table class="table" id="tbl_category">
					<thead align="center">
						<tr align="center">
							<th></th>
							<th>코드</th>
							<th>이름</th>
							<th>수량</th>
							<th>수정</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
							<c:forEach items="${list}" var="vo" varStatus="status">
							<tr>
								<td align="center" class="numbering">${status.count}</td>
								<td><a data-category-code="${vo.category_code}" href="#" class="product_a">${vo.category_code}</a></td>
								<td><a data-category-code="${vo.category_code}" href="#" class="product_a">${vo.category_name}</a></td>
								<td>${vo.cnt}</td>
								<td><button class="btn_update btn btn-lg btn-outline-secondary" 
									data-category-code="${vo.category_code}" data-category-name="${vo.category_name}">UPDATE</button></td>
								<td><button class="btn_delete btn btn-lg btn-outline-secondary"
									data-category-code="${vo.category_code}" data-category-name="${vo.category_name}">DELETE</button></td>
							</tr>
							</c:forEach>
					</tbody>						
				</table>
		</div>
		<div class="col-md-1"></div>
	</div>
</div>



<br><br>

<%@ include file="../include/footer.jsp" %>