<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_links" default="1">
<cfquery name="links" datasource="FSA1">
SELECT *
FROM tblLinks 
ORDER BY topic</cfquery>
<cfset MaxRows_links=20>
<cfset StartRow_links=Min((PageNum_links-1)*MaxRows_links+1,Max(links.RecordCount,1))>
<cfset EndRow_links=Min(StartRow_links+MaxRows_links-1,links.RecordCount)>
<cfset TotalPages_links=Ceiling(links.RecordCount/MaxRows_links)>
<cfset QueryString_links=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_links,"PageNum_links=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_links=ListDeleteAt(QueryString_links,tempPos,"&")>
</cfif>
<cfscript>
//WA AltClass Iterator
function WA_AltClassIterator(theArray,theStartIndex)  {
	if (Len(theArray) GT 1) {
	  if (Left(theArray, 1) EQ "|")
		  theArray = "WABLANKCLASS" & theArray;
		if (Right(theArray, 1) EQ "|")
		  theArray = theArray & "WABLANKCLASS";
	  theArray = Replace(theArray, "||", "|WABLANKCLASS|");
	}
	else {
	  if (theArray EQ "|") {
		  theArray = "WABLANKCLASS|WABLANKCLASS";
		}
	}
	theArray = ListToArray(theArray, "|");
  tempStruct=StructNew();
  StructInsert(tempStruct, "ClassArray", theArray);
  StructInsert(tempStruct, "ClassCounter", theStartIndex);
  return tempStruct;
}

function WA_AltClassIterator_getClass(loopObj, incrementClass)   {
  if (ArrayLen(loopObj.ClassArray) EQ 0)
    return "";
  if (incrementClass) {
    if (loopObj.ClassCounter GT ArrayLen(loopObj.ClassArray))
      loopObj.ClassCounter = 1;
    loopObj.ClassCounter = loopObj.ClassCounter + 1;
  }
	retVal = "";
  if (loopObj.ClassCounter GT 1)
    retVal = loopObj.ClassArray[loopObj.ClassCounter-1];
	else
    retVal = loopObj.ClassArray[1];
  if (retVal EQ "WABLANKCLASS") return "";
	return retVal;
}
</cfscript>
<cfset WARRT_AltClass1 = WA_AltClassIterator("WADAResultsRowDark|", 1) />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Flathead Snowmobile Association Links</title>
<style type="text/css" media="screen">
@import url("FSA_nav.css");
</style>
<script language="JavaScript1.2" type="text/javascript" src="mm_css_menu.js"></script>
<script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
<link href="FSA3.css" rel="stylesheet" type="text/css" />
<link href="FSATxt.css" rel="stylesheet" type="text/css" />
<link href="WA_DataAssist/styles/Refined_Pacifica.css" rel="stylesheet" type="text/css" />
</head>
<body class="oneColFixCtrHdr" onload="MM_preloadImages('images/FSA_nav_r1_c1_s2.gif','images/FSA_nav_r1_c2_s2.gif','images/FSA_nav_r1_c3_s2.gif','images/FSA_nav_r1_c4_s2.gif','images/FSA_nav_r1_c5_s2.gif','images/FSA_nav_r1_c6_s2.gif','images/FSA_nav_r1_c7_s2.gif','images/FSA_nav_r1_c9_s2.gif','images/FSA_nav_r1_c11_s2.gif')">
<div id="container">
  <div id="header"><img src="images/headerHome.jpg" width="955" alt="Flathead Snowmobile Association" height="110" />
    <!-- end #header -->
  </div><!-- #BeginLibraryItem "/Library/MainNav.lbi" --><div id="FWTableContainer1555515835">
<table style="display: inline-table;" border="0" cellpadding="0" cellspacing="0" width="955">
<!-- fwtable fwsrc="FSA_navA.png" fwpage="Page 1" fwbase="FSA_nav.gif" fwstyle="Dreamweaver" fwdocid = "1555515835" fwnested="0" -->
  <tr>
