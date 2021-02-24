<%@page contentType="text/html" %>
<%@ page import="java.util.*,java.sql.*,java.util.Date,java.net.*,java.io.*,java.text.*" %>
<%@ include file="base64.jsp" %>
<%

class hlseven{

	String cCode="",cName="";
	int cntOBR=1;
	Base64 base64 = new Base64();

	Connection conn = null;
	Statement stmt = null;
	Statement stmt1 = null;
	Statement stmt2 = null;

	ResultSet rs = null;
	
	hlseven( String cCD, String cNM  ){
	cCode=cCD;
	cName=cNM;
	
	}
	public String getMSH()
	{
		String str="";
		Date cdt = new Date();	
		try{
		
str = "MSH|^~\\&|TELEMEDICINE||TELEMEDICINE||" +dateformat("yyyyMMdd",cdt) + dateformat("HHmm",cdt) + "||ORU^R01|" + cCode + "|P|2.4|";       
	    	
		}catch(Exception e){
			System.out.println("<BR><B>"+e.toString()+"</B><BR>");
			str="";
		}
	
		return str;	
	}
			
	public String getPID(String pid)
	{
		String str="",DOB="";
		int i=0;
		String ag="";
		String qSql="SELECT * FROM med WHERE PAT_ID like '" + pid + "%'";
		
		dbConnect();
		
		try{
			
			rs=stmt.executeQuery(qSql);

	    	if(rs.next()){

	    		if(rs.getDate("DATEOFBIRTH")!=null) DOB = dateformat("yyyyMMddHHmm",rs.getDate("DATEOFBIRTH"));
	    		else{
	    			if(rs.getString("AGE")!="") {
	    				Date entryDate = rs.getDate("ENTRYDATE");
					String arredate [] = entryDate.toString().split("-");

     					ag=rs.getString("AGE").trim();
					String ymdarr [] = ag.split(",");
	      				int age=0;
          				for(i=0;i<ymdarr.length;i++)
            	 	   			if(ymdarr[i].equals("") || ymdarr[i]==null ) ymdarr[i] = "0";
                			Calendar c1 = Calendar.getInstance();
                			//c1.set(entryDate.getYear(),entryDate.getMonth(),entryDate.getDay());
			c1.set(Integer.parseInt(arredate[0]),Integer.parseInt(arredate[1])-1,Integer.parseInt(arredate[2]));

                   			if(ymdarr.length>0)     c1.add(Calendar.YEAR, - Integer.parseInt(ymdarr[0]));
                			if(ymdarr.length>1)	c1.add(Calendar.MONTH, - Integer.parseInt(ymdarr[1]));
                			if(ymdarr.length>2)	c1.add(Calendar.DATE, - Integer.parseInt(ymdarr[2]));

               				Date newdate = c1.getTime();
					DOB = dateformat("yyyyMMddHHmm",newdate);
           				}
					}
		
		String patientname="",patientSex="", patientAdd1="", patientAdd2="", patientCity="", patientState="", patientCountry="", patientPIN="", patientPhone="", patientReligion="";
        String firstname="", lastname="", restofname="";
        
        if(rs.getString("PAT_NAME")!=null) patientname = rs.getString("PAT_NAME").trim();
        if(rs.getString("SEX")!="") patientSex = rs.getString("SEX").trim();
        if(rs.getString("ADDLINE1")!=null) patientAdd1 = rs.getString("ADDLINE1").trim();
        if(rs.getString("ADDLINE2")!=null) patientAdd2 = rs.getString("ADDLINE2").trim();
        if(rs.getString("CITY")!=null) patientCity = rs.getString("CITY").trim();
        if(rs.getString("STATE")!=null) patientState = rs.getString("STATE").trim();
        if(rs.getString("COUNTRY")!=null) patientState = rs.getString("COUNTRY").trim();
        if(rs.getString("PIN")!=null) patientPIN = rs.getString("PIN").trim();
        if(rs.getString("PHONE")!=null) patientPhone = rs.getString("PHONE").trim();
        if(rs.getString("RELIGION")!=null) patientReligion = rs.getString("RELIGION").trim();
        
        String patNameArr[] = patientname.split(" ");
        for(i=0;i<patNameArr.length;i++){
        	if(i== 0) firstname = patNameArr[i];
        	else if(i>0 && i<patNameArr.length-1) restofname = restofname + " " + patNameArr[i];
        		 else lastname = patNameArr[i];		
        		
        }
         restofname = restofname.trim();
        lastname=lastname.trim();
           
        str = "PID|||" + pid + "||" + lastname + "^" + firstname + "^" + restofname + "||" + DOB + "|" + patientSex + "|||";
        str = str + patientAdd1 + "^" + patientAdd2 + "^" + patientCity + "^" + patientState + "^" + patientPIN + "^" + patientCountry + "|91|";
        str = str + patientPhone + "||||" + patientReligion + "|";
	    }  	
	    rs.close();
		}catch(Exception e){
			System.out.println("<BR><B>"+e.toString()+"</B><BR>");
			str="Error On getPID "+e.toString()+(char)13 + "sql:" +qSql + " " + ag;
		}
	
		dbClose();
		
		return str;
	}
	
