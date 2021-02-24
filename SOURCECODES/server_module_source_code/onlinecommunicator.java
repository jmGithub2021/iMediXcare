package onlinegc;

import java.io.*;
import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.util.StringTokenizer;
import java.util.Vector;
import imedix.*;

public class onlinecommunicator extends UnicastRemoteObject implements onlineinterface {
		
	projinfo pinfo;
	dball mydb;
	public onlinecommunicator(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
	}
	
	public String setUserDetalis(String uid,String pswd,String patid)throws RemoteException,SQLException{
	
		String checkLogin=isLoggedin(uid,patid);

		if(checkLogin.equalsIgnoreCase("PRESENT")){
			return ("PRESENT");
		}
		
		String qsql="Select rg_no from login where uid = '" + uid.trim() + "'";
		String doc_regid=mydb.ExecuteSingle(qsql);
		String isql = "insert into confuser(userid,patid,constatus,doc_regid) values('" + uid.trim() + "','" + patid.trim() + "','FREE','" + doc_regid.trim() + "')";
	    String ans = mydb.ExecuteSql(isql);
	    if(ans.equals("Done")) return ("YES");
	    else return ("NO");
                    
	}
	
	public String getAllPatID(String uid)throws RemoteException,SQLException{
		String str=""; 
		String qsql="Select rg_no from login where uid = '" + uid.trim() + "'";
		String doc_regid=mydb.ExecuteSingle(qsql);
		//qsql = "Select pat_id from lpatq where assigneddoc = '" + doc_regid.trim() + "' union Select pat_id from tpatq where assigneddoc = '" + doc_regid.trim() + "' or refer_doc = '" + doc_regid.trim() + "'";
		//qsql = "Select pat_id from lpatq where assigneddoc = '" + doc_regid.trim() + "' and upper(delflag)='N' union Select pat_id from tpatq where assigneddoc = '" + doc_regid.trim() + "' and upper(delflag)='N'";
		qsql = "Select Distinct pat_id from tpatq where ( assigneddoc = '" + doc_regid.trim() + "'  or refer_doc = '" + doc_regid.trim() + "' ) and upper(delflag)='N'";
				
		Object res=mydb.ExecuteQuary(qsql);
 	    if(res instanceof String){
 	    	str="";
 	    }
		else{
			Vector tmp = (Vector)res;
			for(int i=0;i<tmp.size();i++){
				dataobj datatmp = (dataobj) tmp.get(i);
				str = str + datatmp.getValue(0) + '#' + 'N' + ",";		
			}	
		}
		return str;
	}
	
	
	public String disconnectUser(String uid)throws RemoteException,SQLException {
			
		String qsql = "delete from confuser where userid='" + uid.trim () + "'";
		String ans=mydb.ExecuteSql(qsql);
		System.out.println(ans+":"+qsql);
	    if(ans.equals("Done")){
	    	qsql = "delete from confmessage where postedto='" + uid.trim () + "'";
	    	String ans1=mydb.ExecuteSql(qsql);
	    	return ("YES");
		}
		else return ("NO");
	}
	
	public String putMessage(String postedby,String postedto,String message,String status,String patid)throws RemoteException,SQLException{
		
		String qr="",uids="";
		message = message.trim();
		postedby=postedby.trim();
		postedto=postedto.trim();
		patid=patid.trim();
		
		try
         {
         	 message = message.trim();
             String[] msgs = message.split("#");
             String msg1 = msgs[0];
             
             if (msg1.equals("13")){
             	String db_patid=mydb.ExecuteSingle("Select patid from confuser where userid='" + postedby + "'");
             	if(db_patid.equalsIgnoreCase("NoPat")) patid="NoPat";
             }
             
             if (msg1.equals("RA"))
                qr = "Select userid from confuser where userid<>'" + postedby + "'";
             else{
                 if (msg1.equals("3A") || msg1.equals("3S"))
                     qr = "Select userid from confuser where constatus='" + patid + "' and userid<>'" + postedby + "'";
                 else
                 {
                     if (msg1.equals("31"))
                     {
                         qr = "Select userid from confuser where (patid='" + patid + "' or constatus='" + patid + "') and userid<>'" + postedby + "'";
                     }
                     else
                     {
                         qr = "Select userid from confuser where patid='" + patid + "' and userid<>'" + postedby + "'";
                     }
                 }
             }
    		
    		Object res=mydb.ExecuteQuary(qr);
 	    	if(res instanceof String){
 	    		uids="";
 	    		System.out.println(res);
 	    	}else{
				Vector tmp = (Vector)res;
				for(int i=0;i<tmp.size();i++){
					dataobj datatmp = (dataobj) tmp.get(i);
					uids = uids + datatmp.getValue(0) + ",";		
				}	
			}
         }catch (Exception e){
   			uids="";
         }
         
         int a=0;
         
         try
         {
         String[] usr=uids.split(",");
         for (a = 0; a < usr.length; a++)
         {
         	 qr = "";
         	 usr[a]=usr[a].trim();
         	 if(!usr[a].equals("")){
         	 	qr ="insert into confmessage(postedby,postedto,message,status) values('" + postedby + "','" + usr[a] + "','" + message + "','" + status + "')";
             	String ans=mydb.ExecuteSql(qr);
         	 }
         }
     }catch (Exception e){
 		a=0;
     }
     	System.out.println( " putMessage >>> "+Integer.toString(a));
		return Integer.toString(a);
	}
	
	
	
