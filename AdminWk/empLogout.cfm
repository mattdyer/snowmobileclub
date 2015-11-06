

<cflogout>
  <cflock scope="Session" type="Exclusive" timeout="30" throwontimeout="no">
      	<CFSET SESSION.Auth.IsLoggedIn = "">
  </cflock>
<CFLOCATION URL="index.cfm">