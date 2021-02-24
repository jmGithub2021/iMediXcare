<%@page contentType="text/html" import= "imedix.layout,imedix.rcDisplayData,imedix.cook,imedix.dataobj,imedix.myDate, java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
		String sk_string="",skndu="";
		String sqlQuery1="";
		String imgname="",movname="",patdis="";
		String frmname,fty,fsl,patid,dt="",dt1="",dat="";
		
		cook cookx = new cook();
		rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
		patdis=cookx.getCookieValue("patdis", request.getCookies ());

		patid=request.getParameter("id");
		fty=request.getParameter("ty");
		fsl=request.getParameter("sl");
		frmname=request.getParameter("ty");
		frmname=frmname+"-"+request.getParameter("sl")+"#";
		dt1 = request.getParameter("dt");

		//out.println(dt1);
		//dat = dt1.substring(0,2)+dt1.substring(3,5)+dt1.substring(6,10);
		//out.println(dat);

		dt =dt1;

		//out.println(dt);
		Vector Vres;
		Vres = (Vector) ddinfo.getAttachmentAndOtherFrm(patid,fty,fsl,dt); ////
		// 1st object 'dataobj' and 2nd object 'Vector' ;
		if(frmname.startsWith("i"))
		{		
			dataobj imgmov = (dataobj) Vres.get(0);
			imgname = imgmov.getValue("img");
			movname = imgmov.getValue("mov");
			//out.println("wsds"+imgname);
			//out.println("sdsad"+movname);
		}
%>

<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>
</head>

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function PrintDoc(text){
text=document
print(text)
}

function showselected()
{
var val=document.frm.abc.value;
var tar;
tar="writevaltext.jsp?"+val;
//alert(tar);
window.location=tar;

}

function setvalue(val)
{	
	if(val==true)
	{
	var prevalue;
	var newval;
	newval = <%out.println("'"+ frmname + "'");%> 
	prevalue=getCookie("selfrm");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="selfrm="+prevalue;
	alert(getCookie("selfrm"));
	}
	else
	{
	var arr,prevalue,i,nval="";
	var newval;
	newval = <%out.println("'"+ frmname + "'");%> 
	prevalue=getCookie("selfrm");
	document.cookie="selfrm="+"";
	arr=prevalue.split("#");
	for(i=0;i<arr.length;i++)
	{	
	if(arr[i]+"#" != newval)
	{
	 nval+=arr[i]+"#";
	}
	}
	nval=nval.substring(0,nval.length-1);
	document.cookie="selfrm="+nval;
	alert(getCookie("selfrm"));	
	}
	setimgvalue(val);
	setmovvalue(val);
	
}


function setimgvalue(val)
{	
	
	if(val==true)
	{
	var prevalue;
	var newval;
	newval = <%out.println("'"+ imgname + "'");%> 

	prevalue=getCookie("selimg");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="selimg="+prevalue;
	//alert(getCookie("selimg"));
	}
	else
	{
	var arr,prevalue,i,j,nval="";
	var newval;
	newval = <%out.println("'"+ imgname + "'");%> 
	prevalue=getCookie("selimg");
	document.cookie="selimg="+"";
	//arr=prevalue.split("#");
	arr1=newval.split("#");
	for(j=0;j<arr1.length-1;j++)
	{
	arr=prevalue.split("#");
	
	for(i=0;i<arr.length-1;i++)
	{	
	if(arr[i]+"#" != arr1[j]+"#")
	{
	nval+=arr[i]+"#";
	}
	}
	
	prevalue=nval;
	nval="";
	}
	//prevalue=prevalue.substring(0,prevalue.length-1);
	document.cookie="selimg="+prevalue;
	//alert(getCookie("selimg"));	
	}
	
}

