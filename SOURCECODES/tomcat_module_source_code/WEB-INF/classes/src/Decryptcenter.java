/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package imedix;
import imedix.rcGenOperations;
import imedix.rcCentreInfo;
import imedix.dataobj;
import imedix.cook;
import java.util.regex.Pattern;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;

import java.util.*;
import java.text.*;


/** @brief This Decryption module implement an application
 *  that simply take two parameters(Encrypted String and Current directory as a String) and return the decrypted String(CenterId and CenterName).  
 *  Then it call a Java rmi method with this two arguments(CenterId and CenterName) to save this data in database. 
 */

public class Decryptcenter {
   // final String sKey = "$8%1GW#$W%^%E%$E"; 
   /** @brief This function mainly decrypt the encrypted string using Java Advanced Encryption Standard algorithm(AES).
    * 
    */
    public static String decrypt(String strToDecrypt, String key) throws Exception {
        try {
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5PADDING");
            final SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            final String decryptedString = new String(cipher.doFinal(Base64.decodeBase64(strToDecrypt.getBytes())));
            return decryptedString;
        } catch (Exception e) {
            throw e;
        }
    }
/** @brief This function check that encrypted string is decrypted in proper format and return correct output.
 * 
 */ 
    public static String getCheckSumValue(String content) {
        return DigestUtils.md5Hex(content);
    }

    String randomString( int len ){
       String AB = "0123456789";
       StringBuilder sb = new StringBuilder( len );
       for( int i = 0; i < len; i++ ) 
          sb.append( AB.charAt( getRandomBetween(0, AB.length()-1) ));
       return sb.toString();
    }    
    
    int getRandomBetween(int Min, int Max)
    {
        return Min + (int)(Math.random() * ((Max - Min) + 1));
    }
      
    public String decryptLicString(String encdata) throws Exception {
        //YOU MAY VERIFY
        String decStr="";
        int num = Integer.parseInt(encdata.substring(0, 2));
        String removedGarbage = encdata.substring(num+2);
        //System.out.println("Num:" + num);
        //System.out.println("Str1:" + str1); //tested okay
        String outputKey = removedGarbage.substring(0, 16);
        //System.out.println("outputKey:" + outputKey); //tested okay
        String removedKey = removedGarbage.substring(16);
        //System.out.println("removedKey:" + removedKey); //tested okay
        String decString = removedKey.substring(5);
        //System.out.println("decString: " + decString);
        String outString = this.decrypt(decString, new String(outputKey));
        //System.out.println("decText: " + outString); //tested okay
        String[] ary =  outString.split(Pattern.quote("|"));
        
        String checksum = ary[1];
        String data = ary[0];
        decStr += ("\nchecksum1:" + checksum); //tested okay
        decStr += ("\ndata:" + data); //tested okay
        decStr += ("\nchecksum2:" + getCheckSumValue(data)); //tested okay
        
        if (getCheckSumValue(data).equalsIgnoreCase(checksum)==true ) {
            return data;
        }
        else {
            decStr += ("\nChecksum Mismatch");
            return null;
        }
    }


      /** 
       * @brief This function communicate with business-logic layer. 
       * 
      */  
    public String decryptLicString(String encdata, String realpath) throws Exception {

        String decStr="", outString="",returnvalue="Center has been created.",checksum="",data="",cid="",cname="",cdate="",cnid="",cn="",removedGarbage="",edate="";
        
        try{
			int num = Integer.parseInt(encdata.substring(0, 2));
			removedGarbage = encdata.substring(num+2);
		}
		catch(Exception e){
			returnvalue="Invalid license File";
        	return returnvalue;
			 }
        //System.out.println("Num:" + num);
        //System.out.println("Str1:" + str1); //tested okay
        //String outputKey = removedGarbage.substring(0, 16);
        //System.out.println("outputKey:" + outputKey); //tested okay
        //String removedKey = removedGarbage.substring(16);
        //System.out.println("removedKey:" + removedKey); //tested okay
        //String outString="";

		//removedGarbage = encdata.substring(num+2);
        String outputKey = removedGarbage.substring(0, 16);
        String removedKey = removedGarbage.substring(16);
        String decString = removedKey.substring(5);
        try{
	       outString = Decryptcenter.decrypt(decString, new String(outputKey));
        }
        catch(Exception ex){
			returnvalue="Invalid license File";
        	return returnvalue;
        }
        System.out.println("decText: " + outString); //tested okay
        try{
			String[] ary =  outString.split(Pattern.quote("|"));

			checksum = ary[1];
			data = ary[0];

			String[] all_data=data.split(",");
			String cidd=all_data[0];
			String cnamee=all_data[1];
			String cdatee=all_data[2];
			String edatee=all_data[3];

			cid = cidd.substring(cidd.indexOf(":")+1);
			cname = cnamee.substring(cnamee.indexOf(":")+1);
			cdate = cdatee.substring(cdatee.indexOf(":")+1);
			edate = edatee.substring(edatee.indexOf(":")+1);
		}
		catch(Exception ex){
			returnvalue="Invalid license File";
        	return returnvalue;
        }
	
        System.out.println("Center Id : "+cid);
        System.out.println("Center Name : "+cname);
        System.out.println("checksum1:" + checksum); //tested okay
        System.out.println("data:" + data); //tested okay
        System.out.println("checksum2:" + getCheckSumValue(data)); //tested okay
        
        if (getCheckSumValue(data).equalsIgnoreCase(checksum)==true ) {
            
            /* database insertion start here*/
            
			int ans =0;
			dataobj obj = new dataobj();
			dataobj obj1 = new dataobj();
	
	
	
	try{
				rcCentreInfo rcCinfo = new rcCentreInfo(realpath);
				rcGenOperations rcGen = new rcGenOperations(realpath);
				String refed_all=""; 

				String[] refed = null;
				if(refed!=null){
					for (int i = 0; i < refed.length; ++i){
						//out.println(i+"Referred=>>"+refed[i]+"<br>");
						refed_all+=","+refed[i];
					}
				}
				String refing_all=""; 
				String[] refing = null;
				if(refing!=null){
					for (int i = 0; i < refing.length; ++i){
						//out.println(i+"Referring=>>"+refing[i]+"<br>");
						refing_all+=","+refing[i];
					}
				}

				if(refed_all.startsWith(",")) refed_all=refed_all.substring(1);
				if(refing_all.startsWith(","))  refing_all=refing_all.substring(1);

				String nccode = cnid;
				obj1.add("tname","referhospitals");
				obj1.add("code",nccode);
				obj1.add("referred",refed_all);
				obj1.add("referring",refing_all);
					
				obj.add("name",cname);
				obj.add("code",cid);
				obj.add("cdate",cdate);
				obj.add("expdate",edate);		
				obj.add("visibility","Y");
				obj.add("tname","center");
				System.out.println( "DebugInfo: " + cname + "," + cid + "," + cdate + "," + edate + ",Y" );
				
				ans = rcGen.saveAnyInfo(obj);
				//int ans1 = rcGen.saveAnyInfo(obj1,"code"); /// add to referhospitals

			}
			catch(Exception e){
			returnvalue="License File can not read";
		        	return returnvalue;
			}
             
            
            /* databse insertion stop here */
            //return cnid+"-"+cn;
        }
        else return "Invalid file(Checksum Mismatch)";
        
        //return cnid+"-"+cn+"-"+returnvalue;
        return returnvalue;
    }
    
    public Decryptcenter() {
        try{
          

        	
        }catch(Exception ex){
            ex.printStackTrace(System.out);
        }
    }
     public static void main(String args[]) {
         new Decryptcenter();
     }
}
