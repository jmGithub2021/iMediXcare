package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.Vector;
import java.io.*;
import logger.*;

public class UserInfo extends UnicastRemoteObject implements UserInfoInterface {

	projinfo pinfo;
	dball mydb;
	public UserInfo(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	public int  InsertRegUsers(dataobj obj,byte[] b)throws RemoteException,SQLException{
     		int ans =0,tag=0;
    		dataobj tmp= obj;
    		String qr="",key="",val="";
			String tmpUtype="",tmpDistype="",tmpRg_no="",tmp_Actv="";;
			
    		String uid=tmp.getValue("uid");
    		String type=tmp.getValue("type");
    		String ccode=tmp.getValue("center");
    		
			tmp.replace("crtdate",myDate.getCurrentDateMySql());
			
    	//	if(type.equalsIgnoreCase("usr")){
				tmp.add("rg_no",genusrrg_no(type,ccode));
		//	}

			System.out.println("ans **:"+ans);
			ans=checkuser(uid,tmp.getValue("rg_no"));
			
     		System.out.println("ans **>>:"+ans);
     		
     		if(ans==0) return ans;
    		
    		try{
    			//qr = "select * from regusers";
    			qr = "select * from login";
				String token = mydb.FieldTypesmeta(qr);
				StringTokenizer st = new StringTokenizer(token,"=&");
				qr = "insert into login values( ";
				while(st.hasMoreTokens()){
					key = st.nextToken();
					val = st.nextToken();
						String qv=tmp.getValue(key);
						qv=qv.replaceAll("'","''");
						//System.out.println("KEy : "+key);
						if(key.equalsIgnoreCase("type")){
							 tmpUtype=qv;
							 tmpDistype=tmp.getValue("dis");
							 tmpRg_no=tmp.getValue("rg_no"); 
							 tmp_Actv=tmp.getValue("active"); 
						}
						
						if(qv==null) qv="";
												
						if(qv.length()>0){
							if(val.equalsIgnoreCase("CHAR") ||val.equalsIgnoreCase("VARCHAR")){
								if(key.equalsIgnoreCase("pwd"))
									qr = qr+"SHA1('"+qv+"'),";
								else
									qr = qr+"'"+qv+"',";
							}		
							else if(val.equalsIgnoreCase("DATE") || val.equalsIgnoreCase("DATETIME")){
								//String dt=myDate.getFomateDate("ymd",true,qv);
								qr = qr+"'"+qv+"',";
							}							
							else if (val.equalsIgnoreCase("INT") || val.equalsIgnoreCase("NUMERIC") ||val.equalsIgnoreCase("FLOAT")||val.equalsIgnoreCase("DECIMAL"))
								qr = qr+qv+",";
							else {
								System.out.println("MatchNot Found :"+val);
								qr = qr+"'"+qv+"',";
							}
							
						}else if (val.equalsIgnoreCase("blob") || val.equalsIgnoreCase("longblob") || val.equalsIgnoreCase("mediumblob")){
								if(b==null) qr = qr + "null,";
								else	qr=qr+"?,";
						}else
							qr = qr + "null,";	
					
					
				}

				qr=qr.substring(0,qr.length()-1);
				qr = qr+ " )";
				
				/*
					try
					{
						FileOutputStream out = new FileOutputStream("D:/Log.txt");
				
						PrintStream p = new PrintStream( out );
						
						p.println (qr);
				
						p.close();
					}
					catch (Exception e)
					{
						System.err.println ("Error writing to file");
					}
				*/
					
				System.out.println(qr);
				
				String str=""; 
			//	if(==null)	
				
				str=mydb.ExecuteSql(qr);
				
			//	else str=mydb.ExecuteImage(qr,b); 

	   			if(str.equalsIgnoreCase("Error")) ans=0;
	   			else{
	   				ans =1; 
		   		
		  ////////////////////////// log //////////////////////////////////////////////////////////////////
					
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("uid",uid);
					desdtls.add("table","login");
					
					if(tmp_Actv.equalsIgnoreCase("Y")) desdtls.add("details","Insert User with Activated (" + type + ")" );
					else  desdtls.add("details","Insert User without Activated (" + type + ")" );
					
				//	System.out.println("************bbbb****************");
						
					imxlog.putFormInformation(tmp.getValue("userid"),tmp.getValue("usertype"),1,keydtls,desdtls);
					
		/////////////////////////////////////////////// log ////////////////////////////////////////////
					
				//	System.out.println("****************************");
					
						if(tmp_Actv.equalsIgnoreCase("Y") && tmpUtype.equalsIgnoreCase("doc")){
		   				String IsQl="insert into  othdis values('"+tmpRg_no.trim() +"','"+tmpDistype.trim()+"')";
		   				mydb.ExecuteSql(IsQl);
		   				tmp_Actv="";
		   				tmpUtype="";
		   			}
		   			
	   			}
    		}catch(Exception e){
    			System.out.println("Exception :"+e.toString());
    			ans =0;	
    		}
    	return ans;
  }
  
   private String  genusrrg_no(String uty,String ccode){
   	String ans=uty+ccode;
   	
   	try{

   		String iSql = "select rg_no from login where upper(type)='"+uty.toUpperCase() +"' and center='"+ccode +"' order by rg_no desc";
    	System.out.println("iSql="+iSql);
    	String rgno=mydb.ExecuteSingle(iSql);
    	System.out.println("iSql= rgno "+rgno);
    		
    	if(rgno.equalsIgnoreCase("")) ans+="0000";
    	else{
    		int sl=Integer.parseInt(rgno.substring(rgno.length()-4,rgno.length()));
    		System.out.println("sl *****> "+sl);
    		sl++;
    		System.out.println("slN *****> "+sl);
    		
    		if(sl<10) ans=ans+"000"+Integer.toString(sl);
    		else if(sl<100) ans=ans+"00"+Integer.toString(sl);	
    		else if(sl<1000) ans=ans+"0"+Integer.toString(sl);
    		else ans=ans+Integer.toString(sl);
    	}
    
    }catch(Exception e){
    		System.out.println(e.toString());
    		ans="usr0001";
    }
    System.out.println("usr id "+ans);
    return ans;
    		
   }
   
   private int checkuser(String uid,String rgno){
       	try{
    		
    		String iSql = "select uid from login where uid='"+uid+"'";
    		System.out.println("iSql="+iSql);
    		String lid=mydb.ExecuteSingle(iSql);
    		
    		System.out.println("lid="+lid);
    		
    		if(!lid.equals("")) return 0;
    			
    		iSql = "select rg_no from login where rg_no='"+rgno+"'";
    		System.out.println("iSql="+iSql);
    		String rid=mydb.ExecuteSingle(iSql);
    		System.out.println(" l rid="+rid);
    		if(!rid.equals("")) return 0;
    		
    		/*iSql = "select rg_no from regusers where rg_no='"+rgno+"'";
    		System.out.println("iSql="+iSql);
    		rid=mydb.ExecuteSingle(iSql);
    		System.out.println("rid="+rid);
    		if(!rid.equals("")) return 0;
    		*/
    		
    	}catch(Exception e){
    		System.out.println(e.toString());
    		return 0;
    	}
    	System.out.println("result=1");
    	return 1;
    	
    }
    
	
	public Object getuserinfo(String id,String ps) throws RemoteException,SQLException{
		
		//String isql="Select uid,name,crtdate,type,phone,address,emailid,qualification,designation,dis,rg_no,center,active from login where uid='" +id+"' and pwd='"+ps+"'";


		//String isql="Select uid,name,crtdate,type,phone,address,emailid,qualification,designation,dis,rg_no,center,active,verifemail,verifphone from login where ((binary uid=? and binary pwd=AES_ENCRYPT(?, UNHEX(SHA2(?,512)))) or (binary emailid=? and binary pwd=AES_ENCRYPT(?, UNHEX(SHA2((select uid from login where emailid=?),512))))) and verified=?";
		//String isql="Select uid,name,crtdate,type,phone,address,emailid,qualification,designation,dis,rg_no,center,active,verifemail,verifphone from login where ((binary uid=? and binary pwd=AES_ENCRYPT(?, UNHEX(SHA2(?,512)))) or (binary emailid=? and binary pwd=AES_ENCRYPT(?, UNHEX(SHA2((select uid from login where emailid=?),512)))) or (binary phone=? and binary pwd=AES_ENCRYPT(?, UNHEX(SHA2((select uid from login where phone=?),512))))) and verified=?";
		String isql="Select uid,name,crtdate,type,phone,address,emailid,qualification,designation,dis,rg_no,center,active,verifemail,verifphone from login where ((binary uid=? and binary pwd=SHA1(?)) or (binary emailid=? and binary pwd=SHA1(?)) or (binary phone=? and binary pwd=SHA1(?))) and verified=?";				
		
		
		//String isql="Select uid,name,crtdate,type,phone,address,emailid,qualification,designation,dis,rg_no,center,active from login where binary uid=? and binary pwd=?";
		
		/*String prms[]=new String[7];
		prms[0]=id;
		prms[1]=ps;
		prms[2]=id;
		prms[3]=id;
		prms[4]=ps;
		prms[5]=id;	
		prms[6] = "A";*/
		String prms[]=new String[7];
		prms[0]=id;
		prms[1]=ps;
		prms[2]=id;
		prms[3]=ps;
		prms[4]=id;
		prms[5]=ps;	
		prms[6] = "A";
 	    System.out.println("Login: "+isql);	    
        return mydb.ExecutePQuary(isql,prms,7);
	}
	
	public Object getuserinfo(String id) throws RemoteException,SQLException{
		String isql="Select * from login where uid='" +id+"'";
 	   
        return mydb.ExecuteQuary(isql);
	}
	public Object getuserinfoByrgNo(String rg_no) throws RemoteException,SQLException{
		String isql="Select * from login where rg_no='" +rg_no+"'";
 	   
        return mydb.ExecuteQuary(isql);
	}
		
	public String getreg_no(String id) throws RemoteException,SQLException{
		String isql="Select rg_no from login where uid = '" +id+"'";
 	    
        return mydb.ExecuteSingle(isql);  
	}
	
	public String getName(String regn) throws RemoteException,SQLException{
		String isql="Select name from login where upper(rg_no) = '"+regn.toUpperCase()+"'";
 	    //System.out.println(isql);
 	    
        String aa = mydb.ExecuteSingle(isql);
        //System.out.println("'"+aa+"'");
        if(aa.equals("")) aa=regn;
        return aa;
	}
    
    public byte[] getSign(String regn)throws RemoteException,SQLException { 
       String qSql= "select sign from login where upper(rg_no) = '"+regn.toUpperCase()+"'";
       System.out.println("getSign :" + qSql); 
      
       return mydb.ExecuteImage(qSql);
     }
     
     
    public Object getValues(String fld, String cond ) throws RemoteException,SQLException{
     	String query = "select " + fld + " from login where " + cond;
        System.out.println(query);
        return mydb.ExecuteQuary(query);
    }
    
     public boolean sendDoctor(String uid,String rcode) throws RemoteException,SQLException{
     	boolean ans=false;
     	SendDocRecords sdr=new SendDocRecords(uid,rcode,pinfo);
     	ans=sdr.CollectDocData();
     	if(ans==true){
     	//	ans=sdr.ftpSendDoc();
     	}
     	return ans;	
     }
     
     public int updateUserInfo(dataobj obj) throws RemoteException,SQLException{
		
		int ans=0;
		String pwd="";
		String uid=obj.getValue("uid");
		String opwd=obj.getValue("oldpwd");	
		String tpwd =obj.getValue("pwd");
		
		if (tpwd != null && !tpwd.isEmpty())
			//pwd = "AES_ENCRYPT('"+obj.getValue("pwd").replaceAll("'","''")+"', UNHEX(SHA2('"+uid+"',512)))";
			pwd = "SHA1('"+obj.getValue("pwd").replaceAll("'","''")+"')";
		else 
			pwd = "";
		if(!obj.getValue("userid").equals("admin"))
			if(!opwd.equals(getPswd(uid))) return 2;
		
		try{
    		String qr = "UPDATE login set ";
			if (!pwd.isEmpty()) qr += " pwd="+ pwd +",";
			qr += " name='"+ obj.getValue("name").replaceAll("'","''") +"',";
			qr += " address='"+ obj.getValue("address").replaceAll("'","''") +"',";
			qr += " phone='"+ obj.getValue("phone").replaceAll("'","''") +"',";
			qr += " qualification='"+ obj.getValue("qualification").replaceAll("'","''") +"',";
			qr += " designation='"+ obj.getValue("designation").replaceAll("'","''") +"',";
			qr += " emailid='"+ obj.getValue("emailid").replaceAll("'","''") +"',";
			qr += " verifemail='"+ obj.getValue("verifyemailstatus").replaceAll("'","''") +"',";
			qr += " verifphone='"+ obj.getValue("verifyphonestatus").replaceAll("'","''") +"'";
			qr += " where uid ='"+ uid +"'";
		
			String str=mydb.ExecuteSql(qr);
   			System.out.println("str **:"+str);
   			
   			if(str.equalsIgnoreCase("Error")) ans=0;
   			else{
   					ans=1; 		
   				
	  ////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("uid",uid);
					desdtls.add("table","login");
					desdtls.add("details","Update User (" + obj.getValue("type") + ")" );
					
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
		/////////////////////////////////////////////// log ////////////////////////////////////////////



   			}	   			
    		}catch(Exception e){
    			System.out.println("Exception b:"+e.toString());
    			ans=0;
    		}
       return ans;
     }
     
     private String getPswd(String uid){
     	//String qSql="select pwd from login where uid='"+uid+"'";
     	String qSql="select SHA1(pwd) pwd from login where uid='"+uid+"'";
     	return mydb.ExecuteSingle(qSql);
     }
     
     public boolean updateUserStatus(String uid, String status,dataobj obj) throws RemoteException,SQLException{	
     	String usql = "UPDATE login set active = '"+ status +"' where lower(uid) = '"+uid.toLowerCase().trim()+"'";
     	String str=mydb.ExecuteSql(usql);
     	if(str.equalsIgnoreCase("Error")) return false;
   		else{
   		
   		////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("uid",uid);
					desdtls.add("table","login");
					desdtls.add("details","Update User Status (active="+ status +")" );
					
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
		/////////////////////////////////////////////// log ////////////////////////////////////////////

   		
   				return true;
   		
   		}
     	
     }
     
     public int deleteUser(String uid,dataobj obj) throws RemoteException,SQLException{
     
     String usql = "Delete from login where lower(uid) = '"+uid.toLowerCase().trim()+"'";
     	String str=mydb.ExecuteSql(usql);
     	if(str.equalsIgnoreCase("Error")) return 0;
   		else{
   		
   	////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("uid",uid);
					desdtls.add("table","login");
					desdtls.add("details","Delete User");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),3,keydtls,desdtls);
					
	/////////////////////////////////////////////// log ////////////////////////////////////////////
	
   			return 1;
   		 }
     }
     
      public int deleteRegUser(String uid) throws RemoteException,SQLException{
     
      String usql = "Delete from login where lower(uid) = '"+uid.toLowerCase().trim()+"'";
     	String str=mydb.ExecuteSql(usql);
     	if(str.equalsIgnoreCase("Error")) return 0;
   		else	return 1;
   		  	
     }
     
     public Object getAllUsers(String ccode,String utyp,String ARAll) throws RemoteException,SQLException {
     	
     	String qSql="",cond="", cond1="", cond2="";;
     	
     	if (ccode.equalsIgnoreCase("XXXX") || ccode.equalsIgnoreCase("") ) cond="";
     	else cond = " and Upper(center) ='"+ccode.toUpperCase()+"' ";
     	
     	if(utyp.equalsIgnoreCase("")) cond1="";
     	else cond1 = " and upper(type)= '"+utyp.toUpperCase()+"' ";
     	
     	if(ARAll.equalsIgnoreCase("A")) cond2 = " and available= 'Y' ";
     	else if(ARAll.equalsIgnoreCase("R")) cond2 = " and referral= 'Y' ";
     	else cond2="";
     	
     	//qSql = "Select l.uid,l.name as uname ,l.qualification,l.phone,emailid,rg_no,upper(type) as type,available,referral,center,c.name as cname from login l, center c where active = 'Y' "+cond+cond1+cond2 +" and c.code = l.center Order by center,type,uname";
     	qSql = "Select l.uid,l.name as uname ,l.qualification,l.phone,emailid,rg_no,upper(type) as type,available,referral,center,c.name as cname,c.* from login l, center c where active = 'Y' "+cond+cond1+cond2 +" and c.code = l.center Order by center,type,uname";

     	System.out.println("getAllUsers>> : "+qSql);
     	   
		return mydb.ExecuteQuary(qSql);
     }
     
     public String getSpecialization(String docid) throws RemoteException,SQLException {
     	String output="";
     	String qSql = "select dis from othdis where rg_no='"+docid+"' order by dis";
        Object res=mydb.ExecuteQuary(qSql);
        if(res instanceof String){
			output+=res;
		}else{
			Vector Vtmp = (Vector)res;
			for(int i=0;i<Vtmp.size();i++){
				dataobj tempdata = (dataobj) Vtmp.get(i);	
				output+=","+tempdata.getValue("dis");	
			}
		}
		if(output.startsWith(","))   output=output.substring(1);
     	return output;
     }
     
     public String updateAvailability(String Adocid,String Rdocid,dataobj obj) throws RemoteException,SQLException {
       	String usr=obj.getValue("userid").toString(),uSql="",center="",ans="";
       	center=obj.getValue("center").toString();
       	/*if(obj.getValue("userid")==s||obj.getValue("center")=="XXXX"){
       	uSql="Update login set available='N',referral='N'";
        mydb.ExecuteSql(uSql);
       	
       	uSql="Update login set available='Y' where rg_no in ("+Adocid+")";
       	System.out.println(uSql);
       	mydb.ExecuteSql(uSql);
       	
       	  ////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("rg_no",Adocid);
					desdtls.add("table","login");
					desdtls.add("details","Update Availability (available)");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
	/////////////////////////////////////////////// log ////////////////////////////////////////////

       	uSql="Update login set referral='Y' where rg_no in ("+Rdocid+")";
       	System.out.println(uSql);
       	ans = mydb.ExecuteSql(uSql);
       	
       	 ////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog1 = new imedixlogger(pinfo);
					dataobj keydtls1 = new dataobj();
					dataobj desdtls1 = new dataobj();
					keydtls1.add("rg_no",Rdocid);
					desdtls1.add("table","login");
					desdtls1.add("Update Availability (referral)");
					imxlog1.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
	/////////////////////////////////////////////// log ////////////////////////////////////////////
}
       	else{*/
       	String cen=" center='"+center+"'";
       	String wh=" where ";
       	String nd=" and ";
    
       	if(center.equalsIgnoreCase("XXXX") ){ //|| usr.equalsIgnoreCase("admin")
			cen="";
			wh="";
			nd="";
		}
			uSql="Update login set available='N',referral='N' "+wh+cen;
			//System.out.println(uSql);
			mydb.ExecuteSql(uSql);
			uSql="Update login set available='Y' where rg_no in ("+Adocid+") "+nd+cen;
       	//System.out.println(uSql);
       	mydb.ExecuteSql(uSql);
       	
       	  ////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("rg_no",Adocid);
					desdtls.add("table","login");
					desdtls.add("details","Update Availability (available)");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
	/////////////////////////////////////////////// log ////////////////////////////////////////////

       	uSql="Update login set referral='Y' where rg_no in ("+Rdocid+") "+nd+cen;
       	//System.out.println(uSql);
       	ans = mydb.ExecuteSql(uSql);
       	
       	 ////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog1 = new imedixlogger(pinfo);
					dataobj keydtls1 = new dataobj();
					dataobj desdtls1 = new dataobj();
					keydtls1.add("rg_no",Rdocid);
					desdtls1.add("table","login");
					desdtls1.add("Update Availability (referral)");
					imxlog1.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
			//}
       	return ans;

     }
	public boolean verifyPatient(String verifiedCode, String emailid) throws RemoteException, SQLException{
		String sql = "update login set verified='A' where verified='"+verifiedCode+"' and emailid='"+emailid+"'";
		String ans = mydb.ExecuteSql(sql);
		if(ans.equalsIgnoreCase("Done"))
			return true;
		else
			return false;
	}
	public boolean convertTOSelf(String patid) throws RemoteException, SQLException{
		String sql = "update med set relationship='Self', primarypatid=null where pat_id='"+patid+"'";
		String ans = mydb.ExecuteSql(sql);
		if(ans.equalsIgnoreCase("Done"))
			return true;
		else
			return false;
	}
	public String existEmail(String emailid) throws RemoteException, SQLException{
		String sql = "select count(*) as noemail from login where emailid='"+emailid+"'";
		System.out.println("existEmail> "+sql);
		return mydb.ExecuteSingle(sql);
	}
	public String existPhone(String phone) throws RemoteException, SQLException{
		String sql = "select count(*) as nophone from login where phone='"+phone+"'";
		System.out.println("existEmail> "+sql);
		return mydb.ExecuteSingle(sql);
	}
	public String existUid(String uid) throws RemoteException, SQLException{
		String sql = "select count(*) as noemail from login where uid='"+uid+"'";
		System.out.println("existEmail> "+sql);
		return mydb.ExecuteSingle(sql);
	}
	public String existRgno(String rgno) throws RemoteException, SQLException{
		String sql = "select count(*) as nophone from login where rg_no='"+rgno+"'";
		System.out.println("existEmail> "+sql);
		return mydb.ExecuteSingle(sql);
	}
	/// New Addition as on 21-April-2020
	public Object getPatientsWithoutLogin(String key) throws RemoteException{
		String sql="";
     	sql = "select * from med left join login on med.pat_id = login.uid where (med.pat_name like '%"+key+"%' or med.m_name like '%"+key+"%' or med.l_name like '%"+key+"%') and login.name IS NULL";
     	System.out.println("getPatientsWithoutLogin : "+sql);
		 
		return mydb.ExecuteQuary(sql);
	}

	public Object getPatientData(String pat_id)throws RemoteException, SQLException{
		String sql="";
     	sql = "select * from med where med.pat_id ='"+pat_id+"'";
     	System.out.println("getPatientData : "+sql);
		 
		return mydb.ExecuteQuary(sql);
	}

	public int addPatientFromMed(dataobj obj) throws RemoteException, SQLException{
		int result = 0;// 0=OK, 1=Error
		String sql="";
		String type = obj.getValue("type");
		String ccode = obj.getValue("center");
		String regno = genusrrg_no(type,ccode);
		String crtdate = myDate.getCurrentDateMySql();
		String emailid = obj.getValue("emailid");
		String phone = obj.getValue("phone");
		String fld ="" , vals ="";
		if (emailid != null && !emailid.isEmpty()) {
			fld += ", emailid, verifemail";
			vals += ", '"+ emailid +"','Y' ";
		} 
		if (phone != null && !phone.isEmpty()) {
			fld += ", phone, verifphone";
			vals += ", '"+ phone +"','Y' ";
		} 
		String pwd = "SHA1('"+obj.getValue("pwd")+"')";
     	sql = "insert into login (uid, pwd, name, crtdate, type, rg_no, center, active, available, referral "+fld+",consent) VALUES ";
		sql += "('"+obj.getValue("uid")+"',"+   pwd +",'"+obj.getValue("name")+"','"+crtdate+"','"+
				type+"','"+regno+"','"+ccode+"','"+obj.getValue("active")+"','"+obj.getValue("available")+"','"+obj.getValue("referral")+"' "+vals+",'N')";

		System.out.println("addPatientFromMed : "+sql);
		try{
			mydb.ExecuteSql(sql);
		}catch(Exception e){
			System.out.println("addPatientFromMed: "+e.toString());
			result = 1;
		}
		return result;
	}	
	public Object getuserinfoByEmail(String emailid) throws RemoteException,SQLException{
		String isql="Select uid,SHA1(pwd) as pwd, name, crtdate, type, phone, address, emailid, qualification, designation, dis, rg_no, center, active,verifemail,verifphone from login where (emailid='" +emailid+"' or uid='" +emailid+"') ";
        //System.out.println("SQL = "+isql);
		return mydb.ExecuteQuary(isql);
	}
	
	public Object getuserinfoByAny(String serStr) throws RemoteException,SQLException{
		String isql="Select uid,SHA1(pwd) as pwd, name, crtdate, type, phone, address, emailid, qualification, designation, dis, rg_no, center, active,verifemail,verifphone from login where (emailid='" +serStr+"' or uid='" +serStr+"'  or phone='" +serStr+"' ) ";
        //System.out.println("SQL = "+isql);
		return mydb.ExecuteQuary(isql);
	}
	
	public int addLoginRequest(dataobj obj) throws RemoteException, SQLException{
		int result = 0;// 0=OK, 1=Error
		String iSql="";
		String type = obj.getValue("pat_id");
		String ccode = obj.getValue("pat_name");
		String emailid =  obj.getValue("emailid");
		//String mobileno =  obj.getValue("mobileno");
		//iSql = "insert into login_request (pat_id, pat_name, emailid, mobileno) VALUES ";
		//iSql += "('"+obj.getValue("pat_id")+"','"+ obj.getValue("pat_name") +"','"+obj.getValue("emailid")+"','"+obj.getValue("mobileno")+"')";
		iSql = "insert into login_request (pat_id, pat_name, emailid) VALUES ";
		iSql += "('"+obj.getValue("pat_id")+"','"+ obj.getValue("pat_name") +"','"+obj.getValue("emailid")+"')";
		String str=mydb.ExecuteSql(iSql);
		System.out.println("iSql = "+iSql);
     	if(str.equalsIgnoreCase("Error")) return 0;
		else return 1;
	}
	
	public Object getLoginRequestData() throws RemoteException, SQLException{
		String sql= "select login_request.* from login_request where  login_request.pat_id not in (select distinct uid from login)  order by rdate";
     	System.out.println("getPatientData : "+sql);
		return mydb.ExecuteQuary(sql);
	}
	public Object docOfMinPat(String center, String dis) throws RemoteException, SQLException{
		//String sql = "select assigneddoc from lpatq l,login lg where lg.rg_no = l.assigneddoc and lg.available='Y' and lg.center='"+center+"' and l.assigneddoc in (select rg_no from othdis where dis='"+dis+"') group by assigneddoc order by count(*) limit 1";
		String sql = "select rg_no,emailid,phone,uid,name,verifemail,verifphone from login lg LEFT JOIN lpatq l on lg.rg_no = l.assigneddoc where type='DOC' and lg.available='Y' and lg.center='"+center+"' and lg.rg_no in (select rg_no from othdis where dis='"+dis+"') group by assigneddoc order by count(*) limit 1";
		 System.out.println("docOfMinPat() > "+sql);
		 return mydb.ExecuteQuary(sql);
	}
	public String fileUploadLimit(int dayLimit, String pat_id) throws RemoteException, SQLException{
		String sql = "select count(*) from listofforms l where l.pat_id='"+pat_id+"' and type in ('patdoc','patimages','patmovies') and (select visitdate from patientvisit where pat_id='"+pat_id+"' order by visitdate desc limit 1)+ INTERVAL "+dayLimit+" DAY>=DATE(NOW())";
		System.out.println("fileUploadLimit() > "+sql);
		return mydb.ExecuteSingle(sql);
	}
	public boolean resetPassword(String uid, String pass) throws RemoteException,SQLException{
		String sql="update login set pwd = SHA1('"+pass+"') where uid='"+uid+"'";
		System.out.println("UserInfo -> resetPassword() > "+sql);
		String ans = mydb.ExecuteSql(sql);
		if(ans.equalsIgnoreCase("Done"))
			return true;
		else
			return false;		
	}

	public Object getUserOTP(String val) throws RemoteException,SQLException
	{
		String sql="select * from login where emailid='"+val+"' or phone='"+val+"'";
		System.out.println("getUserOTP() > "+sql);
		return mydb.ExecuteQuary(sql);
	}
	public boolean deactivateAccount(String uid) throws RemoteException,SQLException
	{
		String sql="update login set verified='N',consent='N' where rg_no='"+uid+"'";
		System.out.println("deactivateAccount() > "+sql);
		String ans = mydb.ExecuteSql(sql);
		if(ans.equalsIgnoreCase("Done"))
			return true;
		else
			return false;
		
	}
	public boolean activateAccount(String uid) throws RemoteException,SQLException
	{
		String sql="update login set verified='A' where rg_no='"+uid+"'";
		System.out.println("activateAccount() > "+sql);
		String ans = mydb.ExecuteSql(sql);
		if(ans.equalsIgnoreCase("Done"))
			return true;
		else
			return false;
		
	}
	public Object getEmailId() throws RemoteException, SQLException{
		String sql = "select emailid from login limit 0,10000";
		System.out.println("getEmailId() > "+sql);
		return mydb.ExecuteQuary(sql);		
	}
	public Object getEmailId(int low, int high) throws RemoteException, SQLException{
		String sql = "select emailid from login limit"+low+","+high;
		System.out.println("getEmailId(low, high) > "+sql);
		return mydb.ExecuteQuary(sql);		
	}	    	
}