	public String getNK1(String pid){
	
	String str="",nkPerson="", nkRelation="", nkAddress="";	
	int i=0;
	String qSql="SELECT PAT_PERSON, PAT_RELATION,PAT_PERSON_ADD  FROM med WHERE PAT_ID like '" + pid + "%'";
	dbConnect();

	//System.out.println(qSql);

	try{
	    rs=stmt.executeQuery(qSql);
	    if(rs.next()){

	    	if(rs.getString("PAT_PERSON")!=null) nkPerson = rs.getString("PAT_PERSON").trim();
	    	if(rs.getString("PAT_RELATION")!=null) nkRelation = rs.getString("PAT_RELATION").trim();
		if(rs.getString("PAT_PERSON_ADD")!=null) {
	    			nkAddress = rs.getString("PAT_PERSON_ADD").trim();
	    			String x= "";
	    			x=x+(char)13 +(char)10;

				nkAddress=nkAddress.replaceAll(x, " " );
				x="";
				x=x+(char)13;
	    			nkAddress=nkAddress.replace(x, " " );
				x="";
				x=x+(char)10;
	    			nkAddress=nkAddress.replace(x, " " );

	    		}

	    	// if(!nkPerson.equals("") || !nkRelation.equals("") || !nkAddress.equals(""))

    			str = "NK1|1|" + nkPerson + "|" + nkRelation + "|" + nkAddress + "|";
	    	}
	  	rs.close();
	  		
	}catch(Exception e){
		System.out.println("<BR><B>"+e.toString()+"</B><BR>");
		str="Error On getNK1 "+e.toString()+(char)13 + "sql:" +qSql;
	}

	dbClose();    		
	return str;
   }
public String getOBROBX(String pid){

	String str="";
	String x= "";
		
	ResultSet rsfrm = null;
	ResultSet rsobr = null;
	ResultSet rstemp = null;

	String strtmp="", DT="", tempval="", obx5="", obx6="";
	int cntOBX=0,repeat=0;
	//cntOBR=0,
    String batCode="",batname="";
    Date cdt = new Date();	
    DT=dateformat("yyyyMMdd",cdt)+dateformat("HHmm",cdt);
    repeat = 0;
    String qSql="SELECT TYPE, SERNO FROM LISTOFFORMS WHERE upper(PAT_ID) = '"+pid.toUpperCase() +"' AND TYPE NOT IN('med', 'pre', 'prs', 'smr') ORDER BY TYPE, SERNO";
	
	dbConnect();
			
	try{
		rsfrm=stmt.executeQuery(qSql);
	    if(rsfrm.next()){
	        while(!rsfrm.isAfterLast()){
	        
	       	strtmp = "";
	    	qSql="SELECT * FROM obxmapper WHERE db_table ='" + rsfrm.getString("TYPE")+"'";
	    	rsobr=stmt1.executeQuery(qSql);
	    	
	    	if(rsobr.next()){
	        while(!rsobr.isAfterLast()){
	        	
	        
	    	batCode = rsobr.getString("obsrv_batterycode");
            	batname = rsobr.getString("obsrv_battery");           	
            	qSql="SELECT " + rsobr.getString("db_field").trim()+ ", testdate, serno FROM " + rsobr.getString("db_table").trim() + " WHERE upper(PAT_ID)='" + pid.toUpperCase() + "' AND serno = '" + rsfrm.getString("serno").trim() + "'";
	    	    rstemp=stmt2.executeQuery(qSql);

	    	    if(rstemp.next()){
	    	  	while(!rstemp.isAfterLast()){
	    	  		tempval = "";
   				if (rstemp.getString(1)!=null) tempval = rstemp.getString(1).trim();
                		if(!tempval.equals("")){
                 			x= "";
	    				x=x+(char)13 +(char)10;
					tempval=tempval.replaceAll(x, " " );
	    				tempval=tempval.replace((char)13, ' ' );
	    				tempval=tempval.replace((char)10, ' ' );
	    			}
	    			
	    			if(rsobr.getInt("comp_seq")>1 ){
	    				repeat = rsobr.getInt("comp_seq") - 1;
	    			}

			if (rsobr.getString("db_field").equalsIgnoreCase("APPTDATE") || rsobr.getString("db_field").equalsIgnoreCase("ENTRYDATE")){
		  	tempval = tempval.replace("-","");
		  	}

                
                   // obx5 = Integer.toString(repeat)+"^" + tempval.trim();
			obx5 = createStr(repeat,"^") + tempval.trim();
                	if(!rsobr.getString("obsrv_unit").equals("")){
                		 obx6 = "^" + rsobr.getString("obsrv_unit").trim();
                	}

                	//Date tdt = rstemp.getDate("testdate");
			String tstdt = rstemp.getString("testdate");
			tstdt=tstdt.replace("-","" );

                    strtmp = strtmp + (char)13 + "OBX||" + rsobr.getString("data_type").trim() + "|" + rsobr.getString("loinc_code").trim() + "^" + rsobr.getString("obsrv_name").trim() + "^LN|" + rstemp.getString("serno").trim() + "|" + obx5 + "|" + obx6 + "|||||F|||" + tstdt + "|";  ///dateformat("yyyyMMdd",tdt)

           		 //cntOBX = cntOBX + 1
           		 
					rstemp.next();
					
	    	  	   } // end while
	    	  	   }
	    	  	  
	    	  	   
	    	  	   rstemp.close();
	    	  	  
	    	  	  
	    	  	   
				 rsobr.next();	

              } //end while
             
                 strtmp=strtmp.trim();
               
              if(!strtmp.equals("")){
              	str = str + (char)13+ "OBR" + "|" + Integer.toString(cntOBR) + "|||" + batCode + "^" + batname + "^HL7IITKGP|||" + DT + "|" + strtmp;
        		cntOBR = cntOBR + 1;
               }
             
             } // if 
             
             rsobr.close();
            
			rsfrm.next();
		
			
	      }// end while rsfrm	
	    }// if 1st
	    
	   rsfrm.close();
	   
	 }catch(Exception e){
		//System.out.println("Error getOBROBX : "+e.toString());
		//System.out.println("Sql : "+qSql);	
		str="Error getOBROBX : "+ e.toString()+ (char)13 + "sql:" +qSql;
	}	 
   	dbClose();    		
	//str=Mid(str, 2)
	
	return str;	
   }
	
public String getUnmapped(String pid){
	
	String str="";
	String x= "";
	ResultSet rsobr = null;
	ResultSet rstemp = null;
	String strtmp="", DT="", tempval="", obx5="";
    int cntOBX=0, repeat=0;
    
    Date cdt = new Date();

    DT=dateformat("yyyyMMdd",cdt);
    
	dbConnect();		
	String qSql="SELECT * FROM obxmapper WHERE obsrv_batterycode LIKE 'ZIITKGP991%' ORDER BY db_table, obsrv_batterycode";
	try{
		rsobr=stmt.executeQuery(qSql);
	   	if(rsobr.next()){
	   	while(!rsobr.isAfterLast()){
			qSql="SELECT " + rsobr.getString("db_field").trim().toUpperCase() + " FROM " + rsobr.getString("db_table").trim() + " WHERE upper(PAT_ID)='" + pid.toUpperCase()+ "'";
				rstemp=stmt1.executeQuery(qSql);
				if(rstemp.next()){
	   			while(!rstemp.isAfterLast()){
	    	  		tempval = "";
				if (rstemp.getString(1)!=null) tempval = rstemp.getString(1).trim();
	                 	if(!tempval.equals("")){
                 		x= "";
	    				x=x+(char)13 +(char)10;
					tempval=tempval.replaceAll(x, " " );
	    				tempval=tempval.replace((char)13, ' ' );
	    				tempval=tempval.replace((char)10, ' ' );
	    			}
	    			
	    			if(rsobr.getInt("comp_seq")>1 ){
	    				repeat = rsobr.getInt("comp_seq") - 1;
	    			}
                   // obx5 = Integer.toString(repeat)+"^" + tempval.trim();
			if (rsobr.getString("db_field").equalsIgnoreCase("APPTDATE") || rsobr.getString("db_field").equalsIgnoreCase("ENTRYDATE")){
		  	tempval = tempval.replace("-","");
		  	}
		   obx5 = createStr(repeat,"^") + tempval.trim();

 		strtmp = strtmp + (char)13 + "OBX||" + rsobr.getString("data_type").trim() + "|" + rsobr.getString("loinc_code").trim() + "^" + rsobr.getString("obsrv_name").trim() + "^HL7IITKGP||" +  obx5 + "||||||F|||" + dateformat("yyyyMMdd",cdt) + "|";

                	//cntOBX = cntOBX + 1
                	rstemp.next();
                	
	    	  	} // END WHILE
	    	  	 }
	    	  	rstemp.close();

			 rsobr.next();
	    	  	} // END WHILE

	    		if(!strtmp.equals("")){
              		str = str + (char)13 + "OBR" + "|" + Integer.toString(cntOBR) + "|||IITKGP9910^Unmapped Local Data^HL7IITKGP|||" + DT + "|" + strtmp;
        		cntOBR = cntOBR + 1;
            	}
            	} // if
	   			rsobr.close();
	}catch(Exception e){
		//System.out.println("Error getUnmapped : "+e.toString());
		//System.out.println("Sql : "+qSql);

		str="Error getUnmapped : "+e.toString()+(char)13 + "sql:" +qSql;
	}	 
	dbClose();   
	//str=Mid(str, 2)
	
	return str;

	}


public void getCdaAttachment(String pid,String fn){

	String str="",str1="";
	String DT="", fileName="",filePath1="", filePath2="", tempDesc="";
	String MIMEHead="",MIMEdata="";
    int cntOBX=0;
    boolean docBool=false, sndBool=false, othrBool=false;
    ResultSet rsfile = null;
	ResultSet rstemp = null;

	try{
		FileWriter hl7file = new FileWriter(fn, true);
   		BufferedWriter hl7out = new BufferedWriter(hl7file);

	Date cdt = new Date();
    DT=dateformat("yyyyMMdd",cdt)+ dateformat("HHmm",cdt);

    MIMEHead = "^multipart^related^A^" + "MIME-Version: 1.0" + (char)13 + (char)10;
	MIMEHead =MIMEHead + "Content-Type: multipart/related; boundary=\"HL7-CDA-border-CDA-HL7\"";

    dbConnect();

	String qSql="SELECT * FROM PATDOC WHERE PAT_ID='" + pid + "' ORDER BY TYPE, ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
	   		while(!rsfile.isAfterLast()){
	   			if(rsfile.getString("TYPE").equalsIgnoreCase("DOC")){
	   				if(docBool== false ){
	   				 str = (char)13 + "OBR" + "|" + Integer.toString(cntOBR) + "|||ZIITKGP9900^Patient Documents^HL7IITKGP|||" + DT + "|";
            		 cntOBX = 1;
            		 cntOBR = cntOBR + 1;
            		 docBool = true;
	   				}
	   				else str="";
				fileName = pid + modifyStr(dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE")))+ modifyStr(rsfile.getString("TYPE").trim()) + modifyStr(rsfile.getString("SERNO").trim()) + "." + modifyStr(rsfile.getString("EXT").trim());

				//str = str + (char)13 + "TXA||" + rsfile.getString("DOCDESC") + "||" + DT + "|"+ rsfile.getString("DOC_NAME")+"|"+rsfile.getString("TESTDATE")+"|||"+rsfile.getString("LAB_NAME")+"|||ZIITKGP9900-"+ Integer.toString(cntOBX) + "|ZIITKGP9900|";

				str = str + (char)13 + "TXA||" + modifyStr(rsfile.getString("DOCDESC")) + "||" + DT + "|"+ modifyStr(rsfile.getString("DOC_NAME"))+"|"+  getdatymd(modifyStr(rsfile.getString("TESTDATE"))) +"|||" + modifyStr(rsfile.getString("LAB_NAME"))+"|||ZIITKGP9900-"+ Integer.toString(cntOBX) + "|ZIITKGP9900|";
				 //modifyStr(dateformat("yyyyMMdd",rsfile.getDate("TESTDATE")))

 			MIMEdata = MIMEHead + (char)13 + (char)10 + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"EXT:=" + modifyStr(rsfile.getString("EXT").trim()) + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"TYPE:=" + modifyStr(rsfile.getString("TYPE").trim()) + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"SERNO:=" + modifyStr(rsfile.getString("SERNO").trim()) + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"ENTRYDATE:=" +  getdatymd(modifyStr(rsfile.getString("ENTRYDATE"))) + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"SIZE:=" + modifyStr(rsfile.getString("SIZE").trim()) + (char)13 + (char)10 ;
			Blob blob = rsfile.getBlob("PATDOC");
			int length = (int)blob.length();
			byte [] _blob = blob.getBytes(1, length);

			MIMEdata = MIMEdata+"--HL7-CDA-border-CDA-HL7" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Location:" + fileName + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Transfer-Encoding:BASE64" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Type:" + modifyStr(rsfile.getString("CON_TYPE").trim())+ (char)13 + (char)10 + (char)13 + (char)10;
			MIMEdata = MIMEdata+base64.encode(_blob)+ (char)13 + (char)10+"--HL7-CDA-border-CDA-HL7--";
			str = str +(char)13 + "OBX||ED|ZIITKGP9900-" + Integer.toString(cntOBX)+ "^" +modifyStr(rsfile.getString("DOCDESC").trim())+"^HL7IITKGP||" + MIMEdata + "||||||X|||" + DT + "|";

			hl7out.write(str);

	   		  }else {
	   		  	if(rsfile.getString("TYPE").equalsIgnoreCase("SND")){
               	if(sndBool== false ){
	   				str = (char)13 + "OBR" + "|" + Integer.toString(cntOBR) + "|||ZIITKGP9901^Patient Audios^HL7IITKGP|||" + DT + "|";
            		cntOBX = 1;
            		cntOBR = cntOBR + 1;
            		sndBool = true;
	   				}//if sndBool
	   				else str="";

	   		    fileName = pid + modifyStr(dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE")))+ modifyStr(rsfile.getString("TYPE").trim()) + modifyStr(rsfile.getString("SERNO").trim()) + "." + modifyStr(rsfile.getString("EXT").trim());

//str = str + (char)13 + "TXA||" + rsfile.getString("DOCDESC") + "||" + DT + "|"+ rsfile.getString("DOC_NAME")+"|"+rsfile.getString("TESTDATE")+"|||"+rsfile.getString("LAB_NAME")+"|||ZIITKGP9901-"+ Integer.toString(cntOBX) + "|ZIITKGP9901|";

str = str + (char)13 + "TXA||" + modifyStr(rsfile.getString("DOCDESC")) + "||" + DT + "|"+ modifyStr(rsfile.getString("DOC_NAME"))+"|"+getdatymd(modifyStr(rsfile.getString("TESTDATE"))) + "|||" +modifyStr(rsfile.getString("LAB_NAME"))+"|||ZIITKGP9901-"+ Integer.toString(cntOBX) + "|ZIITKGP9901|";

 			MIMEdata = MIMEHead + (char)13 + (char)10 + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"EXT:=" + modifyStr(rsfile.getString("EXT")).trim() + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"TYPE:=" + modifyStr(rsfile.getString("TYPE")).trim() + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"SERNO:=" + modifyStr(rsfile.getString("SERNO")).trim() + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"ENTRYDATE:=" + getdatymd(modifyStr(rsfile.getString("ENTRYDATE"))) + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"SIZE:=" + modifyStr(rsfile.getString("SIZE")).trim() + (char)13 + (char)10 ;
			Blob blob = rsfile.getBlob("PATDOC");
				int length = (int)blob.length();
				byte [] _blob = blob.getBytes(1, length);

			MIMEdata = MIMEdata+"--HL7-CDA-border-CDA-HL7" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Location:" + fileName + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Transfer-Encoding:BASE64" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Type:" + modifyStr(rsfile.getString("CON_TYPE")).trim()+ (char)13 + (char)10 + (char)13 + (char)10;
			MIMEdata = MIMEdata+base64.encode(_blob)+ (char)13 + (char)10+"--HL7-CDA-border-CDA-HL7--";
			str = str +(char)13 + "OBX||ED|ZIITKGP9901-" + Integer.toString(cntOBX)+ "^" +modifyStr(rsfile.getString("DOCDESC")).trim()+"^HL7IITKGP||" + MIMEdata + "||||||X|||" + DT + "|";
			hl7out.write(str);

	   		    }else{
				   	if(othrBool== false ){
						str = (char)13 + "OBR" + "|" + Integer.toString(cntOBR) + "|||ZIITKGP9902^Other Patient Attachments^HL7IITKGP|||" + DT + "|";
			            cntOBX = 1;
			            cntOBR = cntOBR + 1;
			            othrBool = true;
			         }else str="";

				fileName = pid + modifyStr(dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE")))+ modifyStr(rsfile.getString("TYPE")).trim() + modifyStr(rsfile.getString("SERNO")).trim() + "." + modifyStr(rsfile.getString("EXT")).trim();

				//str = str + (char)13 + "TXA||" + modifyStr(rsfile.getString("DOCDESC")) + "||" + DT + "|"+ modifyStr(rsfile.getString("DOC_NAME"))+"|"+ modifyStr(rsfile.getString("TESTDATE")) + "|||" + modifyStr(rsfile.getString("LAB_NAME")) + "|||ZIITKGP9902-"+ Integer.toString(cntOBX) + "|ZIITKGP9902|";

		str = str + (char)13 + "TXA||" + modifyStr(rsfile.getString("DOCDESC")) + "||" + DT + "|"+ modifyStr(rsfile.getString("DOC_NAME"))+"|"+ getdatymd(modifyStr(rsfile.getString("TESTDATE"))) + "|||" + modifyStr(rsfile.getString("LAB_NAME")) + "|||ZIITKGP9902-"+ Integer.toString(cntOBX) + "|ZIITKGP9902|";

 			MIMEdata = MIMEHead + (char)13 + (char)10 + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"EXT:=" + modifyStr(rsfile.getString("EXT")).trim() + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"TYPE:=" + modifyStr(rsfile.getString("TYPE")).trim() + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"SERNO:=" + modifyStr(rsfile.getString("SERNO")).trim() + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"ENTRYDATE:=" + getdatymd(modifyStr(rsfile.getString("ENTRYDATE"))) + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"SIZE:=" + modifyStr(rsfile.getString("SIZE")) + (char)13 + (char)10 ;
				Blob blob = rsfile.getBlob("PATDOC");
				int length = (int)blob.length();
				byte [] _blob = blob.getBytes(1, length);

			MIMEdata = MIMEdata+"--HL7-CDA-border-CDA-HL7" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Location:" + fileName + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Transfer-Encoding:BASE64" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Type:" + modifyStr(rsfile.getString("CON_TYPE").trim())+ (char)13 + (char)10 + (char)13 + (char)10;
			MIMEdata = MIMEdata+base64.encode(_blob)+ (char)13 + (char)10+"--HL7-CDA-border-CDA-HL7--";
			str = str +(char)13 + "OBX||ED|ZIITKGP9902-" + Integer.toString(cntOBX)+ "^" +modifyStr(rsfile.getString("DOCDESC").trim())+"^HL7IITKGP||" + MIMEdata + "||||||X|||" + DT + "|";
	   		hl7out.write(str);
	   		   }
            } // else

        cntOBX = cntOBX + 1;
        rsfile.next();

	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();

	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT Patdoc : "+e.toString());
		//System.out.println("Sql : "+qSql);
	}

	//////////////////////////////

	qSql="SELECT * FROM PATIMAGES WHERE PAT_ID='" + pid + "' ORDER BY ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
	   	str = (char)13 + "OBR" + "|" + Integer.toString(cntOBR) + "|||ZIITKGP9903^Patient Images^HL7IITKGP|||" + DT + "|";
		cntOBR = cntOBR + 1;
    		cntOBX = 1;
	   	 while(!rsfile.isAfterLast()){

	   		 	qSql="SELECT DESCRIPTION FROM FORMS WHERE CODE = '" + rsfile.getString("TYPE").trim() + "'";
	   		 	rstemp=stmt1.executeQuery(qSql);
	   			tempDesc="";
	   			if(rstemp.next()){
	   				tempDesc = rstemp.getString("DESCRIPTION");
	   			}
	   			if(tempDesc.equals(""))	tempDesc = modifyStr(rsfile.getString("IMGDESC"));

	  			fileName = pid + modifyStr(dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE")))+ modifyStr(rsfile.getString("TYPE").trim()) + modifyStr(rsfile.getString("SERNO").trim()) + "." + modifyStr(rsfile.getString("EXT").trim());
	  			str = str + (char)13 + "TXA||" + modifyStr(tempDesc) + "||" + DT + "|" + modifyStr(rsfile.getString("DOC_NAME")) + "|" + getdatymd(modifyStr(rsfile.getString("TESTDATE"))) + "|||" +modifyStr(rsfile.getString("LAB_NAME")) + "|||ZIITKGP9903-" + Integer.toString(cntOBX) + "|ZIITKGP9903|";

				MIMEdata = MIMEHead + (char)13 + (char)10 + (char)13 + (char)10 ;
 				MIMEdata = MIMEdata+"EXT:=" + rsfile.getString("EXT").trim() + (char)13 + (char)10 ;
 				MIMEdata = MIMEdata+"TYPE:=" + rsfile.getString("TYPE").trim() + (char)13 + (char)10 ;
 				MIMEdata = MIMEdata+"SERNO:=" + rsfile.getString("SERNO").trim() + (char)13 + (char)10 ;
 				MIMEdata = MIMEdata+"FORMKEY:=" + modifyStr(rsfile.getString("FORMKEY")) + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"ENTRYDATE:=" + getdatymd(modifyStr(rsfile.getString("ENTRYDATE"))) + (char)13 + (char)10 ;
 				MIMEdata = MIMEdata+"SIZE:=" + modifyStr(rsfile.getString("SIZE").trim()) + (char)13 + (char)10 ;
				Blob blob = rsfile.getBlob("image");
				int length = (int)blob.length();
				byte [] _blob = blob.getBytes(1, length);

			MIMEdata = MIMEdata+"--HL7-CDA-border-CDA-HL7" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Location:" + fileName + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Transfer-Encoding:BASE64" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Type:" + modifyStr(rsfile.getString("CON_TYPE").trim())+ (char)13 + (char)10 + (char)13 + (char)10;
			MIMEdata = MIMEdata+base64.encode(_blob)+ (char)13 + (char)10+"--HL7-CDA-border-CDA-HL7--";
			str=str + (char)13 + "OBX||ED|ZIITKGP9903-" + Integer.toString(cntOBX) + "^" + modifyStr(tempDesc) + "^HL7IITKGP||" + MIMEdata + "||||||X|||" + DT + "|";
			hl7out.write(str);

	   		str="";
	   		cntOBX = cntOBX + 1;
        	rstemp.close();
            rsfile.next();
	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();
	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT PatImages : "+e.toString());
		//System.out.println("Sql : "+qSql);

		hl7out.write("Error getATTACHMENT PatImages : "+e.toString());

	}

	//////////////////

	qSql="SELECT * FROM refimages WHERE PAT_ID='" + pid + "' ORDER BY ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
		 	 str = (char)13 + "OBR" + "|" + Integer.toString(cntOBR) + "|||ZIITKGP9905^Patient Reffered Images^HL7IITKGP|||" + DT + "|";
    		 cntOBR = cntOBR + 1;
    		 cntOBX = 1;

	   		 while(!rsfile.isAfterLast()){

	   		 qSql="SELECT DESCRIPTION FROM FORMS WHERE CODE = '" + rsfile.getString("TYPE").trim() + "'";
	   		 	rstemp=stmt1.executeQuery(qSql);

	   		 	tempDesc="";
	   			if(rstemp.next()){
	   				tempDesc = rstemp.getString("DESCRIPTION");
	   			}
	   			if(tempDesc.equals(""))	tempDesc = rsfile.getString("IMGDESC");

			fileName = pid + modifyStr(dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE")))+ modifyStr(rsfile.getString("TYPE")).trim() + modifyStr(rsfile.getString("img_serno")).trim() + modifyStr(rsfile.getString("Ref_code").trim()) + modifyStr(rsfile.getString("SERNO")).trim() + "." + modifyStr(rsfile.getString("EXT")).trim();

	//str = str + (char)13 + "TXA||" + modifyStr(tempDesc) + "||" + DT + "|" + modifyStr(rsfile.getString("doc_name")) + "|" + modifyStr(rsfile.getString("TESTDATE")) + "|||" + modifyStr(rsfile.getString("lab_name")) + "|||ZIITKGP9905-" + Integer.toString(cntOBX) + "|ZIITKGP9905|";

str = str + (char)13 + "TXA||" + modifyStr(tempDesc) + "||" + DT + "|" + modifyStr(rsfile.getString("doc_name")) + "|" + getdatymd(modifyStr(rsfile.getString("TESTDATE"))) + "|||" + modifyStr(rsfile.getString("lab_name")) + "|||ZIITKGP9905-" + Integer.toString(cntOBX) + "|ZIITKGP9905|";

		MIMEdata = MIMEHead + (char)13 + (char)10 + (char)13 + (char)10 ;
 		MIMEdata = MIMEdata+"EXT:=" + modifyStr(rsfile.getString("EXT")).trim() + (char)13 + (char)10 ;
 		MIMEdata = MIMEdata+"TYPE:=" + modifyStr(rsfile.getString("TYPE")).trim() + (char)13 + (char)10 ;
 		MIMEdata = MIMEdata+"REF_CODE:=" + modifyStr(rsfile.getString("Ref_code").trim()) + (char)13 + (char)10 ;
 		MIMEdata = MIMEdata+"SERNO:=" + modifyStr(rsfile.getString("SERNO")).trim() + (char)13 + (char)10 ;
 		MIMEdata = MIMEdata+"IMG_SERNO:=" + modifyStr(rsfile.getString("img_serno")).trim() + (char)13 + (char)10 ;
		MIMEdata = MIMEdata+"ENTRYDATE:=" + getdatymd(modifyStr(rsfile.getString("ENTRYDATE"))) + (char)13 + (char)10 ;
		MIMEdata = MIMEdata+"SIZE:=" + modifyStr(rsfile.getString("SIZE").trim()) + (char)13 + (char)10 ;
		Blob blob = rsfile.getBlob("PATPIC");
		int length = (int)blob.length();
		byte [] _blob = blob.getBytes(1, length);

		MIMEdata = MIMEdata+"--HL7-CDA-border-CDA-HL7" + (char)13 + (char)10;
		MIMEdata = MIMEdata+"Content-Location:" + fileName + (char)13 + (char)10;
		MIMEdata = MIMEdata+"Content-Transfer-Encoding:BASE64" + (char)13 + (char)10;
		MIMEdata = MIMEdata+"Content-Type:" + modifyStr(rsfile.getString("CON_TYPE").trim())+ (char)13 + (char)10 + (char)13 + (char)10;
		MIMEdata = MIMEdata+base64.encode(_blob)+ (char)13 + (char)10+"--HL7-CDA-border-CDA-HL7--";
		str=str + (char)13 + "OBX||ED|ZIITKGP9905-" + Integer.toString(cntOBX) + "^" + modifyStr(tempDesc) + "^HL7IITKGP||" + MIMEdata + "||||||X|||" + DT + "|";
		hl7out.write(str);
	   	str="";
	   	cntOBX = cntOBX + 1;
        	rstemp.close();
            rsfile.next();

	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();

	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT refimages : "+e.toString());
		//System.out.println("Sql : "+qSql);
	}

	///

	String points="";

	qSql="SELECT * FROM coord WHERE PAT_ID='" + pid + "' ORDER BY ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
		str =  (char)13 + "OBR" + "|" + Integer.toString(cntOBR) + "|||ZIITKGP9906^Patient Skinpatch Images^HL7IITKGP|||" + DT + "|";
    		 cntOBR = cntOBR + 1;
    		 cntOBX = 1;
	   	 while(!rsfile.isAfterLast()){

		fileName = pid + modifyStr(dateformat("ddMMyyyy",rsfile.getDate("entrydate")))+ modifyStr(rsfile.getString("type")).trim() + modifyStr(rsfile.getString("serno")).trim() + ".txt";
		    str = str + (char)13 + "TXA||Image Coordinates||" + DT + "||" + getdatymd(modifyStr(rsfile.getString("testdate"))) + "||||||ZIITKGP9906-" + Integer.toString(cntOBX) + "|ZIITKGP9906|";

 			MIMEdata = MIMEHead + (char)13 + (char)10 + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"TYPE:=" + rsfile.getString("type").trim() + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"SIZE:=" + modifyStr(rsfile.getString("size").trim()) + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"ENTRYDATE:=" + getdatymd(modifyStr(rsfile.getString("ENTRYDATE"))) + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"SERNO:=" + rsfile.getString("serno").trim() + (char)13 + (char)10 ;

			points=modifyStr(rsfile.getString("points"));
			//points=points.replace(',',' ');
			//points=points.replace('-','\n');
			byte b[] = new byte[points.length()];
			points.getBytes(0,b.length,b,0);

			MIMEdata = MIMEdata+"--HL7-CDA-border-CDA-HL7" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Location:" + fileName + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Transfer-Encoding:BASE64" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Type:text/plain" + (char)13 + (char)10 + (char)13 + (char)10;
			MIMEdata = MIMEdata+base64.encode(b)+ (char)13 + (char)10+"--HL7-CDA-border-CDA-HL7--";
			str = str +(char)13 + "OBX||ED|ZIITKGP9906-" + Integer.toString(cntOBX)+ "^Skin Patch^HL7IITKGP||" + MIMEdata + "||||||X|||" + DT + "|";
			hl7out.write(str);

	   		str="";
	   		cntOBX = cntOBX + 1;
            rsfile.next();

	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();
	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT coord : "+e.toString());
		//System.out.println("Sql : "+qSql);
	}

	//////////

	String movsrc = gblDataDir +"/"+pid.substring(0,3).toLowerCase()+"/"+pid.toLowerCase()+"/movies/";

	qSql="SELECT * FROM PATMOVIES WHERE PAT_ID='" + pid + "' ORDER BY ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
		 	 str = (char)13 + "OBR" + "|" + cntOBR + "|||ZIITKGP9904^Patient Videos^HL7IITKGP|||" + DT + "|";

    		 cntOBR = cntOBR + 1;
    		 cntOBX = 1;
	   		 while(!rsfile.isAfterLast()){

	   		 qSql="SELECT DESCRIPTION FROM FORMS WHERE CODE = '" + rsfile.getString("TYPE").trim() + "'";
	   		 	rstemp=stmt1.executeQuery(qSql);
	   			tempDesc="";
	   			if(rstemp.next()){
	   				tempDesc = rstemp.getString("DESCRIPTION");
	   			}
	   			if(tempDesc.equals(""))	tempDesc = rsfile.getString("MOVDESC");


			fileName = pid + modifyStr(dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE")))+ modifyStr(rsfile.getString("TYPE")).trim() + modifyStr(rsfile.getString("SERNO")).trim() + "." + modifyStr(rsfile.getString("EXT")).trim();

		   	str = str + (char)13 + "TXA||" + modifyStr(tempDesc) + "||" + DT + "|" + modifyStr(rsfile.getString("doc_name")).trim() + "|" + getdatymd(modifyStr(rsfile.getString("TESTDATE"))) + "|||" + modifyStr(rsfile.getString("lab_name")).trim() + "|||ZIITKGP9904-" + Integer.toString(cntOBX) + "|ZIITKGP9904|";

	   		MIMEdata = MIMEHead + (char)13 + (char)10 + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"EXT:=" + modifyStr(rsfile.getString("EXT")).trim() + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"TYPE:=" + modifyStr(rsfile.getString("type")).trim() + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"LINK:=" + modifyStr(rsfile.getString("link")).trim() + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"SERNO:=" + modifyStr(rsfile.getString("SERNO")).trim() + (char)13 + (char)10 ;
			MIMEdata = MIMEdata+"ENTRYDATE:=" + getdatymd(modifyStr(rsfile.getString("ENTRYDATE"))) + (char)13 + (char)10 ;
 			MIMEdata = MIMEdata+"FORMKEY:=" + modifyStr(rsfile.getString("formkey")) + (char)13 + (char)10 ;
     			byte [] data ;

 				try{
				  File f=new File(movsrc+fileName);
				  long len = f.length();
		       	  FileInputStream fis = new FileInputStream(f);
      			  data = new byte[(int)len];
       			  long loc = 0;
                  while(loc < len) {
                  long amt = fis.read(data, (int)loc, (int)(len-loc));
           		  loc += amt;
       			 }
   				}catch(IOException e){
					hl7out.write("Error IOException PATMOVIES : "+e.toString());
					data=new byte[1];
				}

			MIMEdata = MIMEdata+"--HL7-CDA-border-CDA-HL7" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Location:" + fileName + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Transfer-Encoding:BASE64" + (char)13 + (char)10;
			MIMEdata = MIMEdata+"Content-Type:" + modifyStr(rsfile.getString("Con_Type")).trim()+ (char)13 + (char)10 + (char)13 + (char)10;
			MIMEdata = MIMEdata+base64.encode(data)+ (char)13 + (char)10+"--HL7-CDA-border-CDA-HL7--";
			str=str + (char)13 + "OBX||ED|ZIITKGP9904-" + Integer.toString(cntOBX) + "^" + modifyStr(tempDesc) + "^HL7IITKGP||" + MIMEdata + "||||||X|||" + DT + "|";
			hl7out.write(str);
	   		str="";
	   	    cntOBX = cntOBX + 1;
        	rstemp.close();
            rsfile.next();

	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();
	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT PATMOVIES : "+e.toString());
		//System.out.println("Sql : "+qSql);
		hl7out.write("Error getATTACHMENT PATMOVIES : "+e.toString());

	}

	///////////////////////////////

	hl7out.close();
	}catch(IOException e){
		System.out.println(e.toString());
	}

}



public String getATTACHMENT(String pid){

	String str="";
	String DT="", filePath1="", filePath2="", tempDesc="";
    int cntOBX=0;
    //,cntOBR=0
    boolean docBool=false, sndBool=false, othrBool=false;
    ResultSet rsfile = null;
	ResultSet rstemp = null;
	
	Date cdt = new Date();	
    DT=dateformat("yyyyMMdd",cdt)+ dateformat("HHmm",cdt);
    
    dbConnect();
    		
	String qSql="SELECT * FROM PATDOC WHERE PAT_ID='" + pid + "' ORDER BY TYPE, ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
	   		while(!rsfile.isAfterLast()){
	   			if(rsfile.getString("TYPE").equalsIgnoreCase("DOC")){
	   				if(docBool== false ){
	   					
	   				 str = str + (char)13 + "OBR" + "|" + cntOBR + "|||ZIITKGP9900^Patient Documents^HL7IITKGP|||" + DT + "|";
            		 cntOBX = 1;
            		 cntOBR = cntOBR + 1;
            		 docBool = true;
	   				}
					filePath1 = pid + dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE"))+ rsfile.getString("TYPE").trim() + rsfile.getString("SERNO").trim() + "." + rsfile.getString("EXT").trim();
           			str = str + (char)13 + "OBX||RP|ZIITKGP9900-" + cntOBX + "^" + rsfile.getString("DOCDESC") + "^HL7IITKGP||" + filePath1 + "^TeleMediX^TEXT^RTF||||||X|||" + DT + "|";
	   		   }else {
	   		  	if(rsfile.getString("TYPE").equalsIgnoreCase("SND")){
               	if(sndBool== false ){
	   				str = str + (char)13 + "OBR" + "|" + cntOBR + "|||ZIITKGP9901^Patient Audios^HL7IITKGP|||" + DT + "|";
            		cntOBX = 1;
            		cntOBR = cntOBR + 1;
            		sndBool = true;
	   				} //if sndBool
		            filePath1 = pid + dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE"))+ rsfile.getString("TYPE").trim() + rsfile.getString("SERNO").trim() + "." + rsfile.getString("EXT").trim();
					str = str + (char)13 + "OBX||RP|ZIITKGP9901-" + cntOBX + "^" + rsfile.getString("DOCDESC") + "^HL7IITKGP||" + filePath1 + "^TeleMediX^AU||||||X|||" + DT + "|";
	   		    }else{
				   	if(othrBool== false ){
						str = str + (char)13 + "OBR" + "|" + cntOBR + "|||ZIITKGP9902^Other Patient Attachments^HL7IITKGP|||" + DT + "|";
			            cntOBX = 1;
			            cntOBR = cntOBR + 1;
			            othrBool = true;
			         }
 					filePath1 = pid + dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE"))+ rsfile.getString("TYPE").trim() + rsfile.getString("SERNO").trim() + "." + rsfile.getString("EXT").trim();
					str = str + (char)13 + "OBX||RP|ZIITKGP9902-" + cntOBX + "^" + rsfile.getString("DOCDESC") + "^HL7IITKGP||" + filePath1 + "^TeleMediX^AP||||||X|||" + DT + "|";
	   		    }
             } // else 
        
        cntOBX = cntOBX + 1;
        rsfile.next();       
        
	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();
	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT Patdoc : "+e.toString());
		//System.out.println("Sql : "+qSql);	
	}
	
	
	/////////
	
	qSql="SELECT * FROM PATIMAGES WHERE PAT_ID='" + pid + "' ORDER BY ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
		 	 str = str + (char)13 + "OBR" + "|" + cntOBR + "|||ZIITKGP9903^Patient Images^HL7IITKGP|||" + DT + "|";
    		 cntOBR = cntOBR + 1;
    		 cntOBX = 1;
	   		 while(!rsfile.isAfterLast()){
	   		 	qSql="SELECT DESCRIPTION FROM FORMS WHERE CODE = '" + rsfile.getString("TYPE").trim() + "'";
	   		 	rstemp=stmt1.executeQuery(qSql);
	   			tempDesc="";
	   			if(rstemp.next()){
	   				tempDesc = rstemp.getString("DESCRIPTION");
	   			}
	   			if(tempDesc.equals(""))	tempDesc = rsfile.getString("IMGDESC");	
	   			
			filePath1 = pid + dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE"))+ rsfile.getString("TYPE").trim() + rsfile.getString("SERNO").trim() + "." + rsfile.getString("EXT").trim();
			str = str + (char)13 + "OBX||RP|ZIITKGP9903-" + cntOBX + "^" + tempDesc + "^HL7IITKGP||" + filePath1 + "^TeleMediX^IM||||||X|||" + DT + "|";
	   		cntOBX = cntOBX + 1;
        	rstemp.close();	
            rsfile.next();       
        
	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();
	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT PatImages : "+e.toString());
		//System.out.println("Sql : "+qSql);	
	}
	
	////
	    
	
	qSql="SELECT * FROM refimages WHERE PAT_ID='" + pid + "' ORDER BY ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
		 	 str = str + (char)13 + "OBR" + "|" + cntOBR + "|||ZIITKGP9905^Patient Reffered Images^HL7IITKGP|||" + DT + "|";
    		 cntOBR = cntOBR + 1;
    		 cntOBX = 1;
    		 
	   		 while(!rsfile.isAfterLast()){
	   		 	
	   		 qSql="SELECT DESCRIPTION FROM FORMS WHERE CODE = '" + rsfile.getString("TYPE").trim() + "'";
	   		 	rstemp=stmt1.executeQuery(qSql);
	   		 	
	   		 	tempDesc="";
	   			if(rstemp.next()){
	   				tempDesc = rstemp.getString("DESCRIPTION");
	   			}
	   			if(tempDesc.equals(""))	tempDesc = rsfile.getString("IMGDESC");	 
	   		
			filePath1 = pid + dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE"))+ rsfile.getString("TYPE").trim() + rsfile.getString("img_serno").trim() + rsfile.getString("Ref_code").trim() +rsfile.getString("SERNO").trim() + "." + rsfile.getString("EXT").trim();
			str = str + (char)13 + "OBX||RP|ZIITKGP9905-" + cntOBX + "^" + tempDesc + "^HL7IITKGP||" + filePath1 + "^TeleMediX^IM||||||X|||" + DT + "|";
	   		cntOBX = cntOBX + 1;
        	rstemp.close();	
            rsfile.next();       
   
	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();
	   
	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT refimages : "+e.toString());
		//System.out.println("Sql : "+qSql);	
	}
	
	////
	
	qSql="SELECT * FROM PATMOVIES WHERE PAT_ID='" + pid + "' ORDER BY ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
		 	 str = str + (char)13 + "OBR" + "|" + cntOBR + "|||ZIITKGP9904^Patient Videos^HL7IITKGP|||" + DT + "|";
    		 cntOBR = cntOBR + 1;
    		 cntOBX = 1;
    		 
       while(!rsfile.isAfterLast()){

	   		 qSql="SELECT DESCRIPTION FROM FORMS WHERE CODE = '" + rsfile.getString("TYPE").trim() + "'";
       	rstemp=stmt1.executeQuery(qSql);
	   		 	
	   			tempDesc="";
	   			if(rstemp.next()){
	   				tempDesc = rstemp.getString("DESCRIPTION");
	   			}
	   			
	   			if(tempDesc.equals(""))	tempDesc = rsfile.getString("MOVDESC");	 
	   			
	   			
			filePath1 = pid + dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE"))+ rsfile.getString("TYPE").trim() + rsfile.getString("SERNO").trim() + "." + rsfile.getString("EXT").trim();
			str = str + (char)13 + "OBX||RP|ZIITKGP9904-" + cntOBX + "^" + tempDesc + "^HL7IITKGP||" + filePath1 + "^TeleMediX^AP||||||X|||" + DT + "|";
	   		cntOBX = cntOBX + 1;
        	rstemp.close();	
            rsfile.next();       
   
	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();
	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT PATMOVIES : "+e.toString());
		//System.out.println("Sql : "+qSql);	
	}
	
	
	////
	
	qSql="SELECT * FROM coord WHERE PAT_ID='" + pid + "' ORDER BY ENTRYDATE";
	try{
		rsfile=stmt.executeQuery(qSql);
	   	if(rsfile.next()){
		 	 str = str + (char)13 + "OBR" + "|" + cntOBR + "|||ZIITKGP9906^Patient Skinpatch Images^HL7IITKGP|||" + DT + "|";
    		 cntOBR = cntOBR + 1;
    		 cntOBX = 1;
	   		while(!rsfile.isAfterLast()){   			
			filePath1 = pid + dateformat("ddMMyyyy",rsfile.getDate("ENTRYDATE"))+ rsfile.getString("TYPE").trim() + rsfile.getString("SERNO").trim() + ".txt";
			str = str + (char)13 + "OBX||RP|ZIITKGP9906-" + cntOBX + "^" + "^Skin Patch^HL7IITKGP||" +  filePath1 + "^TeleMediX^IM||||||X|||" + DT + "|";
	   		cntOBX = cntOBX + 1;
            rsfile.next();       
   
	   	}  //while rsfile
	   } // 1st if
	   rsfile.close();
	 }catch(Exception e){
		//System.out.println("Error getATTACHMENT coord : "+e.toString());
		//System.out.println("Sql : "+qSql);	
	}
	 
	dbClose(); 
	
	//Mid(str, 2)
	    		
	return str;	
		
	}
	

public String dateformat(String fmat, Date dt){
	String str="";
	try{

		Date date=dt;
		DateFormat df=new SimpleDateFormat(fmat);
		str=df.format(date);

	}catch(Exception e){
		//System.out.println("<BR><B>"+e.toString()+"</B><BR>");
		str=e.toString();
	}

	return str;
 }

 public String createStr(int no, String op ){
	String str="";
	for(int iii=1;iii<=no;iii++){
	str=str+op;
	}
	return str;
 }

 public String getdatymd(String sdt ){
 	String str="";
	str=sdt.replace("-","");
	return str;
 }


public void dbConnect(){

		try {
				Class.forName(gbldbjdbcDriver);
				conn = DriverManager.getConnection(gbldbURL, gbldbusername, gbldbpasswd);
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
				stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
				stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

			}
			catch (Exception e) {
				System.out.println("Error found <B>"+e+"</B>");
			}
}

public void dbClose(){
		try {
			conn.close();
			stmt.close();
			stmt1.close();
			stmt2.close();

		}
		catch (Exception e) {
			System.out.println("Error found <B>"+e+"</B>");
		}
}

public String modifyStr(String sr){
	String str=sr;

		try {
		str=str.replace("\r","");
		str=str.replace("\n","");
		}catch (Exception e) {
			System.out.println("Error found <B>"+e+"</B>");
		}
	return str;
}

}
%>
