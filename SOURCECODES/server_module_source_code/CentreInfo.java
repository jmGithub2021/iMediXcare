package imedix;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import logger.*;


/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This class used to Manage Centres of the System.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see CentreInfoInterface
 */
public class CentreInfo extends UnicastRemoteObject implements CentreInfoInterface {
		
	projinfo pinfo;
	
	/**
     * Constructor used to create this object.
     * @param p server Configuration class object.
     * @see projinfo
     */
	public CentreInfo(projinfo p) throws RemoteException{
		pinfo=p;
	}
	
	public Object getLCentreInfo()throws RemoteException,SQLException{
       	String query = "select * from center where centertype='S'";
       	System.out.println("Call getLCentreInfo :"+ query);
        dball mydb= new dball(pinfo);
        return mydb.ExecuteQuary(query);
    }
            
    public Object getRCentreInfo(String CCode)throws RemoteException,SQLException{
       	String query = "select * from center where code='"+CCode+"'";
        dball mydb= new dball(pinfo);
        return mydb.ExecuteQuary(query);
    }
    
    public Object getAllCentreInfo()throws RemoteException,SQLException{
       	String query = "select * from center order by code ";
        dball mydb= new dball(pinfo);
        return mydb.ExecuteQuary(query);
    }
    public String getFirstCentreCode()throws RemoteException,SQLException{
    	String query = "select code from center order by code ";
        dball mydb= new dball(pinfo);
        return mydb.ExecuteSingle(query);
    }
    public String getHosName(String CCode)throws RemoteException,SQLException{
       	String query = "Select name from center Where upper(code) = '"+ CCode.toUpperCase() +"'";
        dball mydb= new dball(pinfo);
        return mydb.ExecuteSingle(query);
    }
    
    public int  seveCentreInfo(dataobj obj)throws RemoteException,SQLException {   		
       	return 0;
    }
    
    public int editCentreInfo(dataobj obj)throws RemoteException,SQLException {
       	int ans=0;
		try{
			String code=obj.getValue("code");
    		String qr = "UPDATE center set ";
			qr += " name='"+ obj.getValue("name").replaceAll("'","''") +"',";
			qr += " phone='"+ obj.getValue("phone").replaceAll("'","''") +"',";
			qr += " ipaddress='"+ obj.getValue("ipaddress").replaceAll("'","''") +"',";
			qr += " ftpip='"+ obj.getValue("ftpip").replaceAll("'","''") +"',";
			qr += " ftp_uname='"+ obj.getValue("ftp_uname").replaceAll("'","''") +"',";
			qr += " ftp_pwd='"+ obj.getValue("ftp_pwd").replaceAll("'","''") +"'";
			qr += " where code ='"+ code +"'";
			
			dball mydb= new dball(pinfo);
			String str=mydb.ExecuteSql(qr);
   			System.out.println("str **:"+str);
   			
   			if(str.equalsIgnoreCase("Error")) ans=0;
   			else{
					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("code",code);
					desdtls.add("table","center");
					desdtls.add("details","Update Centre Information");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	
   					ans=1; 		
   			}
	   			
		}catch(Exception e){
			System.out.println("Exception b:"+e.toString());
			ans=0;
		}
       return ans;
    }

	//Added by Durga @22Dec2016
	public int editCentreVisibility(dataobj obj)throws RemoteException,SQLException {
       	int ans=0;
		try{
			String code=obj.getValue("code");
    		String qr = "UPDATE center set ";
			qr += " visibility ='"+ obj.getValue("visibility").replaceAll("'","''") +"' ";
			qr += " where code ='"+ code +"'";
			
			dball mydb= new dball(pinfo);
			String str=mydb.ExecuteSql(qr);
   			System.out.println("str **:"+str);
   			
   			if(str.equalsIgnoreCase("Error")) ans=0;
   			else{
					
////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("code",code);
					desdtls.add("table","center");
					desdtls.add("details","Update Centre Information");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),2,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////
	
   					ans=1; 		
   			}
	   			
		}catch(Exception e){
			System.out.println("Exception b:"+e.toString());
			ans=0;
		}
       return ans;
    }
     
    public int deleteCentreInfo(String ccode,dataobj obj)throws RemoteException,SQLException {
    	
    	String query = "delete from center Where upper(code) = '"+ ccode.toUpperCase() +"'";
        dball mydb= new dball(pinfo);
        mydb.ExecuteSql(query);
        
 ////////////////////////// log //////////////////////////////////////////////////////////////////
					imedixlogger imxlog = new imedixlogger(pinfo);
					dataobj keydtls = new dataobj();
					dataobj desdtls = new dataobj();
					keydtls.add("code",ccode);
					desdtls.add("table","center");
					desdtls.add("details","Delete Centre Information");
					imxlog.putFormInformation(obj.getValue("userid"),obj.getValue("usertype"),3,keydtls,desdtls);
					
/////////////////////////////////////////////// log ////////////////////////////////////////////

        return 1;	
    }
	public String getCenterCode(String id, String tableName) throws RemoteException,SQLException{
		String query="",result="";
		if(tableName.equals("med"))
			query = "select center from login where rg_no=(select referring_doctor from med where pat_id='"+id+"')";
		else if(tableName.equals("login"))
			query = "select center from login where rg_no = '"+id+"'";
		else
			query = "";
		dball mydb= new dball(pinfo);
		result = mydb.ExecuteSingle(query);
		return result;
	}
	public Object presInfoData(String id, String entrydate, String tableName) throws RemoteException,SQLException{
		//String query = "select name,dis,center,(select opdno from med where pat_id='"+id+"') as opdno,(select count(*) from patientvisit where pat_id='"+id+"') as noofvisit,(select DATE_FORMAT(entrydate,'%d-%m-%Y') from med where pat_id='"+id+"') as regDate from login where rg_no = (select attending_person from patientvisit where pat_id='"+id+"' and visitdate<(select entrydate from "+tableName+" where pat_id='"+id+"' order by visitdate desc limit 0,1))";
		//String query = "select name,dis,center,(select opdno from med where pat_id='"+id+"') as opdno,(select count(*) from patientvisit where pat_id='"+id+"') as noofvisit,(select DATE_FORMAT(entrydate,'%d-%m-%Y') from med where pat_id='"+id+"') as regDate from login where rg_no = (select docrg_no from "+tableName+" where entrydate='"+entrydate+"')";
		String query = "select name,dis,center,(select opdno from med where pat_id='"+id+"') as opdno,(select count(*) from patientvisit where pat_id='"+id+"') as noofvisit,(select DATE_FORMAT(entrydate,'%d-%m-%Y') from med where pat_id='"+id+"') as regDate from login where rg_no = (select docrg_no from "+tableName+" where entrydate=cast('"+entrydate+"' as DATETIME))";
		System.out.println("presInfoData : "+query);
		dball mydb= new dball(pinfo);
        return mydb.ExecuteQuary(query);		
	}
	public boolean isValidCenter(String centerCode) throws RemoteException,SQLException{
		String query = "select count(*) as p from center where code = '"+centerCode+"'";
		dball mydb= new dball(pinfo);
		String result = mydb.ExecuteSingle(query);
		int ans = Integer.parseInt(result);
		if(ans>0)
			return true;
		else
			return false;
	}
        
}

















