/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package imedix;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Arrays;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author surajitkundu
 */
public class PACSEncryption {
	
		String rpath="";
	
	public PACSEncryption(String path){
		rpath=path;	
		System.out.println(rpath);
		
	}
	
    public String PACSEncryptionString(String user,String password) throws NoSuchAlgorithmException, UnsupportedEncodingException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException{
        String encString="";
                MessageDigest md;
        md = MessageDigest.getInstance("MD5");
        byte[] digestOfPassword = md.digest(password.getBytes("UTF-8"));
        // digestOfPassword.length = 16
        byte[] keyBytes = Arrays.copyOf(digestOfPassword,24);
        // keyBytes.length = 24
        //String byteText = Arrays.toString(keyBytes);
        //System.out.println(digestOfPassword.length);
        for (int j = 0, k = digestOfPassword.length; j < 8;) {
            keyBytes[k++] = keyBytes[j++];
        }

        SecretKey secretKey;
        secretKey = new SecretKeySpec(keyBytes, 0, keyBytes.length, "DESede");

        IvParameterSpec iv = new IvParameterSpec(new byte[8]);
        Cipher cipher = Cipher.getInstance("DESede/CBC/PKCS5Padding");
        /**/
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);

        byte[] plainTextBytes = user.getBytes("UTF-8");
        byte[] cipherText = cipher.doFinal(plainTextBytes);
        /*ipherText = cipher.doFinal(plainTextBytes);*/
        encString = Base64.encode(cipherText);
    return encString;
    }
	public String PACSDecryptionString(String encString,String password) throws NoSuchAlgorithmException, UnsupportedEncodingException, NoSuchPaddingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, Base64DecodingException, InvalidKeySpecException{
		try { 
			MessageDigest md;
			md = MessageDigest.getInstance("MD5");
			final byte[] digestOfPassword = md.digest(password.getBytes("utf-8")); 
			final byte[] keyBytes = Arrays.copyOf(digestOfPassword, 24); 
			for (int j = 0, k = 16; j < 8;) { 
				keyBytes[k++] = keyBytes[j++]; 
			}
			KeySpec keySpec = new DESedeKeySpec(keyBytes); 
			SecretKey key = SecretKeyFactory.getInstance("DESede").generateSecret(keySpec);  
			IvParameterSpec iv = new IvParameterSpec(new byte[8]);     
		  
			Cipher dcipher = Cipher.getInstance("DESede/CBC/PKCS5Padding"); 
			dcipher.init(Cipher.DECRYPT_MODE, key, iv);  
			if(encString==null) 
				return null;  
			byte[] dec = Base64.decode(encString.getBytes()); 
			byte[] dcpString = dcipher.doFinal(dec); 
			return new String(dcpString, "UTF8"); 
		} catch (Exception e) { 
			e.printStackTrace(); 
		}     
          return "";
	} 
	




	
	
   /* public static void main(String[] args) throws NoSuchAlgorithmException, NoSuchPaddingException, UnsupportedEncodingException, InvalidKeyException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException{
        
       System.out.println( new PACSEncryption().PACSEncryptionString("report","IITPACS@123"));
       // write user id and password in co
    }*/
}
