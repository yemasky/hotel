<div id="modal_delete" class="modal hide">
  <div class="modal-header">
    <button data-dismiss="modal" class="close" type="button">×</button>
    <h5><i class="am-icon-warning am-icon-md am-yellow-EBC012"></i> <%$arrayLaguage['warning']['page_laguage_value']%></h5>
  </div>
  <div class="modal-body">
    <p class="alert alert-block" id="modal_delete_message"><%$arrayLaguage['warning_confirm_delete']['page_laguage_value']%></p>
  </div>
  <div class="modal-footer"> <a data-dismiss="modal" id="delete_sumbit" class="btn btn-primary" href="#sumbit">Confirm</a> <a data-dismiss="modal" class="btn" href="#">Cancel</a> </div>
</div>
<div class="modal fade" id="modal_success" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title" id="myModalLabel"><i class="am-success am-icon-sm am-icon-hand-peace-o am-green-54B51C"></i> <%$arrayLaguage['modal_success']['page_laguage_value']%></h3>
            </div>
            <div class="modal-body alert-success alert-block" id="modal_success_message"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%$arrayLaguage['close']['page_laguage_value']%></button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<div class="modal fade" id="modal_fail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3 class="modal-title" id="myModalLabel"><i class="am-icon-frown-o am-icon-sm am-red-E45A5A"></i> <%$arrayLaguage['modal_fail']['page_laguage_value']%></h3>
            </div>
            <div class="modal-body alert-error alert-block" id="modal_fail_message"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%$arrayLaguage['close']['page_laguage_value']%></button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script laguage="javascript">
$(document).ready(function(){
	var delete_url = '';
	// Form Validation
    $("#delete_sumbit").click(function(){
		$.getJSON(delete_url,function(data, status){
			//alert("Data: " + data + "\nStatus: " + status);
			if(data.success == 1) {
				$('#modal_success').modal('show');
				$('#modal_success_message').html(data.message);
			} else {
				$('#modal_fail').modal('show');
				$('#modal_fail_message').html(data.message);
			}
		});
	});
	$(".btn.btn-danger.btn-mini").click(function(){
		delete_url = $(this).attr("url");
	});
	$('#myModal').on('hide.bs.modal', function() {
        window.location.reload();
    });
})
</script>