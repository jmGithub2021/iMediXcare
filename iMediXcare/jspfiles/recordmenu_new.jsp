<%@page language="java" import="java.util.Date,java.util.HashMap,imedix.rcDisplayData,imedix.rcItemlistInfo,java.net.URLEncoder,imedix.cook,imedix.myDate,java.rmi.*,java.sql.*,imedix.dataobj,java.util.*,org.json.simple.JSONObject,org.json.simple.parser.JSONParser,org.json.simple.JSONArray, imedix.Crypto, javax.crypto.*, java.net.URLEncoder, java.nio.charset.StandardCharsets" %>
<%@ include file="..//includes/chkcook.jsp" %>
<%
	String id="";

	rcItemlistInfo rcIlist = new rcItemlistInfo(request.getRealPath("/"));

	cook cookx = new cook();
	id = cookx.getCookieValue("patid", request.getCookies());
    SecretKey cryptoKey = getSecretKey(session);
    Crypto crypto = new Crypto(cryptoKey);

	//String dat = myDate.getCurrentDate("dmy",false);
	//out.println(id);
	//out.println(dat);
/*
	HashMap array=rcIlist.getVisitList(id);
	Object ImageList=array.get("ImageList");
	Object DicomList=array.get("DicomList");
	Object DocList=array.get("DocList");
	Object MovieList=array.get("MovieList");
	Object AdviceList_a=array.get("AdviceList_a");
	Object AdviceList_p=array.get("AdviceList_p");
	Object visiton=(String)array.get("visiton");
	String dt1=(String)array.get("dt1");
	String dt2=(String)array.get("dt2");
	String year=(String)array.get("year");
*/

