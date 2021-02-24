<%@page contentType="text/html" import= "imedix.layout,imedix.rcDisplayData,imedix.cook,imedix.dataobj,imedix.myDate, java.util.*,java.io.*"%>
<%@ include file="..//includes/chkcook.jsp" %>

<%
	String sk_string="";
		cook cookx = new cook();
		rcDisplayData ddinfo=new rcDisplayData(request.getRealPath("/"));
		String patdis=cookx.getCookieValue("patdis", request.getCookies ());

		String sqlQuery1="";
		String frmname,frmpar,fty,fsl,patid,childfrm="";
		patid=request.getParameter("id");
		fty=request.getParameter("ty");
		fsl=request.getParameter("sl");
		frmname=request.getParameter("ty");
		frmname=frmname+"-"+request.getParameter("sl")+"#";
		frmpar=frmname;
		Vector Vres = new Vector();
		Vres = (Vector) ddinfo.getChildAndOtherFrm(patid,fty,fsl);

		childfrm = (String) Vres.get(0);

		//out.println("childfrm :"+childfrm);
		String arr[]=childfrm.split(",");
		for(int i=0;i<arr.length;i++)
		{
			frmname+=arr[i]+"-"+fsl+"#";
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
tar="writeval2.jsp?"+val;
//alert(tar);
window.location=tar;

}

