<%@page contentType='text/html' import='org.json.simple.*,org.json.simple.parser.*, java.io.*, java.util.*, imedix.dataobj,imedix.rcDataEntryFrm,imedix.myDate,imedix.rcUserInfo,imedix.projinfo,imedix.Email,imedix.rcSmsApi,imedix.SMS' %>

<%
	JSONParser parser = new JSONParser();

    Vector<dataobj> selfSign = new Vector();
    Vector<dataobj> familyMembers = new Vector();
    String ccode="VBCR019";

    JSONArray successLogs = new JSONArray();
    JSONArray errorLogs = new JSONArray();

    rcDataEntryFrm rcdef = new rcDataEntryFrm(request.getRealPath("/"));
    rcUserInfo rcuinfo = new rcUserInfo(request.getRealPath("/"));
    JSONArray jarray = (JSONArray) parser.parse(new FileReader(request.getRealPath("/")+"jspfiles/erpPatient.json"));
    for(int i=0;i<jarray.size();i++){
        JSONObject jsObj = (JSONObject) jarray.get(i);
        String fname="", mname="", lname="", gender="", district="", state="", country="", dob="", emailid="", phone="", category="", code="";
            dataobj obj = new dataobj();
            
            dataobj loginObj = new dataobj();
        try{
            fname = String.valueOf(jsObj.get("fname"));
            mname = String.valueOf(jsObj.get("mname"));
            lname = String.valueOf(jsObj.get("lname"));
            gender = String.valueOf(jsObj.get("gender"));
            district = String.valueOf(jsObj.get("district"));
            state = String.valueOf(jsObj.get("state"));
            country = String.valueOf(jsObj.get("country"));
            dob = String.valueOf(jsObj.get("dob"));
            emailid = String.valueOf(jsObj.get("emailid"));
            phone = String.valueOf(jsObj.get("phone"));
            category = String.valueOf(jsObj.get("category"));
            code = String.valueOf(jsObj.get("code"));

            if(Integer.parseInt(rcuinfo.existEmail(emailid))>0 || Integer.parseInt(rcuinfo.existPhone(phone))>0){
                JSONObject existMailLog = new JSONObject();
                existMailLog.put("existingUser","Emailid or Phone already exist, email: "+emailid+", phone: "+phone);
                errorLogs.add(existMailLog);
                continue;
            }
            if(Integer.parseInt(rcdef.existPatientByOPD(code))>0){
                JSONObject existEmployee = new JSONObject();
                existEmployee.put("existingEmployee","A patient is already registered with the same Employee/Student ID:"+ existEmployee);
                errorLogs.add(existEmployee);
                continue;
            }

            obj.add("pat_name", fname);
            obj.add("m_name", mname);
            obj.add("l_name", lname);
            obj.add("sex", gender);
            obj.add("dist", district);
            obj.add("state", state);
            obj.add("country", country);
            obj.add("dateofbirth", dob);
            obj.add("email", emailid);
            obj.add("phone", phone);
            obj.add("category", category);
            obj.add("opdno", code);
            obj.add("relationship", "Self");
            obj.add("primarypatid", "");
            obj.add("entrydate", "");
            obj.add("serno", "");
        }catch(Exception ex){
            JSONObject priJSONParseErr = new JSONObject();
            priJSONParseErr.put("JSONParseError",ex.toString());
            errorLogs.add(priJSONParseErr);
        }

       
        String pat_id="";
        String exist_id = rcdef.checkIntigrity(obj);
        if(exist_id.length()>=14){
            //if(rcdef.isInQueue(exist_id))
            //    out.println("<script>alert('It seems You have already registered');</script>)");
            JSONObject nCardExist = new JSONObject();
            nCardExist.put(exist_id,"A patient is already registered with same idenity card");
            errorLogs.add(nCardExist);
        }  
        else{
            pat_id = rcdef.InsertMedWithoutDocAssign(ccode,obj);
            if(pat_id.equalsIgnoreCase("Error")){
                JSONObject patRegErr = new JSONObject();
                patRegErr.put("PatRegError","Name: "+fname+" "+mname+" "+lname+" Email: "+emailid);
                errorLogs.add(patRegErr);
            }
            else{
                JSONObject successPatReg = new JSONObject();
                successPatReg.put(pat_id,"Patient Registration is Completed, Name: "+fname+" "+mname+" "+lname+" Email: "+emailid);
                successLogs.add(successPatReg);
                Random random = new Random();
                String randomCode = String.format("%06d", random.nextInt(1000000));
                loginObj.add("uid",pat_id);
                loginObj.add("pwd",randomCode);
                loginObj.add("name",fname+" "+mname+" "+lname);
                loginObj.add("crtdate", myDate.getCurrentDateMySql());
                loginObj.add("center", ccode);
                //loginObj.add("userid", userid);
                loginObj.add("type","PAT");
                loginObj.add("active","Y");
                loginObj.add("emailid",emailid);
                loginObj.add("phone",phone);
                loginObj.add("available","Y");
                loginObj.add("referral","Y");
                loginObj.add("verified", "A");
                loginObj.add("verifemail", "N"); //Get the varified status from signup form
                loginObj.add("verifphone", "N"); //Get the varified status from signup form
                loginObj.add("consent","N");

                int ans = rcuinfo.InsertRegUsers(loginObj,null);
                projinfo prin = new projinfo(request.getRealPath("/"));
                String output="", retmsg="";

                    if (ans==1) {
                        JSONObject successPatLogin = new JSONObject();
                        successPatLogin.put(pat_id,"Patient login is created, login id: "+pat_id);
                        successLogs.add(successPatLogin);
                        String subject = "iMediX Registration Status";
                        String mesg = "Dear "+String.valueOf(jsObj.get("fname"))+",\n\n"+
                                    "Your iMediX account has been created. The login details are as follows\n\n"+
                                    "Website: "+prin.gblhome+"\n Login ID: Email/Patient ID\nPatient ID: "+pat_id+"\nPassword: "+randomCode;
                        Email em = new Email(request.getRealPath("/"));
                       // output = em.Send(emailid,subject,mesg);
                    
                        String dataAry[] = new String[4];
                        dataAry[0] = fname;
                        dataAry[1] = prin.gblhome;
                        dataAry[2] = pat_id;
                        dataAry[3] = randomCode;
                        rcSmsApi rcsmsapi = new rcSmsApi(request.getRealPath("/"));
                        String message = (String) rcsmsapi.makeMessage("M007", dataAry);
                        SMS sms = new SMS(request.getRealPath("/"));
                        //retmsg = sms.Send(phone, message);
                    }
                    else{
                        JSONObject loginFaild = new JSONObject();
                        loginFaild.put("loginCreationFaild", "Login account can no be created for the patient,  Name: "+fname+" "+mname+" "+lname+" Email: "+emailid);
                        errorLogs.add(loginFaild);
                    }

               // out.println(pat_id+" : "+fname);                  
            }
          
        }

        JSONArray familyMembersObj = new JSONArray();
        try{
            familyMembersObj = (JSONArray) jsObj.get("familymembers");
        }catch(Exception ex){
            JSONObject jsonParserErrF = new JSONObject();
            jsonParserErrF.put("JSONParseError1",ex.toString());
            errorLogs.add(jsonParserErrF);
        }
        

        if(!pat_id.equalsIgnoreCase("Error")){
            for(int j=0;j<familyMembersObj.size();j++){
                dataobj nesFamilyObj = new dataobj();
                JSONObject nesObj = (JSONObject) familyMembersObj.get(j);
                try{
                    nesFamilyObj.add("pat_name",String.valueOf(nesObj.get("fname")));
                    nesFamilyObj.add("m_name",String.valueOf(nesObj.get("mname")));
                    nesFamilyObj.add("l_name",String.valueOf(nesObj.get("lname")));
                    nesFamilyObj.add("sex",String.valueOf(nesObj.get("gender")));
                    nesFamilyObj.add("dist",String.valueOf(nesObj.get("district")));
                    nesFamilyObj.add("state",String.valueOf(nesObj.get("state")));
                    nesFamilyObj.add("country",String.valueOf(nesObj.get("country")));
                    nesFamilyObj.add("dateofbirth",String.valueOf(nesObj.get("dob")));
                    nesFamilyObj.add("relationship",String.valueOf(nesObj.get("relation")));
                    nesFamilyObj.add("opdno",code+"/"+String.valueOf(nesObj.get("relation")));
                    nesFamilyObj.add("primarypatid",pat_id);
                    nesFamilyObj.add("category",String.valueOf(jsObj.get("category")));
                    nesFamilyObj.add("entrydate","");
                    nesFamilyObj.add("serno",""); 
                    String id = rcdef.InsertMedWithoutDocAssign(ccode,nesFamilyObj);
                    //out.println(id+" : "+String.valueOf(nesObj.get("fname")));
                    JSONObject successFamilyIn = new JSONObject();
                    successFamilyIn.put(id,"Family member is included, Relation: "+String.valueOf(nesObj.get("relation"))+" Primary Patient ID: "+pat_id);
                    successLogs.add(successFamilyIn);
                    String subject = "Family Member Inclusion in iMediX";
                    String mesg = "Dear "+String.valueOf(jsObj.get("fname"))+",\n\n"+
                                "One of your family members is now associated with your iMediX account.\n\n"+
                                "Name: "+String.valueOf(nesObj.get("fname"))+"\n Relationship:"+String.valueOf(nesObj.get("relation"))+"\n\n"+
                                "*Note: If such activivity is not performed by you, please contact to iMediX administrator.";
                    Email em = new Email(request.getRealPath("/"));
                    //output = em.Send(emailid,subject,mesg);
                }catch(Exception ex){
                    JSONObject errJSONParseF = new JSONObject();
                    errJSONParseF.put("JSONParseErrorFamily",ex.toString());
                    errorLogs.add(errJSONParseF);
                }

            }
        }
        
        
        
    }
    out.println("Error Logs: "+errorLogs);
    out.println("Success Logs: "+successLogs);
%>