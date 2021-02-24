/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package imedix;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.regex.Pattern;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.crypto.spec.IvParameterSpec;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.digest.DigestUtils;
import java.net.URLEncoder;
import java.net.URLDecoder;

public class ImedixCrypto {
   //final String sKey = "$8%1GW#$W%^%E%$E"; //Change for every LIC file
    String data="cid: ABCD, cname: Aaaa Bbbbb Ccc Dcdc, ";
    public final static String[] ENC = new String[10];
    public final static String[] DELIM = new String[7];


    public static String b64Enc(String strToEncrypt) {
            return  new String(Base64.encodeBase64(strToEncrypt.getBytes()));
    }
    
    public static String b64Dec(String strToEncrypt) {
            return  new String(Base64.decodeBase64(strToEncrypt.getBytes()));
    }

    public static String urlenc(String strToEncrypt) throws Exception {
            return  URLEncoder.encode(strToEncrypt, "UTF-8"); 
    }
    
    public static String urldec(String strToEncrypt) throws Exception {
            return  URLDecoder.decode(strToEncrypt, "UTF-8"); 
    }

    public static String encrypt(String strToEncrypt, String key) throws Exception {
        try {

            Cipher cipher = Cipher.getInstance("AES");
            final SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            final String encryptedString = new String(Base64.encodeBase64(cipher.doFinal(strToEncrypt.getBytes())));
            return encryptedString;
        } catch (Exception e) {
            throw e;
        }
    }

    public static String decrypt(String strToDecrypt, String key) throws Exception {
        try {
            Cipher cipher = Cipher.getInstance("AES");
            final SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(), "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            final String decryptedString = new String(cipher.doFinal(Base64.decodeBase64(strToDecrypt.getBytes())));
            return decryptedString;
        } catch (Exception e) {
            throw e;
        }
    }

    public String getCurrDate(){
    	
    	Date now = new Date();
    	String cdate = new SimpleDateFormat("ddMMYYYY",Locale.ENGLISH).format(now);
		return cdate;
    	
    }    
    
    public static String getCheckSumValue(String content) {
        return DigestUtils.md5Hex(content);
    }

    public String randomString( int len ){
       String AB = "0123456789";
       StringBuilder sb = new StringBuilder( len );
       for( int i = 0; i < len; i++ ) 
          sb.append( AB.charAt( getRandomBetween(0, AB.length()-1) ));
       return sb.toString();
    }    
    
    public static int getRandomBetween(int Min, int Max)
    {
        return Min + (int)(Math.random() * ((Max - Min) + 1));
    }
    
    public static String getEncKey(int num)
    {
        return  ENC[num];
    }

	public static String getDelim(int num)
    {
        return  DELIM[num];
    }

    public String encryptLicString(String data, String inpKey) throws Exception {
        //YOU MAY VERIFY
        String enc = "";
        int random = getRandomBetween(12,20);
        String randString = randomString(random);
        String checksum = getCheckSumValue(data);
        String encData = ImedixCrypto.encrypt(data+"|"+checksum, new String(inpKey));
        enc = Integer.toString(random)+randString+inpKey+randomString(5)+encData;
        return enc;
    } 
    
    public String decryptLicString(String encdata) throws Exception {

        //YOU MAY VERIFY
        String decStr="";
        int num = Integer.parseInt(encdata.substring(0, 2));
        String removedGarbage = encdata.substring(num+2);
        //System.out.println("Num:" + num);
        //System.out.println("Str1:" + str1); //tested okay
        String outputKey = removedGarbage.substring(0, 16);
        System.out.println("outputKey:" + outputKey); //tested okay
        String removedKey = removedGarbage.substring(16);
        //System.out.println("removedKey:" + removedKey); //tested okay
        String decString = removedKey.substring(5);
        //System.out.println("decString: " + decString);
        String outString = ImedixCrypto.decrypt(decString, new String(outputKey));
        //System.out.println("decText: " + outString); //tested okay
        String[] ary =  outString.split(Pattern.quote("|"));
        
        String checksum = ary[1];
        String data = ary[0];
        decStr += ("\nchecksum1:" + checksum); //tested okay
        decStr += ("\ndata:" + data); //tested okay
        decStr += ("\nchecksum2:" + getCheckSumValue(data)); //tested okay
        
        if (getCheckSumValue(data).equalsIgnoreCase(checksum)==true ) {
            decStr += ("\ndecrypted Okay");
        }
        else decStr += ("\nChecksum Mismatch");
        
        return decStr;
        
        
    }
    
    public ImedixCrypto() {
		ENC[0]="AAAAAAAAAAAAAAAA";
		ENC[1]="BBBBBBBBBBBBBBBB";
		ENC[2]="CCCCCCCCCCCCCCCC";
		ENC[3]="DDDDDDDDDDDDDDDD";    
		ENC[4]="EEEEEEEEEEEEEEEE";
		ENC[5]="FFFFFFFFFFFFFFFF";    
		ENC[6]="GGGGGGGGGGGGGGGG";
		ENC[7]="HHHHHHHHHHHHHHHH";
		ENC[8]="IIIIIIIIIIIIIIII";    
		ENC[9]="JJJJJJJJJJJJJJJJ";

		DELIM[0]="|!|";
		DELIM[1]="|#|";
		DELIM[2]="|@|";
		DELIM[3]="|$|";
		DELIM[4]="|*|";
		DELIM[5]="|&|";
		DELIM[6]="|||";


    }
    /* 
    public static void main(String args[]) {
         new ImedixCrypto();
     }
    */
}
