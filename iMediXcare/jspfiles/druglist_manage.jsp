<%@page language="java"  import= "imedix.rcDisplayData,java.nio.charset.StandardCharsets,java.nio.charset.StandardCharsets.*,java.net.URLEncoder,imedix.rcUserInfo,imedix.rcCentreInfo,imedix.dataobj, imedix.cook,java.util.*,java.io.*"%>
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
<!--<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>-->
<script src="<%=request.getContextPath()%>/bootstrap/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap/dataTables.bootstrap.min.js"></script>

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
.comp-upload-div{
	border: 1px solid #ddd;
		padding: 4px 12px;
		border-radius: 20px;
	position: absolute;
	left: 30%;
}
.comp-upload-div label{padding:5px;margin:0px;}
.comp-upload-span{
	border: 1px solid #ddd;
		padding: 4px 12px;
		font-size: 20px;
		border-radius: 20px;
		color: #4a93ea;
		background: #e1e7ef;
		cursor: pointer;
}
input[name="compReport"]{
		position: absolute;
		top: 0;
		left: 0px;
		float: right;
		width: 60px;
		opacity: 0;
		display: inline-block;
		overflow: hidden;
}
</style>


</head>
<body background="../images/txture.jpg">
	<TABLE class="table" width=90% border=0 Cellpadding=0 Cellspacing=0>
		<TR>
			<TD><Font Size='5' color=#3300FF> <B>EDIT DRUG LIST</B> </Font></TD>
			<TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
		</TR>
	</TABLE>
	<div class="container-fluid">

		<div class="row">
			<div class="col-md-8 col-md-offset-2" style="margin-top: 20px;">
			<%if(!ccode.equals("XXXX")){%>
				<button class="btn btn-primary" onClick="showAdddrugDialog()">Add Drug</button>
				<button class="btn btn-primary" onClick="showAddIMEDIXdrugDialog()">Add Drugs from BaseList</button>
				<button class="btn btn-primary" onClick="window.location.href='drugCSV.jsp'">Add Drugs from .CSV file</button>
			<%}%>
				<% if(ccode.equals("XXXX")){ %>
					<button class="btn btn-primary" onClick="window.location.href='druglist_imedixUpdate.jsp'">Edit Drugs from BaseList</button>
                <div class="form-group">
                    <label for="exampleInputEmail1">Select Hospital</label>
                    <select class="form-control" id="hospital" name="hospital" onClick="selectHospital()">
                        <option value="Select Hospital">Select Hospital</option>
                        <%
                        try{
                            rcCentreInfo cinfo = new rcCentreInfo(request.getRealPath("/"));
                            Object res=cinfo.getAllCentreInfo();
                            Vector tmp = (Vector)res;
                            for(int i=0;i<tmp.size();i++){
                                dataobj temp = (dataobj) tmp.get(i);
                                String _occode = temp.getValue("code").trim();
                                String _cname = temp.getValue("name").trim();
                                out.println("<option value='"+_occode+"'>"+_cname+"</option>");
                            }
                        }catch(Exception e){
                            out.println(e.getMessage());
                        }

                        %>
                    </select>
                </div>
                <% } %>

                <table style="margin-top:20px;" class="table table-bordered table-stripped table-hover" id="searchdrug">

					<thead>
						<tr>
							<th>Drug Name</th>
							<%if(!ccode.equals("XXXX")){%>
							<th>Active</th>
							<%}%>
						</tr>
					</thead>

					<tbody id="drugs">
                    <%
                        try{
                            if(!ccode.equals("XXXX")){
                                Object drugs = ddinfom.getAlldrugs(ccode);
                                Vector drugsV = (Vector)drugs;
                                //String options = "";
                                for(int i=0;i<drugsV.size();i++){
                                    dataobj obj = (dataobj)drugsV.get(i);
                                    int active = Integer.parseInt(obj.getValue("active"));
                                    out.println("<tr>");
                                    out.println("<td><div class='row'><div class='col-md-10'>"+obj.getValue("drug_name")+
                                        "</div><div class='col-md-2'><a href='#' onClick=\"editdrug('"+obj.getValue("drug_name")+
                                        "',"+obj.getValue("sl_no")+")\">"+
                                        "<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span></a>"+
                                        "&nbsp;&nbsp;<a href='#' onClick=\"deletedrug('"+obj.getValue("drug_name")+
                                        "',"+obj.getValue("sl_no")+")\">"+
                                        "<span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>"+
                                        "</div></div></td>");
                                    out.println("<td><input type='checkbox' "+ (active == 1 ? "checked" : "") +
                                        " onClick=\"updateActive("+obj.getValue("sl_no")+",'"+
                                        obj.getValue("drug_name")+"',"+(active == 1 ? 0 : 1)+")\"></input>");
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
	<script type="text/javascript">

        var ccode = "<%=ccode%>";
        $(document).ready(function(){

					<% if(!ccode.equals("XXXX")){ %>

					$('#searchdrug').DataTable();
					<% } %>
					var availableTags = [];
			    $.ajax({
			           type: "POST",
			           url: "druglist.jsp",
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
						$('#modalAddIMEDIXdrug').on('show.bs.modal',function(e){

						});
						$(".allSet").on("click",function(){
							if($(this).prop("checked") == true)
							{
								$("input:checkbox[name=appSet]").prop("checked", true);
							}
							else if($(this).prop("checked") == false)
							{
								$("input:checkbox[name=appSet]").prop("checked", false);
							}
						});
						$(".setappall").on("click",function(){
							//alert("ButtonClicked");
							var drug_name=[];
							var id=[];
							$("input:checkbox[name=appSet]:checked").each(function () {
								drug_name.push($(this).attr("drug_name"));
								//console.log($(this).val());
								id.push($(this).attr("id"));
								//alert("ID:-"+$(this).attr("id")+" name:-"+$(this).attr("drug_name"));
							});
							addIMEDIXdrugs(id);
						});


        });

				function addIMEDIXdrugs(drug_id)
				{
					console.log(drug_id.toString());
					var flag=0;
					var param = {cmd: 'add-multiple', drug_id: drug_id.toString()};
					if(ccode == 'XXXX'){
							var hcode = $('#hospital').val();
							if(hcode == 'Select Hospital'){
									alert("Please select a hospital");
									return;
							}
							param.ccode = hcode;
					}
					$.ajax({
							type: 'POST',
							url: "updateDruglist.jsp",
							data: param,
							dataType: "text",
							success: function(data) {
									var res = JSON.parse(data);
									alert(res.message);
									location.reload(true);
							}
							//location.reload(true);
					});
			}

        function updateActive(drug_id, drug_name, value){
            event.preventDefault();

            if(confirm('Do you want to '+(value == 0 ? 'DEACTVATE' : 'ACTIVATE')+' the '+drug_name.toUpperCase()+' drug ?')){
                var param = {cmd: 'update-active', drug_id: drug_id, active: value};
                $.ajax({
                    type: 'POST',
                    url: "updateDruglist.jsp",
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


        function editdrug(drug_name, drug_id){
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
                url: "updateDruglist.jsp",
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
				function showAddIMEDIXdrugDialog(){

					$('#modalAddIMEDIXdrug').modal();

				}

        function adddrug(){
            event.preventDefault();
            var drug_name = $('#add_drug_name').val();

            var param = {cmd: 'add', drug_name: drug_name};
            if(ccode == 'XXXX'){
                var hcode = $('#hospital').val();
                if(hcode == 'Select Hospital'){
                    alert("Please select a hospital");
                    return;
                }
                param.ccode = hcode;
            }
            $.ajax({
                type: 'POST',
                url: "updateDruglist.jsp",
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
                    url: "updateDruglist.jsp",
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

        function selectHospital(){
            var hcode = $('#hospital').val();
						$.get('drugImedixList.jsp?ccode='+hcode,function(data,status){
							$('#drugsIMEDIX').html(data);
						});

            $.get('drugInfo.jsp?ccode='+hcode, function(data,status){
							console.log(data);
            var drugs = JSON.parse(data)
            var drugList = "";
						//alert(drugs);
            //console.log(data);
						//$('#searchdrug').DataTable().clear();
            drugs.forEach(element => {

                var active = element['active'];
                //console.log(element['drug_id'],element['drug_name'],active);
                drugList += "<tr>";
              	drugList += "<td><div class='row'><div class='col-md-10'>"+element['drug_name']+
		                    "</div></td>";
                drugList += "</tr>";

            });

						var return_data = new Array();

						drugs.forEach(element => {
							return_data.push({
									"drug_name": element['drug_name']
								})
						});

						//$('#drugs').html(drugList);

						$("#searchdrug").dataTable().fnDestroy();
						$('#searchdrug').DataTable({
						    "data": return_data,
						      "columns": [
									{ "data": "drug_name" }
						    ]
						});
	        });
        }

	</script>


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
                        <input type="text" autocomplete="off" maxlength="100" class="form-control drug-c" id="add_drug_name"></input>
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


		<div class="modal fade" id="modalAddIMEDIXdrug" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">DRUGS BASELIST</h4>
            </div>
            <div class="modal-body">

						<input type='checkbox' class='allSet' />&nbsp;&nbsp;Select All Drugs

						<button  class="btn btn-default setappall" type="button">
						Add Selected Drugs
					  </button>
						<table style="margin-top:20px;" class="table table-bordered table-stripped table-hover" id="searchdrug">
			<thead>
				<tr>
					<th>Select</th>
					<th>Drug Name</th>
				</tr>
			</thead>
			<tbody id="drugsIMEDIX">
								<%
								if(!ccode.equals("XXXX")){
										try{
														//Object imedix_drugs = ddinfom.getDrugList();
														Object imedix_drugs = ddinfom.getDrugListIMEDIX(ccode);
														Vector imedix_drugsV = (Vector)imedix_drugs;
														//String options = "";
														if(imedix_drugsV.size()==0)
														{
																out.println("<tr style='color:red;'><td>All Drugs from BaseList have been added !</td><td>---------------------</td></tr>");
																out.println("<script>$('.setappall').prop('disabled', true);</script>");
														}
														else{
														for(int i=0;i<imedix_drugsV.size();i++){
																dataobj obj = (dataobj)imedix_drugsV.get(i);
																//int active = Integer.parseInt(obj.getValue("active"));
																//String value = new String(URLEncoder.encode(obj.getValue("drug_name"),"UTF-8"));
																//String value = new String(obj.getValue("drug_name"), StandardCharsets.UTF_8);

																//String str=obj.getValue("drug_name");
																//byte[] ptext = str.getBytes();
																//String value = new String(ptext, StandardCharsets.UTF_8);

															//	System.out.println(obj.getValue("drug_name"));
																out.println("<tr>");
															if(!obj.getValue("drug_name").equalsIgnoreCase("")){
																out.println("<td><input class='form-control'  name='appSet' type='checkbox' id='"+obj.getValue("sl_no")+"' drug_name='"+obj.getValue("drug_name")+"' /></td><td>"+obj.getValue("drug_name")+"</td>");
																out.println("</tr>");
															}
																//options += "<option value='"+obj.getValue("drug_name")+"'>"+obj.getValue("drug_name")+"</option>";
														}
													}
												//out.println(options);
										}catch(Exception e){
												System.out.println(e.getMessage());
										}
									}
								%>
			</tbody>
		</table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <!--<button type="button" class="btn btn-primary" onClick="adddrug()">Save changes</button>-->
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
</body>
</html>
