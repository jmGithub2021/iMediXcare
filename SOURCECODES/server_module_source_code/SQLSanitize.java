package imedix;

import java.util.regex.*;
import java.util.Date;

 public class SQLSanitize
    {
        public static String Sanitize(String sql)
        {
            String modsql = sql;

            modsql = SanitizeDate(modsql);
//            modsql = SanitizeFunction(modsql);
            return modsql;

        }

        public static String SanitizeDate(String sql)
        {
            
            int x, y, m, n, o;
            String modsql = sql;
            
            try{
   		//	System.out.println( " SanitizeDate sql) : "+ sql );
            Pattern expression = Pattern.compile("'(\\d{4}|\\d{2})(/|-)([0-2]\\d)(/|-)([0-3]\\d)([^\']*)");    
        //	System.out.println( " expression toString : "+ expression.toString() );
            Matcher matcher = expression.matcher(modsql);
        // System.out.println( " matcher groupCount : "+ matcher.groupCount() );  
            	
            while (matcher.find()) {
            	
             	String datestr = matcher.group().substring(1);
           	  
         //	System.out.println( "matcher.group().substring(1) : "+ datestr ); 
             	          	
                modsql = modsql.replace("'" + datestr + "'", "'" + matcher.group(1) + matcher.group(3) + matcher.group(5) + "'"); 
             
             }
           
            }catch (Exception e) {
				System.out.println("Error In SanitizeDate " + e.toString());
				modsql = modsql+"\r\n Error In SanitizeDate " + e.toString();
			}  
                     
            return modsql;
        }
        
        public static String getPatid(String sql)
        {
        String pid="NOPID";
        try{
   		
            Pattern expression = Pattern.compile("([A-Za-z]{4})([0-3]\\d)([01]\\d)(\\d{2})(\\d{4})"); 
                   	    
            Matcher matcher = expression.matcher(sql);

        // System.out.println( " matcher groupCount : "+ matcher.groupCount() );  
         while (matcher.find()) {
           pid = matcher.group();
           break;
          }
           
         }catch (Exception e) {
			System.out.println("Error In SanitizeDate " + e.toString());
			pid ="NOPID";
		 }
			
			return pid;  
				
        }

/*
        public static String SanitizeFunction(String sql)
        {
            String modsql = sql;
            String funcstr, funcname, paramstr;
            String[] paramarr;
            int start, end;
		
			try{
            
             Pattern expression=Pattern.compile(" [a-zA-Z][a-zA-Z0-9_]*[ \t]*\\([a-zA-Z0-9_ ,]*\\)");
                      
             Matcher matcher = expression.matcher(modsql);
            
           
            while (matcher.find()) {	
            	
                funcstr = matcher.group().replace(" ", "");
                
                start = funcstr.indexOf("(");
                end = funcstr.lastIndexOf( ")");
                funcname = funcstr.substring(0, start).trim();
                
                paramstr = funcstr.substring(start + 1, end );
                
                paramarr = paramstr.split( ",");
				
				
				
				
				if(funcname.equalsIgnoreCase("curdate") || funcname.equalsIgnoreCase("current_date"))
					modsql = modsql.replace(funcstr, "'" + myDate.getCurrentDate("ymd",false) + "'");
				else if(funcname.equalsIgnoreCase("length"))
					modsql = modsql.replace(funcstr, "#LENGTH#" + paramstr);
				else if(funcname.equalsIgnoreCase("left"))
					modsql = modsql.replace(funcstr, "#LSUBSTR#" + paramstr);
				else if(funcname.equalsIgnoreCase("right"))
					modsql = modsql.replace(funcstr, "#RSUBSTR#" + paramstr);
				else if(funcname.equalsIgnoreCase("ltrim"))
					modsql = modsql.replace(funcstr, "#LTRIM#" + paramstr);
				else if(funcname.equalsIgnoreCase("rtrim"))
					modsql = modsql.replace(funcstr, "#RTRIM#" + paramstr);
				else if(funcname.equalsIgnoreCase("trim"))
					modsql = modsql.replace(funcstr, "#TRIM#" + paramstr);
				else if(funcname.equalsIgnoreCase("lower") || funcname.equalsIgnoreCase("lcase"))
					modsql = modsql.replace(funcstr, "#LCASE#" + paramstr);
				else if(funcname.equalsIgnoreCase("upper") || funcname.equalsIgnoreCase("ucase"))
					modsql = modsql.replace(funcstr, "#UCASE#" + paramstr);
				else if(funcname.equalsIgnoreCase("replace"))
					modsql = modsql.replace(funcstr, "#REPLACE#" + paramstr);
				else if(funcname.equalsIgnoreCase("substr") || funcname.equalsIgnoreCase("substring"))
					modsql = modsql.replace(funcstr, "#SUBSTR#" + paramstr);
					 //math functions
				else if(funcname.equalsIgnoreCase("rand"))
					modsql = modsql.replace(funcstr, "#RANDOM#" );
				else if(funcname.equalsIgnoreCase("round"))
					modsql = modsql.replace(funcstr, "#ROUND#" + paramstr);
				else if(funcname.equalsIgnoreCase("floor"))
					modsql = modsql.replace(funcstr, "#FLOOR#" + paramstr);
				else if(funcname.equalsIgnoreCase("ceil") || funcname.equalsIgnoreCase("ceiling"))
					modsql = modsql.replace(funcstr, "#CEILING#" + paramstr);
               }
             }catch (Exception e) {
				System.out.println("Error In SanitizeFunction " + e.toString());
				modsql = modsql+"\r\n Error In SanitizeFunction " + e.toString();
			}  
              

            return modsql;
        }
        */
        
    }
