 	var ckp, dkp;
	ckp=0;
	dkp=true;	
	window.onresize=arp;


	function arp(complete) {
		
		var oText, oSelect, obj, x, y;
		
		for(var i=1;i<=ckp;i++) {	
			x=0;
			y=0;
			oText=eval("document.all.deb"+i);                  
			oSelect=eval("document.all.kumar"+i);				
			obj=oText;

			while(obj.tagName!="BODY") {
				x+=obj.offsetLeft;
				y+=obj.offsetTop;
				obj=obj.offsetParent;
			}	
	
			if(dkp) {
				oText.style.width=oText.offsetWidth-16;
				oSelect.selectedIndex=-1;
				dkp=false;
			}
			if(complete) {
				oSelect.selectedIndex=-1;
				oText.style.marginRight=16;
			}	
			
			oSelect.style.left=x;
			oSelect.style.top=y;
			oSelect.style.width=oText.offsetWidth+16;
	
			oSelect.style.clip="rect(0,"+(oText.offsetWidth+18)+","+(oText.offsetHeight)+","+(oText.offsetWidth-2)+")";
			oSelect.style.display="block";
		}
		
	}

	function chhotu(instance, lookup) {							
		var oText=eval("document.all.deb"+instance);
		var oSelect=eval("document.all.kumar"+instance);
		var tr=oText.createTextRange();
		if(lookup) tr.text=oSelect.options[oSelect.selectedIndex].value;
		else tr.text=oSelect.options[oSelect.selectedIndex].text;
		oSelect.selectedIndex=-1;
		
		tr.expand("textedit");
		oText.focus();		
		tr.select();
	}	
		
		
		function anamika(level) {					   
		if(document.readyState=="complete") {
			arp(true);
		}
		else if(document.readyState=="interactive") {
			if(level!=2) arp();
			setTimeout("anamika(2)",100);
		}
		else {
			setTimeout("anamika(1)",100);
		}
	}
	anamika(1);





