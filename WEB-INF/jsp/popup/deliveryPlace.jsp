<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>배송지 선택</title>
	<link rel="shortcut icon" href="<c:url value='/images/comm/icon/favicon.ico' />">

	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/jquery-ui.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/default.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/style_v2.css?v=1.1">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/${mobile}/jquery-2.2.4.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/${mobile}/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/${mobile}/jquery.mousewheel.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/comm/pineComm.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/${mobile}/fineStyle.css?v=1.1">

	<style type="text/css">
		input:focus::-webkit-input-placeholder{color:transparent;}

		/* 배송지 팝업 리디자인 */
		body {
			background: #f5f5f5;
			font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
		}

		.delivery-popup {
			max-width: 480px;
			margin: 0 auto;
			padding: 20px;
			background: #fff;
			min-height: 100vh;
		}

		.delivery-popup .popup-header {
			text-align: center;
			padding-bottom: 20px;
			border-bottom: 1px solid #eee;
			margin-bottom: 20px;
		}

		.delivery-popup .popup-header h2 {
			font-size: 18px;
			font-weight: 600;
			color: #1a1a1a;
			margin: 0;
		}

		/* 기본 배송지 카드 */
		.delivery-popup .default-addr {
			background: linear-gradient(135deg, #f8faf7 0%, #e8f5e9 100%);
			border: 1px solid #5a8648;
			border-radius: 12px;
			padding: 18px;
			margin-bottom: 24px;
		}

		.delivery-popup .default-addr .badge {
			display: inline-block;
			padding: 4px 10px;
			background: #5a8648;
			color: #fff;
			font-size: 11px;
			font-weight: 600;
			border-radius: 12px;
			margin-bottom: 10px;
		}

		.delivery-popup .default-addr .name {
			font-size: 16px;
			font-weight: 600;
			color: #1a1a1a;
			margin-bottom: 8px;
		}

		.delivery-popup .default-addr .address {
			font-size: 14px;
			color: #555;
			line-height: 1.5;
			margin-bottom: 6px;
		}

		.delivery-popup .default-addr .tel {
			font-size: 14px;
			color: #777;
		}

		.delivery-popup .default-addr .notice {
			margin-top: 12px;
			padding-top: 12px;
			border-top: 1px dashed #c8e6c9;
			font-size: 12px;
			color: #666;
		}

		.delivery-popup .default-addr .notice span {
			color: #5a8648;
			font-weight: 600;
		}

		/* 등록된 배송지 섹션 */
		.delivery-popup .addr-section {
			margin-bottom: 20px;
		}

		.delivery-popup .section-header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 16px;
		}

		.delivery-popup .section-header h3 {
			font-size: 15px;
			font-weight: 600;
			color: #1a1a1a;
			margin: 0;
		}

		.delivery-popup .btn-add {
			display: inline-flex;
			align-items: center;
			gap: 4px;
			padding: 8px 14px;
			background: #fff;
			border: 1px solid #5a8648;
			border-radius: 20px;
			font-size: 13px;
			font-weight: 500;
			color: #5a8648;
			text-decoration: none;
			transition: all 0.2s;
		}

		.delivery-popup .btn-add:hover {
			background: #5a8648;
			color: #fff;
		}

		/* 배송지 리스트 */
		.delivery-popup .addr-list {
			max-height: 320px;
			overflow-y: auto;
		}

		.delivery-popup .addr-item {
			background: #fff;
			border: 1px solid #e8e8e8;
			border-radius: 10px;
			padding: 16px;
			margin-bottom: 12px;
			transition: all 0.2s;
		}

		.delivery-popup .addr-item:hover {
			border-color: #5a8648;
			box-shadow: 0 2px 8px rgba(90, 134, 72, 0.1);
		}

		.delivery-popup .addr-item .item-header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 10px;
		}

		.delivery-popup .addr-item .name {
			font-size: 15px;
			font-weight: 600;
			color: #1a1a1a;
		}

		.delivery-popup .addr-item .btn-group {
			display: flex;
			gap: 8px;
		}

		.delivery-popup .addr-item .btn-group a {
			padding: 6px 12px;
			font-size: 12px;
			border-radius: 4px;
			text-decoration: none;
			transition: all 0.2s;
		}

		.delivery-popup .addr-item .btn-select {
			background: #5a8648;
			color: #fff;
		}

		.delivery-popup .addr-item .btn-select:hover {
			background: #4a7639;
		}

		.delivery-popup .addr-item .btn-edit {
			background: #f5f5f5;
			color: #555;
		}

		.delivery-popup .addr-item .btn-edit:hover {
			background: #e8e8e8;
		}

		.delivery-popup .addr-item .btn-delete {
			background: #fff;
			color: #e74c3c;
			border: 1px solid #e74c3c;
		}

		.delivery-popup .addr-item .btn-delete:hover {
			background: #e74c3c;
			color: #fff;
		}

		.delivery-popup .addr-item .address {
			font-size: 14px;
			color: #555;
			line-height: 1.5;
			margin-bottom: 4px;
		}

		.delivery-popup .addr-item .tel {
			font-size: 13px;
			color: #888;
		}

		/* 닫기 버튼 */
		.delivery-popup .btn-close {
			display: block;
			width: 100%;
			padding: 14px;
			background: #f5f5f5;
			border: none;
			border-radius: 8px;
			font-size: 15px;
			font-weight: 500;
			color: #555;
			cursor: pointer;
			transition: all 0.2s;
			margin-top: 16px;
		}

		.delivery-popup .btn-close:hover {
			background: #e8e8e8;
		}

		/* 스크롤바 스타일 */
		.delivery-popup .addr-list::-webkit-scrollbar {
			width: 6px;
		}

		.delivery-popup .addr-list::-webkit-scrollbar-track {
			background: #f1f1f1;
			border-radius: 3px;
		}

		.delivery-popup .addr-list::-webkit-scrollbar-thumb {
			background: #ccc;
			border-radius: 3px;
		}

		.delivery-popup .addr-list::-webkit-scrollbar-thumb:hover {
			background: #aaa;
		}
	</style>
	<script language=javascript>
		$(document).ready(function() {
			$("#frmPopup input[name=returnPage]").val(1);
			FnAddrList("");
		});

		function FnAddrList(pType) {
			var intPageNo = 0;

			if (pType != "append") {
				$("#id_List").html("");
				$("#frmPopup input[name=returnPage]").val(0);
			}

			var curpages = $("#frmPopup input[name=returnPage]").val();
			if(curpages == "") {
				return;
			}
			intPageNo = parseInt(curpages)+1;

			var strBtnBackColor = "";
			var htmlStr = "";
			var dataParam = {};
			dataParam['mobileGb'] = "popup";
			dataParam['pPageNo'] = intPageNo;
			$.ajax({
				url : "${sysPcGubunUrl}/delivery/ajaxDeliveryAddrList.do",
				type : 'post',
				data : dataParam,
				dataType:'json',
				cache : false,
				async : false,
				success : function(data) {
					$(data.list).each(function(index, value){
						htmlStr += '<div class="addr-item">\n';
						htmlStr += '	<div class="item-header">\n';
						htmlStr += '		<span class="name">('+value.receiverNicknm+') '+value.receiverNm+'</span>\n';
						htmlStr += '		<div class="btn-group">\n';
						htmlStr += '			<a href="javascript:void(0);" class="btn-select" onclick="FnAddrSelect(\''+value.deliveryGb+'\', '+value.deliveryNo+');">선택</a>\n';
						htmlStr += '			<a href="javascript:void(0);" class="btn-edit" onclick="FnDeliveryPlaceAddOpen(\'modify\', '+value.deliveryNo+');">수정</a>\n';
						htmlStr += '			<a href="javascript:void(0);" class="btn-delete" onclick="FnAddrDelete('+value.deliveryNo+');">삭제</a>\n';
						htmlStr += '		</div>\n';
						htmlStr += '	</div>\n';
						htmlStr += '	<p class="address">'+value.receiverAddr1+' '+value.receiverAddr2+'</p>\n';
						htmlStr += '	<p class="tel">'+value.receiverCtel+'</p>\n';
						htmlStr += '</div>\n';
					});

					$("#id_List").append(htmlStr);

					$("#frmPopup input[name=returnPage]").val(intPageNo)
					if ((data.list.length == 0) || (data.list.length > 0 && data.list.length < "${pageSize}")) gbAppend = false;
			        else gbAppend = true;

				}, error: function(xhr,status,error){
					console.log("오류가 발생했습니다.");
					return false;
				}
			});

		}

		function FnAddrSelect(pDeliveryGb, pNo) {
			var strUrl = "${sysPcGubunUrl}/delivery/ajaxDeliveryAddrChoice.do";

			var dataParam = {};
			dataParam['pMobile'] = "${mobile}";
			dataParam['pDeliveryGb'] = pDeliveryGb;
			dataParam['pDeliveryNo'] = pNo;
			$.ajax({
				url : strUrl,
				type : 'post',
				data : dataParam,
				dataType:'json',
				cache : false,
				async : false,
				success : function(retdata) {
					FnGetDeliveryDateSetPlace("${sessionLoginVO.deliveryDate}", retdata.receiverZip);

					$("#id_cart_delivertAddr",opener.document).html(retdata.receiverAddr1 +" "+ retdata.receiverAddr2);

					if ("${returnCartTab}" == "0") {
						$("#id_deliveryGb_view",opener.document).css("display", "none");
					}

					window.close();
					opener.parent.FnCartLoad("${returnCartTab}");

				}, error: function(xhr,status,error){
				}
			});
		}

		function FnGetDeliveryDateSetPlace(pDlDate, pZip) {
			var dataParam = {};
			dataParam['deliveryDate'] = pDlDate;
			dataParam['deliveryStDate'] = "${sysDeliveryMonDate}";
			dataParam['deliveryEdDate'] = "${sysDeliveryDate}";
			dataParam['deliveryZip'] = pZip;
			$.ajax({
				url : "${sysPcGubunUrl}/delivery/ajaxDeliveryTmsSet.do",
				type : 'post',
				data : dataParam,
				dataType:'json',
				cache : false,
				async : false,
				success : function(data) {
					$(data).each(function(index, value){
						var strNotDateS = value.notDlDate;
						if ((strNotDateS != null) && (strNotDateS.search(value.deliveryDate) >= 0)) {
							FnGuestSessionChange("delivery");
							$("#id_cart_delivertDate",opener.document).html("배송일 없음");
						}
					});
				}, error: function(xhr,status,error){
					return false;
				}
			});
		}

		function FnAddrDelete(pNo) {
			var cfm = confirm("삭제하시겠습니까?");
			if(!cfm){ return; }

			var dataParam = {};
			dataParam['pNo'] = pNo;
			$.ajax({
				url : "${sysPcGubunUrl}/delivery/ajaxDeliveryDelete.do",
				type: "post",
				cache : false,
				data : dataParam,
				success : function(retdata) {
					if (retdata == 9) {
						alert("기본배송지는 삭제할 수 없습니다.");
						return;
					} else {
						$("#frmPopup input[name=returnPage]").val(1);
					}
					FnAddrList("");
				}, error: function(xhr,status,error){
					console.log("오류가 발생했습니다.");
				}
			});

		}

		function FnDeliveryPlaceAddOpen(pMod, pNo) {
			$("#frmPopup input[name=returnParam2]").val(pMod);
			$("#frmPopup input[name=returnParam3]").val(pNo);
			var url = "${pageContext.request.contextPath}/popup/view/deliveryPlaceAdd.do";
			$("#frmPopup").attr("target", "_self");
			$("#frmPopup").attr("action", url);
			$('#frmPopup').submit();
		}

		function FnPopupClose() {
			$("#id_cart_delivertAddr",opener.document).html("${addr.receiverAddr1} ${addr.receiverAddr2}");
			window.close();
		}
	</script>
