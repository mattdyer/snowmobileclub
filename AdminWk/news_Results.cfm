<!--- Make sure visitor is logged in --->
<cfif not isDefined("SESSION.Auth.IsLoggedIn") OR SESSION.Auth.IsLoggedIn NEQ "Yes">
<!--- If submitting, add check code --->
		<cfif isDefined("FORM.UserLogin")>
			<cfinclude template="empLoginChk.cfm">
		</cfif>
	<!--- Don't forget to include the login form --->
	<cfinclude template="empLogin.cfm">
	<cfabort>
</cfif>
<cfset CurrentPage=GetFileFromPath(GetBaseTemplatePath())>
<cfparam name="PageNum_WADAnews" default="1">
<cfquery name="WADAnews" datasource="FSA1">
SELECT ID, newsDate, newsHeadline, newsDetails FROM news ORDER BY newsDate DESC 
</cfquery>
<cfset MaxRows_WADAnews=10>
<cfset StartRow_WADAnews=Min((PageNum_WADAnews-1)*MaxRows_WADAnews+1,Max(WADAnews.RecordCount,1))>
<cfset EndRow_WADAnews=Min(StartRow_WADAnews+MaxRows_WADAnews-1,WADAnews.RecordCount)>
<cfset TotalPages_WADAnews=Ceiling(WADAnews.RecordCount/MaxRows_WADAnews)>
<cfset QueryString_WADAnews=Iif(CGI.QUERY_STRING NEQ "",DE("&"&XMLFormat(CGI.QUERY_STRING)),DE(""))>
<cfset tempPos=ListContainsNoCase(QueryString_WADAnews,"PageNum_WADAnews=","&")>
<cfif tempPos NEQ 0>
  <cfset QueryString_WADAnews=ListDeleteAt(QueryString_WADAnews,tempPos,"&")>
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
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/Admin1.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>News Listing</title>
<!-- InstanceEndEditable -->
<script language="JavaScript1.2" type="text/javascript" src="../mm_css_menu.js"></script>
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
<!-- InstanceBeginEditable name="head" -->
<link href="../WA_DataAssist/styles/Refined_Pacifica.css" rel="stylesheet" type="text/css" />
<link href="../WA_DataAssist/styles/Arial.css" rel="stylesheet" type="text/css" />
<style type="text/css">
/* Title Section */
#WADAPageTitleArea {
	width: 555px;
}
#WADAPageTitleArea div, #WADAPageTitleArea p {
	font-size: 11px;
	padding-bottom: 10px;
}
#WADAPageTitleArea div#WADAPageTitle, #WADAPageTitle {
	font-size: 14px;
	font-weight: bold;
}

.WADAResultsNavigation {
	padding-top: 5px;
	padding-bottom: 10px;
}
.WADAResultsCount {
	font-size: 11px;
}
.WADAResultsNavTop, .WADAResultsInsertButton {
	clear: none;
}
.WADAResultsNavTop {
	width: 60%;
	float: left;
}
.WADAResultsInsertButton {
	width: 30%;
	float: right;
	text-align: right;
}
.WADAResultsNavButtonCell, .WADAResultsInsertButton {
	padding: 2px;
}
.WADAResultsTable {
	font-size: 11px;
	clear: both;
	padding-top: 1px;
	padding-bottom: 1px;
}

.WADAResultsTableHeader, .WADAResultsTableCell {
	padding: 3px;
	text-align: left;
}

.WADAResultsTableHeader {
	padding-left: 12px;
	padding-right: 12px;
}

.WADAResultsTableCell {
	padding-left: 14px;
	padding-right: 14px;
}

.WADAResultsTableCell {
	border-left: 1px solid #BABDC2;
}

.WADAResultsEditButtons {
	border-left: 1px solid #BABDC2;
	border-right: 1px solid #BABDC2;
}

.WADAResultsRowDark {
	background-color: #DFE4E9;
}
</style>
<!-- InstanceEndEditable -->
<link href="../FSATxt.css" rel="stylesheet" type="text/css" />
<link href="../FSA3.css" rel="stylesheet" type="text/css" />

<link href="../FSA_nav.css" rel="stylesheet" type="text/css" />
</head>

<body class="oneColFixCtrHdr" onload="MM_preloadImages('../images/FSA_nav_r1_c1_s2.gif','../images/FSA_nav_r1_c2_s2.gif','../images/FSA_nav_r1_c3_s2.gif','../images/FSA_nav_r1_c4_s2.gif','../images/FSA_nav_r1_c5_s2.gif','../images/FSA_nav_r1_c6_s2.gif','../images/FSA_nav_r1_c7_s2.gif','../images/FSA_nav_r1_c9_s2.gif','../images/FSA_nav_r1_c11_s2.gif')" >

