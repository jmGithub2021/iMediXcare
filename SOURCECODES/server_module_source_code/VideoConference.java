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
 * @author Mithun Sarkar
 **/
  
import java.rmi.*;
//import java.sql.*;
import java.rmi.server.*;
// import java.util.Date;
// import java.util.StringTokenizer;
// import java.util.Vector;
// import java.io.*;
// import logger.*;

import imedix.SmsInterface;

public class VideoConference extends UnicastRemoteObject implements VideoConferenceInterface{
	
	projinfo pinfo;
	dball mydb;
	private String username, password, senderId, secureKey;

    public VideoConference(projinfo p) throws RemoteException{
		
		pinfo=p;
		mydb= new dball(pinfo);
		username = "Wbdhfw";
		password = "SMS@hfw1";
		senderId = "something";
		secureKey = "somekey";
    }

	@Override
    public String SayHello(String msg) throws RemoteException {
        System.out.println("Received: "+msg);
        return "Hello from VideoConference: "+msg;
    }
    
    public Object StartConference(String room) throws RemoteException {
		dataobj result = new dataobj();
		result.add("status", "success");

		try{
			String sql = "insert into vidconf_meeting (meeting_id) values ('"+room+"')";
			String res = mydb.ExecuteSql(sql);
			System.out.println(sql);
			if(res.equalsIgnoreCase("Error")){
				result.setValue("status","Error");
				result.add("message","Could not start the meeting");
				System.out.println("VideoConference: Could not start the meeting");
			}
		}catch(Exception e){
			System.out.println("VideoConference: "+ e.toString());
			result.setValue("status","Error");
			result.add("message", e.toString());
		}
		return result;
	}


	public Object StopConference(String room) throws RemoteException {
		dataobj result = new dataobj();
		result.add("status", "success");

		try{
			String qr = "UPDATE vidconf_meeting set ";
			qr += " active = false";
			qr += " where meeting_id ='"+ room +"'";
		
			String str=mydb.ExecuteSql(qr);
			System.out.println("str **:"+str);
			
			if(str.equalsIgnoreCase("Error")){
				result.setValue("status","Error");
				result.add("message","Could not stop the meeting");
				System.out.println("VideoConference: Could not stop the meeting");
			}   			   			
		}catch(Exception e){
			System.out.println("VideoConference: "+ e.toString());
			result.setValue("status","Error");
			result.add("message", e.toString());
		}		
		return result;
	}

	public Object GetDoctors() throws RemoteException{
		String sql="";
     	sql = "select * from login where type='doc'";
     	System.out.println("getUsers : "+sql);
		 
		return mydb.ExecuteQuary(sql);
	}

	
    
}