<!-- Shim row, height 1. -->
   <td><img src="images/spacer.gif" width="49" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="58" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="66" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="84" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="54" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="94" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="91" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="51" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="72" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="334" height="1" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="1" border="0" alt=""></td>
  </tr>

  <tr><!-- row 1 -->
   <td><a href="index.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c1','','images/FSA_nav_r1_c1_s2.gif',1)"><img name="FSA_nav_r1_c1" src="images/FSA_nav_r1_c1.gif" width="49" height="22" border="0" alt="Home"></a></td>
   <td><a href="mission.cfm" onMouseOut="MM_swapImgRestore();MM_menuStartTimeout(1000)" onMouseOver="MM_menuShowMenu('MMMenuContainer0228065437_0', 'MMMenu0228065437_0',0,23,'FSA_nav_r1_c2');MM_swapImage('FSA_nav_r1_c2','','images/FSA_nav_r1_c2_s2.gif',1)"><img name="FSA_nav_r1_c2" src="images/FSA_nav_r1_c2.gif" width="58" height="22" border="0" alt="About FSA"></a></td>
   <td><a href="eventsCal.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c3','','images/FSA_nav_r1_c3_s2.gif',1)"><img name="FSA_nav_r1_c3" src="images/FSA_nav_r1_c3.gif" width="66" height="22" border="0" alt="Calendar"></a></td>
   <td><a href="ridingAreas.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c4','','images/FSA_nav_r1_c4_s2.gif',1)"><img name="FSA_nav_r1_c4" src="images/FSA_nav_r1_c4.gif" width="84" height="22" border="0" alt="Riding Areas"></a></td>
   <td><a href="join.cfm" onMouseOut="MM_swapImgRestore();MM_menuStartTimeout(1000)" onMouseOver="MM_menuShowMenu('MMMenuContainer0228062045_1', 'MMMenu0228062045_1',0,23,'FSA_nav_r1_c5');MM_swapImage('FSA_nav_r1_c5','','images/FSA_nav_r1_c5_s2.gif',1)"><img name="FSA_nav_r1_c5" src="images/FSA_nav_r1_c5.gif" width="54" height="22" border="0" alt="Join"></a></td>
   <td><a href="localSvcs.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c6','','images/FSA_nav_r1_c6_s2.gif',1)"><img name="FSA_nav_r1_c6" src="images/FSA_nav_r1_c6.gif" width="94" height="22" border="0" alt="Local Services"></a></td>
   <td><a href="NewsPhotos/news.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c7','','images/FSA_nav_r1_c7_s2.gif',1)"><img name="FSA_nav_r1_c7" src="images/FSA_nav_r1_c7.gif" width="91" height="22" border="0" alt="News & Events"></a></td>
   <td><img name="FSA_nav_r1_c8" src="images/FSA_nav_r1_c8.gif" width="1" height="22" border="0" alt=""></td>
   <td><a href="links.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c9','','images/FSA_nav_r1_c9_s2.gif',1)"><img name="FSA_nav_r1_c9" src="images/FSA_nav_r1_c9.gif" width="51" height="22" border="0" alt="Links"></a></td>
   <td><img name="FSA_nav_r1_c10" src="images/FSA_nav_r1_c10.gif" width="1" height="22" border="0" alt=""></td>
   <td><a href="mailto:info@m-s-a.org" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c11','','images/FSA_nav_r1_c11_s2.gif',1)"><img name="FSA_nav_r1_c11" src="images/FSA_nav_r1_c11.gif" width="72" height="22" border="0" alt=""></a></td>
   <td><img name="FSA_nav_r1_c12" src="images/FSA_nav_r1_c12.gif" width="334" height="22" border="0" alt=""></td>
   <td><img src="images/spacer.gif" width="1" height="22" border="0" alt=""></td>
  </tr>
<!--   This table was automatically created with Adobe Fireworks   -->
<!--   http://www.adobe.com   -->
</table>
<div id="MMMenuContainer0228065437_0">
	<div id="MMMenu0228065437_0" onMouseOut="MM_menuStartTimeout(1000);" onMouseOver="MM_menuResetTimeout();">
		<a href="mission.cfm" id="MMMenu0228065437_0_Item_0" class="MMMIFVStyleMMMenu0228065437_0" onMouseOver="MM_menuOverMenuItem('MMMenu0228065437_0');">
			Mission&nbsp;Statement
		</a>
		<a href="officers.cfm" id="MMMenu0228065437_0_Item_1" class="MMMIVStyleMMMenu0228065437_0" onMouseOver="MM_menuOverMenuItem('MMMenu0228065437_0');">
			Officers
		</a>
	</div>
</div>
<div id="MMMenuContainer0228062045_1">
	<div id="MMMenu0228062045_1" onMouseOut="MM_menuStartTimeout(1000);" onMouseOver="MM_menuResetTimeout();">
		<a href="join.cfm" id="MMMenu0228062045_1_Item_0" class="MMMIFVStyleMMMenu0228062045_1" onMouseOver="MM_menuOverMenuItem('MMMenu0228062045_1');">
			Join&nbsp;Online
		</a>
		<a href="membershipapp.pdf" id="MMMenu0228062045_1_Item_1" class="MMMIVStyleMMMenu0228062045_1" onMouseOver="MM_menuOverMenuItem('MMMenu0228062045_1');">
			Print&nbsp;Application
		</a>
	</div>
