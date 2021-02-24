package imedix;

import java.io.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.DOMException;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.NamedNodeMap;

public class layout{
	
	String rpath="";
	
	public layout(String path){
		rpath=path;	
		System.out.println(rpath);
		
	}
	
	public String getMainMenu(){
		
	           
		String framestr = "";
        String name="", link="", menuid="";
            
	try {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		//Document doc = db.parse (new File(rpath+"/jspfiles/displaylayout/template_main.xml"));
		Document doc = db.parse (new File(rpath+"/displaylayout/template_main.xml"));
		
		doc.normalize();	
		//System.out.println("getDocumentURI="+doc.getDocumentURI());
		//framestr = doc.getDocumentURI() + "<br>";
		//framestr = "<HTML>";
		
		//framestr+="Root element of the doc is :" + doc.getDocumentElement().getNodeName()+"<br>";
		
		NodeList listOfFrameTable = doc.getElementsByTagName("FrameTable");
		
		//int totalFrameTable = listOfFrameTable.getLength();
		//framestr+="Total no of FrameTable : " + totalFrameTable+"<br>";
		Node FrameTable = listOfFrameTable.item(0);
						
	   	//framestr+="Rows : " +FrameTable.getAttributes().getNamedItem("rows").toString() +"<br>";

		framestr = "<HTML>";
		
        if (FrameTable.getAttributes().getNamedItem("rows") != null)
            //framestr += "<frameset frameborder=\"0\" rows=\"" + FrameTable.getAttributes().getNamedItem("rows") + "\">";
            framestr += "<frameset frameborder=\"0\" " + FrameTable.getAttributes().getNamedItem("rows") + ">";
        else if (FrameTable.getAttributes().getNamedItem("cols") != null)
            framestr += "<frameset frameborder=\"0\" cols=\"" + FrameTable.getAttributes().getNamedItem("cols") + "\">";
        else
            framestr += "<frameset frameborder=\"0\">";

    	
    	NodeList frameChield =FrameTable.getChildNodes();
    	for(int s=0; s<frameChield.getLength() ; s++){
    		Node frmcNode = frameChield.item(s);
    	//	framestr+= "<br> frmcNode:::"+ frmcNode.getNodeName()+"<br>";
      		NodeList frameChield2 =frmcNode.getChildNodes();

    		for(int i=0; i<frameChield2.getLength() ; i++){
    			Node frmcNode2 = frameChield2.item(i);
    		   // framestr+= ">>>>>>frmcNode2 :::"+ frmcNode2.getNodeName()+"<br>";
    		    if(frmcNode2.hasAttributes()){
    		    	
    		    //framestr+= "\n>>>>>>>>>>>>>>>>>>"+ frmcNode2.getNodeName()+" : " +frmcNode2.getAttributes().getNamedItem("name").toString() +"<br>";
    		        		    //int Ano=frmcNode2.getAttributes().getLength();
    		   // System.out.println("Ano :"+Ano);
    		     		    
    		     name = frmcNode2.getAttributes().getNamedItem("name").getNodeValue(); 
    		     link = frmcNode2.getAttributes().getNamedItem("link").getNodeValue();
    		     Node mapmid=frmcNode2.getAttributes().getNamedItem("menuid");
    		     
    		     if(mapmid!=null) menuid = frmcNode2.getAttributes().getNamedItem("menuid").getNodeValue();
    		     else menuid=null;
    		     
    		     
    		     if (menuid != null)
                     //framestr += "<frame name='" + name + "' src='" + link + "?template=template_home.xml&menuid=" + menuid + "' marginheight=\"0\" marginwidth=\"0\" scrolling=\"no\" noresize>";
                     framestr += "<frame name='" + name + "' src='" + link + "?templateid=1&menuid=" + menuid + "' marginheight=\"0\" marginwidth=\"0\" scrolling=\"no\" noresize>";
                 else
                      framestr += "<frame name='" + name + "' src='" + link + "?templateid=1&menuid=" + menuid + "' noresize>";
    		    }
    		    		
    			//	framestr+= ">>>>>>>>>>>>>>>>>>"+ frmcNode2.getNodeName()+" : " +frmcNode2.getAttributes().getNamedItem("name").toString() +"<br>";
			}		
		}
		
		
		
	
    framestr += "</frameset></HTML>";
    //System.out.println(">>>\n"+framestr);
    
        
	}catch(Exception e){
	
		System.out.println(e.toString());
		framestr+=e.toString();

	}
	
	return framestr;
	}
	
	
  public String getMainMenuForBrowse(int template){
	String frmstr = "";
	String tempFile="";
	tempFile= getXMLFile(template);
	if(template==1){
		tempFile= "template_home.xml";
	}else if(template==2){
		tempFile="phiv_template_display.xml";
	}else if(template==3){
		tempFile="gen_template_display.xml";
	}else if(template==4){
		tempFile="onco_template_display.xml";
	}else if(template==5){
		tempFile="drtb_template_display.xml";	
	}
	
	try {
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder db = dbf.newDocumentBuilder();
		//Document doc = db.parse (new File(rpath+"/jspfiles/displaylayout/template_display.xml"));	
		Document doc = db.parse (new File(rpath+"/displaylayout/"+tempFile));	
			
		//System.out.println("getDocumentURI="+doc.getDocumentURI());
		
		//framestr = doc.getDocumentURI() + "<br>";
		//framestr+="Root element of the doc is :" + doc.getDocumentElement().getNodeName()+"<br>";
		doc.normalize();
		
		NodeList listOfFrameTable = doc.getElementsByTagName("FrameTable");

		//int totalFrameTable = listOfFrameTable.getLength();
		//framestr+="Total no of FrameTable : " + totalFrameTable+"<br>";
		Node FrmTable = listOfFrameTable.item(0);
	   	//framestr+="Rows : " +FrameTable.getAttributes().getNamedItem("rows").toString() +"<br>";
		frmstr= GenerateFrames(FrmTable,template);
		frmstr="<HTML>"+frmstr+"</HTML>";
		
		//System.out.println("Return Value \n"+frmstr);
        
	}catch(Exception e){
		System.out.println(e.toString());
		//frmstr=e.toString();
	}
	 	return frmstr;
	}
	
