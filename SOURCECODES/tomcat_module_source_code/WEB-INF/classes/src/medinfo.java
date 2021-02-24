package imedix;

import java.io.*;
import org.json.simple.*;
import org.json.simple.parser.*;
import imedix.dataobj;


public class medinfo{
	 private String home="";
	 private dataobj sex;
	 private dataobj marital;
	 private dataobj age;
	 private dataobj state;
	 private dataobj country;
	 private dataobj race;
	 private dataobj caste;
	 private dataobj district;
	 private dataobj appellation;
	 private dataobj religion;
	 
	public medinfo( String path){
		home=path;
		System.out.println(home);	 
		sex=new dataobj();
		marital=new dataobj();
		age=new dataobj();
		state=new dataobj();
		country=new dataobj();
		race=new dataobj();
		caste=new dataobj();
		district = new dataobj();
		appellation = new dataobj();
		religion = new dataobj();
		setValues();
	
	}
	
	public dataobj getSexValues(){
		return sex;	
	}
	
	public dataobj getMaritalValues(){
		return marital;	
	}
	
	public dataobj getAgeValues(){
		return age;	
	}
	
	public dataobj getStateValues(){
		return state;	
	}
	
	public dataobj getCountryValues(){
		return country;	
	}
	
	public dataobj getRaceValues(){
		return race;	
	}
	
	public dataobj getCasteValues(){
		return caste;	
	}
	
	public dataobj getDistrictValues(){
		return district;
	}
	
	public dataobj getAppellationValues(){
		return appellation;
	}
	
	public dataobj getReligionValues(){
		return religion;
	}
	
	private void setValues(){
	
	String line="";
		 
	try {
       BufferedReader br = new BufferedReader(new FileReader(home+"jsystem/sex.txt"));
       while ((line = br.readLine()) != null) { 
       
       if(!line.equals("")){
         String [] vl=line.split(">");
         sex.add(vl[0],vl[1]);
       	  
       	 }
       	
       } // end while 
       br.close();
     } catch (IOException e) {
       	System.err.println("Error: " + e);
     }
     
     
     try {
       BufferedReader br = new BufferedReader(new FileReader(home+"jsystem/marital.txt"));
       while ((line = br.readLine()) != null) { 
         if(!line.equals("")){
         	String[] vl=line.split(">");
       	 	marital.add(vl[0],vl[1]);
       	 }
       	
       } // end while 
       br.close();
     } catch (IOException e) {
       	System.err.println("Error: " + e);
     }
     
     try {
       BufferedReader br = new BufferedReader(new FileReader(home+"jsystem/age.txt"));
       while ((line = br.readLine()) != null) { 
       
         if(!line.equals("")){
         	String[] vl=line.split(">");
       	 	age.add(vl[0],vl[1]);
       	 }
       	
       } // end while 
       br.close();
     } catch (IOException e) {
       	System.err.println("Error: " + e);
     }
     
   /*  try {
       BufferedReader br = new BufferedReader(new FileReader(home+"jsystem/state.txt"));
       while ((line = br.readLine()) != null) { 
         if(!line.equals("")){
         String[] vl=line.split(">");
       	 state.add(vl[0],vl[1]);
       	 }
       	
       } // end while 
       br.close();
     } catch (IOException e) {
       	System.err.println("Error: " + e);
     }*/
	try{
		FileReader jsonContent = new FileReader(new File(home+"jsystem/MDDS_demographic/statecode.json"));
		Object obj = new JSONParser().parse(jsonContent);
		JSONObject jsobj = (JSONObject)obj;
		JSONArray nodes = (JSONArray)jsobj.get("nodes");
		int no_of_state = nodes.size();
		for(int i=0;i<no_of_state;i++){
			JSONObject jo = (JSONObject)nodes.get(i);
			state.add(jo.get("state_code").toString(),jo.get("state_name").toString());
		}
	}catch(Exception ex){System.err.println("Error: " + ex);}     

	try{
		FileReader jsonContent = new FileReader(new File(home+"jsystem/MDDS_demographic/districtcode.json"));
		Object obj = new JSONParser().parse(jsonContent);
		JSONObject jsobj = (JSONObject)obj;
		JSONArray nodes = (JSONArray)jsobj.get("nodes");
		int no_of_dist = nodes.size();
		for(int i=0;i<no_of_dist;i++){
			JSONObject jo = (JSONObject)nodes.get(i);
			district.add(jo.get("district_code").toString(),jo.get("district_name").toString());
		}
	}catch(Exception ex){System.err.println("Error: " + ex);} 
     
	try{
		FileReader jsonContent = new FileReader(new File(home+"jsystem/MDDS_demographic/appellation.json"));
		Object obj = new JSONParser().parse(jsonContent);
		JSONObject jsobj = (JSONObject)obj;
		JSONArray nodes = (JSONArray)jsobj.get("nodes");
		int no_of_appl = nodes.size();
		for(int i=0;i<no_of_appl;i++){
			JSONObject jo = (JSONObject)nodes.get(i);
			appellation.add(jo.get("appliation_code").toString(),jo.get("values").toString());
		}
	}catch(Exception ex){System.err.println("Error: " + ex);}  
	 
	try{
		FileReader jsonContent = new FileReader(new File(home+"jsystem/MDDS_demographic/religion.json"));
		Object obj = new JSONParser().parse(jsonContent);
		JSONObject jsobj = (JSONObject)obj;
		JSONArray nodes = (JSONArray)jsobj.get("nodes");
		int no_of_religion = nodes.size();
		for(int i=0;i<no_of_religion;i++){
			JSONObject jo = (JSONObject)nodes.get(i);
			religion.add(jo.get("religion_code").toString(),jo.get("religion_values").toString());
		}
	}catch(Exception ex){System.err.println("Error: " + ex);}  	
	   
     try {
       BufferedReader br = new BufferedReader(new FileReader(home+"jsystem/country.txt"));
       while ((line = br.readLine()) != null) { 
         if(!line.equals("")){
         String[] vl=line.split(">");
       	 country.add(vl[0],vl[1]);
       	 }
       	
       } // end while 
       br.close();
     } catch (IOException e) {
       	System.err.println("Error: " + e);
     }
     
     try {
       BufferedReader br = new BufferedReader(new FileReader(home+"jsystem/race.txt"));
       while ((line = br.readLine()) != null) { 
         if(!line.equals("")){
         String[] vl=line.split(">");
       	 race.add(vl[0],vl[1]);
       	 }
       	
       } // end while 
       br.close();
     } catch (IOException e) {
       	System.err.println("Error: " + e);
     }
     
	try {
       BufferedReader br = new BufferedReader(new FileReader(home+"jsystem/caste.txt"));
       while ((line = br.readLine()) != null) { 
         if(!line.equals("")){
         String[] vl=line.split(">");
       	 caste.add(vl[0],vl[1]);
       	 }
       	
       } // end while 
       br.close();
     } catch (IOException e) {
       	System.err.println("Error: " + e);
     }

		
	}	
	
	
}
	
