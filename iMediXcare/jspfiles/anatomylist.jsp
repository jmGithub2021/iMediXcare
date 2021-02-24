<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<!-- Surajit Kundu -->
<HEAD>

<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
	<script src="../bootstrap/jquery-2.2.1.min.js"></script>
	<script src="../bootstrap/js/bootstrap.min.js"></script>

<TITLE> Human Anatomy </TITLE>
</HEAD>
<!-- surajit -->
<BODY background="../images/txture5.jpg">

<div class="container-fluid">

<script>
function getimage(s)
{
sessionStorage.setItem('imgs', s);
//document.getElementById('div').innerHTML=s;
}


</script>

<CENTER><BR><B><FONT SIZE="+2" COLOR="Darkgreen"><B>Images of <BR> Human Anatomy</B></FONT></B><BR><BR>
<FONT COLOR="#FF55AA">Click on the Image to Mark</FONT><BR>

<!--<TABLE Border=3 bgcolor=#EEEEDD bordercolor=black>-->



<div class="row">

<div class="col-sm-2 col-lg-3"></div>

<div class="col-sm-4 col-lg-3">
<table class="table table-bordered" style="background-color:#EEEEDD">
	<tr><td>
	<center><A HREF="offlineskinpatchmodifyed.jsp?type=bre" onclick="return getimage('bre.jpg')" > <IMG SRC="anatomyimages/bre.jpg" WIDTH="100" HEIGHT="100" BORDER=0 ALT="Breast"> </A>
	<A HREF="offlineskinpatchmodifyed.jsp?type=lun" onclick="return getimage('lun.jpg')" > <IMG SRC="anatomyimages/lun.jpg" WIDTH="100" HEIGHT="100" BORDER=0 ALT="Lungs"> </A>
	</center></td></tr>
	
	<tr><td>
	<center><A HREF="offlineskinpatchmodifyed.jsp?type=lar" onclick="return getimage('lar.jpg')" > <IMG SRC="anatomyimages/lar.jpg" WIDTH="100" HEIGHT="100" BORDER=0 ALT="Larynx"> </A>
	<A HREF="offlineskinpatchmodifyed.jsp?type=ora" onclick="return getimage('ora.jpg')" > <IMG SRC="anatomyimages/ora.jpg" WIDTH="100" HEIGHT="100" BORDER=0 ALT="Oral Cavity and Tongue & Floor of Mouth "></A>
	</center></td></tr>
</table>	
</div>		<!-- "col-sm-4 col-lg-3" -->	
	
<div class="col-sm-4 col-lg-3">	
<table class="table table-bordered"  style="background-color:#EEEEDD">
	<tr><td>	
	<center><A HREF="offlineskinpatchmodifyed.jsp?type=thy" onclick="return getimage('thy.jpg')" ><IMG SRC="anatomyimages/thy.jpg" WIDTH="100" HEIGHT="100" BORDER=0 ALT=" Neck and Thyroid"> </A>
	<A HREF="offlineskinpatchmodifyed.jsp?type=tsv" onclick="return getimage('tsv.jpg')" ><IMG SRC="anatomyimages/tsv.jpg" WIDTH="100" HEIGHT="100" BORDER=0 ALT=" Testis and Seminal Vesicle "></A>
	</center></td></tr>
	
	<tr><td>
	<center><A HREF="offlineskinpatchmodifyed.jsp?type=uto" onclick="return getimage('uto.jpg')" > <IMG SRC="anatomyimages/uto.jpg" WIDTH="100" HEIGHT="100" BORDER=0 ALT="Uterus and Ovarian "></A>
	<A HREF="offlineskinpatchmodifyed.jsp?type=skp" onclick="return getimage('skp.jpg')" > <IMG SRC="anatomyimages/skp.jpg" WIDTH="100" HEIGHT="100" BORDER=0 ALT="Human Profile "></A>
	</center></td></tr>
</table>	
</div>		<!-- "col-sm-4 col-lg-3" -->
<div class="col-sm-2 col-lg-3"></div>

</div>		<!-- "row" -->




</div>		<!-- "container-fluid" -->
</BODY>
</HTML>
