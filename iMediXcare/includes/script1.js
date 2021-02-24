function checkint(fdval) { 
	var tmp; var tnum; 
	 for(i=0;i<fdval.length;i++) { 
	 tmp=fdval.substring (i,i+1); 
	 if (tmp == '.' || tmp == '+' || tmp == '-' ) continue;
		tnum=parseInt(tmp); 
		if (tnum>=0 && tnum<=9) 
			continue; 
		else { 
			alert('Please enter Number in the field'); 
			return false; 
			} 
		} 
	return true;
}

function checkintObject(Obj) { 
	var tmp; var tnum; 
	var fdval = Obj.value.trim();
	for(i=0;i<fdval.length;i++) { 
		 tmp=fdval.substring (i,i+1); 
		 if (tmp == '.' || tmp == '+' || tmp == '-' ) continue;
		 tnum=parseInt(tmp); 
		 if (tnum>=0 && tnum<=9) continue; 
		 else return false;
	}
	return true;
}

function chkdt(dat) {
	//alert(dat);
	var retval;
	var mm,dd,yy,t,yr; 

	if(dat.length != 0)
	{
	for(i=0;i<8;i++){
		t = dat.substring(i,i+1);
		if (t >= '0' && t <= '9')
			continue;
		else
			alert ("Enter Appropriate Date in ddmmyyyy format ");
			return false;
			}
	dd=dat.substring(0,2); 
	mm=dat.substring(2,4); 
	yy=dat.substring(4,8);
	if (dd < 1 || dd > 31) { window.alert('Day must range from 1 to 31. Date Format DDMMYYYY'); return false; } 
	if (mm < 1 || mm > 12) { window.alert('Month must range from 1 to 12. Date Format DDMMYYYY'); return false; } 
	else
	{
	switch (mm)
	{
	case "02":
	yr=yy%4;
	  if(dd==29&&yr!=0){window.alert('This Year is not a leap year'); return false;}
	  if(dd>29) {window.alert('February have not more than 29 days except leap year'); return false;}
	case "04":
	if(dd==31){window.alert('In April Date 31 is not present'); return false;}
	case "06":
	if(dd==31){window.alert('In June Date 31 is not present'); return false;}
	case "09":
	if(dd==31){window.alert('In September Date 31 is not present'); return false;}
	case "11":
	if(dd==31){window.alert('In November Date 31 is not present'); return false;}
	}
	}
	if (yy < 1931 || yy > 2030) { window.alert('year must range from 1931 to 2030. Date Format DDMMYYYY'); return false; } 

	}
}


function txtlength(textarea,length)
{
	if(textarea.value.length >=length)
	{
		return false;
	}
	}

	function chkpest(textarea,length)
	{
	if(textarea.value.length >length+1)
	{
	alert ("More than"+length+"char is not allowed");
	return textarea.focus();
	}
}



function testdt(dat,today) { 
	console.log(dat+" : "+today);
	var retval,cmd;
	var mm,dd,yy,t,yr; 
	var m,d,y;
	if (dat.length == 0)
		{
			document.getElementById("testdate").focus();
		alert ("Date Field is not optional, Enter date in ddmmyyyy format");
		return false;
		}
	for(i=0;i<8;i++){
		t = dat.substring(i,i+1);
		if (t >= '0' && t <= '9'){
			continue;}
		else{
			document.getElementById("testdate").focus();
			alert ("Enter Appropriate Date in ddmmyyyy format");
			return false;}
		}
	dd=dat.substring(0,2); 
	mm=dat.substring(2,4); 
	yy=dat.substring(4,8);

	d=today.substring(0,2); 
	m=today.substring(2,4); 
	y=today.substring(4,8);
	if( yy > y)
		{ alert("Future date not allowed");document.getElementById("testdate").focus(); return false; }
	else 
	{	if (yy == y && mm > m) 
		{alert("Future date not allowed"); document.getElementById("testdate").focus(); return false;}
		else
		{
			if (yy == y && mm == m && dd > d)
			{alert("Future date not allowed"); document.getElementById("testdate").focus(); return false;}
		}
	}

	if (dd < 1 || dd > 31) { window.alert('Day must range from 1 to 31. Date Format DDMMYYYY'); return false; } 
	if (mm < 1 || mm > 12) { window.alert('Month must range from 1 to 12. Date Format DDMMYYYY'); return false;}
	else
	{
	switch (mm)
	{
	case "02":
	yr=yy%4;
	  if(dd==29&&yr!=0){window.alert('This Year is not a leapyear'); return false;}
	  if(dd>29) {window.alert('February have not more than 29 days except leap year'); return false;}
	case "04":
	if(dd==31){window.alert('In April Date 31 is not present'); return false;}
	case "06":
	if(dd==31){window.alert('In June Date 31 is not present'); return false;}
	case "09":
	if(dd==31){window.alert('In September Date 31 is not present'); return false;}
	case "11":
	if(dd==31){window.alert('In November Date 31 is not present'); return false;}
	}
	}


}



