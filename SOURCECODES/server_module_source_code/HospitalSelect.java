package imedix;

import java.util.regex.*;

 public class HospitalSelect
    {
        public static String[] getHospitals(String modsql)
        {
            String hospcode = "", hospstr = "";
           	String[] hospitals = null;
            
            Pattern expression = Pattern.compile("'([A-Za-z]{4})(\\d{10})'");
      		
      		/*
            for( Match myMatch in expression. .Matches(modsql))
            {
                hospcode = myMatch.Value.Substring(1, 4);
                if (!hospstr.Contains(hospcode))
                hospstr += hospcode + ",";
            }
          */  
          
            Matcher matcher = expression.matcher(modsql);
            while (matcher.find()) {
            	hospcode = matcher.group().substring(1, 4);
            	if (!hospstr.contains(hospcode))
                	hospstr += hospcode + ",";
            	}
            
            
            expression.compile("'(DOC|doc|ADM|adm|USR|usr)([A-Za-z]{4})(\\d{4})'");
            
             matcher = expression.matcher(modsql);
            while (matcher.find()) {
            	
           		hospcode = matcher.group().substring(4, 7);
                if (!hospstr.contains(hospcode))
                    hospstr += hospcode + ",";
                    
            }
            /*	            
            foreach (Match myMatch in expression.Matches(modsql))
            {
                hospcode = myMatch.Value.Substring(4, 4);
                if (!hospstr.Contains(hospcode))
                    hospstr += hospcode + ",";
            }
			*/
			
            hospitals = hospstr.split(","); //new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            return hospitals;
        }

/*
        public static string[] getHospitals(SqlCommand myCmd)
        {
            String hospcode = "", hospstr = "";
            String[] hospitals = null;
            Regex expression1 = null, expression2 = null;
            
            expression1 = new Regex(@"([A-Za-z]{4})(\d{10})");
            expression2 = new Regex(@"(DOC|ADM|USR)([A-Za-z]{4})(\d{4})");
            foreach (SqlParameter p in myCmd.Parameters)
            {
                if (p.SqlDbType.ToString() == "NVarChar")
                {
                    foreach (Match myMatch in expression1.Matches(p.Value.ToString()))
                    {
                        hospcode = myMatch.Value.Substring(0, 4);
                        if (!hospstr.Contains(hospcode))
                            hospstr += hospcode + ",";
                    }
                    foreach (Match myMatch in expression2.Matches(p.Value.ToString()))
                    {
                        hospcode = myMatch.Value.Substring(3, 4);
                        if (!hospstr.Contains(hospcode))
                            hospstr += hospcode + ",";
                    }
                }
            }
            
            expression1 = new Regex(@"'([A-Za-z]{4})(\d{10})'");
            expression2 = new Regex(@"'(DOC|ADM|USR)([A-Za-z]{4})(\d{4})'");
            foreach (Match myMatch in expression1.Matches(myCmd.CommandText))
            {
                hospcode = myMatch.Value.Substring(1, 4);
                if (!hospstr.Contains(hospcode))
                    hospstr += myMatch.Value.Substring(1, 4) + ",";
            }
            foreach (Match myMatch in expression2.Matches(myCmd.CommandText))
            {
                hospcode = myMatch.Value.Substring(4, 4);
                if (!hospstr.Contains(hospcode))
                    hospstr += hospcode + ",";
            }

            hospitals = hospstr.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            return hospitals;
        }
        
        */
    }