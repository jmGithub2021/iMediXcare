package imedix;
import java.util.HashMap;
import java.rmi.*;
import java.sql.*;
import java.rmi.registry.*;
import java.util.Vector;

public class rcItemlistInfo{
	
	private static ItemlistInfoInterface iliserver=null;
	private Registry registry;
	projinfo proj;
	
	public rcItemlistInfo(String p){
	   try{
   	   // value will be read from file;
   	   proj= new projinfo(p);
   	   
   	   registry=LocateRegistry.getRegistry(proj.blip, Integer.parseInt(proj.blport));
	   iliserver= (ItemlistInfoInterface)(registry.lookup("ItemlistInfo"));
	         	   
   	  }catch(Exception ex){
   	  	  System.out.println(ex.getMessage());
   	  }
	}
	
	public Object getListOfForms(String id,String p)throws RemoteException,SQLException {
		return iliserver.getListOfForms(id,p);
		
	}
     public Object getListOfPrs(String id)throws RemoteException,SQLException {
     	return iliserver.getListOfPrs(id);
     }
     public Object getListOfTsr(String id)throws RemoteException,SQLException {
     	return iliserver.getListOfTsr(id);
     }

     public Object getListOfImages(String id) throws RemoteException,SQLException{
     	return iliserver.getListOfImages(id);
     }
     public Object getListOfImagesDtl(String id,String type, String dt1,String dt2) throws 
     RemoteException,SQLException{
     	return iliserver.getListOfImagesDtl(id,type,dt1,dt2);
     }
     
     public Object getListOfVectors(String id) throws RemoteException,SQLException{
     	return iliserver.getListOfVectors(id);
     }
     public Object getListOfVectorsDtl(String id) throws RemoteException,SQLException{
     	return iliserver.getListOfVectorsDtl(id);
     }
     
     public Object getListOfDicoms(String id ) throws RemoteException,SQLException{
     	return iliserver.getListOfDicoms(id);
     }
     public Object getListOfDicomsDtl(String id, String dt1,String dt2) throws RemoteException,
     SQLException{
     	return iliserver.getListOfDicomsDtl(id,dt1,dt2);
     }
     
     public Object getListOfDocuments(String id) throws RemoteException,SQLException{
     	return iliserver.getListOfDocuments(id);
     }
     public Object getListOfDocumentsDtl(String id,String type, String dt1,String dt2) throws 
     RemoteException,SQLException{
     	return iliserver.getListOfDocumentsDtl(id,type,dt1,dt2);
     }
     
     public Object getListOfMovies(String id) throws RemoteException,SQLException{
     	return iliserver.getListOfMovies(id);
     }
     
     public Object getListOfMoviesDtl(String id,String dt1,String dt2) throws RemoteException,
     SQLException{
     	return iliserver.getListOfMoviesDtl(id,dt1,dt2);
     }
     
     public String  getVisitWiseInfo(String id) throws RemoteException,SQLException{
     	
     	dataobj obj= (dataobj) iliserver.getVisitWiseInfo(id);
     	String tempstr="";
		boolean started=false;
		int total_visit=obj.getLength();
		
		System.out.println("total_visit :"+total_visit);
		
     	for (int i = 0; i <obj.getLength(); i++){
     		String key=obj.getKey(i);
     		String val=obj.getValue(i);
     		if(key.equalsIgnoreCase("Year")){
				if (started) tempstr += "</div>";
                tempstr += "<b><span style='cursor:hand;background-color:#C7EBFA;height:20px;color:#0000FF;font-family:verdana;font-size:10pt;display:block;width:96%;padding:2 0 2 7;margin:1px' onclick='show_hide(\"main_" + i + "\", " + total_visit + ")'>Year " + val + "</span></b>";
                tempstr += "<div id=\"main_" + i + "\" style=\"visibility:visible;\">";
                started = true;
     		}else{
     			 tempstr += "<a href='#' style='font-family:verdana;font-size:8pt;text-decoration:none;padding:2 0 2 7;display:block;width:96%' onclick='fold_unfold(\"sub_" + i + "\", " + total_visit + ")'>" + key + "</a><span class='glyphicon'></span>";
                 tempstr += "<div id=\"sub_" + i + "\" style=\"padding-left:10;visibility:hidden;display:none\">" + val + "</div>";
     		}
     	}
     	
     	if (started) tempstr += "</div>";
     	
     	System.out.println("tempstr >>>> ****** :"+tempstr);
     	
		return tempstr;
		
     }
     
     public Object getRadiologyCount(String id) throws RemoteException,SQLException{
     
     	return iliserver.getRadiologyCount(id);
     }
     
     public Object getRadiologyInfo(String id, String radiotype) throws RemoteException,SQLException{
     	
     	return iliserver.getRadiologyInfo(id,radiotype);	
	 }
	 
	 public String getImageDesc(String typ) throws RemoteException,SQLException{

		return iliserver.getImageDesc(typ);
	 }
	public Object getVisitList(String id) throws RemoteException,SQLException{
		return iliserver.getVisitList(id);
		//dataobj obj= (dataobj) iliserver.getVisitList(id);
     	/*String tempstr="";
		boolean started=false;
		int total_visit=obj.getLength();
		
		System.out.println("total_visit :"+total_visit);
		
     	for (int i = 0; i <obj.getLength(); i++){
     		String key=obj.getKey(i);
     		String val=obj.getValue(i);
     		if(key.equalsIgnoreCase("Year")){
				if (started) tempstr += "</div>";
                tempstr += "<b><span onclick='show_hide(\"main_" + i + "\", " + total_visit + ")'>Year " + val + "</span></b>";
                tempstr += "<div id=\"main_" + i + "\">";
                started = true;
     		}else{
				//int k = i+1;
				if(i==1){
					tempstr += "<a class='' href='Javascript:void(0)' data-toggle='collapse' data-target=\"#visit_" + i + "\">" + key + "</a>";
					tempstr += "<div id=\"visit_" + i + "\" class=\"collapse in\">" + val + "</div>";
				}else{
					tempstr += "<a class='collapsed' href='Javascript:void(0)' data-toggle='collapse' data-target=\"#visit_" + i + "\">" + key + "</a>";
					tempstr += "<div id=\"visit_" + i + "\" class=\"collapse\">" + val + "</div>";					
					}
     		}
     	}
     	
     	if (started) tempstr += "</div>";
     	
     	System.out.println("tempstr >>>> ****** :"+tempstr);
     	
		return tempstr;*/
	}
	public Object getImagesListTable(String id,String dt1, String dt2) throws RemoteException,SQLException{
		return iliserver.getImagesListTable(id,dt1,dt2);
	}
	public Object getDocListTable(String id,String dt1, String dt2) throws RemoteException,SQLException{
		return iliserver.getDocListTable(id,dt1,dt2);
	}
	public Object getMoviesListTable(String id,String dt1, String dt2) throws RemoteException,SQLException{
		return iliserver.getMoviesListTable(id,dt1,dt2);
	}
  	public Object getDicomListTable(String id,String dt1, String dt2) throws RemoteException,SQLException{
		return iliserver.getDicomListTable(id,dt1,dt2);
	}
 	public Object getAdvicedListTable(String id,String dt1, String dt2,String priority) throws RemoteException,SQLException{
			return iliserver.getAdvicedListTable(id,dt1,dt2,priority);
	} 	
	}
