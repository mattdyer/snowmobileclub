<cfcomponent>
	<cffunction name="eventInfo" access="public" returntype="query">
		<cfargument name="eventDate" type="date" required="yes">
			<cfquery name="qGetEvents" datasource="#APPLICATION.Datasource#">
            	SELECT ID, eventDate, eventLocation,eventName, eventTime,eventNote
                FROM Events
            </cfquery> 
		<cfset myResult="foo">
		<cfreturn qEvents>
	</cffunction>
</cfcomponent>