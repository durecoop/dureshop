<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 하단 서브 메뉴 (요리조리, 두레이야기) -->
<style>
.footer-sub-menu {
	background: #F8F9FA;
	border-top: 1px solid #E5E5E5;
	padding: 20px 0;
	margin-top: 40px;
}
.footer-sub-menu .inner {
	max-width: 1200px;
	margin: 0 auto;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 40px;
}
.footer-sub-menu .menu-item {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 12px 24px;
	background: #fff;
	border: 1px solid #E0E0E0;
	border-radius: 8px;
	text-decoration: none;
	transition: all 0.2s ease;
}
.footer-sub-menu .menu-item:hover {
	border-color: #3D6041;
	background: #F3F6F4;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(61, 96, 65, 0.15);
}
.footer-sub-menu .menu-item .icon {
	width: 32px;
	height: 32px;
	background: #3D6041;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 16px;
	color: #fff;
}
.footer-sub-menu .menu-item .text {
	display: flex;
	flex-direction: column;
}
.footer-sub-menu .menu-item .title {
	font-size: 15px;
	font-weight: 600;
	color: #1D271E;
}
.footer-sub-menu .menu-item .desc {
	font-size: 12px;
	color: #828284;
	margin-top: 2px;
}
</style>
<div class="footer-sub-menu">
	<div class="inner">
		<a href="<c:url value='/recipe.do' />" class="menu-item">
			<span class="icon">🍳</span>
			<span class="text">
				<span class="title">요리조리</span>
				<span class="desc">두레생협 레시피</span>
			</span>
		</a>
		<a href="<c:url value='/story.do' />" class="menu-item">
			<span class="icon">📖</span>
			<span class="text">
				<span class="title">두레이야기</span>
				<span class="desc">생협 소식과 이야기</span>
			</span>
		</a>
	</div>
</div>

<!-- 기존 팝업 (하위 호환용) -->
<div class="layer_pop_wrap">
	<div class="in" id="lyMessage1"></div>
</div>

<!-- 토스트 알림 -->
<div class="toast_wrap" id="toastWrap">
	<div class="toast_content">
		<div class="toast_icon">
			<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
				<polyline points="20 6 9 17 4 12"></polyline>
			</svg>
		</div>
		<div class="toast_text">
			<p class="toast_msg" id="toastMsg">장바구니에 담았습니다</p>
		</div>
		<button type="button" class="toast_close" onclick="closeToast();">
			<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
				<line x1="18" y1="6" x2="6" y2="18"></line>
				<line x1="6" y1="6" x2="18" y2="18"></line>
			</svg>
		</button>
	</div>
	<div class="toast_btns">
		<a href="javascript:closeToast();" class="btn_continue">계속 쇼핑</a>
		<a href="javascript:goPageSubmit('Y', 'cart/cart.do');" class="btn_cart">장바구니 가기</a>
	</div>
</div>

<div class="layer_popmsg_wrap">
	<div class="inner">
		<div class="layer_pop">
			<div class="txt_box" id="lyMessage"></div>
			<ul class="btn_list">
				<li><a href="javascript:layer_popmsg_close();goLayerOkSubmit();" class="btn_b" id="id_lyBtnOk">확인</a></li>
			</ul>
		</div>
	</div>
</div>
<div class="layer_popmsg_wrap2">
	<div class="inner">
		<div class="layer_pop">
			<div class="txt_box" id="lyMessage2"></div>
			<ul class="btn_list">
				<li><a href="javascript:layer_popmsg_close2();" class="btn_g" id="id_lyBtnCancel2">취소</a></li>
				<li><a href="javascript:layer_popmsg_close2();goLayerOkSubmit2();" class="btn_b" id="id_lyBtnOk2">확인</a></li>
			</ul>
		</div>
	</div>
</div>
<!-- 생활재후기 등록 레이어 -->
<div class="layer_pop_write_review">
	<div class="inner">
		<div class="layer_pop">
			<!-- <div class="txt_box" style="overflow:auto;height:450px;"> -->
			<div class="txt_box" style="height:200px;">
				<div class="my_review_write_wrap inline-block">
					<div class="chk_wrap">
						<p class="txt">이 물품을 추천하나요?</p>
						<ul class="list2">
							<li class="radio_wrap good">
								<input type="radio" name="ly_eval_chk" id="ly_eval_chk1" value="1" checked="">
								<label for="ly_eval_chk1"><span class="icon"></span>추천해요</label>
							</li>
							<li class="radio_wrap bad">
								<input type="radio" name="ly_eval_chk" id="ly_eval_chk2" value="0">
								<label for="ly_eval_chk2"><span class="icon"></span>아쉬워요</label>
							</li>
						</ul>
					</div>
					<div class="txt_wrap">
						<p class="txt">의견을 적어주세요</p>
						<textarea id="ly_content_review" style="height:210px;" placeholder="내용을 입력해주세요. (10자 이상 500자 이내로 입력해주세요)"></textarea>
					</div>
				</div>
			</div>
			<ul class="btn_list padded">
				<li style="width:47%;"><a href="javascript:layer_popboard_write_close('.layer_pop_write_review');" class="btn_white">취소</a></li>
				<li style="width:47%;"><a href="javascript:FnGoodsBoardSave('review');" class="btn_green" id="id_btn_write_qna">저장</a></li>
			</ul>
		</div>
	</div>
</div>
<!-- 문의 등록 레이어 -->
<div class="layer_pop_write_qna">
	<div class="inner">
		<div class="layer_pop">
			<div class="txt_box" style="height:400px;">
				<div class="cscenter_wrap ask_write_wrap" style="padding-left:30px;">
					<div class="cs_content_wrap" style="width:504px;">
						<h3 class="cs_title">1:1 문의하기</h3>
						<div class="form_wrap">
							<div class="input_wrap">
								<input type="text" class="def_input" id="ly_title_qna" placeholder="제목을 입력해주세요.">
							</div>
							<div class="input_wrap">
								<textarea id="ly_content_qna" style="height:200px;" placeholder="문의내용을 입력해주세요."></textarea>
							</div>
							<div class="check_wrap" style="float:left;margin-top:10px;">
								<input type="checkbox" name="ly_secret_chk" id="ly_secret_chk" value="Y"><label for="ly_secret_chk">비밀글</label>
							</div>
						</div>
					</div>
				</div>
			</div>
			<ul class="btn_list padded-sm">
				<li style="width:47%;"><a href="javascript:layer_popboard_write_close('.layer_pop_write_qna');" class="btn_white">취소</a></li>
				<li style="width:47%;"><a href="javascript:FnGoodsBoardSave('qna');" class="btn_green" id="id_btn_write_qna">저장</a></li>
			</ul>
		</div>
	</div>
</div>

<script>
	function layer_popmsg_close(){
		$('.layer_popmsg_wrap').hide();
	}

	function layer_popmsg_close2(){
		$('.layer_popmsg_wrap2').hide();
	}

	function layer_popboard_write_close(pClass){
		$(pClass).hide();
	}

</script>