</div>
</div><!-- #EndLibraryItem --><div id="mainContent">
    <h1>Snowmobiling Links</h1>
    <table border="0" align="center">
      <cfoutput>
        <tr>
          <td class="navText"><cfif PageNum_links GT 1>
              <a href="#CurrentPage#?PageNum_links=1#QueryString_links#"><img src="WA_DataAssist/images/Pacifica/Refined_first.gif" border="0" />First</a>
            </cfif>
          </td>
          <td class="navText"><cfif PageNum_links GT 1>
              <a href="#CurrentPage#?PageNum_links=#Max(DecrementValue(PageNum_links),1)##QueryString_links#"><img src="WA_DataAssist/images/Pacifica/Refined_previous.gif" border="0" />Previous</a>
            </cfif>
          </td>
          <td class="navText"><cfif PageNum_links LT TotalPages_links>
              <a href="#CurrentPage#?PageNum_links=#Min(IncrementValue(PageNum_links),TotalPages_links)##QueryString_links#">Next<img src="WA_DataAssist/images/Pacifica/Refined_next.gif" border="0" /></a>
            </cfif>
          </td>
          <td class="navText"><cfif PageNum_links LT TotalPages_links>
              <a href="#CurrentPage#?PageNum_links=#TotalPages_links##QueryString_links#">Last<img src="WA_DataAssist/images/Pacifica/Refined_last.gif" border="0" /></a>
            </cfif>
          </td>
        </tr>
      </cfoutput>
    </table>
    <table border="0" cellspacing="0" class="WADADataTable">

      <tr>
        <td colspan="2" class="TableHdrHoriz"><div align="center">Listed by Topic</div>          </td>
      </tr>
      <cfoutput query="links" startRow="#StartRow_links#" maxRows="#MaxRows_links#">
      <cfset limitDt = DateFormat(#expDate#)>
        <cfif limitDt EQ "" OR limitDt GTE DateFormat(Now())>
		<tr class="#WA_AltClassIterator_getClass(WARRT_AltClass1,true)#">
          <td width="320" ><span class="topicHeadline">#links.topic#</span><br/>
            <span class="msgThree">#links.linkDesc#</span></td>
          <td class="WADADataTableCell"><a href="#links.linkURL#" class="linkTxt">#links.linkURL#</a></td>
        </tr>
        </cfif>
      </cfoutput>
      <tr class="tableBtmBar">
        <td colspan="2" ><img name="imgPlacehldr" src="" width="1" height="14" alt="" /></td>
      </tr>
    </table>
    </p>
    <!-- end #mainContent -->
  </div><!-- #BeginLibraryItem "/Library/footerNav.lbi" --><table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr>
                <td colspan="3" class="footerCtr" ><a href="index.cfm">Home</a>&nbsp;|&nbsp;<a href="mission.cfm">About</a>&nbsp;|&nbsp;<a href="eventsCal.cfm">Calendar</a>&nbsp;|&nbsp;<a href="ridingAreas.cfm">Riding</a>&nbsp;|&nbsp;<a href="join.cfm">Join</a>&nbsp;|&nbsp;<a href="localSvcs.cfm">Local Svcs</a>&nbsp;|&nbsp;<a href="NewsPhotos/news.cfm">News</a>&nbsp;|&nbsp;<a href="links.cfm">Links</a>&nbsp;|&nbsp;<a href="AdminWk/index.cfm">Admin</a></td>
              </tr>
            </table><!-- #EndLibraryItem --><div id="footer"><!-- #BeginLibraryItem "/Library/footer.lbi" -->
<style type="text/css">
<!--
.footerTxt {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	color: #033AB8;
}
-->
</style>
<div class="footerTxt">
  <table width="100%" border="0">
    <tr>
      <td width="45%" class="copyrightL"><div align="left">&copy; <cfoutput>#Year(Now())#</cfoutput> Flathead Snowmobile Association.<br>
        All rights Reserved</div></td>
      <td width="10%" class="footerCtr"><a href="mailto:webmaster@flatheadsnowmobiler.com">webmaster</a></td>
      <td width="45%" class="copyrightR">Web Design and hosting by<a href="http://www.ssb-ca.com"><img src="images/SSBLogoTiny.jpg" width="59" height="15" hspace="4" border="0" align="right" /></a> </td>
    </tr>
  </table>
</div>
<!-- #EndLibraryItem --><p>&nbsp;</p>
    <!-- end #footer -->
  </div>
  <!-- end #container -->
</div>
</body>
</html>
