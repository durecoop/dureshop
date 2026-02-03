<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
/* go_shop_wrap 버튼 영역 스타일 */
.go_shop_wrap .btn_area {
	display: flex !important;
	align-items: center !important;
	gap: 12px !important;
}

/* 서비스 버튼 - 매장찾기와 동일 스타일 */
.go_shop_wrap .btn_service {
	display: inline-flex !important;
	align-items: center !important;
	gap: 6px !important;
	padding: 12px 20px !important;
	background: #fff !important;
	border: 1px solid #ddd !important;
	border-radius: 25px !important;
	text-decoration: none !important;
	transition: all 0.2s ease !important;
}

.go_shop_wrap .btn_service:hover {
	border-color: #5a8648 !important;
	box-shadow: 0 2px 8px rgba(0,0,0,0.1) !important;
}

.go_shop_wrap .btn_service .ico {
	width: 20px !important;
	height: 20px !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	font-size: 16px !important;
}

.go_shop_wrap .btn_service .txt {
	font-size: 15px !important;
	font-weight: 500 !important;
	color: #333 !important;
}

.go_shop_wrap .btn_service:hover .txt {
	color: #5a8648 !important;
}
</style>

<script>
$(document).ready(function() {
	var serviceButtons = '<a href="<c:url value="/recipe.do" />" class="btn_service"><span class="ico">🍳</span><span class="txt">요리조리</span></a>' +
		'<a href="<c:url value="/story.do" />" class="btn_service"><span class="ico">📖</span><span class="txt">두레이야기</span></a>';

	var $btnArea = $('.go_shop_wrap .inner');
	if ($btnArea.length > 0) {
		// 매장찾기 버튼 앞에 삽입
		$btnArea.find('a').first().before(serviceButtons);
	}
});
</script>
