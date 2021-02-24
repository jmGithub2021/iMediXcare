
package imedix;

import java.io.*;


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
 
public class data implements Serializable{
	
	private String key;
	private String value;
	
	/**
     * Constructor used to create a object.
     */
     
	public data(){
	}
	
	/**
     * Constructor used to create a object.
     * @param  k		Key.
 	 * @param  v		Value.
     */
	public data(String k,String v){
		this.key = k;
		this.value = v;
	}
	
	/**
 	* Method used to get name of Key.
 	* @return    	Name of key.
 	*/
	public String getkey(){
		return key;
	}
	
	/**
 	* Method used to get Value.
 	* @return    	Value of key.
 	*/
	public String getvalue(){
		return value;
	}
	
	/**
 	* Method used to Set the Name of Key.
 	* @param  k		Name of the key. 
 	*/
 	
	public void setkey(String k){
		this.key = k;
	}
	
	/**
 	* Method used to Set the Value.
 	* @param  v		Value. 
 	*/
	public void setvalue(String v){
		this.value = v;
	}
	
	}