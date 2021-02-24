/**
 * @author Saikat Ray
 **/
 
package imedix;
 
import java.util.Vector;
import java.io.*;
import java.util.*;

public class dataobj implements Serializable{
	private Vector vd;
	private int cpos;
	
	public dataobj(){
		vd=new Vector ();
		cpos=0;	
	}
		
	public void add(Object d){
		vd.add(cpos,d);
		cpos=cpos+1;
	}
	
	public void add(String k, String v){
		vd.add(cpos,new data(k,v));
		cpos=cpos+1;
	}
	
	
	
	
	public void removeLast(){
		cpos=cpos-1;
		vd.remove(cpos);
	}
	
	public void remove(String key){
		int ind;
		if((ind = findbykey(key)) > -1) vd.remove(ind);
	}
	
	public void replace(String key,String newval){
		int ind;
		if((ind = findbykey(key)) > -1) vd.setElementAt(newval,ind);
		else{
			add(key,newval);
		}
	
	}
	
	
	
	public void gotop(){
		cpos=0;	
	}
	
	public void next(){
		cpos=cpos+1;	
	}
	
	public void prev(){
		cpos=cpos-1;	
	}
	
	public String getKey(){
		if(cpos<0 || cpos>=vd.size()) return "";
		else{
			data tmp = (data) vd.get(cpos);
			return tmp.getkey();		
		}
	}
	
	public String getValue(){
		if(cpos<0 || cpos>=vd.size()) return "";
		else{
			data tmp = (data) vd.get(cpos);
			return tmp.getvalue();	
		}	
	}
	
	public int getLength(){
		return vd.size();		
	}
	
		
	public String getKey(String value){
	
	String vl="";
		
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			if(tmp.getvalue().equals(value)){
				vl=tmp.getkey();
				break;
			}
		}
		
		return vl;
	}
	
	public String getValue(String key){
		String vl="";
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			if(tmp.getkey().equals(key)){
				vl=tmp.getvalue();
				break;
			}
		}
		return vl;
	}
	
	public String getKey(int i){
		String vl="";
		data tmp = (data) vd.get(i);
		vl=tmp.getkey();	
		return vl;
	}
	
	public String getValue(int i){
		String vl="";
		data tmp = (data) vd.get(i);
		vl=tmp.getvalue();
		return vl;
	}
	
	public void setValue(String key,String nval){
		String vl="";
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			if(tmp.getkey().equals(key)){
				//vl=tmp.getvalue();
				tmp.setvalue(nval);
				break;
			}
		}
		
		//return vl;
	}
	
	public void setValue(int i,String nval){
		String vl="";
		data tmp = (data) vd.get(i);
		tmp.setvalue(nval);
		//return vl;
	}
	
	
	
	public String getAllKey(){
		String vl="";
		
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			vl=vl+","+tmp.getkey();
		}
		
		vl=vl.substring(1);
		System.out.print(vl);
		
		return vl;
	}
	
	public String getAllValue(){
		String vl="";
		
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			System.out.println(i+" "+tmp.getvalue());
			vl=vl+","+tmp.getvalue();
		}
		
		vl=vl.substring(1);
		System.out.println(vl);
		
		return vl;
	}
	
	public String getAllQValue(){
		String vl="";
		
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			vl=vl+",'"+tmp.getvalue()+"'";
		}
		
		vl=vl.substring(1);
		System.out.print(vl);
		
		return vl;
		
	}
	
		
	private int findbykey(String key){
		int ans=-1;
		
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			if(tmp.getkey().equals(key)){
				ans=i;
				break;
			}
		}
		return ans;
	}
	
	
}