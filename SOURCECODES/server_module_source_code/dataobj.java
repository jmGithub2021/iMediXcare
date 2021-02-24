package imedix;
 
import java.util.Vector;
import java.io.*;
import java.util.*;

/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at Telemedicine Lab, IIT Kharagpur.
 * <p>
 * This class used to store data.
 * @author Saikat Ray.<br>Telemedicine Lab, IIT Kharagpur
 * @author <a href="mailto:skt.saikat@gmail.com">skt.saikat@gmail.com</a>
 * @see CentreInfo
 */
 
public class dataobj implements Serializable{
	
	private Vector vd;
	private int cpos;
	
	/**
     * Constructor used to create a object.
     */
     
	public dataobj(){
		vd=new Vector ();
		cpos=0;	
	}
	
	/**
 	* Method used to add any object.  
 	* @param  d		Any Object.
  	* @see        	data
 	*/     
	public void add(Object d){
		vd.add(cpos,d);
		cpos=cpos+1;
	}
	
	/**
 	* Method used to add a value with a key.  
 	* @param  k		Key.
 	* @param  v		Value.
  	* @see        	data
 	*/ 
	public void add(String k, String v){
		vd.add(cpos,new data(k,v));
		cpos=cpos+1;
	}
	
	/**
 	* Method used to remove last value.  
 	*/ 
 		
	public void removeLast(){
		cpos=cpos-1;
		vd.remove(cpos);
	}
	
	/**
 	* Method used to remove the value assign with a key. 
 	* @param  key		Nmae of a key for find. 
 	*/ 
 	
	public void remove(String key){
		int ind;
		if((ind = findbykey(key)) > -1) vd.remove(ind);
	}
	
	/**
 	* Method used to replace the value assign with a key. 
 	* @param  key		Nmae of a key for find. 
 	* @param  newval	New Value of the key. 
 	*/ 
 	
	public void replace(String key,String newval){
		int ind;
		if((ind = findbykey(key)) > -1) vd.setElementAt(new data(key,newval),ind);
		else{
			add(key,newval);
		}
	
	}
	
	/**
 	* Method used to point the first value. 
 	*/ 
 		
	public void gotop(){
		cpos=0;	
	}
	
	/**
 	* Method used to point the next value from current position. 
 	*/ 
 	
	public void next(){
		cpos=cpos+1;	
	}
	
	/**
 	* Method used to point the previous value from current position. 
 	*/ 
	public void prev(){
		cpos=cpos-1;	
	}
	
	/**
 	* Method used to get name of Key of current position.
 	* @return    	Name of key.
 	*/
 	
	public String getKey(){
		if(cpos<0 || cpos>=vd.size()) return "";
		else{
			data tmp = (data) vd.get(cpos);
			return tmp.getkey();		
		}
	}
	
	/**
 	* Method used to get the Value of current position. 
 	* @return    	Value of a key.
 	*/
 	
	public String getValue(){
		if(cpos<0 || cpos>=vd.size()) return "";
		else{
			data tmp = (data) vd.get(cpos);
			return tmp.getvalue();	
		}	
	}
	
	/**
 	* Method used to get total no of element. 
 	*/
 	
	public int getLength(){
		return vd.size();		
	}
	
	/**
 	* Method used to get name of key assign with a Value. 
 	* @param  value		Value for find Key. 
 	* @return    		Name of key.
 	*/ 
 		
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
	
	/**
 	* Method used to get the value assign with a key. 
 	* @param  key		Nmae of a key for find.
 	* @return    		Value of a key.
 	*/ 
 	
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
	
	/**
 	* Method used to get name of key from a position. 
 	* @param  i		position of a element. 
 	* @return    	Name of key.
 	*/ 
 	
	public String getKey(int i){
		String vl="";
		data tmp = (data) vd.get(i);
		vl=tmp.getkey();	
		return vl;
	}
	
		
 	/**
 	* Method used to get the value from a position. 
 	* @param  i		position of a element. 
 	* @return    	Value of a key.
 	*/ 
 	
	public String getValue(int i){
		String vl="";
		data tmp = (data) vd.get(i);
		vl=tmp.getvalue();
		return vl;
	}
	
	/**
 	* Method used to SET the value of a Key. 
 	* @param  key		Nmae of a key for find. 
 	* @param  nval	New Value of the key. 
 	*/ 
 	
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
	
	/**
 	* Method used to SET the value of a position. 
 	* @param  i		position of a element.  
 	* @param  nval	New Value of the key. 
 	*/ 
 	
	public void setValue(int i,String nval){
		String vl="";
		data tmp = (data) vd.get(i);
		tmp.setvalue(nval);
		//return vl;
	}
	

	/**
 	* Unused Method on our system.  
 	*/
 	
	public String getAllKey(){
		String vl="";
		
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			vl=vl+","+tmp.getkey();
		}
		vl=vl.substring(1);
	//	System.out.print(vl);
		
		return vl;
	}
	
	/**
 	* Unused Method on our system.  
 	*/
 	
	public String getAllValue(){
		String vl="";
		
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			System.out.println(i+" "+tmp.getvalue());
			vl=vl+","+tmp.getvalue();
		}
		
		vl=vl.substring(1);
	//	System.out.println(vl);
		
		return vl;
	}
	
	/**
 	* Unused Method on our system.  
 	*/
	public String getAllQValue(){
		String vl="";
		
		for(int i=0; i<vd.size();i++){
			data tmp = (data) vd.get(i);
			vl=vl+",'"+tmp.getvalue()+"'";
		}
		
		vl=vl.substring(1);
	//	System.out.print(vl);
		
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