package imedix;

import java.io.*;

public class data implements Serializable{
	
	private String key;
	private String value;
	
	public data(){
	
	}
	
	public data(String k,String v){
		this.key = k;
		this.value = v;
		
	}
	
	public String getkey(){
		return key;
	}
	
	public String getvalue(){
		return value;
	}
	
	public void setkey(String k){
		this.key = k;
	}
	
	public void setvalue(String v){
		this.value = v;
	}
	
	}