	private String GenerateFrames(Node FrameTable,int tempID){

       String name="", link="", menuid="";
       String framestr="";

	   if (FrameTable.getAttributes().getNamedItem("rows") != null)
           framestr += "<frameset frameborder=\"0\" " + FrameTable.getAttributes().getNamedItem("rows") + ">";
        else if (FrameTable.getAttributes().getNamedItem("cols") != null)
            framestr += "<frameset frameborder=\"0\" " + FrameTable.getAttributes().getNamedItem("cols") + "\">";
        else
            framestr += "<frameset frameborder=\"0\">";
    	
    	NodeList frameChield =FrameTable.getChildNodes();
    	
    	for(int s=0; s<frameChield.getLength() ; s++){
    		Node frmcNode = frameChield.item(s);
       		NodeList frameChield2 =frmcNode.getChildNodes();

    		for(int i=0; i<frameChield2.getLength() ; i++){
    			Node frmcNode2 = frameChield2.item(i);
    			
    			String Ano=frmcNode2.getNodeName();
	    	//	System.out.println("PHIV getNodeName >>:" + Ano);
	    		    
    			if(frmcNode2.hasChildNodes()){
    				String fd=frmcNode2.getNodeName();
    			//	System.out.println("***** >>> frmcNode2 :"+fd);
    					
    				NodeList Node2Chield =frmcNode2.getChildNodes();    				
    			
    				for(int k=0; k<Node2Chield.getLength() ; k++){
    					Node Node2CH = Node2Chield.item(k);
    					
    					String fdata= frmcNode2.getNodeName() + ">****>:"+Node2CH.getNodeName();
    					    						
    					if(Node2CH.getNodeName().equalsIgnoreCase("FrameTable")) {
    							//System.out.println("if FrameTable >>>> :"+fdata +"\n framestr :"+framestr+"\n\n");
    							framestr+=GenerateFrames(Node2CH,tempID);
    						}
    				}

    			}else{
    			
      		   // framestr+= ">>>>>>frmcNode2 :::"+ frmcNode2.getNodeName()+"<br>";
    		    if(frmcNode2.hasAttributes()){
    		    	
	    		  //  framestr+= "\n>>>>>>>>>>>>>>>>>>:"+ frmcNode2.getNodeName() +"<br>";
	    		  	    		    	    		    	    		     		    
	    		    name = frmcNode2.getAttributes().getNamedItem("name").getNodeValue(); 
	    		    //System.out.println(">>>>name :"+name);
	    		     
	    		    Node maplink=frmcNode2.getAttributes().getNamedItem("link");
	    		    if(maplink!=null) link = frmcNode2.getAttributes().getNamedItem("link").getNodeValue();
	    		    else link="";
	    		    
	    		    //System.out.println(">>>>>link :"+link);
	    		     
	    		    Node mapmid=frmcNode2.getAttributes().getNamedItem("menuid");
	    		    if(mapmid!=null) menuid = frmcNode2.getAttributes().getNamedItem("menuid").getNodeValue();
	    		    else menuid="";

	    			if (menuid != ""){
	                    if (name.equalsIgnoreCase("rightpanel"))
	                       framestr += "<frame name=\"" + name + "\" src=\"" + link + "?templateid="+tempID+"&menuid=" + menuid + "\" marginheight=\"0\" marginwidth=\"0\" noresize>";
	                    else
	                        framestr += "<frame name=\"" + name + "\" src=\"" + link + "?templateid="+tempID+"&menuid=" + menuid + "\" marginheight=\"0\" marginwidth=\"0\" scrolling=\"auto\" noresize>";
	                 }else
	                      framestr += "<frame name=\"" + name + "\" src=\"" + link + "?templateid="+tempID+"&menuid=" + menuid + "\" noresize>";
	              //           
	    		  // System.out.println(" >>>>>>>>>>>>>>>>>>>>>>>>>>>>>framestr :\n"+framestr+"\n===="+frmcNode2.getNodeName());
				}
			}
		}
	}
	
    framestr += "</frameset>";
    System.out.println("*** Main framestr*** :\n"+framestr+"\n");
  	return framestr;
	}
	
	
	
public String getMainMenu(String utype,String templateID,String menuid,String menupos, String level){

           String template="";
           String activeframe="";
           String caption, link, target, nextmenuid, roles, menustr = "",name="",submit="";
           String[] rolearr;
           int key=0;
           //System.out.println("**getMainMenu="+utype+">>"+templateID+">>"+menuid+">>"+menupos+">>"+level);	
           
           boolean validuser=false;
           template= getXMLFile(Integer.parseInt(templateID));
           if(templateID.equals("1")) activeframe = "header1";
           else activeframe = "header2";
           
    
          try{
          
           	DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
      		DocumentBuilder db = dbf.newDocumentBuilder();
			//Document doc = db.parse (new File(rpath+"/jspfiles/displaylayout/"+template));	
			Document doc = db.parse (new File(rpath+"/displaylayout/"+template));	
			doc.normalize();
			//System.out.println("**getMainMenu getDocumentURI="+doc.getDocumentURI());		
			NodeList menulist = doc.getElementsByTagName("menu");
       		for(int ii=0; ii<menulist.getLength() ; ii++){
       			validuser=false;
       			Node menu = menulist.item(ii);
       			String mid=menu.getAttributes().getNamedItem("id").getNodeValue();
       		//	System.out.println("id==>"+mid);
       			if (mid.equalsIgnoreCase(menuid)){
                    roles = menu.getAttributes().getNamedItem("role").getNodeValue();
                    //System.out.println("roles==>"+roles);
                    rolearr = roles.split(",");
                 //   System.out.println(">>>>> rolearr Length ==>"+rolearr.length);
                    	for (int i = 0; i < rolearr.length; i++)
                    	{
	                    //	System.out.println(i+">>>>> roles==>"+rolearr[i].trim() + "   utype >>  "+utype);
	                    	
	                        if (rolearr[i].trim().equalsIgnoreCase("ALL") || rolearr[i].trim().equalsIgnoreCase(utype.trim()))
	                        {
	                            validuser = true;
	                         //   System.out.println(">>>>> validuser==>"+validuser+"  "+rolearr[i].trim());
	                            break;
	                        }
                        }
                        if (validuser==true){
                        //	System.out.println("**** menu.getNodeName() >>"+menu.getNodeName());
                        	NodeList menudata=menu.getChildNodes();
                        	//System.out.println("menudata.getLength() >>"+menudata.getLength());
                        	for (int j = 0; j < menudata.getLength(); j++){
                        	  Node menuAttrb = menudata.item(j);
                        	  	if(menuAttrb.hasAttributes()){
	                        	 // System.out.println("<<>>***>>>>"+menuAttrb.getNodeName());
	                        	 
	                        	  name = menuAttrb.getAttributes().getNamedItem("name")!=null ? menuAttrb.getAttributes().getNamedItem("name").getNodeValue() : "";
	                        	  caption = menuAttrb.getAttributes().getNamedItem("caption")!=null ? menuAttrb.getAttributes().getNamedItem("caption").getNodeValue() : "";
	                        	  link = menuAttrb.getAttributes().getNamedItem("link")!=null ? menuAttrb.getAttributes().getNamedItem("link").getNodeValue() : "";
	                        	  target = menuAttrb.getAttributes().getNamedItem("target")!=null ? menuAttrb.getAttributes().getNamedItem("target").getNodeValue() : "";
	                        	  submit = menuAttrb.getAttributes().getNamedItem("submit")!=null ? menuAttrb.getAttributes().getNamedItem("submit").getNodeValue() : "";
	                        	  Node mapmenuid=menuAttrb.getAttributes().getNamedItem("menuid");
					    		    
					    		  if(mapmenuid!=null) nextmenuid = menuAttrb.getAttributes().getNamedItem("menuid")!=null ? menuAttrb.getAttributes().getNamedItem("menuid").getNodeValue() : "";
					    		  else nextmenuid="";
	    		    	                        	                          		
	                        		if (link.indexOf("?") != -1)
	                                	link = link + "&templateid=" + templateID + "&menuid=" + nextmenuid ;
	                                else if(menuid.equals("left"))	                              
										link=link;
	                           		else
	                                	link = link + "?templateid=" + templateID + "&menuid=" + nextmenuid ;

	                            	if (menupos.equalsIgnoreCase("top"))
	                            		menustr += "<a class=\""+nextmenuid+"\" href=\"" + link + "\" onclick=\"clearPanel('" + activeframe + "')\"" + (target != "" ? " target=\"" + target + "\"" : "") + ">" + caption + "</a>";  
	                            	else if(menupos.equalsIgnoreCase("new_sk") && menuid.equals("head1"))
										menustr += link+","+caption+":";
	                            	else if(menupos.equalsIgnoreCase("new_sk") && menuid.equals("left")){
										menustr += "\""+key+"\":[\""+link+"\",\""+caption+"\",\""+submit+"\"],";
										key++;
									}
	                            	else{
	                            		
	                            		if (level.equalsIgnoreCase("1")){
											if(target.equalsIgnoreCase("submenu")){
											link=link + "&divid=" + name;
											menustr += 	"<a class='menuitem submenuheader' href='#' onclick=\" javascript:ExecuteCallContent('"+link+"','get','','','"+name+"');\">" + caption + "</a>";  
											menustr += "<div class='submenu' id='"+name+"'></div>";
											}else
	                            			menustr += "<a class=\"menuitem\" href=\"" + link + "\" onclick=\"clearPanel('" + activeframe + "')\"" + (target != "" ? " target=\"" + target + "\"" : "") + ">" + caption + "</a>";  
	                            		}else{
	                            			menustr += "<li><a href=\"" + link + "\" onclick=\"clearPanel('" + activeframe + "')\"" + (target != "" ? " target=\"" + target + "\"" : "") + ">" + caption + "</a></li>";                              		
	                                  	}
	                            	}
	                        	
	                        	}
	                        	
                        	}               
                        	break;
                    	}
           		}
			}
		
				
       		
   		}catch(Exception e){
		System.out.println("Error: "+e.toString());
		//framestr+=e.toString();
		}
		if (!level.equalsIgnoreCase("1")){
		menustr="<ul>"+menustr+"</ul>";
		}
		if(menuid.equals("left")) menustr = "{"+menustr+"}";

			
      //System.out.println(" *********** getMainMenu >>>\n"+menustr);          
     return menustr;
	}
	
