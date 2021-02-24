function fold_unfold(divid, total)
{
	document.getElementById(divid).style.display="";
	document.getElementById(divid).style.visibility="visible";
	for(var i = 0; i < total; i++)
	{
		if (document.getElementById("sub_"+i) && divid != "sub_"+i)
		{
				ele = document.getElementById("sub_"+i);
				ele.style.display="none";
				ele.style.visibility="hidden";
		}
	}
}

function show_hide(divid, total)
{
	document.getElementById(divid).style.display="";
	document.getElementById(divid).style.visibility="visible";
	for(var i = 0; i < total; i++)
	{
		if (document.getElementById("main_"+i) && divid != "main_"+i)
		{
				ele = document.getElementById("main_"+i);
				ele.style.display="none";
				ele.style.visibility="hidden";
		}
	}
}