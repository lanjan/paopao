<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<h3 class="header smaller lighter blue">编辑公告类型</h3>
<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<form class="form-horizontal data-form" role="form" action="edit/exec" valid = "true">
			<!-- #section:elements.form -->
			<input type="hidden" name='id' value="${PAGE_DATA.id }">
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 公告类型名称 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="text" name="typeName" value="${PAGE_DATA.typeName }" class="col-xs-10 col-sm-5" />
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 所属小区 </label>
			
				<div class="col-sm-9">
					<select name="vid" class="col-xs-10 col-sm-5">
						<c:forEach items="${villages }" var="village">
							<option <c:if test="${PAGE_DATA.vid eq village.id }">selected='selected'</c:if> value="${village.id }">${village.villageName }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 是否启用 </label>
			
				<div class="col-sm-9">
					<label class="checkbox-inline">
				      <input type="radio" name="useFlag" value="YES" <c:if test="${PAGE_DATA.useFlag eq 'YES' }">checked='checked'</c:if> /> 是
				    </label>
				    <label class="checkbox-inline">
				      <input type="radio" name="useFlag" value="NO" <c:if test="${PAGE_DATA.useFlag eq 'NO' }">checked='checked'</c:if> /> 否
				    </label>
				</div>
				
			</div>
			
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="form-field-1"> 备注 </label>
			
				<div class="col-sm-5">
    				<textarea class="form-control" name="remark" rows="3">${PAGE_DATA.remark }</textarea>
				</div>
			</div>
			
			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info save" type="button">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>
			
					&nbsp; &nbsp; &nbsp;
					<button class="btn reset" type="reset">
						<i class="ace-icon fa fa-refresh bigger-110"></i>
						重置
					</button>
					
					&nbsp; &nbsp; &nbsp;
					<button class="btn btn-danger cancel" type="button">
						<i class="ace-icon fa fa-undo bigger-110"></i>
						取消
					</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	$(function() {
		$(".save").on("click", function() {
			$(".data-form").form({
				success:function(res) {
					//弹窗提示
					$.messager.alert(res.msg, function() {
						if(res) {
							//提交成功,跳转回查询页面
							action("vestate/estate/announceTypeManage/list");
						}
					});
				},
				error : function() {
					$.messager.alert("error", function(){});
				}
			})
		});
		

		$(".reset").on("click", function() {
			$(".data-form").formClear();
		});
		
		$(".cancel").on("click", function() {
			action("vestate/estate/announceTypeManage/list");
		});
		
	});
	
	//js校验表单;
	$(".data-form").validate(
			{
				errorElement : 'div',
				errorClass : 'help-block',
				focusInvalid : false,
				ignore : "",
				rules : {
					typeName : {
						required : true
					}
				},
				highlight : function(e) {
					$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
				},
				success : function(e) {
					$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
					$(e).remove();
				},
				errorPlacement : function(error, element) {
					if (element.is('input[type=checkbox]')
							|| element.is('input[type=radio]')) {
						var controls = element.closest('div[class*="col-"]');
						if (controls.find(':checkbox,:radio').length > 1)
							controls.append(error);
						else
							error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
					} else if (element.is('.select2')) {
						error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
					} else if (element.is('.chosen-select')) {
						error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
					} else
						error.insertAfter(element.parent());
				},
				submitHandler : function(form) {
				},
				invalidHandler : function(form) {
				}
			});
	
</script>