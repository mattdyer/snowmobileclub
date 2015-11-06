<cfinclude template="HelperGroupsRulesCF.cfm" >

<cfset WA_Auth_Separator = "|§|" >

<cffunction name="WA_AuthenticateUser">
	<cfargument name="args" type="struct" required="yes" >
	
	<cfset var UserAuthenticated = False >
	<cfset var columnNamesArray = WA_Auth_split(args.columns, WA_Auth_Separator) >
	<cfset var columnValuesArray = WA_Auth_split(args.columnValues, WA_Auth_Separator) >
	<cfset var columnTypesArray = WA_Auth_split(args.columnTypes, WA_Auth_Separator) >
	<cfset var columnSizesArray = WA_Auth_split(args.columnSizes, WA_Auth_Separator) >
	<cfset var sessionColumnsArray = WA_Auth_split(args.sessionColumns, WA_Auth_Separator) >
	<cfset var sessionNamesArray = WA_Auth_split(args.sessionNames, WA_Auth_Separator) >
	<cfif ListLen(args.columns) EQ ListLen(args.columnValues) >

		<cfquery name="MM_qryWA_AuthenticateUser" datasource="#args.connection#">
			SELECT #Replace(args.sessionColumns, WA_Auth_Separator, ",", "all")# FROM #args.tableName# WHERE 
			<cfif ArrayLen(columnNamesArray) GTE 1>
				<cfloop from="1" to="#ArrayLen(columnNamesArray)#" index="idx" >
					<cfif idx GT 1 >AND</cfif> #columnNamesArray[idx]#=<cfqueryparam value="#columnValuesArray[idx]#" cfsqltype="#columnTypesArray[idx]#" maxlength="#columnSizesArray[idx]#">
				</cfloop>
			</cfif>
		</cfquery>
		
		<cfif MM_qryWA_AuthenticateUser.RecordCount NEQ 0 >
			<cfset UserAuthenticated = True >
			<cflock scope="Session" timeout="30" type="Exclusive">
				<cfif ArrayLen(sessionColumnsArray) GTE 1 >
					<cfloop from="1" to="#ArrayLen(sessionColumnsArray)#" index="idx" >
						<cfset Session[sessionColumnsArray[idx]] = MM_qryWA_AuthenticateUser[sessionColumnsArray[idx]][1] >
					</cfloop>
				</cfif>
			</cflock>

			<cfif args.gotoPreviousURL AND IsDefined("URL.accessdenied")>
				<cfset args.successRedirect=URL.accessdenied>
			</cfif>
			<cfif args.successRedirect NEQ "" >
				<cfset args.successRedirect = WA_Auth_BuildRedirectURL(args.successRedirect, args.keepQueryString) >
				<cflocation url="#args.successRedirect#" addtoken="no" >
			</cfif>
		</cfif>
	</cfif>

	<cfif (Not UserAuthenticated) AND (args.failRedirect NEQ "") >
		<cfset failureRedirect = WA_Auth_BuildRedirectURL(args.failRedirect, args.keepQueryString) >
		<cflocation url="#failureRedirect#" addtoken="no" >
	</cfif>

</cffunction>


<cffunction name="WA_Auth_ClearSession" >
	<cfargument name="clearAll" type="boolean" required="yes" >
	<cfargument name="clearThese" type="array" required="yes" >

	<cfif clearAll>
		 <cflock scope="Session" type="Exclusive" timeout="60" >
			  <cfset StructClear(Session)>
		 </cflock>
	<cfelse>
		<cfloop from="1" to="#ArrayLen(clearThese)#" index="i" >
			<cfset StructDelete(Session, clearThese[i]) >
		</cfloop>
	</cfif>

</cffunction>

<cffunction name="WA_Auth_RestrictAccess" returntype="string">
	<cfargument name="redirectURL" type="string" required="yes">
	<cfset redirectURL = WA_Auth_BuildRedirectURL(redirectURL, False, True) >
	<cflocation url="#redirectURL#" addtoken="no" >
</cffunction>