function setvalue(val)
{	
	if(val==true)
	{
	var prevalue,i,j;
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
	var arr,prevalue,i,j,nval="";
	var newval;
	newval = <%out.println("'"+ frmname + "'");%> 
	prevalue=getCookie("selfrm");
	document.cookie="selfrm="+"";
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
	//nval=nval.substring(0,nval.length-1);
	document.cookie="selfrm="+prevalue;
	alert(getCookie("selfrm"));	
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
</script>
<STYLE>
a:hover {color:WHITE; background:#537768; text-decoration:none }
a { text-decoration:none }
</STYLE>
<TABLE Width=100%  Border=0 class='tablea'>
<Form name="frm">
<TR>
	<TD><A HREF="#"  onClick='PrintDoc();' Border=0 Style='Color:WHITE font-weight:Bold; text-decoration:none '>
<IMG SRC="../images/printer.gif" WIDTH="30" HEIGHT="30" BORDER=0 ALT="Print This"  >&nbsp;Print this Document&nbsp;</A>
</TD>
<%

int haveval=0,tagfv=-1,fldtag=-1;	
String ty="",id="",dt="",sl="",qr,dat;	
ty = request.getParameter("ty").toUpperCase();
id = request.getParameter("id");
dt = request.getParameter("dt");

//dat = dt.substring(0,2)+dt.substring(3,5)+dt.substring(6);
//dt = myDate.getFomateDate("ymd",true,dat);

sl = request.getParameter("sl");

out.println("<td Align=Right><FONT SIZE = 3 COLOR= blue >ID:&nbsp;"+id+ "</FONT></TD></TR>");


String sqlQuery="",iData="";
String chlnam ="",fetch="",fiel="";
boolean found=false;

///// get the child of this form

String infrm="", pdt="",dt1;
childfrm=ty+","+childfrm;			//eg: p30,p31 where parent is p29


try {
		//if(islocal.length()==0)
		//{
			//telemedicin req
			String utype="";
			utype=cookx.getCookieValue("userid", request.getCookies ());
			String selfrm,thisfrm;
			int hasthisfrm=0;
			selfrm = cookx.getCookieValue("selfrm", request.getCookies ());
			thisfrm = frmname;
			if(!selfrm.equals("")){
				try
				{
					String str1[]=selfrm.split("#");
					for(int k=0;k<str1.length;k++)
					{	if(thisfrm.equals(str1[k]+"#"))
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

//		}//end of islocal if

		int tag=0;
			Object Objtmp = Vres.get(1);
			if(Objtmp instanceof String){ tag=1;}
			else{
				Vector Vtmp = (Vector)Objtmp;
				if(Vtmp.size()>1 ) {
					String sn;
					out.println("<td Align='Right'><FONT SIZE='-1' COLOR='#0080C0'>View Other : </FONT>");
					out.println("<SELECT NAME=abc onChange='showselected();'>"); //showselected(abc.value);
					out.println("<option></option>");
					for(int i=0;i<Vtmp.size();i++){
						dataobj datatemp = (dataobj) Vtmp.get(i);
						pdt = datatemp.getValue("date");
						dt1 = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						sn=datatemp.getValue("serno");
						//if(sn.length()<2)  sn= "0" + sn; 
						out.println("<option value='id="+id+"&ty="+ty+"&sl="+sn+"&dt="+pdt+"' >"+ty+"-"+sn+"</option>");
					}
					out.println("</SELECT></TD></TR></form></TABLE><HR Size=3  Color=RED>");
				}
				else out.println("</TR></form></TABLE><HR Size=3  Color=RED>");

			}
			if(tag==1) out.println("</TR></form></TABLE><HR Size=3  Color=RED>");

	} catch(Exception e)
	{out.print("Exception **: "+e+"<BR>"+sqlQuery); }

		
   //'''''''''''''''''''''''''''''''''''''displaying contents of form'''''''''''''''''''''''''''''''''''''''''''''''''''''//

String Ustr="",put="";
String str="",data="",fname="";
int i=0,start = 0,got = -1,input=-1,textareab=-1,epoint=-1,textareae=-1,chkbx=-1,button=-1,tag=0;	

try {
	//out.println(ty+" : "+id+" : "+dt+" : "+sl);
	
	//FileInputStream fin = new FileInputStream(request.getRealPath("/")+"/templates/"+ty.toLowerCase()+".html");
	layout LayoutMenu = new layout(request.getRealPath("/"));
	FileInputStream fin = new FileInputStream(LayoutMenu.getTemplates(ty,patdis));

	Object res = ddinfo.DisplayFrmLayers(childfrm,id,dt,sl);

		if(res instanceof String){
			out.println("<br><center><h1> Data Not Available </h1></center>");
			out.println("<br><center><h1> " +i + " :: "+  res+ "</h1></center>");
		}
		else{
		dataobj temp = (dataobj)res;
		//out.println(temp.getAllKey());

		if(temp.getLength()>0){
			start = 0;			// it is the index to the fieldName vector, 0 contains pat_id so ignore it
			do{
			i = fin.read();
			if((char) i != '\n')
				str = str + (char) i;
			else {
				//out.println(str);		//contains a single line of the html file
				Ustr = str.toUpperCase();

				if(start<temp.getLength()){

					iData = temp.getKey(start);
					if(iData.equalsIgnoreCase("reflex")) iData=iData+1;
					data=temp.getValue(start);
				}

				got = Ustr.indexOf(iData.toUpperCase());
				if(got != -1)			// the line contains the field name
				{	
					input = Ustr.indexOf("INPUT");
					epoint = Ustr.indexOf(">",input);
					textareab = Ustr.indexOf("TEXTAREA");
					chkbx = Ustr.indexOf("CHECKBOX");
					button = Ustr.indexOf("BUTTON");
					textareae = Ustr.indexOf("/TEXTAREA");
//					fname=temp.getKey(start);

					if(button != -1)  out.println(str);
					else
					{
						if(input != -1 && chkbx == -1)			//if it is a input box insert the value
						{	//out.print("chkbx :"+chkbx);
							//now check if it is checkbox
							if(Ustr.indexOf("TESTDATE") > 0 || Ustr.indexOf("ENTRYDATE") > 0)
							{   
								out.print(str.substring(0,input-1));
								out.println("<B>:</B>&nbsp;&nbsp;"+ data.substring(8,10)+"-"+data.substring(5,7)+"-"+data.substring(0,4));
								out.print(str.substring(epoint+1));
							}
							else
							{
								out.print(str.substring(0,input-1));
								out.print("<B>:</B>&nbsp;&nbsp;<Font color=brown>"+ data+"</font> &nbsp;");
								out.print(str.substring(epoint+1));
							}
						}
						else
						{
							if(chkbx != -1)
							{	
								out.print(str.substring(0,input-1));
								if(data.equalsIgnoreCase("checked")) out.print("<Font color='RED'> + </font>");
								else out.print("<Font color='MAGENTA'> x </font>");
								out.print(str.substring(epoint+1));
							}

						}

						if(textareab != -1)			//if it is a textarea box insert the value
						{
							out.print(str.substring(0,textareab-1) );
							out.print("<B>:</B>&nbsp;&nbsp;"+data);
							out.print(str.substring(textareae+10));
						}
						got=-1;input=-1;textareab=-1;epoint=-1;textareae=-1;chkbx=-1;		// reset all the values
						start++;

					}	//else
				} // end of (got != -1)	
				else{  
					
					  sk_string=str.replaceAll("BORDER=1","class='table table-bordered'");
			  //sk_string=sk_string+str.replaceAll("","class='table'");
						sk_string=sk_string.replaceAll("border=1","class='table table-bordered'");
			 out.println(sk_string);
						//out.println(str); 
						//if((iData.equalsIgnoreCase("TESTDATE") || iData.equalsIgnoreCase("ENTRYDATE"))) start++;
				}
				data="";
				fname="";
				str="";
			   } //end of else of ((char) i != '\n')
			}while(i!=-1);
			fin.close();
		}
	   }
	}catch(Exception e)
	{
		out.print("iData "+ iData + "Data "+ data + "<BR>: "+e );
		
	}
	
%>
