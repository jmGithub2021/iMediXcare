package logger;

import java.rmi.*;
import java.sql.*;
import java.rmi.server.*;
import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.xml.sax.*;
import imedix.*;
import java.util.Date;


public class imedixlogger extends UnicastRemoteObject implements imedixloggerInterface {
		
	projinfo pinfo;
	
	public imedixlogger(projinfo p) throws RemoteException{
		pinfo=p;
	}
	
	/* 1. Success > Successful login	 2. Failure > Login Failed 	3. Logout > SESSION CLOSED 4. Unknown */
	public void putLoginDetails(String uid, String utype,int evtType)throws RemoteException,SQLException{
	
	String act="";
	String ltype="Authentication";
	dataobj desdtls = new dataobj();
	
	switch(evtType){
		case 1: desdtls.add("details","Successful login");break;
		case 2: desdtls.add("details","Login Failed"); break;
		case 3: desdtls.add("details","Session Closed"); break;
		default: desdtls.add("details","Unknown"); break;
	}
	writeLogsToFile(uid,utype,ltype,"Select",null,desdtls);
		
	}
	
	/* 1. Insert 	 2. Edit  	3. Delete  4. Unknown */
	public void putFormInformation(String uid, String utype,int evtType,dataobj keydtls,dataobj desdtls )throws RemoteException,SQLException{
	String act="";
	String ltype="Information";
	switch(evtType){
		case 1: act="Insert"; break;
		case 2: act="Edit"; break;
		case 3: act="Delete"; break;
		default: act="Unknown"; break;
	}
		writeLogsToFile(uid,utype,ltype,act,keydtls,desdtls);
		
	}
	
	private String getLogPath(){
	    String dt = myDate.getCurrentDate("dmy",false);
	    String Path =pinfo.SystemLoggerPath;
	    File fp = new File (Path);
	    if(fp.exists()==false) fp.mkdirs();
	    Path += "/"+getLogFileName();
	    return Path;
   }
   
   private String getLogFileName(){
	    String dt = myDate.getCurrentDate("dmy",false);
	    String fn = dt + "AccessLog.xml";
	    return fn;
   }
  
  
   private void writeLogsToFile(String userid, String usertype,String logtype,String action,dataobj keydtls,dataobj desdtls){
   	
   	if(pinfo.SystemLogger.equalsIgnoreCase("yes")){
   		
	   		try {
				System.out.println("Log Path : "+getLogPath());
	   		File logfn= new File(getLogPath());
	        boolean isFnEx=logfn.exists();
	        FileWriter fw =null;
	        if(isFnEx==false){
	   	  		fw= new FileWriter(logfn,false);
	   	  		fw.write("<imedixlog>\r\n</imedixlog>");
	   	  	}else{
	   	  		fw= new FileWriter(logfn,true);	
	   	  	}
	   	  	fw.close();
	   	  	
	   	  	DocumentBuilderFactory dbfac = DocumentBuilderFactory.newInstance();
	        DocumentBuilder docBuilder = dbfac.newDocumentBuilder();
	        Document doc = docBuilder.newDocument();
	        Document readdoc = docBuilder.parse(logfn);
	//      normalize text representation
	        readdoc.getDocumentElement ().normalize ();
	        Node rootList = readdoc.getDocumentElement();
	               
	        Element rootElement = (Element)rootList;
	        //System.out.println("***"+rootElement.getNodeName());
	        
	      Element log = readdoc.createElement("log");
	      rootElement.appendChild(log);
	      
	      Element date = readdoc.createElement("datetime");
	      date.setTextContent(new Date().toString());
	      log.appendChild(date);
	      
	      Element type = readdoc.createElement("type");
	      type.setTextContent(logtype);
	      log.appendChild(type);
	      
	      Element eaction = readdoc.createElement("action");
	      eaction.setTextContent(action);
	      log.appendChild(eaction);
	      
	      Element euserid = readdoc.createElement("userid");
	      euserid.setTextContent(userid);
	      log.appendChild(euserid);
	      
	      Element eusertype = readdoc.createElement("usertype");
	      eusertype.setTextContent(usertype);
	      log.appendChild(eusertype);
	      
	      //System.out.println("1****************************");
	      if(keydtls!=null){
	      	if(keydtls.getLength()>0){
	      		Element key = readdoc.createElement("key");
	      		for(int i=0;i<keydtls.getLength();i++){
	      			Element keyval = readdoc.createElement(keydtls.getKey(i));
	      			keyval.setTextContent(keydtls.getValue(i));	 
	      			key.appendChild(keyval); 
	      		}
	      		log.appendChild(key);
	      	}
	      }
	      
	     // System.out.println("2****************************");
	      
	      if(desdtls!=null){
	      //	System.out.println("3****************************");
	      	if(desdtls.getLength()>0){
	      //		System.out.println("4****************************");
	      		Element key = readdoc.createElement("description");
	      		for(int i=0;i<desdtls.getLength();i++){
	      			Element keyval = readdoc.createElement(desdtls.getKey(i));
	      			keyval.setTextContent(desdtls.getValue(i));	 
	      			key.appendChild(keyval); 
	      		}
	      		log.appendChild(key);
	      	}
	      }
	      
	     // System.out.println("5****************************");
	     
	     
        //set up a transformer
        TransformerFactory transfac = TransformerFactory.newInstance();
        Transformer trans = transfac.newTransformer();
        trans.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");
        trans.setOutputProperty(OutputKeys.METHOD, "xml");  
        trans.setOutputProperty(OutputKeys.INDENT, "yes");
 		
        StreamResult result = new StreamResult(logfn);
        DOMSource source = new DOMSource(readdoc);
        trans.transform(source, result);
         
	      	      
   		}catch (Exception e){	
   		
   		System.out.println( "writeLogsToFile : "+e.toString());
		}
   	}
   	
   }  	
 }
   
