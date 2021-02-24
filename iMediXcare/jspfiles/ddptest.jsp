<%@page language="java"  import= "imedix.rcDataEntryFrm,imedix.dataobj,imedix.cook,java.util.*,java.util.regex.*"%>
<%
      String patternStr = ",2.*";
      int j=0, c=0;
      while(j<patternStr.length()) {
	char tm = patternStr.charAt(j);
	if (Character.isLetterOrDigit(tm)) c++;
	j++;
      }
      out.println("Character: "+c);
%>