<cffunction name="WA_Auth_ForgotPassword" >
	<cfargument name="WA_Auth_Parameter" type="struct" required="yes" >

	<cfset var selectColumns = ArrayNew(1) >	
	<cfset var columnNamesArray = WA_Auth_split(WA_Auth_Parameter.selectColumns, WA_Auth_Separator) >
	<cfset var sessionNamesArray = WA_Auth_split(WA_Auth_Parameter.sessionVariables, WA_Auth_Separator) >
	<cfset var emailSettings = WA_Auth_split(WA_Auth_Parameter.emailSettings, WA_Auth_Separator) >

	<cfloop from="1" to="#ArrayLen(columnNamesArray)#" index="idx" >
		<cfif columnNamesArray[idx] NEQ "" >
			<cfset ArrayAppend(selectColumns, columnNamesArray[idx]) >
		</cfif>
	</cfloop>

	<cfset ArrayAppend(selectColumns, WA_Auth_Parameter.column) >
	<cfset ArrayAppend(selectColumns, WA_Auth_Parameter.usernameColumn) >
	<cfset ArrayAppend(selectColumns, WA_Auth_Parameter.passwordColumn) >

	<cfif WA_Auth_Parameter.dbUserName NEQ "" >
		<cfquery datasource="#WA_Auth_Parameter.connection#" name="MM_Auth_ForgotPassword" username="#WA_Auth_Parameter.dbUserName#" password="#WA_Auth_Parameter.dbPassword#" >
			SELECT #ArrayToList(selectColumns, ",")# FROM #WA_Auth_Parameter.tableName#
			WHERE
			#WA_Auth_Parameter.column# = <cfqueryparam value="#WA_Auth_Parameter.columnValue#" cfsqltype="#WA_Auth_Parameter.columnType#" maxlength="#WA_Auth_Parameter.columnSize#">
		</cfquery>
	<cfelse>
		<cfquery datasource="#WA_Auth_Parameter.connection#" name="MM_Auth_ForgotPassword" >
			SELECT #ArrayToList(selectColumns, ",")# FROM #WA_Auth_Parameter.tableName#
			WHERE
			#WA_Auth_Parameter.column# = <cfqueryparam value="#WA_Auth_Parameter.columnValue#" cfsqltype="#WA_Auth_Parameter.columnType#" maxlength="#WA_Auth_Parameter.columnSize#">
		</cfquery>
	</cfif>

	<cfif MM_Auth_ForgotPassword.recordCount GTE 1>
		<cfset WA_Auth_Parameter.mailBody = Replace(WA_Auth_Parameter.mailBody, "\n", Chr(13), "all") >
		<cfloop from="1" to="#ArrayLen(selectColumns)#" index="column">
			<cfset WA_Auth_Parameter.mailBody = Replace(WA_Auth_Parameter.mailBody, "[" & selectColumns[column] & "]", MM_Auth_ForgotPassword[selectColumns[column]][1] , "all") >
		</cfloop>

		<cfloop from="1" to="#ArrayLen(sessionNamesArray)#" index="column">
		<cfset WA_Auth_Parameter.mailBody = Replace(WA_Auth_Parameter.mailBody, "[Session." & sessionNamesArray[column] & "]", IIf(IsDefined('Session.#sessionNamesArray[column]#'),"Session["&sessionNamesArray[column]&"]",DE("")) , "all") >
		</cfloop>
		<cfif WA_Auth_Parameter.fromAddressDisplay NEQ "" >
			<cfset WA_Auth_Parameter.fromAddress = WA_Auth_Parameter.fromAddressDisplay & " <" & WA_Auth_Parameter.fromAddress & ">" >
		</cfif>
		<cfif emailSettings[2] NEQ "" >
			<cfmail subject="#WA_Auth_Parameter.subject#" from="#WA_Auth_Parameter.fromAddress#" server="#emailSettings[1]#" port="#emailSettings[4]#" timeout="#emailSettings[5]#" username="#emailSettings[2]#" password="#emailSettings[3]#" to="#MM_Auth_ForgotPassword[WA_Auth_Parameter.toAddressColumn][1]#"><cfsilent>
			</cfsilent>#WA_Auth_Parameter.mailBody#</cfmail>
		<cfelse>
			<cfmail subject="#WA_Auth_Parameter.subject#" from="#WA_Auth_Parameter.fromAddress#" server="#emailSettings[1]#" port="#emailSettings[4]#" timeout="#emailSettings[5]#" to="#MM_Auth_ForgotPassword[WA_Auth_Parameter.toAddressColumn][1]#"><cfsilent>
			</cfsilent>#WA_Auth_Parameter.mailBody#</cfmail>
		</cfif>
		<cfif WA_Auth_Parameter.successRedirect NEQ "" >
			<cfset WA_Auth_Parameter.successRedirect = WA_Auth_BuildRedirectURL(WA_Auth_Parameter.successRedirect, WA_Auth_Parameter.keepQueryString) >
			<cflocation url="#WA_Auth_Parameter.successRedirect#" addtoken="no" >
		</cfif>
	<cfelse>
		<cfif WA_Auth_Parameter.failRedirect NEQ "" >
			<cfset WA_Auth_Parameter.failRedirect = WA_Auth_BuildRedirectURL(WA_Auth_Parameter.failRedirect, WA_Auth_Parameter.keepQueryString) >
			<cflocation url="#WA_Auth_Parameter.failRedirect#" addtoken="no" >
		</cfif>
	</cfif>