<div id="container">
  <div id="header"><img src="../images/headerHome.jpg" width="955" alt="Flathead Snowmobile Association" height="110" />
  <!-- end #header --></div>
<!--The following section is an HTML table which reassembles the sliced image in a browser.-->
<!--Copy the table section including the opening and closing table tags, and paste the data where-->
<!--you want the reassembled image to appear in the destination document. -->
<!--======================== BEGIN COPYING THE HTML HERE ==========================-->
<!-- #BeginLibraryItem "/Library/MainNav.lbi" -->
<div id="FWTableContainer1555515835">
  <table style="display: inline-table;" border="0" cellpadding="0" cellspacing="0" width="955">
    <!-- fwtable fwsrc="FSA_navA.png" fwpage="Page 1" fwbase="FSA_nav.gif" fwstyle="Dreamweaver" fwdocid = "1555515835" fwnested="0" -->
    <tr>
      <!-- Shim row, height 1. -->
      <td><img src="../images/spacer.gif" width="49" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="58" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="66" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="84" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="54" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="94" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="91" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="1" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="51" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="1" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="72" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="334" height="1" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="1" height="1" border="0" alt=""></td>
    </tr>
    <tr>
      <!-- row 1 -->
      <td><a href="../index.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c1','','../images/FSA_nav_r1_c1_s2.gif',1)"><img name="FSA_nav_r1_c1" src="../images/FSA_nav_r1_c1.gif" width="49" height="22" border="0" alt="Home"></a></td>
      <td><a href="../mission.cfm" onMouseOut="MM_swapImgRestore();MM_menuStartTimeout(1000)" onMouseOver="MM_menuShowMenu('MMMenuContainer0228065437_0', 'MMMenu0228065437_0',0,23,'FSA_nav_r1_c2');MM_swapImage('FSA_nav_r1_c2','','../images/FSA_nav_r1_c2_s2.gif',1)"><img name="FSA_nav_r1_c2" src="../images/FSA_nav_r1_c2.gif" width="58" height="22" border="0" alt="About FSA"></a></td>
      <td><a href="../eventsCal.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c3','','../images/FSA_nav_r1_c3_s2.gif',1)"><img name="FSA_nav_r1_c3" src="../images/FSA_nav_r1_c3.gif" width="66" height="22" border="0" alt="Calendar"></a></td>
      <td><a href="../ridingAreas.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c4','','../images/FSA_nav_r1_c4_s2.gif',1)"><img name="FSA_nav_r1_c4" src="../images/FSA_nav_r1_c4.gif" width="84" height="22" border="0" alt="Riding Areas"></a></td>
      <td><a href="../join.cfm" onMouseOut="MM_swapImgRestore();MM_menuStartTimeout(1000)" onMouseOver="MM_menuShowMenu('MMMenuContainer0228062045_1', 'MMMenu0228062045_1',0,23,'FSA_nav_r1_c5');MM_swapImage('FSA_nav_r1_c5','','../images/FSA_nav_r1_c5_s2.gif',1)"><img name="FSA_nav_r1_c5" src="../images/FSA_nav_r1_c5.gif" width="54" height="22" border="0" alt="Join"></a></td>
      <td><a href="../localSvcs.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c6','','../images/FSA_nav_r1_c6_s2.gif',1)"><img name="FSA_nav_r1_c6" src="../images/FSA_nav_r1_c6.gif" width="94" height="22" border="0" alt="Local Services"></a></td>
      <td><a href="../NewsPhotos/news.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c7','','../images/FSA_nav_r1_c7_s2.gif',1)"><img name="FSA_nav_r1_c7" src="../images/FSA_nav_r1_c7.gif" width="91" height="22" border="0" alt="News & Events"></a></td>
      <td><img name="FSA_nav_r1_c8" src="../images/FSA_nav_r1_c8.gif" width="1" height="22" border="0" alt=""></td>
      <td><a href="../links.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c9','','../images/FSA_nav_r1_c9_s2.gif',1)"><img name="FSA_nav_r1_c9" src="../images/FSA_nav_r1_c9.gif" width="51" height="22" border="0" alt="Links"></a></td>
      <td><img name="FSA_nav_r1_c10" src="../images/FSA_nav_r1_c10.gif" width="1" height="22" border="0" alt=""></td>
      <td><a href="mailto:info@m-s-a.org" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r1_c11','','../images/FSA_nav_r1_c11_s2.gif',1)"><img name="FSA_nav_r1_c11" src="../images/FSA_nav_r1_c11.gif" width="72" height="22" border="0" alt=""></a></td>
      <td><img name="FSA_nav_r1_c12" src="../images/FSA_nav_r1_c12.gif" width="334" height="22" border="0" alt=""></td>
      <td><img src="../images/spacer.gif" width="1" height="22" border="0" alt=""></td>
    </tr>
    <!--   This table was automatically created with Adobe Fireworks   -->
    <!--   http://www.adobe.com   -->
  </table>
  <div id="MMMenuContainer0228065437_0">
    <div id="MMMenu0228065437_0" onMouseOut="MM_menuStartTimeout(1000);" onMouseOver="MM_menuResetTimeout();"> <a href="../mission.cfm" id="MMMenu0228065437_0_Item_0" class="MMMIFVStyleMMMenu0228065437_0" onMouseOver="MM_menuOverMenuItem('MMMenu0228065437_0');"> Mission&nbsp;Statement </a> <a href="../officers.cfm" id="MMMenu0228065437_0_Item_1" class="MMMIVStyleMMMenu0228065437_0" onMouseOver="MM_menuOverMenuItem('MMMenu0228065437_0');"> Officers </a> </div>
  </div>
  <div id="MMMenuContainer0228062045_1">
    <div id="MMMenu0228062045_1" onMouseOut="MM_menuStartTimeout(1000);" onMouseOver="MM_menuResetTimeout();"> <a href="../join.cfm" id="MMMenu0228062045_1_Item_0" class="MMMIFVStyleMMMenu0228062045_1" onMouseOver="MM_menuOverMenuItem('MMMenu0228062045_1');"> Join&nbsp;Online </a> <a href="../membershipapp.pdf" id="MMMenu0228062045_1_Item_1" class="MMMIVStyleMMMenu0228062045_1" onMouseOver="MM_menuOverMenuItem('MMMenu0228062045_1');"> Print&nbsp;Application </a> </div>
  </div>