</head>
<body>

<div class="delivery-popup">
	<div class="popup-header">
		<h2>배송지 선택</h2>
	</div>

	<!-- 기본 배송지 -->
	<div class="default-addr">
		<span class="badge">기본 배송지</span>
		<c:choose>
			<c:when test="${addr eq null}">
				<p class="name">배송지 없음</p>
			</c:when>
			<c:otherwise>
				<p class="name">(<c:out value="${addr.receiverNicknm}"/>) <c:out value="${addr.receiverNm}"/></p>
				<p class="address"><c:out value="${addr.receiverAddr1}"/> <c:out value="${addr.receiverAddr2}"/></p>
				<p class="tel"><c:out value="${addr.receiverCtel}"/></p>
			</c:otherwise>
		</c:choose>
		<p class="notice">※ 기본배송지는 <span>마이두레 > 배송지관리</span>에서 변경 가능합니다.</p>
	</div>

	<!-- 등록된 배송지 -->
	<div class="addr-section">
		<div class="section-header">
			<h3>등록된 배송지</h3>
			<c:set var="sGuestNo" value="${sessionScope.sessionLoginVO.guestNo }"></c:set>
			<c:choose>
				<c:when test="${sGuestNo >= '794748' && sGuestNo <= '794756'}"></c:when>
				<c:otherwise>
					<a href="javascript:void(0);" class="btn-add" onclick="FnDeliveryPlaceAddOpen('insert', 0);">+ 배송지 추가</a>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="addr-list" id="id_List">
		</div>
	</div>

	<button type="button" class="btn-close" onclick="FnPopupClose();">창 닫기</button>
</div>

<form name="frmPopup" id="frmPopup" method="post" action="">
	<input type="hidden" name="returnPage" value="${returnPage}"/>
	<input type="hidden" name="returnCartTab" value="${returnCartTab}"/>
	<input type="hidden" name="returnParam2" value="insert"/>
	<input type="hidden" name="returnParam3" value="0"/>
</form>

</body>
</html>