	public String getMessage(String postedto)throws RemoteException,SQLException{
			
		String msgs="";
			
		String qr = "Select postedby,message from confmessage where postedto='" + postedto.trim() +"' and status='N'";
		Object res=mydb.ExecuteQuary(qr);
		try{
			if(res instanceof String){
				msgs="";
				System.out.println(res);
			}else{
				Vector tmp = (Vector)res;
				for(int i=0;i<tmp.size();i++){
					dataobj datatmp = (dataobj) tmp.get(i);
					msgs = msgs + datatmp.getValue(0).trim() +"="+ datatmp.getValue(1).trim()+ "@@imed@@";	
				}	
			}
		}catch (Exception e){
			msgs="";
		}
		
		if (msgs.equalsIgnoreCase("")) msgs="nomsg";
		else{
			msgs=msgs.substring(0,msgs.lastIndexOf("@@imed@@"));
		}
		
	    qr = " update confmessage set status='R' where postedto='" + postedto.trim()  + "' and status='N'";    
		String ans=mydb.ExecuteSql(qr)	;
		
		System.out.println( " getMessage >>> "+msgs);
		
		return msgs;
	
	}
	
	public String joinForConf(String postedby,String patid,String postedtos)throws RemoteException,SQLException{
		
		String selected_doc = postedtos.trim().replace("#","','");
        selected_doc = postedby + "','" + selected_doc;
        String qr = "update confuser set constatus='" + patid.trim() + "' where userid in ('" + selected_doc + "') and constatus='FREE'";
        String ans=mydb.ExecuteSql(qr);
        if(ans.equals("Done")) return ("YES");
        else return ("NO");
	}
	
	
	public String updateConfStatus(String postedby,String patid,String constatus)throws RemoteException,SQLException{
	   	String qr = "update confuser set patid='" + patid.trim() + "', constatus='" + constatus.trim() + "' where userid='" + postedby.trim() + "'";
        String ans=mydb.ExecuteSql(qr);
        if(ans.equals("Done")) return ("YES");
        else return ("NO");
	}
	
	
	public String getOnlineDoc(String postedby,String patid)throws RemoteException,SQLException{
		String online="",busy="",offline="";
		
		String qr = "Select assigneddoc from lpatq where pat_id = '" + patid.trim() + "' and assigneddoc in (select doc_regid from confuser where constatus='FREE')union Select assigneddoc from tpatq where pat_id = '" + patid.trim() + "' and assigneddoc in (select doc_regid from confuser where constatus='FREE')";
		
		try{
			Object res=mydb.ExecuteQuary(qr);
			if(res instanceof String){
				online="";
				System.out.println(res);
			}else{
				Vector tmp = (Vector)res;
				for(int i=0;i<tmp.size();i++){
					dataobj datatmp = (dataobj) tmp.get(i);
					online = online + datatmp.getValue(0).trim()+ ",";
				}	
			}
		}catch (Exception e){
			online="";
			System.out.println("*1** "+qr+">>"+e.toString());
		}
		
		qr = "Select assigneddoc from lpatq where pat_id = '" + patid.trim() + "' and assigneddoc in (select doc_regid from confuser where constatus='BUSY' or constatus='" + patid.trim() + "')union Select assigneddoc from tpatq where pat_id = '" + patid.trim() + "' and assigneddoc in (select doc_regid from confuser where constatus='BUSY'or constatus='" + patid.trim() + "')";
		
		try{
			Object res=mydb.ExecuteQuary(qr);
			if(res instanceof String){
				busy="";
				System.out.println(res);
			}else{
				Vector tmp = (Vector)res;
				for(int i=0;i<tmp.size();i++){
					dataobj datatmp = (dataobj) tmp.get(i);
					busy = busy + datatmp.getValue(0).trim()+ ",";
				}	
			}
		}catch (Exception e){
			busy="";
			System.out.println("*2** "+qr+">>"+e.toString());
		}
		
        qr = "Select assigneddoc from lpatq where pat_id = '" + patid.trim() + "' and assigneddoc not in (select doc_regid from confuser)union Select assigneddoc from tpatq where pat_id = '" + patid.trim() + "' and assigneddoc not in (select doc_regid from confuser)";
                
        try{
			Object res=mydb.ExecuteQuary(qr);
			if(res instanceof String){
				offline="";
				System.out.println(res);
			}else{
				Vector tmp = (Vector)res;
				for(int i=0;i<tmp.size();i++){
					dataobj datatmp = (dataobj) tmp.get(i);
					offline = offline + datatmp.getValue(0).trim()+ ",";
				}	
			}
		}catch (Exception e){
			offline="";
			System.out.println("*3** "+qr+">>"+e.toString());
			
		}
		System.out.println("*4** "+online+">>"+offline+">>"+busy);
		
		String[] online_doc = online.split(",");
		String[] offline_doc = offline.split(",");
        String[] busy_doc = busy.split(",");
        
        System.out.println("*5** >ON>"+online+">OF>"+offline+">B>"+busy);
        System.out.println("Length *6** >ON>"+online_doc.length+">OF>"+offline_doc.length+">B>"+busy_doc.length);
        
        
		if(!online.trim().equals("")){
			online = "";
			
			for (int i = 0; i < online_doc.length; i++)
	             {
	                 qr = "Select uid,center from login where rg_no = '" + online_doc[i].trim() + "'";
	                 Object res=mydb.ExecuteQuary(qr);
	                 if(res instanceof String){
							System.out.println(res);
						}else{
							Vector tmp = (Vector)res;
							if(tmp.size()>0){
								dataobj datatmp = (dataobj) tmp.get(0);
								online = online + datatmp.getValue(0).trim()+"="+datatmp.getValue(1).trim()+"=ONLINE**";						
							}
								
						}
	             }
	        
	        //System.out.println("online** "+online);
	           	
		}
             
        if(!busy.trim().equals("")){
        	busy = "";
        	for (int i = 0; i < busy_doc.length; i++)
             {
                 qr = "Select uid,center from login where rg_no = '" + busy_doc[i].trim() + "'";
                 Object res=mydb.ExecuteQuary(qr);
                 if(res instanceof String){
						System.out.println(res);
					}else{
						Vector tmp = (Vector)res;
						if(tmp.size()>0){
							dataobj datatmp = (dataobj) tmp.get(0);
							busy = busy + datatmp.getValue(0).trim()+"="+datatmp.getValue(1).trim()+"=BUSY**";	
						}
											
							
					}
             }
            //System.out.println("busy** "+busy);
	           		
        } 

        if(!offline.trim().equals("")){
        	offline = "";
        	for (int i = 0; i < offline_doc.length; i++)
             {
                 qr = "Select uid,center from login where rg_no = '" + offline_doc[i].trim() + "'";
                 Object res=mydb.ExecuteQuary(qr);
                 if(res instanceof String){
						System.out.println(res);
					}else{
						Vector tmp = (Vector)res;
						if(tmp.size()>0){
							dataobj datatmp = (dataobj) tmp.get(0);
							offline = offline + datatmp.getValue(0).trim()+"="+datatmp.getValue(1).trim()+"=OFFLINE**";						
						}
					}
				//System.out.println( i+" offline** "+offline+":"+qr);	 
             }   			
        }   
        String str = online.trim() + busy.trim() + offline.trim();
        if (str.equals("")) str = "none";          
        System.out.println( " getOnlineDoc >>> "+str);
        return str;
	}
	
