	function ShowHide(id)
{
	var el=document.getElementById(id);
	if (el.style.display=="none")
		el.style.display="block";
	else 		el.style.display="none";

}

function pcount(val)
{	var dispense='dispense';
	var consume='consume';
	var adhere='adhere'; 
	dispense+=val;
	consume+=val;
	adhere+=val;
	dis=document.getElementById(dispense).value ;
	con=document.getElementById(consume).value ;
	if (con && dis)
	{
	
	cent= (dis-con)*100/dis;
	cent=cent.toFixed(2);
	adh=document.getElementById(adhere);
	adh.value=cent;
	}

}