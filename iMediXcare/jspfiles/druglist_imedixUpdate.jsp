<%@page language="java"  import= "imedix.rcDisplayData, imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	cook cookx = new cook();
	String utyp=cookx.getCookieValue("usertype", request.getCookies());
	String usr=cookx.getCookieValue("userid", request.getCookies());

	rcUserInfo uinfo=new rcUserInfo(request.getRealPath("/"));

	String ccode= cookx.getCookieValue("center", request.getCookies ());
	String cname = cookx.getCookieValue("centername", request.getCookies ());

	rcDisplayData ddinfom=new rcDisplayData(request.getRealPath("/"));

%>

<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
	<script src="../bootstrap/js/jquery-ui.js"></script>


<script language="JavaScript">


</script>

<style>
input:invalid,
input:out-of-range {
    border-color:hsl(0, 50%, 50%);
    background:hsl(0, 50%, 90%);
}
.ui-widget.ui-widget-content{z-index:1055 !important;}
.ui-helper-hidden-accessible{
    display:none !important;
}
ul.ui-autocomplete {
    list-style: none;
    list-style-type: none;
    padding: 0px;
    margin: 0px;
		background-color: white;
		width:500px;
		height: 120px;
    overflow-x: hidden;
    overflow-y: auto;
}

</style>


</head>
<body>

    <div class="modal fade" id="modalAdddrug" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">New Drug</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="add_drug_name">Name of the Drug<p style="color:tomato;">Please don't enter Single Quote(') or Double Quote(") in Drug Name.<br>Single Quote(') and Double Quote(") will be replaced by (^) if entered.</p></label>
                        <input type="text" autocomplete="off" maxlength="100" class="form-control drug-c" id="add_drug_name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onClick="adddrug()">Save changes</button>
            </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade" id="modalEditdrug" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Edit drug</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <input type="hidden" id="edit_drug_id" value="">
                        <label for="edit_drug_name">Name of the drug<p style="color:tomato;">Please don't enter Single Quote(') or Double Quote(") in Drug Name.<br>Single Quote(') and Double Quote(") will be replaced by (^) if entered.</p></label>
                        <input type="text" autocomplete="off" maxlength="100" class="form-control drug-c" id="edit_drug_name" value="">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onClick="editdrugProcess()">Save changes</button>
            </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->



	<div class="container-fluid">

		<div class="row">

			<div class="col-md-8 col-md-offset-2" style="margin-top: 20px;">
      <table style="margin-top:20px;" class="table table-bordered table-stripped table-hover">
      <button class="btn btn-primary" style="float:left" onClick="showAdddrugDialog()">Add Drug</button>
      <button class="btn btn-primary" style="float:right" onClick="window.location.href='druglist_manage.jsp'">Go Back</button>
        <thead>
          <tr>
            <th>Drug Name</th>
          </tr>
        </thead>
        <tbody id="drugsIMEDIX">
          <%
          try{
              if(ccode.equals("XXXX")){
                  Object drugs = ddinfom.getDrugListIMEDIX();
                  Vector drugsV = (Vector)drugs;
                  //String options = "";
                  for(int i=0;i<drugsV.size();i++){
                      dataobj obj = (dataobj)drugsV.get(i);
                      //int active = Integer.parseInt(obj.getValue("active"));
                      out.println("<tr>");
                      out.println("<td><div class='row'><div class='col-md-10'>"+obj.getValue("drug_name")+
                          "</div><div class='col-md-2'><a href='#' onClick=\"editdrug('"+obj.getValue("drug_name")+
                          "',"+obj.getValue("sl_no")+")\">"+
                          "<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span></a>"+
                          "&nbsp;&nbsp;<a href='#' onClick=\"deletedrug('"+obj.getValue("drug_name")+
                          "',"+obj.getValue("sl_no")+")\">"+
                          "<span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>"+
                          "</div></div></td>");
                      out.println("</tr>");
                      //options += "<option value='"+obj.getValue("drug_name")+"'>"+obj.getValue("drug_name")+"</option>";
                  }
              }
              //out.println(options);
          }catch(Exception e){
              System.out.println(e.getMessage());
          }
          %>
          </tbody>
      </table>
			</div>
		</div>
	</div>
</body>
</html>



<script type="text/javascript">

      var ccode = "<%=ccode%>";
      $(document).ready(function(){
				var availableTags = [];
				$.ajax({
							 type: "POST",
							 url: "druglistBaselist.jsp",
							 success: function(data)
							 {
									availableTags = JSON.parse(data);
							 },
					 complete:function(){
						$(".drug-c").keydown(function(){
							$(this).autocomplete({
								source: availableTags
							});
						});
					 }
						 });



          $('#modalAdddrug').on('show.bs.modal', function (e) {
              $('#add_drug_name').val('').focus();
              $('#add_drug_name').focus();
          });
      });


      function editdrug(drug_name, drug_id){
        //alert(drug_id+"---"+drug_name);
          event.preventDefault();
          $('#edit_drug_id').val(drug_id);
          $('#edit_drug_name').val(drug_name);
          $('#modalEditdrug').modal();
      }

      function editdrugProcess(){
          event.preventDefault();
          var drug_name = $('#edit_drug_name').val();
          var drug_id = $('#edit_drug_id').val();
          var param = {cmd: 'edit', drug_name: drug_name, drug_id: drug_id};
          $.ajax({
              type: 'POST',
              url: "updateImedixDruglist.jsp",
              data: param,
              dataType: "text",
              success: function(data) {
                  //console.log("Data: "+data);
                  var res = JSON.parse(data);
                  alert(res.message);
                  //console.log('updateStatus: '+JSON.stringify(res));
                  location.reload(true);
              }
          });
      }

      function showAdddrugDialog(){
          if(ccode == 'XXXX'){
              var hcode = $('#hospital').val();
              if(hcode == 'Select Hospital'){
                  alert("Please select a hospital");
                  return;
              }else{
                  $('#modalAdddrug').modal();
              }
          }else{
              $('#modalAdddrug').modal();
          }
      }

      function adddrug(){
          event.preventDefault();
          var drug_name = $('#add_drug_name').val();

          var param = {cmd: 'add', drug_name: drug_name};

          $.ajax({
              type: 'POST',
              url: "updateImedixDruglist.jsp",
              data: param,
              dataType: "text",
              success: function(data) {
                  //console.log("Data: "+data);
                  var res = JSON.parse(data);
                  alert(res.message);
                  //console.log('updateStatus: '+JSON.stringify(res));
                  location.reload(true);
              }
          });
      }

      function deletedrug(drug_name, drug_id){
          if(confirm('Do you want to delete '+drug_name.toUpperCase()+' drug ?')){
              var param = {cmd: 'delete', drug_id: drug_id};
              $.ajax({
                  type: 'POST',
                  url: "updateImedixDruglist.jsp",
                  data: param,
                  dataType: "text",
                  success: function(data) {
                      //console.log("Data: "+data);
                      var res = JSON.parse(data);
                      alert(res.message);
                      //console.log('updateStatus: '+JSON.stringify(res));
                      location.reload(true);
                  }
              });
          }
      }


</script>
