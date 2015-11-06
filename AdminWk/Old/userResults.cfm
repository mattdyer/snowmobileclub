<cfinclude template="../WA_SecurityAssist/Helper_CF.cfm" >
<cfif ( Not WA_Auth_RulePasses("Logged in to Users") ) >
	<cfset WA_Auth_RestrictAccess("denied.html") >
</cfif>
<cfparam name="PageNum_users" default="1">
<cfquery name="users" datasource="FSA1">
SELECT *
FROM Users 
</cfquery>
<cfset MaxRows_users=10>
<cfset StartRow_users=Min((PageNum_users-1)*MaxRows_users+1,Max(users.RecordCount,1))>
<cfset EndRow_users=Min(StartRow_users+MaxRows_users-1,users.RecordCount)>
<cfset TotalPages_users=Ceiling(users.RecordCount/MaxRows_users)>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/Admin1.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- InstanceBeginEditable name="doctitle" -->
<title>FSA Our Mission</title>
<!-- InstanceEndEditable -->
<link href="../FSA3.css" rel="stylesheet" type="text/css" />
<style type="text/css" media="screen">
@import url("../FSA_nav.css");


	

	@import url("../FSA_nav.css");
</style>
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
<link href="../FSATxt.css" rel="stylesheet" type="text/css" />
<!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
</head>

<body class="oneColFixCtrHdr" onLoad="MM_preloadImages('../images/FSA_nav_r2_c1_f2.gif','../images/FSA_nav_r2_c2_f2.gif','../images/FSA_nav_r2_c3_f2.gif','../images/FSA_nav_r2_c4_f2.gif','../images/FSA_nav_r2_c5_f2.gif','../images/FSA_nav_r2_c6_f2.gif','../images/FSA_nav_r2_c7_f2.gif')" tracingsrc="../images/FSA2.jpg" tracingopacity="57">

<div id="container">
  <div id="header"><img src="../images/headerHome.jpg" width="955" alt="Flathead Snowmobile Association" height="110" />
    <!-- end #header --></div>
  <div id="nav">
    <!--The following section is an HTML table which reassembles the sliced image in a browser.-->
    <!--Copy the table section including the opening and closing table tags, and paste the data where-->
    <!--you want the reassembled image to appear in the destination document. -->
    <!--======================== BEGIN COPYING THE HTML HERE ==========================-->
    <div id="FWTableContainer1555515835">
      <table border="0" cellpadding="0" cellspacing="0" width="955">
        <!-- fwtable fwsrc="FSA_nav.png" fwpage="Page 1" fwbase="FSA_nav.gif" fwstyle="Dreamweaver" fwdocid = "1555515835" fwnested="0" -->
        <tr>
          <!-- Shim row, height 1. -->
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="48" height="1" border="0" id="undefined_2" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="51" height="1" border="0" id="undefined_2" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="66" height="1" border="0" id="undefined_2" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="86" height="1" border="0" id="undefined_2" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="38" height="1" border="0" id="undefined_2" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="97" height="1" border="0" id="undefined_2" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="102" height="1" border="0" id="undefined_2" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="467" height="1" border="0" id="undefined_2" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="1" height="1" border="0" id="undefined_2" /></td>
        </tr>
        <tr>
          <!-- row 1 -->
          <td colspan="8"><img name="FSA_nav_r1_c1" src="../images/FSA_nav_r1_c1.gif" width="955" height="1" border="0" id="FSA_nav_r1_c1" alt="" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="1" height="1" border="0" id="undefined_2" /></td>
        </tr>
        <tr>
          <!-- row 2 -->
          <td><a href="../index.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r2_c1','','../images/FSA_nav_r2_c1_f2.gif',1)"><img name="FSA_nav_r2_c1" src="../images/FSA_nav_r2_c1.gif" width="48" height="20" border="0" id="FSA_nav_r2_c1" alt="Home" /></a></td>
          <td><a href="../mission.html" onMouseOut="MM_swapImgRestore();MM_menuStartTimeout(500)" onMouseOver="MM_menuShowMenu('MMMenuContainer0005200202_0', 'MMMenu0005200202_0',0,21,'FSA_nav_r2_c2');MM_swapImage('FSA_nav_r2_c2','','../images/FSA_nav_r2_c2_f2.gif',1)"><img name="FSA_nav_r2_c2" src="../images/FSA_nav_r2_c2.gif" width="51" height="20" border="0" id="FSA_nav_r2_c2" alt="About FSA" /></a></td>
          <td><a href="../eventsCal.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r2_c3','','../images/FSA_nav_r2_c3_f2.gif',1)"><img name="FSA_nav_r2_c3" src="../images/FSA_nav_r2_c3.gif" width="66" height="20" border="0" id="FSA_nav_r2_c3" alt="Calendar" /></a></td>
          <td><a href="../ridingAreas.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r2_c4','','../images/FSA_nav_r2_c4_f2.gif',1)"><img name="FSA_nav_r2_c4" src="../images/FSA_nav_r2_c4.gif" width="86" height="20" border="0" id="FSA_nav_r2_c4" alt="Riding Areas" /></a></td>
          <td><a href="../join.cfm" onMouseOut="MM_swapImgRestore();MM_menuStartTimeout(500)" onMouseOver="MM_menuShowMenu('MMMenuContainer0005200636_1', 'MMMenu0005200636_1',0,21,'FSA_nav_r2_c5');MM_swapImage('FSA_nav_r2_c5','','../images/FSA_nav_r2_c5_f2.gif',1)"><img name="FSA_nav_r2_c5" src="../images/FSA_nav_r2_c5.gif" width="38" height="20" border="0" id="FSA_nav_r2_c5" alt="Join" /></a></td>
          <td><a href="../localSvcs.htm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r2_c6','','../images/FSA_nav_r2_c6_f2.gif',1)"><img name="FSA_nav_r2_c6" src="../images/FSA_nav_r2_c6.gif" width="97" height="20" border="0" id="FSA_nav_r2_c6" alt="Local Services" /></a></td>
          <td><a href="../news.cfm" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FSA_nav_r2_c7','','../images/FSA_nav_r2_c7_f2.gif',1)"><img name="FSA_nav_r2_c7" src="../images/FSA_nav_r2_c7.gif" width="102" height="20" border="0" id="FSA_nav_r2_c7" alt="News &amp; Events" /></a></td>
          <td rowspan="2"><img name="FSA_nav_r2_c8" src="../images/FSA_nav_r2_c8.gif" width="467" height="21" border="0" id="FSA_nav_r2_c8" alt="" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="1" height="20" border="0" id="undefined_2" /></td>
        </tr>
        <tr>
          <!-- row 3 -->
          <td colspan="7"><img name="FSA_nav_r3_c1" src="../images/FSA_nav_r3_c1.gif" width="488" height="1" border="0" id="FSA_nav_r3_c1" alt="" /></td>
          <td><img src="../images/spacer.gif" alt="" name="undefined_2" width="1" height="1" border="0" id="undefined_2" /></td>
        </tr>
        <!--   This table was automatically created with Adobe Fireworks   -->
        <!--   http://www.adobe.com   -->
      </table>
      <div id="MMMenuContainer0005200202_0">
        <div id="MMMenu0005200202_0" onMouseOut="MM_menuStartTimeout(500);" onMouseOver="MM_menuResetTimeout();"> <a href="../mission.html" id="MMMenu0005200202_0_Item_0" class="MMMIFVStyleMMMenu0005200202_0" onMouseOver="MM_menuOverMenuItem('MMMenu0005200202_0');"> Mission&nbsp;Statement </a> <a href="../officers.htm" id="MMMenu0005200202_0_Item_1" class="MMMIVStyleMMMenu0005200202_0" onMouseOver="MM_menuOverMenuItem('MMMenu0005200202_0');"> Officers </a> </div>
      </div>
      <div id="MMMenuContainer0005200636_1">
        <div id="MMMenu0005200636_1" onMouseOut="MM_menuStartTimeout(500);" onMouseOver="MM_menuResetTimeout();"> <a href="../join.cfm" id="MMMenu0005200636_1_Item_0" class="MMMIFVStyleMMMenu0005200636_1" onMouseOver="MM_menuOverMenuItem('MMMenu0005200636_1');"> Join&nbsp;Online </a> <a href="../membershipApp.pdf" id="MMMenu0005200636_1_Item_1" class="MMMIVStyleMMMenu0005200636_1" onMouseOver="MM_menuOverMenuItem('MMMenu0005200636_1');"> Print&nbsp;Application </a> </div>
      </div>
    </div>
    <!--========================= STOP COPYING THE HTML HERE =========================-->
