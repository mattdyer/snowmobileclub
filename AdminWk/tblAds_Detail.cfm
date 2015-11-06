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
<cfparam name="URL.AdsID" default="-1">
<cfparam name="WADA_URL_AdsID" default="#URL.AdsID#">
<cfparam name="SESSION.WADA_Insert_tblAds" default="-1">
<cfquery name="WADAtblAds" datasource="FSA1">
SELECT * 
FROM tblAds 
WHERE AdsID = <cfqueryparam value="#URL.AdsID#" cfsqltype="cf_sql_numeric"> OR ( -1= <cfqueryparam value="#WADA_URL_AdsID#" cfsqltype="cf_sql_numeric"> AND AdsID=<cfqueryparam value="#SESSION.WADA_Insert_tblAds#" cfsqltype="cf_sql_numeric">) 
</cfquery>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/Admin1.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>Ad Details</title>
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
/* Details page CSS */
.WADADetailsContainer {
	font-size: 11px;
}
#WADADetails {
	padding-top: 10px;
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
    <h1>Ad Details</h1>
    <!-- InstanceEndEditable -->
      <div id="MainImg">
        <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><!-- InstanceBeginEditable name="MainText" -->
            <div class="oneColFixCtrHdr">
              <div align="justify"></div>
            </div>
            
            
            <div class="WADADetailsContainer"> <a name="top"></a>
                <div class="WADAHorizLine"><img src="../WA_DataAssist/images/_tx_.gif" alt="" height="1" width="1" border="0" /></div>
              <cfif WADAtblAds.RecordCount GT 0><div id="WADADetails"><div class="WADAHeader"></div>
                <table class="WADADataTable" cellpadding="0" cellspacing="0" border="0">
                      <tr>
                        <th class="WADADataTableHeader">Advertiser Name:</th>
                        <td class="WADADataTableCell"><cfoutput>#WADAtblAds.AdsCustomerName#<br/>
                        #WADAtblAds.AdsAddress#<br/>
						#WADAtblAds.AdsCity#, #WADAtblAds.AdsState# #WADAtblAds.AdsZip#<br/>
                        #WADAtblAds.AdsEmail#<br/>#WADAtblAds.AdsPhone#</cfoutput>                        </td>
                      </tr>
                      <tr>
                        <th class="WADADataTableHeader">Price Paid:</th>
                        <td class="WADADataTableCell"><cfoutput>#LSCurrencyFormat(WADAtblAds.AdsPricePaid)#</cfoutput></td>
                      </tr>
                      <tr>
                        <th class="WADADataTableHeader">Ad Headline:</th>
                        <td class="topicHeadline"><cfoutput>#WADAtblAds.AdsHeadline#</cfoutput></td>
                      </tr>
                      <tr>
                        <th class="WADADataTableHeader">AdsBody:</th>
                        <td class="WADADataTableCell"><cfoutput>#WADAtblAds.AdsBody#</cfoutput></td>
                      </tr>
                      <tr>
                        <th class="WADADataTableHeader">Ad Banner Image:</th>
                        <td class="WADADataTableCell"><img src="../images/<cfoutput>#WADAtblAds.AdsBanner#</cfoutput>" /><br/><cfoutput>#WADAtblAds.AdsBanner#</cfoutput></td>
                      </tr>
                      <tr>
                        <th class="WADADataTableHeader">Ad Web Link:</th>
                        <td class="WADADataTableCell"><a href="<cfoutput>#WADAtblAds.AdsLink#</cfoutput>"><cfoutput>#WADAtblAds.AdsLink#</cfoutput></a></td>
                    </tr>
                      <tr>
                        <th class="WADADataTableHeader">Start Date:</th>
                        <td class="WADADataTableCell"><cfoutput>#DateFormat(WADAtblAds.AdsStartDate,"M/D/YY")#</cfoutput></td>
                      </tr>
                      <tr>
                        <th class="WADADataTableHeader">End Date:</th>
                        <td class="WADADataTableCell"><cfoutput>#DateFormat(WADAtblAds.AdsEndDate,"M/D/YY")#</cfoutput></td>
                      </tr>
                    </table>
                  <div class="WADAHorizLine"><img src="../WA_DataAssist/images/_tx_.gif" alt="" height="1" width="1" border="0" /></div>
                    <div class="WADAButtonRow">
                      <table border="0" align="center" cellpadding="0" cellspacing="0" class="WADADataNavButtons">
                        <tr>
                          <td class="WADADataNavButtonCell" nowrap="nowrap"><a href="tblAds_Update.cfm?AdsID=<cfoutput>#URLEncodedFormat(WADAtblAds.AdsID)#</cfoutput>" title="Update"><img border="0" name="Update" id="Update" alt="Update" src="../WA_DataAssist/images/Pacifica/Refined_update.gif" /></a></td>
                          <td class="WADADataNavButtonCell" nowrap="nowrap"><a href="tblAds_Delete.cfm?AdsID=<cfoutput>#URLEncodedFormat(WADAtblAds.AdsID)#</cfoutput>" title="Delete"><img border="0" name="Delete" id="Delete" alt="Delete" src="../WA_DataAssist/images/Pacifica/Refined_delete.gif" /></a></td>
                          <td class="WADADataNavButtonCell" nowrap="nowrap"><a href="tblAds_Results.cfm" title="Results"><img border="0" name="Results" id="Results" alt="Results" src="../WA_DataAssist/images/Pacifica/Refined_results.gif" /></a></td>
                        </tr>
                      </table>
                  </div>
                  </div>
            </cfif>
                <cfif WADAtblAds.RecordCount EQ 0>
                  <div class="WADANoResults">
                    <div class="WADANoResultsMessage">No record found.</div>
                  </div>
                  <div class="WADAHorizLine"><img src="../WA_DataAssist/images/_tx_.gif" alt="" height="1" width="1" border="0" /></div>
                  <div class="WADADetailsLinkArea">
                    <div class="WADADataNavButtonCell"><a href="tblAds_Results.cfm" title="Results"><img border="0" name="Results1" id="Results1" alt="Results" src="../WA_DataAssist/images/Pacifica/Refined_results.gif" /></a></div>
                  </div>
                  <div class="WADAHorizLine"><img src="../WA_DataAssist/images/_tx_.gif" alt="" height="1" width="1" border="0" /></div>
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