function dateentry() {
	document.forms[0].elements[2].focus();
	currdate=new Date()
	var endt=new Date();
	dd=endt.getDate();
	mm=endt.getMonth()+1;
	if(dd<10)
	  putdate=('0'+dd.toString())
	else
	  putdate=dd.toString()

	if(mm<10)
	  putmonth=('0'+mm.toString())
	else
	  putmonth=mm.toString()
	  
	  yy=endt.getFullYear();
	  putyear=yy.toString();
}



{
	var win=null;
	function NewWindow(mypage,myname,w,h,scroll,pos){
	if(pos=="random"){LeftPosition=(screen.width)?Math.floor(Math.random()*(screen.width-w)):100;TopPosition=(screen.height)?Math.floor(Math.random()*((screen.height-h)-75)):100;}
	if(pos=="center"){LeftPosition=(screen.width)?(screen.width-w)/2:100;TopPosition=(screen.height)?(screen.height-h)/2:100;}
	else if((pos!="center" && pos!="random") || pos==null){LeftPosition=0;TopPosition=20}
	settings='width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=yes';
	win=window.open(mypage,myname,settings);
	}
}	

function fold_unfold(divid, imgid)
{
	var ele = document.getElementById(divid);
	var ele1 = document.getElementById(imgid);
	if (ele.style.visibility == "visible")
	{
		ele.style.display="none";
		ele.style.visibility="hidden";
		ele1.innerHTML = "<img src=\"../images/open.jpg\" border=\"0\">"
	}
	else
	{
		ele.style.display="";
		ele.style.visibility="visible";
		ele1.innerHTML = "<img src=\"../images/close.jpg\" border=\"0\">"
	}
}



function CheckAll()
{
	var inputs = document.getElementsByTagName('input');
	var checkboxes = [];
	for (var i = 0; i < inputs.length; i++) {
		if (inputs[i].type == 'checkbox') {
			inputs[i].checked =true;
		}
	}
}

function isNumberKey(evt){
		 var charCode = (evt.which) ? evt.which : event.keyCode;
         if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;
         return true;
}

function UncheckAll()
{
	var inputs = document.getElementsByTagName('input');
	var checkboxes = [];
	for (var i = 0; i < inputs.length; i++) {
		if (inputs[i].type == 'checkbox') {
			inputs[i].checked=false;
		}
	}
}

function ToggleCheck()
{
	var inputs = document.getElementsByTagName('input');
	var checkboxes = [];
	for (var i = 0; i < inputs.length; i++) {
		if (inputs[i].type == 'checkbox') {
			inputs[i].checked=!(inputs[i].checked);
		}
	}
}

String.prototype.trim = function () {
    return this.replace(/^\s*/, "").replace(/\s*$/, "");
}

function checknum(chval){
		var validcodechr = '0123456789.-+';
			for (var i = 0; i < chval.length; i++) {
			var chr = chval.substring(i,i+1);
			if (validcodechr.indexOf(chr) == -1){
				//alert ("Characters and Special Character not allowed in this field");
				return false;
			}
		}
}