function setmovvalue(val)
{	
	
	if(val==true)
	{
	var prevalue;
	var newval;
	newval = <%out.println("'"+ movname + "'");%> 
	prevalue=getCookie("selmov");
	if(prevalue == null) prevalue="";
	prevalue=prevalue+newval;
	document.cookie="selmov="+prevalue;
	//alert(getCookie("selmov"));
	}
	else
	{
	var arr,prevalue,i,nval="";
	var newval;
	newval = <%out.println("'"+ movname + "'");%> 
	prevalue=getCookie("selmov");
	document.cookie="selmov="+"";
	//arr=prevalue.split("#");
	arr1=newval.split("#");
	for(j=0;j<arr1.length-1;j++)
	{
	arr=prevalue.split("#");
	for(i=0;i<arr.length;i++)
	{	
	if(arr[i]+"#" != arr1[j]+"#")
	{
	 nval+=arr[i]+"#";
	}
	}
	prevalue=nval;
	nval="";
	}
	prevalue=prevalue.substring(0,prevalue.length-1);
	document.cookie="selmov="+prevalue;
	//alert(getCookie("selmov"));	
	}
	

}

function getCookie(name) {    // use: getCookie("name");
    var bikky;
	bikky = document.cookie;
	var index = bikky.indexOf(name + "=");
    if (index == -1) return null;
    index = bikky.indexOf("=", index) + 1;
    var endstr = bikky.indexOf(";", index);
    if (endstr == -1) endstr = bikky.length;
    return unescape(bikky.substring(index, endstr));
  }
//  End -->


function disp_img(a){
	var en_a=encodeURI(a);
	document.getElementById("img-display").innerHTML="<img class='img-responsive' src="+en_a+" />"
	//prompt("sd",en_a);
	}

</script>
<SCRIPT LANGUAGE="JavaScript" SRC="../includes/script1.jsp"></script>

<STYLE>
a:hover {color:WHITE; background:#537768; text-decoration:none }
a { text-decoration:none }
</STYLE>
<TABLE Width=100%  Border=0 class='tablea'>
<Form name="frm" >
<TR>
	<TD><A HREF="#"  onClick='PrintDoc();' Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
<IMG  class="img-responsive" SRC="../images/printer.gif" WIDTH="30" HEIGHT="30" BORDER=0 ALT="Print This"  >&nbsp;Print this Document&nbsp;</A>
</TD>
<%

String ty="",id="",sl="";
	//ty = request.getParameter("ty").toUpperCase();
	ty = request.getParameter("ty");
	id = request.getParameter("id");
	//out.println("dt : "+dt);
	sl = request.getParameter("sl");
	/////////////////////////////////// SEE PRES
	if (ty.equalsIgnoreCase("pre") || ty.equalsIgnoreCase("prs")) {
		String redirectto = "dispres.jsp?" +  request.getQueryString();
		response.sendRedirect(response.encodeRedirectURL(redirectto));
	}
	


String pdt="",iData;
boolean found=false;


		
		out.println("<td Align=Right><FONT SIZE = 3 COLOR= blue >ID:&nbsp;"+id+ "</FONT></TD></TR>");

			String utype="";
			utype=cookx.getCookieValue("userid", request.getCookies ());
			String selfrm,thisfrm;
			int hasthisfrm=0;
			selfrm = cookx.getCookieValue("selfrm", request.getCookies ());
			thisfrm = frmname;
			if(!selfrm.equals("")){
				try
				{
					String str[]=selfrm.split("#");
					for(int k=0;k<str.length;k++)
					{	if(thisfrm.equals(str[k]+"#"))
						{
						found = true;
						break;
						}
						else found=false;

					} //end of for loop
				} catch(ArrayIndexOutOfBoundsException e1) { }
 
			}

			out.println("<tr><td><FONT SIZE='-1' COLOR='#0080C0'><INPUT TYPE=checkbox NAME=seltele");
			if(found == true)
			{
			out.println(" checked");
			}
			out.println(" onClick='setvalue(seltele.checked);'> Select for Teleconsultation</FONT></td>");


			int tag=0;
			Object Objtmp = Vres.get(1);
			if(Objtmp instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)Objtmp;
				if(Vtmp.size()>1 ) {
					String sn;
					out.println("<td Align='Right'><FONT SIZE='-1' COLOR='#0080C0'>View Other : </FONT>");
					out.println("<SELECT class='btn btn-default' NAME=abc onChange='showselected();'>"); //showselected(abc.value);
					out.println("<option></option>");
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						pdt = datatemp.getValue("date");
						String dt3= pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						sn=datatemp.getValue("serno");
						//if(sn.length()<2)  sn= "0" + sn; 
						out.println("<option value='id="+id+"&ty="+ty+"&sl="+sn+"&dt="+pdt+"' >"+ty+"-"+sn+"</option>");
					}
					out.println("</SELECT></TD></TR></form></TABLE><HR Size=3  Color=RED>");
				}
				else out.println("</TR></form></TABLE><HR Size=3  Color=RED>");

			}
			if(tag==1) out.println("</TR></form></TABLE><HR Size=3  Color=RED>");

    //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''//

	
	
	String wprn1 = "<a class='btn btn-default btn-sm' href='writevaltext.jsp?id="+id+"&ty="+ty+"&dt="+dt1+"&sl="+sl+"' Style='text-decoration: none; Color:brown; font-weight: bold; font-size: 10' >";
	out.println("<tr><td><table BORDER=1>");
    	out.println("<td Align=RIght VAlign=Bottom style='background-color=#C8DCE1'>"+ wprn1 +"&nbsp;&nbsp;Data Fields Only&nbsp;&nbsp;</A></td></table></td></tr>");

