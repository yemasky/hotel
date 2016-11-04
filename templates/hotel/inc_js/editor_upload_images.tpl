<link rel="stylesheet" href="<%$__RESOURCE%>editor/kindeditor/themes/default/default.css" />
<script src="<%$__RESOURCE%>editor/kindeditor/kindeditor-min.js"></script>
<script src="<%$__RESOURCE%>editor/kindeditor/lang/zh_CN.js"></script>
<script language="javascript">
	KindEditor.ready(function(K) {
		var editor = K.editor({
			uploadJson : '<%$upload_images_url%>',
			fileManagerJson : '<%$upload_manager_img_url%>',
			allowFileManager : true
		});
		K('#upload_images').click(function() {
			editor.loadPlugin('image', function() {
				editor.plugin.imageDialog({
					imageUrl : K('#upload_images_url').val(),
					clickFn : function(url, title, width, height, border, align) {
						//K('#upload_images_url').val(url);
						uploadSuccess(url, title);
						editor.hideDialog();
					}
				});
			});
		});
	});
</script>