</cffunction>

<cffunction name="WA_Auth_BuildRedirectURL" returntype="string">
	<cfargument name="redirectURL" type="string" required="yes" >
	<cfargument name="keepCurrentQueryString" type="boolean" required="yes" >
	<cfargument name="addDeniedURL" type="boolean" required="no" default="false">

	<cfset var WA_Auth_Referrer=CGI.SCRIPT_NAME >

	<cfif keepCurrentQueryString AND CGI.QUERY_STRING NEQ "" >
		<cfif Find("?", redirectURL) GT 0 >
			<cfset redirectURL = redirectURL & "&" & CGI.QUERY_STRING />
			<cfelse>
			<cfset redirectURL = redirectURL & "?" & CGI.QUERY_STRING />
		</cfif>
	</cfif>

	<cfif addDeniedURL >
		<cfif CGI.QUERY_STRING NEQ "">
			<cfset WA_Auth_Referrer = WA_Auth_Referrer & "?" & CGI.QUERY_STRING >
		</cfif>
		<cfif Find("?", redirectURL) GT 0 >
			<cfset redirectURL = redirectURL & "&accessdenied=" & URLEncodedFormat(WA_Auth_Referrer) />
		<cfelse>
			<cfset redirectURL = redirectURL & "?accessdenied=" & URLEncodedFormat(WA_Auth_Referrer) />
		</cfif>
	</cfif>
	
	<cfreturn redirectURL >		

</cffunction>

<!--- Rules Functions --->
<cffunction name="WA_Auth_RulePasses" >
	<cfargument name="ruleName" type="string" required="yes" >
	<cfreturn WA_Auth_RuleObject_EvaluateRules(ruleName) >
</cffunction>

<cffunction name="WA_Auth_RuleObject_EvaluateRules" >
	<cfargument name="ruleName" type="string" required="yes" >

	<cfset var rulePasses = False >
	<cfset var comparisons = WA_Auth_GetComparisonsForRule(ruleName) >
	<cfset var comparison = "" >
	<cfset var compareLen = ArrayLen(comparisons) >
	<cfset var compareSucceeds = False >

	<cfloop from="1" to="#compareLen#" index="idx">
		<cfset compareSucceeds = False >
		<cfset comparison =  comparisons[idx]>
		<cfswitch expression="#comparison[3]#">
		<!---
			1-9		Direct value comparisons
			10-19		String Comparisons
			20-29		List Comparisons
		
		--->
			<cfcase value="1">
				<cfset compareSucceeds = (comparison[2] EQ comparison[4]) >
			</cfcase>

			<cfcase value="2">
				<cfset compareSucceeds = (comparison[2] NEQ comparison[4]) >
			</cfcase>

			<cfcase value="3">
				<cfset compareSucceeds = (comparison[2] LT comparison[4]) >
			</cfcase>

			<cfcase value="4">
				<cfset compareSucceeds = (comparison[2] LTE comparison[4]) >
			</cfcase>

			<cfcase value="5">
				<cfset compareSucceeds = (comparison[2] GT comparison[4]) >
			</cfcase>

			<cfcase value="6">
				<cfset compareSucceeds = (comparison[2] GTE comparison[4]) >
			</cfcase>

			<cfcase value="20">
				<cfset compareSucceeds = WA_Auth_GroupContainsValue(comparison[4], comparison[2]) >
			</cfcase>
		
		</cfswitch>

		<cfif ( (Not comparison[1] AND compareSucceeds ) OR ( comparison[1] AND Not compareSucceeds ) )>
			<cfset rulePasses = False >
			<cfbreak >		
		<cfelseif compareSucceeds >
				<cfset rulePasses = True >
				<cfbreak >
		</cfif>
	
	</cfloop>

	<cfreturn rulePasses >