//out.println("writevalall.jsp?id="+id+"&ty="+ty+"&dt="+dt1+"&sl="+sl);

	try {
	

	Object res=ddinfo.DisplayFrm(ty.toLowerCase(),id,dt,sl);

	//browse through the values and store it in vector
	String val1, tmp1,key,val,qry,Ustr,typ1="";
	dataobj temp;
	int i,start=0,got=-1,input=-1,textareab=-1,epoint=-1,textareae=-1,chkbx=-1;
	Double fldDbl;
   

	if(res instanceof String){
		
		out.println("<br><center><h1> Data Not Available </h1></center>");
		out.println("<br><center><h1> " +  res+ "</h1></center>");
	}
	else{
		Vector tmp = (Vector)res;
		if(tmp.size()>0){
		temp = (dataobj) tmp.get(0);
		
		layout LayoutMenu = new layout(request.getRealPath("/"));
		FileInputStream fin = new FileInputStream(LayoutMenu.getTemplates(ty,patdis));

		String str="",data="",fname="",age="",agep="";
		start = 1;						// it is the index to the fieldName vector, 0 contains pat_id so ignore it
		do{
		i = fin.read();
		if((char) i != '\n')
			str = str + (char) i;
		else {
			//out.println(str);		//contains a single line of the html file
			Ustr = str.toUpperCase();
			iData = temp.getKey(start);
			if(iData.equalsIgnoreCase("name_hos")){
				start++;
				iData = temp.getKey(start);
			}
			//out.println(iData);
			got = Ustr.indexOf("NAME="+iData.toUpperCase());
			if(got==-1) got = Ustr.indexOf("NAME=\""+iData.toUpperCase()+"\"");
			if(got==-1) got = Ustr.indexOf("NAME=\'"+iData.toUpperCase()+"\'");
			
			if(got != -1)			// the line contains the field name
			{
				//if the line contains field name then it must be a input or textarea box
				input = Ustr.indexOf("INPUT");
				//out.println(Ustr +":"+input);
				epoint= Ustr.indexOf(">",input);
				textareab = Ustr.indexOf("TEXTAREA");
				chkbx = Ustr.indexOf("CHECKBOX");
				textareae = Ustr.indexOf("/TEXTAREA");
				data=temp.getValue(start);
				fname=temp.getKey(start);
				
				if (fname.equals("nofimg") )
				{
				 start++;
				}
				else
				{
					if(input != -1)			//if it is a input box insert the value
					{	
						if(Ustr.indexOf("TESTDATE") > 0 || Ustr.indexOf("ENTRYDATE") > 0)
						{	
							dt = data;
							out.print(str.substring(0,input-1));
					out.println("<B>:</B>&nbsp;&nbsp;"+dt.substring(8,10)+"-"+dt.substring(5,7)+"-"+dt.substring(0,4));
							out.print(str.substring(epoint+1));
						}
						else{	
						 out.print(str.substring(0,input-1));
						 out.print("<B>:</B>&nbsp;&nbsp;<Font color=brown>"+ data +"</font> &nbsp;");
						 out.print(str.substring(epoint+1));
						}
					}

					if(textareab != -1)			//if it is a textarea box insert the value
					{
						out.print(str.substring(0,textareab-1) );
						String nstr=data;
						nstr=nstr.replaceAll("\n","<br>");
						out.print("<B>:</B>&nbsp;&nbsp;"+nstr);
						out.print(str.substring(textareae+10));
					}

				got=-1;input=-1;textareab=-1;epoint=-1;textareae=-1;			// reset all the values
				start++;
				} //end of null if

		  } // end of (got != -1)	
			else {
				if(ty.equalsIgnoreCase("a41")){
				String pain = temp.getValue("pain");
				pain=pain.toLowerCase().replace(" ","_")+".jpg";
				String imgsrc="<IMG SRC='./../images/pain/"+pain+"' WIDTH='80' HEIGHT='80' ALT='Pain'>";
				str=str.replaceAll("#imgsrc#",imgsrc);
				//System.out.println(str);
				//System.out.println(imgsrc);
				}
				sk_string=str.replaceAll("BORDER","class='table table-bordered tableb'");

			 out.println(sk_string);
			}
			data="";
			fname="";
			str="";
		} //end of else of ((char) i != '\n')

	}while(i != -1);
	  fin.close();
	}

 }// end writing file content

} catch(Exception e)
{
	out.print("Exception **: "+e+"<BR>"); 
}

