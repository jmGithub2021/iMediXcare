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


<script language="JavaScript">


</script>

<style>
input:invalid,
input:out-of-range {
    border-color:hsl(0, 50%, 50%);
    background:hsl(0, 50%, 90%);
}
</style>


</head>
<BODY background="../images/txture.jpg" >
    <div class="container-fluid">
    
    <TABLE class="table" width=100% border=0 Cellpadding=0 Cellspacing=0>
    <TR>
        <TD><Font Size='5' color=#3300FF> <B>MANAGE DEPARTMENTS</B> </Font></TD>
        <TD align='right'><A class="btn" HREF="javascript:history.go(-1)" Style="color:yellow; size:9px; background:RED; font-weight:bold; text-decoration:none; ">&nbsp;BACK&nbsp;</A> </TD>
    </TR>
    </TABLE>
	<div class="container-fluid">

		<div class="row">
			<div class="col-md-8 col-md-offset-2" style="margin-top: 20px;">
				<button class="btn btn-primary" onClick="showAddDepartmentDialog()">Add Department</button>
				<% if(ccode.equals("XXXX")){ %>
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

                <table style="margin-top:20px;" class="table table-bordered table-stripped table-hover" >
					<thead>
						<tr>
							<th>Department</th>
							<th>Active</th>
						</tr>
					</thead>
					<tbody id="departments">
                    <%
                        try{
                            if(!ccode.equals("XXXX")){
                                Object depts = ddinfom.getAllDepartments(ccode);
                                Vector deptsV = (Vector)depts;
                                //String options = "";
                                for(int i=0;i<deptsV.size();i++){
                                    dataobj obj = (dataobj)deptsV.get(i);
                                    int active = Integer.parseInt(obj.getValue("active"));
                                    out.println("<tr>");
                                    out.println("<td><div class='row'><div class='col-md-10'>"+obj.getValue("department_name")+
                                        "</div><div class='col-md-2'><a href='#' onClick=\"editDepartment('"+obj.getValue("department_name")+
                                        "',"+obj.getValue("iddepartment")+")\">"+
                                        "<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span></a>"+
                                        "&nbsp;&nbsp;<a href='#' onClick=\"deleteDepartment('"+obj.getValue("department_name")+
                                        "',"+obj.getValue("iddepartment")+")\">"+
                                        "<span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>"+
                                        "</div></div></td>");
                                    out.println("<td><input type='checkbox' "+ (active == 1 ? "checked" : "") +
                                        " onClick=\"updateActive("+obj.getValue("iddepartment")+",'"+
                                        obj.getValue("department_name")+"',"+(active == 1 ? 0 : 1)+")\"></input>");
                                    out.println("</tr>");
                                    //options += "<option value='"+obj.getValue("department_name")+"'>"+obj.getValue("department_name")+"</option>";
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
            $('#modalAddDepartment').on('show.bs.modal', function (e) {
                $('#add_department_name').val('').focus();
                $('#add_department_name').focus();
            });
        });


        function updateActive(dept_id, dept_name, value){
            event.preventDefault();

            if(confirm('Do you want to '+(value == 0 ? 'DEACTVATE' : 'ACTIVATE')+' the '+dept_name.toUpperCase()+' department ?')){
                var param = {cmd: 'update-active', dept_id: dept_id, active: value};
                $.ajax({
                    type: 'POST',
                    url: "updateDepartment.jsp",
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


        function editDepartment(dept_name, dept_id){
            event.preventDefault();
            $('#edit_dept_id').val(dept_id);
            $('#edit_department_name').val(dept_name);
            $('#modalEditDepartment').modal();
        }

        function editDepartmentProcess(){
            event.preventDefault();
            var dept_name = $('#edit_department_name').val();
            var dept_id = $('#edit_dept_id').val();
            var param = {cmd: 'edit', dept_name: dept_name, dept_id: dept_id};
            $.ajax({
                type: 'POST',
                url: "updateDepartment.jsp",
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

        function showAddDepartmentDialog(){
            if(ccode == 'XXXX'){
                var hcode = $('#hospital').val();
                if(hcode == 'Select Hospital'){
                    alert("Please select a hospital");
                    return;
                }else{
                    $('#modalAddDepartment').modal();
                }
            }else{
                $('#modalAddDepartment').modal();
            }
        }

        function addDepartment(){
            event.preventDefault();
            var dept_name = $('#add_department_name').val();

            var param = {cmd: 'add', dept_name: dept_name};
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
                url: "updateDepartment.jsp",
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

        function deleteDepartment(dept_name, dept_id){
            if(confirm('Do you want to delete '+dept_name.toUpperCase()+' Department ?')){
                var param = {cmd: 'delete', dept_id: dept_id};
                $.ajax({
                    type: 'POST',
                    url: "updateDepartment.jsp",
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

            $.get('departmentInfo.jsp?ccode='+hcode, function(data,status){
            var depts = JSON.parse(data)
            var deptList = "";
            console.log(data);
            depts.forEach(element => {
                var active = element['active'];
                deptList += "<tr>";
                deptList += "<td><div class='row'><div class='col-md-10'>"+element['dept_name']+
                    "</div><div class='col-md-2'><a href='#' onClick=\"editDepartment('"+element['dept_name']+
                    "',"+element['dept_id']+")\">"+
                    "<span class='glyphicon glyphicon-pencil' aria-hidden='true'></span></a>"+
                    "&nbsp;&nbsp;<a href='#' onClick=\"deleteDepartment('"+element['dept_name']+
                    "',"+element['dept_id']+")\">"+
                    "<span class='glyphicon glyphicon-trash' aria-hidden='true'></span></a>"+
                    "</div></div></td>";
                deptList += "<td><input type='checkbox' "+ (active == '1' ? 'checked' : '') +
                    " onClick=\"updateActive("+element['dept_id']+",'"+
                    element['dept_name']+"',"+(active == '1' ? '0' : '1')+")\"></input>";
                deptList += "</tr>";
                //options += '<option value="'+element['dept_id']+'">'+element['dept_name']+'</option>';
            });
            $('#departments').html(deptList);

	        })
        }

	</script>


    <div class="modal fade" id="modalAddDepartment" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">New Department</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="add_department_name">Name of the Department</label>
                        <input type="text" autocomplete="off" maxlength="100" class="form-control" id="add_department_name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onClick="addDepartment()">Save changes</button>
            </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->


    <div class="modal fade" id="modalEditDepartment" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Edit Department</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <input type="hidden" id="edit_dept_id" value="">
                        <label for="edit_department_name">Name of the Department</label>
                        <input type="text" autocomplete="off" maxlength="100" class="form-control" id="edit_department_name" value="">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onClick="editDepartmentProcess()">Save changes</button>
            </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</body>
</html>