	public String getConfUser(String patid)throws RemoteException,SQLException{
	
			String str = "";
            String qr = "Select userid from confuser where patid='" + patid.trim() + "' and constatus='BUSY'";
            
            try{
				Object res=mydb.ExecuteQuary(qr);
				if(res instanceof String){
					str="";
					System.out.println(res);
				}else{
					Vector tmp = (Vector)res;
					for(int i=0;i<tmp.size();i++){
						dataobj datatmp = (dataobj) tmp.get(i);
						str = str + datatmp.getValue(0).trim()+  "#";
					}	
				}
			}catch (Exception e){
				str="";
			}
	        if (str.equals("")) str = "none";
	        
	        System.out.println( " getConfUser >>> "+str);
            
            
            return str;	
	}
	
	
	public String getImgListForApplet(String patid)throws RemoteException,SQLException{
	
	String ans="",output1="",output2="";
	
	String qSql="select type,serno,entrydate from patimages where upper(pat_id) = '"+patid.toUpperCase()+"' and Upper(type)<>'DCM' Order By serno";

    try{
			Object res=mydb.ExecuteQuary(qSql);
			if(res instanceof String){
				System.out.println(res);
			}else{
				Vector tmp = (Vector)res;
				for(int i=0;i<tmp.size();i++){
					dataobj datatmp = (dataobj) tmp.get(i);
					
					String typ=datatmp.getValue("type").trim();
					String sl=datatmp.getValue("serno").trim();
					
					output1+="#"+typ+"-"+sl;
					String edt = datatmp.getValue("entrydate");
					//edt = edt.substring(8,10)+"/"+edt.substring(5,7)+"/"+edt.substring(0,4);
					String qrstr="id="+patid+"&type="+typ+"&ser="+sl+"&dt="+edt;
					output2+="#"+"?"+qrstr;
				}	
			}
		}catch (Exception e){
			output1="";
			output2="";
		}
		output1=output1.substring(1);
		output2=output2.substring(1);
		
		ans=output1+"@@sep@@"+output2;
		System.out.println("getImgListForApplet>>"+ans);
		return ans;
    	
		
	}
		
	private String isLoggedin(String userid, String patid){
		
		String qr = "Select userid from confuser where userid='" + userid.trim() + "'";
		String str=mydb.ExecuteSingle(qr);
		if (str.equals(userid)) return ("PRESENT");
	    else	return ("NOTPRESENT");
		}
	
  }
  
  