//out.println("aaa'"+imgname+"'ss");
//i00-0#;
if(frmname.startsWith("i"))
{
%>

<B>List of Attached Images & Movies </B>
<HR Color=RED>

<%
	//<a  href="images.jsp?id=" //onclick="NewWindow(this.href,'psychiatry','600','190','yes','CENTER');return false" //onfocus="this.blur()"><font size=+1><b><font color="#FF0000">Attach File</b></font></a>
	//Target=fullform
}
if(imgname.length()>4){
	String[] arr=imgname.split("#");
	//out.println("length:"+arr.length);
	if(arr.length>0){
	for(int i=0;i<arr.length;i++){
		String[] arr1=arr[i].split("-");
		String wprn="<IMG SRC='displayimg.jsp?id="+patid+"&ser="+arr1[1]+"&type="+fty+"&dt="+dt1+" ' Width=30 Height=30>";
	//	out.println("<TD Width=30 Height=30 Valign=Bottom><A Href='displayimg.jsp?id="+patid+"&type="+fty+"&ser="+arr1[1]+"&dt="+dt1+"' onclick=\"NewWindow(this.href,'AttachFiles','520','350','yes','CENTER');return false\">"+wprn+"</A></TD>");
		skndu=arr1[1];
		
%>	

	<button type="button"  onmouseover="disp_img('displayimg.jsp?id=<%=patid%>&type=<%=fty%>&ser=<%=skndu%>&dt=<%=dt1%>')" class="btn btn-default btn-lg" data-toggle="modal" data-target="#sk"><%=wprn%></button>

  <!-- Modal -->
  <div class="modal fade" id="sk" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"><span class="well"><%=patid%></span></h4>
        </div>
        <div class="modal-body">
         <center><div id="img-display"></div></center>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>




<%	
		
	}
	}
}

if(movname.length()>4){
	String[] array=movname.split("#");
	//out.println("length:"+array.length);
	if(array.length>0){
	for(int i=0;i<array.length;i++){
		String[] array1=array[i].split("-");
		String wprn="<IMG SRC='displaymov.jsp?id="+patid+"&ser="+array1[1]+"&type="+fty+"&dt="+dt1+" ' Width=30 Height=30 >";

		out.println("<TD Width=30 Height=30 Valign=Bottom><A Href='displaymov.jsp?id="+patid+"&type="+fty+"&ser="+array1[1]+"&dt="+dt1+"' Target=fullform>"+wprn+"</A></TD>");
	}

	}
}
%>

