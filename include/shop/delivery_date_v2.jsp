<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<jsp:include page="/include/comm/deliveryDateComm.jsp" />
<jsp:include page="/include/shop/deliveryCommV2.jsp" />

<div class="delivery_date_wrap">
	<div class="in_box">
		<div class="title_box">배송일 선택</div>
		<div class="txt_box">
			<p class="b_txt"><c:out value="${sessionLoginVO.guestNm}"/> (<c:out value="${sessionLoginVO.propNm}"/>)</p>
			<p class="txt" id="id_dldate_self_desc"></p>
		</div>
		<div class="delivery_chk_list">
			<h3 class="tt"><span id="id_deliveryDateView"></span></h3>
			<div class="in">
				<c:set var="startDate" value="" />
				<c:set var="endDate" value="" />
				<form name="f_dldate" id="id_deliveryDateForm">
				</form>
				<input type="hidden" id="id_startWorkDate">
				<input type="hidden" id="id_endWorkDate">
			</div>
			<div class="notice-toggle" onclick="toggleDeliveryNotice();">
				<span>주문마감 안내</span>
				<span class="arrow">▼</span>
			</div>
			<div class="notice-content" id="deliveryNoticeContent">
				• 주문마감: 배송일 하루 전 오전 11:30<br>
				• 월요일 배송: 토요일 오전 11:30 마감<br>
				• 마감 후 변경/취소 불가
			</div>
		</div>
		<div class="delivery_add">
			<h3 class="tt">현재 배송지 <span id="id_deliveryGb_desc" style="font-size:15px;"></span></h3>
			<input type="text" class="input_green" readonly id="id_deliveryAddr_view" value="">
		</div>
		<div class="btn_box">
			<ul class="inner">
				<li><button type="button" class="btn_white" onclick="FnDeliveryCancel();">창닫기</button></li>
				<li><button type="button" class="btn_green" onclick="FnDeliveryConfirm();">확인</button></li>
			</ul>
		</div>
	</div>
</div>

<script language=javascript>
	function FnDeliveryDateOpen() {
		if (!FnLoginCheck()) {return;}

		var strDate = $("#deliveryFrm input[name=deliveryDate]").val();

		var dataParam = {};
		dataParam['mallCd'] = "${sysMallCd}";
		dataParam['deliveryDate'] = strDate;
		$.ajax({
			url : "${sysPcGubunUrl}/delivery/ajaxDeliveryDateOpen.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				$(data).each(function(index, value){
					$("#id_deliveryDate_temp").val(value.deliveryDate);
					$("#id_deliveryNo_temp").val(value.deliveryNo);
					$("#id_deliveryGb_temp").val(value.deliveryGb);
					$("#id_receiverZip_temp").val(value.receiverZip);

					$("#id_deliveryAddr_view").val(value.receiverAddr1+" "+value.receiverAddr2);

					setDeliveryDateForm();
				});
			}, error: function(xhr,status,error){
				return false;
			}
		});
	}

	function setDeliveryDateForm() {
		var dataParam = {};
		dataParam['mallCd'] = "${sysMallCd}";
		dataParam['deliveryDate'] = $("#id_deliveryDate_temp").val();
		dataParam['deliveryZip'] = $("#id_receiverZip_temp").val();
		$.ajax({
			url : "${sysPcGubunUrl}/delivery/ajaxDeliveryDateListV2.do",
			type : 'post',
			data : dataParam,
			dataType:'json',
			cache : false,
			async : false,
			success : function(data) {
				var strNo = $("#id_deliveryNo_temp").val();
				var strGb = $("#id_deliveryGb_temp").val();
				var strDate = $("#id_deliveryDate_temp").val();
				var strZip = $("#id_receiverZip_temp").val();

				displayDeliveryDateList(data.dateList);

				FnGetDeliveryDateSet(strDate, strZip);

				delivery_date_on();

			}, error: function(xhr,status,error){
				return false;
			}
		});

	}

	function displayDeliveryDateList(data) {
		$("#id_deliveryDateForm").html("");
		var strStartDate = "";
		var strEndDate = "";
		var htmlStr = "";
		for ( var i=0; i<data.length; i++ ) {
			if (i == 0) {
				strStartDate = data[i].workDt;
			}
			if (i == data.length-1) {
				strEndDate = data[i].workDt;
			}
			htmlStr += '<input type="hidden" id="id_endChk_'+i+'" value="'+data[i].endChk+'">\n';
			htmlStr += '<input type="hidden" id="id_workDt_'+i+'" value="'+data[i].workDt+'">\n';
			htmlStr += '<input type="hidden" id="id_weekNm_'+i+'" value="'+data[i].weekNm+'">\n';
			htmlStr += '<input type="hidden" id="id_deliveryYn_'+i+'" value="'+data[i].deliveryYn+'">\n';
			htmlStr += '<input type="hidden" id="id_delivery2Yn_'+i+'" value="'+data[i].delivery2Yn+'">\n';
			htmlStr += '<input type="hidden" id="id_dateView_'+i+'" value="'+data[i].dateView+'">\n';
			htmlStr += '<div class="check_wrap" id="id_check_wrap1_'+i+'" style="display:none;">\n';
			htmlStr += '	<input type="radio" name="rdoDelivery" id="rdoDelivery_'+i+'" value="'+data[i].workDt+'" onclick="FnRdoDeliveryDateClick(\''+data[i].workDt+'\', '+i+');">\n';
			htmlStr += '	<label for="rdoDelivery_'+i+'">'+data[i].dateView+'</label>\n';
			htmlStr += '</div>\n';
			htmlStr += '<div class="check_wrap none_chk" id="id_check_wrap2_'+i+'" style="display:none;">\n';
			htmlStr += '	<label for="id_dateNonechk_'+i+'">'+data[i].dateView+'<span class="r_txt" id="id_not_desc2_'+i+'"></span></label>\n';
			htmlStr += '</div>\n';
		}

		$("#id_deliveryDateForm").append(htmlStr);

		$("#id_startWorkDate").val(strStartDate);
		$("#id_endWorkDate").val(strEndDate);
	}

</script>

<script>
	function delivery_date_on(){
		$('.delivery_date_wrap').css({display : 'flex'});
	}

	function delivery_date_off(){
		$('.delivery_date_wrap').hide();
	}

	function toggleDeliveryNotice() {
		var content = document.getElementById('deliveryNoticeContent');
		var arrow = document.querySelector('.notice-toggle .arrow');
		if (content.classList.contains('show')) {
			content.classList.remove('show');
			arrow.textContent = '▼';
		} else {
			content.classList.add('show');
			arrow.textContent = '▲';
		}
	}
</script>