</div>
  <div id="mainContent">
    <!-- InstanceBeginEditable name="Heading1" --><h1>Our Mission</h1><!-- InstanceEndEditable -->
    <div id="MainImg">
      <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
       	  <td><!-- InstanceBeginEditable name="MainText" -->
       	    <div class="oneColFixCtrHdr">
              <div align="justify">
                <table>
                  <tr>
                    <td>UserName</td>
                    <td>Role</td>
                    <td>Name</td>
                    <td>Email</td>
                  </tr>
                  <cfoutput query="users" startRow="#StartRow_users#" maxRows="#MaxRows_users#">
                    <tr>
                      <td>#users.userName#</td>
                      <td>#users.role#</td>
                      <td>#Trim(users.firstName)# #Trim(users.lastName)#</td>
                      <td>#users.emailAddress#</td>
                    </tr>
                  </cfoutput>
                </table>
              </div>
   	        </div><!-- InstanceEndEditable -->
       	  </td>
        </tr>
        </table>
     </div>
    <div id="tagMessage">
      <p>Remember - T.E.A.M  Together Everyone Achieves More</p>
      <p>Thanks for Your Support</p>
    </div>
    
  <!-- end #mainContent --></div>
  <div id="footer"><!-- #BeginLibraryItem "/Library/footer.lbi" -->
<table width="100%" border="0">
<tr>
            <td width="45%" class="copyrightL">&copy; 2007 Flathead Snowmobile Association.<br>
            All rights Reserved</td>
    <td width="10%" class="footerCtr"><a href="mailto:webmaster@flatheadsnowmobiler.com">webmaster</a></td>
    <td width="45%" class="copyrightR">Web Design and hosting by<a href="http://www.ssb-ca.com"><img src="../../images/SSBLogoTiny.jpg" width="59" height="15" hspace="4" border="0" align="right" /></a> </td>
  </tr>
        </table><!-- #EndLibraryItem --><p>&nbsp;</p>
  <!-- end #footer --></div>
<!-- end #container --></div>
</body>
<!-- InstanceEnd --></html>