%>
<%!
public String imageList(Object ImageList,String id,String dt1,String dt2,rcItemlistInfo rcIlist, Crypto crypto) throws RemoteException,SQLException
{
	String maxendt="",maxendt1="",wprn="";
	String output1="";
	int cnt=1;
	Vector tmpv = (Vector)ImageList;
		if(tmpv.size()>0){
		output1 += "<div class='table-responsive'><table class='visitRecList images table table-bordered'><thead><tr><td colspan='5' align='center'>Images</td></tr><tr><th>TITLE</th><th>DESCRIPTION</th><th>DOCTOR NAME</th><th>LAB. NAME</th><th>VIEW</th></tr></thead><tbody>";

       	for(int i=0;i<tmpv.size();i++){

			dataobj tmpdata = (dataobj) tmpv.get(i);


		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());


			Object res1=rcIlist.getListOfImagesDtl(id,tmpdata.getValue("type"),dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String fdt=dt.replaceAll("/","");

						//String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String pty = tmpdata1.getValue("type").trim();
						String psl = tmpdata1.getValue("serno").trim();
						String dsl=psl;

						String reportName = rcIlist.getImageDesc(pty);

						String cnttype = tmpdata1.getValue("con_type").trim();
						String ext = tmpdata1.getValue("ext").trim();

						String imgdesc = tmpdata1.getValue("imgdesc").trim();
						String doc_name = tmpdata1.getValue("doc_name").trim();
						String lab_name = tmpdata1.getValue("lab_name").trim();

						if (psl.length()<2) dsl = "0" + psl;

						if(pty.equalsIgnoreCase("TEG")){
							wprn = "<A Href='showecg.jsp?frm=N&mtype=nomark&id="+pid+"&ty="+pty+"&ser="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 8.5pt' Target='_blank'>ECG"+dsl+"</A>";
							output1+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/ecg.jpg' Width=25 Height=30 Valign=Bottom>"+wprn+"</TD></tr>";
						}else{
							if(cnttype.equalsIgnoreCase("LRGFILE")){
								String fname=pid+fdt+pty+psl+"."+ext;
								String fpath="getFile.jsp?file="+URLEncoder.encode(crypto.encrypt("/data/"+id+"/"+fname), StandardCharsets.UTF_8);

								wprn="<IMG SRC='"+fpath+"' Width=25 Height=30 >";
								output1+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD Width=25 Height=30 Valign=Bottom><A Href='showimage.jsp?mtype=nomark&id="+pid+"&type="+pty+"&ser="+psl+"&dt="+pdt+"' Target='_blank'>"+wprn+"</A></TD></tr>";
							}else{
								wprn="<IMG SRC='displayimg.jsp?id="+pid+"&ser="+psl+"&type="+pty+"&dt="+pdt+"' Width=25 Height=30 >";
								output1+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD Width=25 Height=30 Valign=Bottom><A Href='showimage.jsp?mtype=nomark&id="+pid+"&type="+pty+"&ser="+psl+"&sn="+psl+"&dt="+pdt+"' Target='_blank'>"+wprn+"</A></TD></tr>";
							}

						}

					cnt=cnt+1;
					if (cnt>4) {
						output1 += "";
						cnt=1;
					}
			} //end of for1

       	  }// for
       	output1 +="</tbody></table></div>";
       	}//if
				return output1;
}
%>
<%!
public String dicomList(Object DicomList,String id,String dt1,String dt2,rcItemlistInfo rcIlist)throws RemoteException,SQLException
{
		String maxendt_2="",maxendt1_2="",wprn_2="";
    String output2="";
    int cnt=1;

	 	Vector tmpv_2 = (Vector)DicomList;
		if(tmpv_2.size()>0){
		output2 += "<div class='table-responsive'><table class='visitRecList dicoms table table-bordered'><thead><tr><td colspan='5' align='center'>DICOM</td></tr><tr><th>TITLE</th><th>DESCRIPTION</th><th>DOCTOR NAME</th><th>LAB. NAME</th><th>VIEW</th></tr></thead><tbody>";

       	for(int i=0;i<tmpv_2.size();i++){

			dataobj tmpdata = (dataobj) tmpv_2.get(i);

		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());

			Object res1=rcIlist.getListOfDicomsDtl(id,dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();

						String reportName = rcIlist.getImageDesc(pty);
						String imgdesc = tmpdata1.getValue("imgdesc").trim();
						String doc_name = tmpdata1.getValue("doc_name").trim();
						String lab_name = tmpdata1.getValue("lab_name").trim();

						String dsl=psl;
						if (psl.length()<2) dsl = "0" + psl;

						wprn_2 = "<A HREF='showdicom.jsp?mtype=nomark&id="+pid+"&ser="+psl+"&type="+pty+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; ' target='_blank'>"+pty+dsl+"</A>";
						output2+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/dicom.jpg' Width=25 Height=30 Valign=Bottom>"+wprn_2+"</TD>";

					cnt=cnt+1;
					if (cnt>4) {
						output2 += "";
						cnt=1;
					}
			} //end of for1

       	  }// for
       	output2 +="</tbody></table></div>";
       	}//if
				return output2;
}
%>
<%!
public String docList(Object DocList,String id,String dt1,String dt2,rcItemlistInfo rcIlist,String path)throws RemoteException,SQLException
{
		String maxendt_3="",maxendt1_3="",wprn_3="";
		String output3="";
		int cnt=1;
    Vector tmpv_3 = (Vector)DocList;
		if(tmpv_3.size()>0){
			output3+="<div class='table-responsive'><table class='visitRecList documents table table-bordered'><thead><tr><td colspan='5' align='center'>DOCUMENTS</td></tr><tr><th>TITLE</th><th>DESCRIPTION</th><th>DOCTOR NAME</th><th>LAB. NAME</th><th>VIEW</th></tr></thead><tbody>";
		//output3 += "<table border=0 cellspacing=1 class=rpanel_tab><tr>";

       	for(int i=0;i<tmpv_3.size();i++){

			dataobj tmpdata = (dataobj) tmpv_3.get(i);
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());

			Object res1=rcIlist.getListOfDocumentsDtl(id,tmpdata.getValue("type"),dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();
						String dsl=psl;
						String reportName = rcIlist.getImageDesc(pty);
						String img_desc = tmpdata1.getValue("imgdesc").trim();
						String doc_name = tmpdata1.getValue("doc_name").trim();
						String lab_name = tmpdata1.getValue("lab_name").trim();

						if (psl.length()<2) dsl = "0" + psl;

						if(pty.equalsIgnoreCase("TEG")){
							wprn_3 = "<A Href=\'showecg.jsp?patid="+pid+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 8.5pt' target='_blank'>ECG"+dsl+"</A>";
							//output3+="<TD BackGround='../images/ecg.jpg' Width=25 Height=30 Valign=Bottom>"+wprn_3+"</TD>";
							output3+="<tr><td>"+reportName+"</td><td>"+img_desc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/ecg.jpg' Width=25 Height=30 Valign=Bottom>"+wprn_3+"</TD></tr>";
						}else if (pty.equalsIgnoreCase("snd")) {
							wprn_3 = "<A HREF='playsound.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target='_blank'>"+pty+dsl+"</A>";
							//output3+="<TD BackGround='../images/sound.jpg' Width=25 Height=30 Valign=Bottom>"+wprn_3+"</TD>";
							output3+="<tr><td>"+reportName+"</td><td>"+img_desc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/sound.jpg' Width=25 Height=30 Valign=Bottom>"+wprn_3+"</TD></tr>";
						}else if (pty.equalsIgnoreCase("doc")) {
							rcDisplayData ddinfo=new rcDisplayData(path);
							Vector AllDataDoc=(Vector)ddinfo.getDocumentdetailsOthers(pid,pdt,pty,psl);
					 	 Object resu =(Object)AllDataDoc.get(0);
						 String imgdesc="",labname="",docnm="";
					    if(resu instanceof String){ //data=resu.toString();
							}
					    else{
					 		Vector VTemp = (Vector)resu;
					 		dataobj dataTemp = (dataobj) VTemp.get(0);
					 		imgdesc =dataTemp.getValue("docdesc");
					 		labname = dataTemp.getValue("lab_name");
					 		docnm = dataTemp.getValue("doc_name");
					 		//String tstdat=dataTemp.getValue("testdate");
						}
							//wprn_3 = "<A HREF='docframes.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' target='_blank'>"+pty+dsl+"</A>";
							//output3+="<TD BackGround='../images/doc.jpg' Width=25 Height=30 Valign=Bottom>"+wprn_3+"</TD>";
							wprn_3 = "<A HREF='docframes.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"'  target='_blank'>"+pty+dsl+"</A>";

							output3+="<tr><td>"+reportName+"</td><td>"+imgdesc+"</td><td>"+docnm+"</td><td>"+labname+"</td><TD BackGround='../images/doc.jpg' Width=30 Height=30 Valign=Bottom>"+wprn_3+"</TD></tr>";
						}

					cnt=cnt+1;
					if (cnt>4) {
						output3 += "</TR><TR>";
						cnt=1;
					}
			} //end of for1

       	  }// for
       	//output3 +="</Table>";
				output3 +="</tbody></table></div>";
			}
			return output3;
}
%>
<%!
public String movieList(Object MovieList,String id,String dt1,String dt2,rcItemlistInfo rcIlist)throws RemoteException,SQLException
{
		String maxendt_4="",maxendt1_4="",wprn_4="";
		String output4="";
		int cnt=1;
		Vector tmpv_4 = (Vector)MovieList;
		if(tmpv_4.size()>0){
		output4 += "<div class='table-responsive'><table class='visitRecList videos table table-bordered'><thead><tr><td colspan='5' align='center'>videos</td></tr><tr><th>TITLE</th><th>DESCRIPTION</th><th>DOCTOR NAME</th><th>LAB. NAME</th><th>VIEW</th></tr></thead><tbody>";

       	for(int i=0;i<tmpv_4.size();i++){

			dataobj tmpdata = (dataobj) tmpv_4.get(i);
		//	maxendt = tmpdata.getValue("b");
		//	java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(maxendt);
		//	c1.setTime(date);
		//	maxendt=sdf.format(c1.getTime());
		//	c1.add(Calendar.DATE,-3);
		//	maxendt1=sdf.format(c1.getTime());

			Object res1=rcIlist.getListOfMoviesDtl(id,dt1,dt2);
			Vector tmpv1 = (Vector)res1;
					for(int j=0;j<tmpv1.size();j++){
						dataobj tmpdata1 = (dataobj) tmpv1.get(j);
						String pid = tmpdata1.getValue("pat_id");
						String pdt = tmpdata1.getValue("entrydate");
						String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
						String pty = tmpdata1.getValue("type").toUpperCase().trim();
						String psl = tmpdata1.getValue("serno").trim();

						String reportName = rcIlist.getImageDesc(pty);
						String movdesc = tmpdata1.getValue("movdesc").trim();
						String doc_name = tmpdata1.getValue("doc_name").trim();
						String lab_name = tmpdata1.getValue("lab_name").trim();

						String dsl=psl;
						if (psl.length()<2) dsl = "0" + psl;

						if (pty.equalsIgnoreCase("mov")) {
							wprn_4="<A HREF='viewmovie.jsp?id="+pid+"&dt="+pdt+"&ty="+pty+"&sl="+psl+"'  Style='text-decoration:none; font:Tahoma; font-weight:bold;' target='_blank'>"+pty+dsl+"</A>";
							output4+="<tr><td>"+reportName+"</td><td>"+movdesc+"</td><td>"+doc_name+"</td><td>"+lab_name+"</td><TD BackGround='../images/video.jpg' Width=35 Height=35 Valign=Bottom>" + wprn_4 + "</TD>";
						}

					cnt=cnt+1;
					if (cnt>4) {
						output4 += "";
						cnt=1;
					}
			} //end of for1

       	  }// for
       	output4 +="</tbody></table></div>";
			}
			return output4;
}
%>
<%!
public String adviceList(Object AdviceList,String id,String dt1,String dt2,rcItemlistInfo rcIlist)throws RemoteException,SQLException
{
	//System.out.println("adviceList priority called");
	String output5 = "";
	String wprn_5="";
	String code,frmView,altTag="",date1="",date2="";
	int cnt=1;

		Vector tmpv_5 = (Vector)AdviceList;
		JSONObject ar=new JSONObject();
		String all="";
		if(tmpv_5.size()>0){

			for(int i=0;i<tmpv_5.size();i++){
			dataobj tmpdata = (dataobj) tmpv_5.get(i);

			String pcn=tmpdata.getValue("par_chl");
			String pdt = tmpdata.getValue("date");
			String dt = pdt.substring(8,10)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
			String pty = tmpdata.getValue("type").toLowerCase();
			String psl = tmpdata.getValue("serno");
			String dsl=psl;
			if (psl.length()<2) dsl = "0" + psl;
			pdt=pdt.replace('-','/');

			altTag =tmpdata.getValue(10)+ ", Entry Date : (" + dt + ")";

				if(pcn.trim().equalsIgnoreCase("P") || pcn.trim().equalsIgnoreCase("N"))
				{

					if(pty.equalsIgnoreCase("pre")){
						//wprn_5 = "<script>$('."+dt1.replaceAll("/","")+"').load('dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' )</script>";
					//	System.out.println("this value is:"+i+"-----"+psl);
						//wprn_5 = "<script>$.get('dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>"+"<script>setTimeout(function() {},5000);</script>";

						//wprn_5 = "<script>setTimeout(function() {$.get('dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})},1000);</script>";
						ar.put(String.valueOf(i),"dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"");
						all+="dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+""+"###";
					//	output5 +=wprn_5;

						//out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
						cnt=cnt+1;
					}
					if(pty.equalsIgnoreCase("prs")){
						//wprn_5 = "<script>$('."+dt1.replaceAll("/","")+"').load('dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' ).appendTo()</script>";
						//wprn_5 = "<script>$.get('dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>"+"<script>setTimeout(function() {},5000);</script>";
						//wprn_5 = "<script>setTimeout(function() {$.get('dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)}),},1000);</script>";
						ar.put(String.valueOf(i),"dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"");
						all+="dispres1.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+""+"###";
						//output5 +=wprn_5;

						//out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
						cnt=cnt+1;
					}

					//wprn = "<A class='"+pty+"' HREF='writevaltext.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"' Style='text-decoration:none; font:Tahoma; font-weight:bold; font-size: 6.5pt' Target=content2 Title='"+altTag+"'>"+pty.toUpperCase()+dsl+"</A>";
					if(pty.equalsIgnoreCase("ai0")){
						//wprn_5 = "<script>$('."+dt1.replaceAll("/","")+"').load('ai0.jsp?id="+id+"&ty="+pty+"&ndt="+dt2+"&dt="+dt1+"' ).appendTo()</script>";
						//wprn_5 = "<script>$.get('ai0.jsp?id="+id+"&ty="+pty+"&ndt="+dt2+"&dt="+dt1+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>"+"<script>setTimeout(function() {},5000);</script>";

						//wprn = "<script>$.get('ai0.jsp?id="+id+"&ty="+pty+"&sl="+psl+"&dt="+pdt+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>";
						//wprn_5 = "<script>$.get('ai0.jsp?id="+id+"&ty="+pty+"&ndt="+dt2+"&dt="+dt1+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>"+"<script>setTimeout(function() {},5000);</script>";
						//wprn_5 = "<script>setTimeout(function() {$.get('ai0.jsp?id="+id+"&ty="+pty+"&ndt="+dt2+"&dt="+dt1+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)},},1000);)</script>";
						ar.put(String.valueOf(i),"ai0.jsp?id="+id+"&ty="+pty+"&ndt="+dt2+"&dt="+dt1+"");
						all+="ai0.jsp?id="+id+"&ty="+pty+"&ndt="+dt2+"&dt="+dt1+""+"###";
						//output5 +=wprn_5;

						//out.println("<TD BackGround='../images/formicon.jpg' Width=35 Height=40 Valign=Bottom>"+wprn+"</TD>");
						cnt=cnt+1;
					}

				} // if p

			if (cnt>4) {
				//out.println( "</TR><TR>");
				output5 +="";
				cnt=1;
				}
			} // for

		}
		//System.out.println("output5:"+output5);
		output5="";
		output5="<script>$.get('visitList.jsp?all="+URLEncoder.encode(all)+"&dt1="+dt1+"',function(data){$('."+dt1.replaceAll("/","")+"').append(data)})</script>";
		return output5;

}
%>

<%

			Object res=rcIlist.getVisitList(id);
			dataobj output = new dataobj();
			int count = 0;
			java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
			Calendar c1 = Calendar.getInstance();

			Vector tmpv = (Vector)res;
	       //	System.out.println("tmpv.size  ::::: " + tmpv.size());

			if(tmpv.size()>0){
				String dt2=myDate.getCurrentDate("ymd",true);
				try{
					//java.util.Date date=new java.text.SimpleDateFormat("yyyy-MM-dd").parse(dt2);
					java.util.Date dat = new java.util.Date();
					c1.setTime(dat);
					c1.add(Calendar.DATE,1);
					dt2=sdf.format(c1.getTime());
				//	System.out.println("\nNew dt2 :::"+dt2);

				}catch(Exception e){
						System.out.println("\n Error ::: "+e.toString());
				}

				String pvyear="";

				for(int i=0;i<tmpv.size();i++){
					dataobj tmpdata = (dataobj) tmpv.get(i);
					String pdt = tmpdata.getValue("visitdate");
					String prevdt="";
					//System.out.println("visitdate>>"+pdt);

					String dt1 = pdt.substring(0,4)+"/"+pdt.substring(5,7)+"/"+pdt.substring(8);
					String dtdmy = pdt.substring(8)+"/"+pdt.substring(5,7)+"/"+pdt.substring(0,4);
					String year = pdt.substring(0,4);
					if(i>0)
					{
						dataobj tmpdata2 = (dataobj) tmpv.get(i-1);
						String pdt2 = tmpdata.getValue("visitdate");
						prevdt = pdt2.substring(0,4)+"/"+pdt2.substring(5,7)+"/"+pdt2.substring(8);
					}

					if(!pvyear.equalsIgnoreCase(year)){
						output.add("year", year);
						//array.put("year",year);
						pvyear=year;
					}
					//System.out.println("visitdate>>"+pdt);
					Date d1=new Date();
					System.out.println("PROFILING>recordmenu_new.jsp started at (ms):-"+d1.getTime());
					System.out.println("PROFILING>recordmenu_new.jsp>ItemListInfo>getImageListTable call RMI started at (ms):-"+d1.getTime());
					Object ImageList=rcIlist.getImagesListTable(id, dt1, dt2);

					Date d2=new Date();
					System.out.println("PROFILING>recordmenu_new.jsp>ItemListInfo>getDicomListTable call RMI started at (ms):-"+d2.getTime());
					Object DicomList=rcIlist.getDicomListTable(id, dt1, dt2);

					Date d3=new Date();
					System.out.println("PROFILING>recordmenu_new.jsp>ItemListInfo>getDocListTable call RMI started at (ms):-"+d3.getTime());
					Object DocList=rcIlist.getDocListTable(id, dt1, dt2);

					Date d4=new Date();
					System.out.println("PROFILING>recordmenu_new.jsp>ItemListInfo>getMoviesListTable call RMI started at (ms):-"+d4.getTime());
					Object MovieList=rcIlist.getMoviesListTable(id, dt1, dt2);

					Date d5=new Date();
					System.out.println("PROFILING>recordmenu_new.jsp>ItemListInfo>getAdvicedListTable(priority-a) call RMI started at (ms):-"+d5.getTime());
					Object AdviceList_a=rcIlist.getAdvicedListTable(id,dt1,dt2,"a");

					
					Date d6=new Date();
					System.out.println("PROFILING>recordmenu_new.jsp>ItemListInfo>getAdvicedListTable(priority-p) call RMI started at (ms):-"+d6.getTime());
					Date d7=new Date();
					System.out.println("PROFILING>recordmenu_new.jsp ended at (ms):-"+d7.getTime());

					Object AdviceList_p=rcIlist.getAdvicedListTable(id,dt1,dt2,"p");
					String tempstr="<div class='advisedTest "+dt1.replaceAll("/","")+"'></div>";
					tempstr+=imageList(ImageList,id,dt1,dt2,rcIlist, crypto);
					tempstr+=dicomList(DicomList,id,dt1,dt2,rcIlist);
					tempstr+=docList(DocList,id,dt1,dt2,rcIlist,request.getRealPath("/"));
					tempstr+=movieList(MovieList,id,dt1,dt2,rcIlist);
					tempstr+=adviceList(AdviceList_a,id,dt1,dt2,rcIlist);
					tempstr+=adviceList(AdviceList_p,id,dt1,dt2,rcIlist);
					//out.println(adviceList(AdviceList_p,id,dt1,dt2,rcIlist));
					dt2=dt1;
					output.add("Visit On "+dtdmy, tempstr);
//					System.out.println("-----------------------------------------------------");
//					System.out.println("Visit On "+dtdmy);
				}
			}

			String tempstr2="";
			boolean started=false;
			dataobj obj= (dataobj)output;
			int total_visit=obj.getLength();

			//System.out.println("total_visit :"+total_visit);

	     	for (int i = 0; i <obj.getLength(); i++){
	     		String key=obj.getKey(i);
	     		String val=obj.getValue(i);
	     		if(key.equalsIgnoreCase("Year")){
					if (started) tempstr2 += "</div>";
	                tempstr2 += "<b><span onclick='show_hide(\"main_" + i + "\", " + total_visit + ")'>Year " + val + "</span></b>";
	                tempstr2 += "<div id=\"main_" + i + "\">";
	                started = true;
	     		}else{
					//int k = i+1;
					if(i==1){
						tempstr2 += "<a class='' href='Javascript:void(0)' data-toggle='collapse' data-target=\"#visit_" + i + "\">" + key + "</a>";
						tempstr2 += "<div id=\"visit_" + i + "\" class=\"collapse in\">" + val + "</div>";
					}else{
						tempstr2 += "<a class='collapsed' href='Javascript:void(0)' data-toggle='collapse' data-target=\"#visit_" + i + "\">" + key + "</a>";
						tempstr2 += "<div id=\"visit_" + i + "\" class=\"collapse\">" + val + "</div>";
						}
	     		}
	     	}

	     	if (started) tempstr2 += "</div>";

				out.println(tempstr2);

%>