	public int checkMainMenuForBrowse(int template){
	int menuid =3; // 3 for gen_template_display.xml
	try{
		String tempFile=getXMLFile(template);
		File tmpfn= new File(rpath+"/displaylayout/"+tempFile);
		if(tmpfn.exists()) menuid=template;
		else menuid =3;
	}catch(Exception e){
		System.out.println(e.toString());	
	}
	return menuid;
}

	private String getXMLFile(int template){
		String tempFile="";
		if(template==1){
			tempFile= "template_home.xml";
		}else if(template==2){
			tempFile="phiv_template_display.xml";
		}else if(template==3){
			tempFile="gen_template_display.xml";
		}else if(template==4){
			tempFile="onco_template_display.xml";
		}else if(template==5){
			tempFile="drtb_template_display.xml";	
		}
		return tempFile;
	}
	
	public String  getTemplates(String ty, String patdis){
		String fn=rpath+"/templates/"+ty.toLowerCase()+".html";
		File tempfn= new File(fn);
		if(!tempfn.exists()){
			if(patdis.equalsIgnoreCase("Pediatric HIV")) fn=rpath+"/phivtemplates/"+ty.toLowerCase()+".html";
			else if(patdis.equalsIgnoreCase("Oncological")) fn=rpath+"/oncotemplates/"+ty.toLowerCase()+".html";
			else if(patdis.equalsIgnoreCase("Tuberculosis")) fn=rpath+"/tbtemplates/"+ty.toLowerCase()+".html";
		}
		return fn;		
				
	}
			
	
	
	
}
