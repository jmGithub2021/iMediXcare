package imedix;

import logger.*;
import org.json.simple.*;
import org.json.simple.parser.*;
import java.io.*;
import java.util.*;
import java.net.URL;


/**
 * <center><b>iMediX Business Logic RMI Server </b></center>
 * <p>
 * Developted at CSE, IIT Kharagpur.
 * <p>
 * This Class used for Manage User Access Control. 
 * @author Surajit Kundu.<br>VIP Lab, IIT Kharagpur
 * @author <a href="mailto:surajit.113125@gmail.com">surajit.113125@gmail.com</a>
 */

public class UserAccessCheck{
	public static boolean isAccessable(String accessPage, String usertype){
		JSONParser parser = new JSONParser();
		try{
			URL jsonURL = UserAccessCheck.class.getClassLoader().getResource("UserAccessControl.json");
			InputStream inputStream = (InputStream)jsonURL.openStream();
			Reader accessReader = new InputStreamReader(inputStream);
			System.out.println("Path UserAccessCheck: "+jsonURL);
			System.out.println("InputStream: "+inputStream);
			System.out.println("Reader: "+accessReader);
			JSONObject jsObj = (JSONObject) parser.parse(accessReader);
			//System.out.println(jsObj);
			JSONArray jsArr = (JSONArray) jsObj.get(accessPage);
			//System.out.println("Array: "+jsArr);
			if(jsArr.contains(usertype) || jsArr.contains("*"))
				return true;
			else
				return false;
		}catch(Exception ex){
			System.out.println("Err is isAccessable()/accessPage is not mapped : "+ex.toString());
			return false;
		}
	}
}