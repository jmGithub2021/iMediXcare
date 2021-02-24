package imedix;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.security.KeyManagementException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import java.sql.*;
import java.util.*;

/**
 * @author D Durga Prasad
 **/
  
import java.rmi.*;
import java.rmi.server.*;

import imedix.SmsInterface;

public class SmsApi extends UnicastRemoteObject implements SmsInterface{
	
	projinfo pinfo;
	dball mydb;

    public SmsApi(projinfo p) throws RemoteException{
		pinfo=p;
		mydb= new dball(pinfo);
    }

	public Object getSMSTypes() throws RemoteException, SQLException
	{
		String sql="";
     	sql = "select * from sms_type order by msgid";
     	System.out.println("getSMSTypes : "+sql);
		return mydb.ExecuteQuary(sql);
	}

	public Object getSMSType(String msgid) throws RemoteException,SQLException
	{
		String sql = "select * from sms_type where msgid='"+msgid+"'";
     	System.out.println("getSMSType : "+sql);
		return mydb.ExecuteQuary(sql);
	}

	public Object addSMSType(dataobj obj) throws RemoteException,SQLException
	{
		dataobj result = new dataobj();
		result.add("status", "success");

		try{
			String msgid=obj.getValue("msgid");
			String description=obj.getValue("description");
			String params=obj.getValue("params");
			String body=obj.getValue("body");		
			
			String sql = "insert into sms_type(msgid,description,params,body) values ('"+msgid+"','"+description+"','"+params+"','"+body+"')";
			String res = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(res.equalsIgnoreCase("Error")){
				result.setValue("status","Error");
				result.add("message","Could not add SMS Type");
			}
		}catch(Exception e){
			System.out.println("addSMSType: "+ e.toString());
			result.setValue("status","Error");
		}
		return result;
	}


	public Object updateSMSType(String msgid, dataobj obj) throws RemoteException,SQLException
	{
		dataobj result = new dataobj();
		result.add("status", "success");
		try{
			String description=obj.getValue("description");
			String params=obj.getValue("params");
			String body=obj.getValue("body");		
			
			String sql = "update sms_type set description='"+description+"',params='"+params+"',body='"+body+"'  where msgid= '"+msgid+"')";
			String res = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(res.equalsIgnoreCase("Error")){
				result.setValue("status","Error");
				result.add("message","Could not add SMS Type");
			}
		}catch(Exception e){
			System.out.println("addSMSType: "+ e.toString());
			result.setValue("status","Error");
		}
		return result;
	}
	
	public int deleteSMSType(String msgid) throws RemoteException,SQLException
	{
		String sql = "delete from sms_type where msgid='"+msgid+"'";
     	System.out.println("deleteSMSType: "+sql);
		 
		String res = mydb.ExecuteSql(sql);
		if(res == "Error")
			return 0;
		else
			return 1;
	}
   
	public Object getMessages() throws RemoteException, SQLException
	{
     	String sql = "select * from sms_log order by timestamp desc";
     	System.out.println("getMessages : "+sql);
		 
		return mydb.ExecuteQuary(sql);
	}
	
	public Object addLog(dataobj obj) throws RemoteException, SQLException 
	{
		dataobj result = new dataobj();
		result.add("status", "success");
		try{
			String mobno=obj.getValue("mobileno");
			String message=obj.getValue("message");	
			String resultstr=obj.getValue("result");
			String sql = "insert into sms_logs(mobileno,message,result) values ('"+mobno+"','"+message+"','"+resultstr+"')";
			String res = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(res.equalsIgnoreCase("Error")){
				result.setValue("status","Error");
				result.add("message","Could not add SMS Type");
			}
		}catch(Exception e){
			System.out.println("addSMSType: "+ e.toString());
			result.setValue("status","Error");
		}
		return result;
	}
	
	public String makeMessage(String msgid, String[] dataAry)  throws RemoteException, SQLException 
	{
		String sql = "select * from sms_type where msgid='"+msgid+"'";
     	System.out.println("getSMSType : "+sql);
		Vector objMsgVect = (Vector) mydb.ExecuteQuary(sql);
		dataobj obj = (dataobj)objMsgVect.get(0);
		//String msgid=obj.getValue("msgid");
		//String description=obj.getValue("description");
		String params=obj.getValue("params");
		String message=obj.getValue("body");
		int prmCount = Integer.parseInt(params);
		if (prmCount>0) {
			for (int i=0; i< prmCount; i++) {
				message = message.replace("["+i+"]", dataAry[i]);
			}
		}
		return message;
	}
}
