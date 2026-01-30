<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
/* 하단 서브 메뉴 스타일 */
.footer-sub-menu {
	background: #F8F9FA;
	border-top: 1px solid #E5E5E5;
	padding: 20px 0;
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

<!-- 하단 서브 메뉴 (요리조리, 두레이야기) -->
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
