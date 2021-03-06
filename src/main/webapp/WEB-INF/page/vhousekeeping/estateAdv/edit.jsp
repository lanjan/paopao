<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- 自定义样式 -->

<h3 class="header smaller lighter blue">编辑广告信息</h3>
<!-- /.page-header -->

<div class="row">
	<div class="col-xs-12">
		<!-- PAGE CONTENT BEGINS -->
		<form class="form-horizontal data-form" role="form" action="${pageContext.request.contextPath}/vestate/estate/estateAdvManage/edit/exec" method="post" enctype="multipart/form-data" valid="true" >
			<input type="hidden"  placeholder="广告" class="col-xs-10 col-sm-5" id="id" name="id" value="${PAGE_DATA.id}"/>
			<input type="hidden" name="villageId" value="${PAGE_DATA.village.id}"/>
			<!-- #section:elements.form -->
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="name"> 标题 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="text"  placeholder="标题" class="col-xs-10 col-sm-5" id="title" name="title" value="${PAGE_DATA.title}"/>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="ueditor">内容</label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<script id="ueditor" name="content" type="text/plain">${PAGE_DATA.content}</script>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="file"> 图片 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="file" id="file" name="file"/>
						<input type="hidden" id="hidFile" name="hidFile" value="${PAGE_DATA.picUrl}"/>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="sortno"> 排序权重 </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="text"  class="col-xs-10 col-sm-5" id="sortno" name="sortno" value="${PAGE_DATA.sortno}"/>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="useFlag"> 是否显示 </label>
				
				<div class="col-sm-9">
					<div class="clearfix">
						<select id="useFlag" name="useFlag" class="col-xs-10 col-sm-5">
							<c:forEach var="item" items="${requestScope.useFlags}">
							<option value="${item}" <c:if test="${item == PAGE_DATA.useFlag}">selected="selected"</c:if> >${item.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label no-padding-right" for="villageName"> 小区名称  </label>
			
				<div class="col-sm-9">
					<div class="clearfix">
						<input type="text"  class="col-xs-10 col-sm-5" id="villageName" name="villageName" value="${PAGE_DATA.village.villageName}" disabled/>
					</div>
				</div>
			</div>
			
			<div class="clearfix form-actions">
				<div class="col-md-offset-3 col-md-9">
					<button class="btn btn-info save" type="button">
						<i class="ace-icon fa fa-check bigger-110"></i>
						提交
					</button>
			
					&nbsp; &nbsp; &nbsp;
					<button class="btn reset" type="button">
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

<script type="text/javascript" src="${pageContext.request.contextPath }/plugin/ue/ueditor.config.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/plugin/ue/ueditor.all.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/plugin/ue/my.ue.initconfig.js"></script>
<script type="text/javascript">
	$(function() {
		var ue = UE.getEditor('ueditor');
		$(".data-form").validate({
			errorElement: 'div',
			errorClass: 'help-block',
			focusInvalid: false,
			ignore: "",
			rules: {
				title: {
					required: true,
					maxlength: 16
				},
				sortno: {
					required: true,
					digits: true,
					maxlength: 11			
				},
				hidFile: {
					required: true			
				}
			},
			highlight: function (e) {
				$(e).closest('.form-group').removeClass('has-info').addClass('has-error');
			},
			success: function (e) {
				$(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
				$(e).remove();
			},
			errorPlacement: function (error, element) {
				if(element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
					var controls = element.closest('div[class*="col-"]');
					if(controls.find(':checkbox,:radio').length > 1) controls.append(error);
					else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
				}
				else if(element.is('.select2')) {
					error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
				}
				else if(element.is('.chosen-select')) {
					error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
				}
				else error.insertAfter(element.parent());
			},
			submitHandler: function (form) {
			},
			invalidHandler: function (form) {
			}
		});
		
		$('input[type="file"]').ace_file_input({
			style: 'well',
			btn_choose: '点击或将图片拖拽至此上传!',
			btn_change: null,
			no_icon: 'ace-icon fa fa-cloud-upload',
			droppable: true,
			thumbnail: 'small', //large | fit,
			allowExt:  ['jpg', 'jpeg', 'png', 'gif', 'tif', 'tiff', 'bmp'],
			allowMime: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'image/tif', 'image/tiff', 'image/bmp'],
			maxSize: 10000000,
			before_remove: function() {
				$("#hidFile").val("");
				return true;
			},
			preview_error: function(filename, error_code) {
				console.log(error_code)
			}
		}).on('change', function(){
			$("#hidFile").val($(this).data('ace_input_files')[0]);
		});
		$("input[type='file']").ace_file_input('show_file_list', ['${urlPrefx}${PAGE_DATA.picUrl}']);
		$(".ace-file-input").addClass("col-xs-10 col-sm-5");
		
		$(".save").on("click",function(){
			if(!ue.hasContents()){
				$.messager.alert("内容不能为空");
			}else{
				$(".data-form").form({
					success:function(res) {
						//弹窗提示
						$.messager.alert(res.msg, function() {
							if(res.code) {
								//提交成功,跳转回查询页面
								action("vestate/estate/estateAdvManage/list");
							}
						});
					}
				})
			}
		
		});
		
		$(".reset").on("click", function() {
			$(".data-form").formClear();
		});
		
		$(".cancel").on("click", function() {
			action("vestate/estate/estateAdvManage/list");
		});
	});
</script>