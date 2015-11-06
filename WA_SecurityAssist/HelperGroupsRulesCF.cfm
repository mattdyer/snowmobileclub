<cffunction name="WA_Auth_GetComparisonsForRule" >
	<cfargument name="ruleName" type="string" required="yes">
	<cfset var rule = ArrayNew(1) >

	<cfswitch expression="#ruleName#">
		<cfcase value="Logged in to Users" >
			<cfset ArrayAppend(rule, ArrayNew(1)) >
			<cfset ArrayAppend(rule[1], True) >
			<cfset ArrayAppend(rule[1], "" & IIf(isDefined("Session.ID"),"Session.ID",DE("")) & "") >
			<cfset ArrayAppend(rule[1], 2) >
			<cfset ArrayAppend(rule[1], "") >
			<!--- End Condition --->
		</cfcase>
	</cfswitch>

	<cfreturn rule >
	
</cffunction>

<cffunction name="WA_Auth_GetGroup" returntype="array" >
	<cfargument name="groupName" required="yes" >
	
	<cfset var group = ArrayNew(1) >

	<cfswitch expression="#groupName#">
		
	</cfswitch>
	
	<cfreturn group>
</cffunction>