</div>
<!-- #EndLibraryItem --><!--========================= STOP COPYING THE HTML HERE =========================-->

  <div id="adminHomelink"><a href="index.cfm">Admin Home</a> | <a href="empLogout.cfm">Log Out</a></div>
  <div id="mainContent"> <!-- InstanceBeginEditable name="Heading1" -->
    <h1>News Listing</h1>
    <!-- InstanceEndEditable -->
      <div id="MainImg">
        <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><!-- InstanceBeginEditable name="MainText" -->
            <div class="oneColFixCtrHdr">
              <div align="justify"></div>
            </div>
            
            
            <div class="WADAResultsContainer"> <a name="top"></a>
                <div id="WADAPageTitleArea">
                  <div id="WADAPageTitle"></div>
              </div>
              <div class="WADAHorizLine"><img src="../WA_DataAssist/images/_tx_.gif" alt="" height="1" width="1" border="0" /></div>
              <cfif WADAnews.RecordCount GT 0>
                  <div class="WADAResults">
                    <div class="WADAResultsNavigation">

                      <div class="WADAResultsInsertButton"> <a href="news_Insert.cfm" title="Insert"><img border="0" name="Insert" id="Insert" alt="Insert" src="../WA_DataAssist/images/Pacifica/Refined_insert.gif" /></a> </div>
                    </div>
                    <table class="WADAResultsTable" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <th class="WADAResultsTableHeader">Date:</th>
                        <th class="WADAResultsTableHeader">Headline:</th>
                        <th class="WADAResultsTableHeader">Details:</th>
                        <th>&nbsp;</th>
                      </tr>
                      <cfoutput query="WADAnews" startRow="#StartRow_WADAnews#" maxRows="#MaxRows_WADAnews#">
                        <tr class="#WA_AltClassIterator_getClass(WARRT_AltClass1,true)#">
                          <td class="WADAResultsTableCell">#DateFormat(WADAnews.newsDate, "MM/DD/YYYY")#</td>
                          <td class="WADAResultsTableCell"><a href="news_Detail.cfm?ID=#URLEncodedFormat(WADAnews.ID)#" >#WADAnews.newsHeadline#</a></td>
                          <td class="WADAResultsTableCell">#WADAnews.newsDetails#</td>
                          <td class="WADAResultsEditButtons" nowrap="nowrap"><table class="WADAEditButton_Table">
                            <tr>
                              <td><a href="news_Detail.cfm?ID=#URLEncodedFormat(WADAnews.ID)#" title="View"><img border="0" name="View#URLEncodedFormat(WADAnews.ID)#" id="View#URLEncodedFormat(WADAnews.ID)#" alt="View" src="../WA_DataAssist/images/Pacifica/Refined_zoom.gif" /></a></td>
                              <td><a href="news_Update.cfm?ID=#URLEncodedFormat(WADAnews.ID)#" title="Update"><img border="0" name="Update#URLEncodedFormat(WADAnews.ID)#" id="Update#URLEncodedFormat(WADAnews.ID)#" alt="Update" src="../WA_DataAssist/images/Pacifica/Refined_edit.gif" /></a></td>
                              <td><a href="news_Delete.cfm?ID=#URLEncodedFormat(WADAnews.ID)#" title="Delete"><img border="0" name="Delete#URLEncodedFormat(WADAnews.ID)#" id="Delete#URLEncodedFormat(WADAnews.ID)#" alt="Delete" src="../WA_DataAssist/images/Pacifica/Refined_trash.gif" /></a></td>
                            </tr>
                          </table></td>
                        </tr>
                      </cfoutput>
                    </table>
                    <div class="WADAResultsNavigation">
                      <div class="WADAResultsCount">Records
                        <cfoutput>#StartRow_WADAnews#</cfoutput>
                        to
                        <cfoutput>#EndRow_WADAnews#</cfoutput>
                        of
                        <cfoutput>#WADAnews.RecordCount#</cfoutput>
                      </div>
                      <div class="WADAResultsNavBottom">
                        <table border="0" cellpadding="0" cellspacing="0" class="WADAResultsNavTable">
                          <tr valign="middle">
                            <td class="WADAResultsNavButtonCell" nowrap="nowrap"><cfif PageNum_WADAnews GT 1>
                              <a href="<cfoutput>#CurrentPage#?PageNum_WADAnews=1#QueryString_WADAnews#</cfoutput>" title="First"><img border="0" name="First1" id="First1" alt="First" src="../WA_DataAssist/images/Pacifica/Refined_first.gif" /></a>
                            </cfif></td>
                            <td class="WADAResultsNavButtonCell" nowrap="nowrap"><cfif PageNum_WADAnews GT 1>
                              <a href="<cfoutput>#CurrentPage#?PageNum_WADAnews=#Max(DecrementValue(PageNum_WADAnews),1)##QueryString_WADAnews#</cfoutput>" title="Previous"><img border="0" name="Previous1" id="Previous1" alt="Previous" src="../WA_DataAssist/images/Pacifica/Refined_previous.gif" /></a>
                            </cfif></td>
                            <td class="WADAResultsNavButtonCell" nowrap="nowrap"><cfif PageNum_WADAnews LT TotalPages_WADAnews>
                              <a href="<cfoutput>#CurrentPage#?PageNum_WADAnews=#Min(IncrementValue(PageNum_WADAnews),TotalPages_WADAnews)##QueryString_WADAnews#</cfoutput>" title="Next"><img border="0" name="Next1" id="Next1" alt="Next" src="../WA_DataAssist/images/Pacifica/Refined_next.gif" /></a>
                            </cfif></td>
                            <td class="WADAResultsNavButtonCell" nowrap="nowrap"><cfif PageNum_WADAnews LT TotalPages_WADAnews>
                              <a href="<cfoutput>#CurrentPage#?PageNum_WADAnews=#TotalPages_WADAnews##QueryString_WADAnews#</cfoutput>" title="Last"><img border="0" name="Last1" id="Last1" alt="Last" src="../WA_DataAssist/images/Pacifica/Refined_last.gif" /></a>
                            </cfif></td>
                          </tr>
                        </table>
                      </div>
                    </div>
                  </div>
              </cfif>
                <cfif WADAnews.RecordCount EQ 0>
                  <div class="WADANoResults">
                    <div class="WADANoResultsMessage">No results for your search</div>
                    <div> <a href="news_Insert.cfm" title="Insert"><img border="0" name="Insert1" id="Insert1" alt="Insert" src="../WA_DataAssist/images/Pacifica/Refined_insert.gif" /></a> </div>
                  </div>
                </cfif>
            </div>
            <!-- InstanceEndEditable --> </td>
          </tr>
        </table>
      </div>
    <div class="tagMessage">
        <p>Remember - T.E.A.M  Together Everyone Achieves More</p>
      <p>Thanks for Your Support</p>
    </div>
    <!-- end #mainContent -->
  </div>
  <div id="footer"><!-- #BeginLibraryItem "/Library/footer.lbi" -->
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
      <td width="45%" class="copyrightR">Web Design and hosting by<a href="http://www.ssb-ca.com"><img src="../images/SSBLogoTiny.jpg" width="59" height="15" hspace="4" border="0" align="right" /></a> </td>
    </tr>
  </table>
</div>
<!-- #EndLibraryItem --><p>&nbsp;</p>
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
<!-- InstanceEnd --></html>