</cffunction>

<!--- Groups functions --->
<cffunction name="WA_Auth_GroupContainsValue" returntype="boolean">
	<cfargument name="groupName" type="string" required="yes" >
	<cfargument name="value" type="string" required="yes" >

	<cfset var valueFound = False >
	<cfset var group = WA_Auth_GetGroup(groupName) >
	<cfset var groupLen = ArrayLen(group) >	
	<cfset var idx = 0 >
	
	<cfloop from="1" to="#groupLen#" index="idx" >
		<cfif NOT Compare(group[idx], value) >
			<cfset valueFound = True >
			<cfbreak >
		</cfif>
	</cfloop>
	
	<cfreturn valueFound >
</cffunction>


<!--- Debug functions --->
<cffunction name="WA_Auth_RuleObject_DebugAllComparisons">
	<cfargument name="comparisons" type="array" required="yes" >
	
	<cfloop from="1" to="#ArrayLen(comparisons)#" index="idx">
		<cfset WA_Auth_RuleObject_DebugComparison(comparisons[idx]) > 
	</cfloop>
	
</cffunction>

<cffunction name="WA_Auth_RuleObject_DebugComparison">
	<cfargument name="comparison" type="array" required="yes" >
	<cfoutput>
	#comparison[1]#<br />#comparison[2]#<br />#comparison[3]#<br />#comparison[4]#<br />
	</cfoutput>

</cffunction>

<cfscript>
/**
 * Splits a string according to another string or multiple delimiters.
 * 
 * Renamed to prevent potential naming conflicts
 * 
 * 
 * @param str 	 String to split. (Required)
 * @param splitstr 	 String to split on. Defaults to a comma. (Optional)
 * @param treatsplitstrasstr 	 If false, splitstr is treated as multiple delimiters, not one string. (Optional)
 * @return Returns an array. 
 * @author Steven Van Gemert (svg2@placs.net) 
 * @version 3, February 12, 2005 
 */
function WA_Auth_split(str) {
	var results = arrayNew(1);
	var splitstr = ",";
	var treatsplitstrasstr = true;
	var special_char_list      = "\,+,*,?,.,[,],^,$,(,),{,},|,-";
	var esc_special_char_list  = "\\,\+,\*,\?,\.,\[,\],\^,\$,\(,\),\{,\},\|,\-";	
	var regex = ",";
	var test = "";
	var pos = 0;
	var oldpos = 1;

	if(ArrayLen(arguments) GTE 2){
		splitstr = arguments[2]; //If a split string was passed, then use it.
	}
	
	regex = ReplaceList(splitstr, special_char_list, esc_special_char_list);
	
	if(ArrayLen(arguments) GTE 3 and isboolean(arguments[3])){
		treatsplitstrasstr = arguments[3]; //If a split string method was passed, then use it.
		if(not treatsplitstrasstr){
			pos = len(splitstr) - 1;
			while(pos GTE 1){
				splitstr = mid(splitstr,1,pos) & "_Separator_" & mid(splitstr,pos+1,len(splitstr) - (pos));
				pos = pos - 1;
			}
			splitstr = ReplaceList(splitstr, special_char_list, esc_special_char_list);
			splitstr = Replace(splitstr, "_Separator_", "|", "ALL");
			regex = splitstr;
		}
	}
	test = REFind(regex,str,1,1);
	pos = test.pos[1];

	if(not pos){
		arrayAppend(results,str);
		return results;
	}

	while(pos gt 0) {
		arrayAppend(results,mid(str,oldpos,pos-oldpos));
		oldpos = pos+test.len[1];
		test = REFind(regex,str,oldpos,1);
		pos = test.pos[1];
	}
	//Thanks to Thomas Muck
	if(len(str) gte oldpos) arrayappend(results,right(str,len(str)-oldpos + 1));

	if(len(str) lt oldpos) arrayappend(results,"");

	return results;
}
</cfscript>